package core;

import routing.BlossomUtilities.Cluster;

public interface ClusterListener {

    public void newCluster(Cluster c);

    public void removeCluster(Cluster c);
}
