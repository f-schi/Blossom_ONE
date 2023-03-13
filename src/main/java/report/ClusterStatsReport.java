package report;

import core.ClusterListener;
import routing.BlossomUtilities.Cluster;

import java.util.*;

public class ClusterStatsReport extends Report implements ClusterListener {

    private Map<Cluster, Double> creationTimes;
    private Map<Cluster, Integer> nrOfNodesWhenInitialised;
    private List<Cluster> removedClusters;
    private double totalClusterExistingTime;
    private int nrOfClusters;
    private int nrOfMaxNodes;
    private int nrOfMaxNodesExisting;
    private int nrOfMaxNodesRemoved;
    private int totalNrOfNodesWhenInitialised;

    /**
     * Constructor
     */
    public ClusterStatsReport() { init(); }

    protected void init() {
        super.init();

        this.creationTimes = new HashMap<>();
        this.nrOfNodesWhenInitialised = new HashMap<>();
        this.removedClusters = new ArrayList<>();
        this.totalClusterExistingTime = 0.0;
        this.nrOfClusters = 0;
        this.nrOfMaxNodes = 0;
        this.totalNrOfNodesWhenInitialised = 0;
    }


    public void newCluster(Cluster c) {
        this.creationTimes.put(c, getSimTime());
        this.nrOfNodesWhenInitialised.put(c, c.getClusterSize());
        this.totalNrOfNodesWhenInitialised += c.getClusterSize();
        this.nrOfClusters++;
    }

    /**
     * Will only consider clusters that are initialized by the setAverageDirection(),
     * as the assignClusterLogic creates temporary clusters
     * @param c
     */
    public void removeCluster(Cluster c) {
        if (this.creationTimes.containsKey(c)) {
            this.totalClusterExistingTime += getSimTime() - this.creationTimes.get(c);
            this.removedClusters.add(c);

            this.nrOfMaxNodesRemoved += c.getMaxNumberHosts();
        }
    }

    @Override
    public void done() {
        write("Cluster stats for scenario " + getScenarioName() +
                "\nsim_time: " + format(getSimTime()));
        double averageMaxClusterSize = 0;
        double averageMaxClusterSizeExisting = 0;
        double averageMaxClusterSizeRemoved = 0;
        double averageSizeWhenInitialized = 0;
        double averageExistingTimeOfACluster = 0;
        double averageClusterSizeWhenInitialised = 0;

        calculateMaxValues();

        if (this.nrOfClusters > 0) {
            averageMaxClusterSize = (1.0 * this.nrOfMaxNodes) / this.nrOfClusters;
            averageMaxClusterSizeExisting =  (1.0 * this.nrOfMaxNodesExisting) / (this.nrOfClusters - this.removedClusters.size());
            averageMaxClusterSizeRemoved = (1.0 * this.nrOfMaxNodesRemoved) / this.removedClusters.size();
            averageSizeWhenInitialized = (1.0 * this.totalNrOfNodesWhenInitialised) / this.nrOfClusters;;
            averageExistingTimeOfACluster = this.totalClusterExistingTime / this.nrOfClusters;
            averageClusterSizeWhenInitialised = (1.0 * this.totalNrOfNodesWhenInitialised) / this.nrOfClusters;
        }
//
        String statsText = "created: " + this.nrOfClusters +
                "\n" +
                "\nAverage max cluster size: " + averageMaxClusterSize +
                "\nAverage number when cluster is initialized: " +  averageClusterSizeWhenInitialised +
                "\nAverage max cluster size of at the end existing clusters: " + averageMaxClusterSizeExisting +
                "\nAverage max cluster size of removed clusters: " + averageMaxClusterSizeRemoved +
                "\nAverage size when a cluster gets initialized: " + averageSizeWhenInitialized +
                "\nAverage existing time of a cluster: " +  averageExistingTimeOfACluster +
                "\nNumber of removed cluster: " +  this.removedClusters.size()
                ;

        write(statsText);
        super.done();
    }

    private void calculateMaxValues() {
        for (Cluster c : this.creationTimes.keySet()) {
            if(!this.removedClusters.contains(c)) {
                this.nrOfMaxNodesExisting += c.getMaxNumberHosts();
            }
            this.nrOfMaxNodes += c.getMaxNumberHosts();
        }
    }
}
