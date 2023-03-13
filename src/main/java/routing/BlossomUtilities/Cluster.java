package routing.BlossomUtilities;

import core.ClusterListener;
import core.DTNHost;

import java.awt.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class Cluster {
    private static final UUID id = UUID.randomUUID();
    private final Color color = new Color(getRandomColourValue(), getRandomColourValue(), getRandomColourValue());

    private final List<DTNHost> hosts;
    private Direction averageDirection;
    private final double maxClusterRange;

    private final List<ClusterListener> cListeners;
    private int maxNumberHosts = 0;

    public Cluster(DTNHost host, double maxHeight, List<ClusterListener> cListeners) {
        this.cListeners = cListeners;

        this.hosts = new ArrayList<>();
        addToHosts(host);

        this.maxClusterRange = (maxHeight * 180) / 2;
    }

    private int getRandomColourValue() {
        return (int) (Math.random()*255)+1;
    }

    /**
     * Sets the average direction of this cluster only once to prevent overwriting.
     * Overwriting require a central server which is not suitable for Opportunistic Networks.
     */
    public final void initializeCluster() {
        if (isClusterNotInitialized()) {
            setCluster();
            provideDataForClusterStatisticReport(true);
        }
    }

    /**
     *
     */
    private void setCluster() {
        this.averageDirection = calculateAverageDirection();
    }

    /**
     * Calculates the average direction of this cluster through the all assigned hosts.
     * It uses a transformation in case the directions lying over 0 and below as well (1. and 4. quadrant).
     * @return the average direction of this cluster.
     */
    private Direction calculateAverageDirection() {
        boolean dataLiesInFirstAndFourthQuadrant = doesDataLiesInFirstAndFourthQuadrant();
        double sumOfDirections = 0.0;
        Direction averageDirection;
        Double currentDirection;

        for (DTNHost host : hosts) {
            currentDirection = host.getDirection().getDirectionValue();
            if (currentDirection > 180 && dataLiesInFirstAndFourthQuadrant) {
                currentDirection =  (currentDirection - 360);
            }
            sumOfDirections += currentDirection;
        }

        averageDirection = new Direction(sumOfDirections / hosts.size());
        if (averageDirection.getDirectionValue() < 0 ) {
            averageDirection.setDirectionValue(360 + averageDirection.getDirectionValue());;
        }

        return averageDirection;
    }

    private boolean isClusterNotInitialized() {
        return this.averageDirection == null;
    }

    /**
     * Help function for setAverageDirection to check if data lies in the second and fourth quadrant
     * and therefore setAverageDirection needs to perform a transformation.
     * Can only manage a max of maxHeight of 0.5.
     * @return  boolean if the data lies in the 1. and 4. quadrant.
     */
    private boolean doesDataLiesInFirstAndFourthQuadrant() {
        boolean dataLiesInFirstQuadrant = false;
        boolean dataLiesInFourthQuadrant = false;
        double currentDirection;

        for (DTNHost host : hosts) {
            currentDirection = host.getDirection().getDirectionValue();

            if (0 <= currentDirection && currentDirection < 90) {
                dataLiesInFirstQuadrant = true;
            }
            if (270 <= currentDirection && currentDirection < 360) {
                dataLiesInFourthQuadrant = true;
            }
        }

        return dataLiesInFirstQuadrant && dataLiesInFourthQuadrant;
    }

    public final Direction getAverageDirection() {
        return averageDirection;
    }


    /**
     * Assigns a new host to this cluster.
     * For consistency it deletes a host from its old cluster if necessary.
     * @param host the new assigned host.
     */
    public final void addToHosts(DTNHost host) {
        Cluster hostsCluster = host.getCluster();

        if (hostsCluster != null) {
            hostsCluster.deleteFromHosts(host);
        }

        this.hosts.add(host);
        host.setCluster(this);

        provideDataForClusterStatisticReport(false);
    }

    /**
     * Calls the functions for the cluster report.
     * @param firstInitialized moment when the function is called.
     */
    private void provideDataForClusterStatisticReport(boolean firstInitialized) {
        if(firstInitialized) {
            for (ClusterListener cl : cListeners) {
                cl.newCluster(this);
            }
        }

        if (hosts.isEmpty()) {
            for (ClusterListener cl : cListeners) {
                cl.removeCluster(this);
            }
        }

        if (getClusterSize() > this.maxNumberHosts) {
            this.maxNumberHosts = getClusterSize();
        }
    }

    /**
     * Removes the host from this cluster as sets all corresponding parameters accordingly.
     * @param host the removed host from this cluster.
     */
    public final void deleteFromHosts(DTNHost host) {
        hosts.remove(host);
        host.setCluster(null);
        host.setReachableClusterMembers(0);

        provideDataForClusterStatisticReport(false);
    }

    /**
     * Checks if the given host belong to this cluster when this cluster is already initialized.
     * @param host the host which gets checked.
     * @return if the host fits to this cluster or not.
     */
    public final boolean doesHostBelongToCluster(DTNHost host) {
        boolean hostBelongToCluster = true;

        if (!isClusterNotInitialized()) {
            double distanceBetweenHostAndOtherCluster = this.averageDirection.calculateDistanceBetweenThisDirectionAndOther(host.getDirection());
            hostBelongToCluster = distanceBetweenHostAndOtherCluster < this.maxClusterRange;
        }

        return hostBelongToCluster;
    }

    public final List<DTNHost> getHosts() {
        return hosts;
    }

    public final void getHosts(DTNHost host) {
        hosts.add(host);
    }

    public final int getClusterSize() {
        return hosts.size();
    }

    public final Color getColor() {
        return color;
    }

    public final UUID getId() {
        return id;
    }

    public final int getMaxNumberHosts() {
        return maxNumberHosts;
    }

    @Override
    public final String toString() {
        String returnString;

        if(averageDirection != null) {
            returnString = Long.toString(Math.round(averageDirection.getDirectionValue()));
        } else {
            returnString = "new";
        }

        return returnString;
    }
}