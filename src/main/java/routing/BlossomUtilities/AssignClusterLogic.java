package routing.BlossomUtilities;

import core.ClusterListener;
import core.Connection;
import core.DTNHost;
import routing.BlossomRouter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class AssignClusterLogic {

    private List<ClusterListener> cListeners;
    private final BlossomRouter blossomRouter;

    private List<DTNHost> hosts;
    private List<Cluster> clusters;
    private List<Integer> resultOfClusterAnalysis;

    public AssignClusterLogic(BlossomRouter blossomRouter, List<ClusterListener> cListeners) {
        this.blossomRouter = blossomRouter;
        this.cListeners = cListeners;
        this.clusters = new ArrayList<>();
    }

    /**
     * Checks whether a host should execute a new cluster-analysis and assign its surroundings to clusters
     * our just assign himself to a cluster
     */
    public final void performClusterAssigmentLogic() {
        this.cListeners = this.blossomRouter.getClusterListener();
        this.hosts = getAllHostsFromConnections();

        if (shouldSurroundingNodesGetAssigned()) {
            assignNodesAccordingToClusterAnalysis();
        } else {
            assignHostToBestMatchingCluster(blossomRouter.getHost(), this.hosts);
        }
    }

    private boolean shouldSurroundingNodesGetAssigned() {
        boolean doesHostHasNoCluster = blossomRouter.getHost().getCluster() == null;
        boolean isClusterListEmpty = this.blossomRouter.getHost().getCluster() == null;
        boolean areThereEnoughHostsToCluster = this.hosts.size() > 2;

        return doesHostHasNoCluster && isClusterListEmpty && areThereEnoughHostsToCluster;
    }

    /**
     * Assigns the surrounding hosts with the help of the cluster analysis.
     * In case some the hosts have already a cluster, the best matching cluster will be found.
     */
    private void assignNodesAccordingToClusterAnalysis() {
        this.clusters = new ArrayList<>();
        this.resultOfClusterAnalysis = getClusterResults();
        HashMap<Integer, List<DTNHost>> tupleList = getIndexOfClusterAnalysisAndAssociatedHostsTupleList();

        DTNHost currentHost;

        for (int i = 0; i < this.hosts.size(); i++) {
            currentHost = this.hosts.get(i);

            assignHostToBestMatchingCluster(currentHost, tupleList.get(resultOfClusterAnalysis.get(i)));
            addNewClusterIfNoBestMatchFound(currentHost);
            addToClusterOfHostToList(currentHost);

        }
        setAverageClusterDistanceToNewClusters();
    }

    /**
     * takes the suggestion of the cluster analysis and stores the numbers of the result as keys.
     * As value a list with all hosts dedicated to the cluster number hosts be saved.
     * @return the corresponding tuple list
     */
    private HashMap<Integer, List<DTNHost>> getIndexOfClusterAnalysisAndAssociatedHostsTupleList() {
        HashMap<Integer, List<DTNHost>> tupleList= new HashMap<>();
        int associatedClusterIndex;

        for (int i = 0; i < this.hosts.size(); i++) {
            associatedClusterIndex = this.resultOfClusterAnalysis.get(i);

            if(!tupleList.containsKey(associatedClusterIndex)) {
                tupleList.put(associatedClusterIndex, new ArrayList<>());
            }
            tupleList.get(associatedClusterIndex).add(this.hosts.get(i));
        }

        return tupleList;
    }

    /**
     * Sets the average direction for new build clusters.
     * setAverageDirection() prevents overwriting.
     */
    private void setAverageClusterDistanceToNewClusters() {
        for (Cluster c : this.clusters) {
            c.initializeCluster();
        }
    }

    /**
     * Assigns the given host the best possible cluster.
     * @param host the one who should get assigned.
     * @param associatedHosts is a list of all hosts where the given host can be assigned to.
     */
    private void assignHostToBestMatchingCluster(DTNHost host, List<DTNHost> associatedHosts) {
        DTNHost bestHost;

        bestHost = getBestMatchingHost(host, associatedHosts);

        if(host != bestHost) {
            bestHost.getCluster().addToHosts(host);
            bestHost.setReachableClusterMembers(bestHost.getReachableClusterMembers() + 1);
            host.setReachableClusterMembers(host.getRouter().findReachableClusterMembers());
        }
    }

    /**
     * Looks for the host with the best possible cluster for the given host.
     * @param host is the one where this method tries to find a better cluster for.
     * @param associatedHosts is a list of all hosts where the given host can be assigned to.
     * @return the best matching host to the given one.
     */
    private DTNHost getBestMatchingHost(DTNHost host, List<DTNHost> associatedHosts) {
        DTNHost bestHost = host;

        for (DTNHost otherHost: associatedHosts) {
            if (host != otherHost && isOthersClusterAGoodMatchForHost(bestHost, otherHost)) {
                bestHost = otherHost;
            }
        }

        return bestHost;
    }

    /**
     * Checks if the cluster of the other host fits better for the given host.
     * @param host which looks for a better cluster
     * @param otherHost which possibly have a better cluster
     * @return answers the question if the cluster of the other host is better.
     */
    private boolean isOthersClusterAGoodMatchForHost(DTNHost host, DTNHost otherHost) {
        boolean checkClusterSizes = false, checkDistance = false;
        Cluster hostsCluster = host.getCluster(), otherCluster = otherHost.getCluster();

        if (hostsCluster == null && otherCluster != null || host.getReachableClusterMembers() <= otherHost.getReachableClusterMembers()) {
            checkClusterSizes = true;
        }

        if (otherCluster != null && hostsCluster != otherCluster && otherCluster.doesHostBelongToCluster(host)) {
            checkDistance = true;
        }

        return checkClusterSizes && checkDistance;
    }

    /**
     *
     * @param currentHost
     */
    private void addNewClusterIfNoBestMatchFound(DTNHost currentHost) {
        if (currentHost.getCluster() == null) {
            new Cluster(currentHost, this.blossomRouter.getMaxHeight(), this.cListeners);
        }
    }

    /**
     *
     * @param currentHost
     */
    private void addToClusterOfHostToList(DTNHost currentHost) {
        if (!this.clusters.contains(currentHost.getCluster())) {
            this.clusters.add(currentHost.getCluster());
        }
    }

    /**
     * Get all hosts from getConnections() including the hosts of this router.
     * @return list of all hosts.
     */
    private List<DTNHost> getAllHostsFromConnections() {
        List<DTNHost> hosts = new ArrayList<>();

        hosts.add(blossomRouter.getHost());
        for(Connection c: blossomRouter.getConnections()) {
            hosts.add(c.getOtherNode(blossomRouter.getHost()));
        }

        return hosts;
    }

    /**
     * call the start method and returns the result of the cluster analysis.
     * @return the result of the cluster analysis.
     */
    private List<Integer> getClusterResults() {
        ClusterAnalysisRenjin cluster = new ClusterAnalysisRenjin(getDirections(), blossomRouter.getMaxHeight(), blossomRouter.getEngine(), getNames());
        cluster.computeClusterAnalysis();

        return cluster.getResult();
    }

    /**
     * Gets all directions of the given hosts.
     * @return List with the directions of hosts.
     */
    private List<Double> getDirections() {
        List<Double> inputData = new ArrayList<>();

        for (DTNHost h : this.hosts) {
            inputData.add(h.getDirection().getDirectionValue());
        }
        return inputData;
    }

    /**
     * F-SCHI
     * Gets all names of the given hosts.
     * @return List with the names of hosts.
     */
    private List<String> getNames() {
        List<String> hostNames = new ArrayList<>();

        for (DTNHost h : this.hosts) {
            hostNames.add(h.getName());
        }
        return hostNames;
    }

    public final List<Cluster> getClusters() {
        return this.clusters;
    }

    @Override
    public final String toString() {
        return "AssignClusterLogic{" +
                ", hosts=" + hosts +
                ", clusters=" + clusters +
                ", resultOfClusterAnalysis=" + resultOfClusterAnalysis +
                '}';
    }
}