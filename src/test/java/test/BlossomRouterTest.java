package test;

import core.ClusterListener;
import core.Message;
import routing.BlossomRouter;
import routing.BlossomUtilities.Cluster;
import routing.MessageRouter;

import java.util.ArrayList;
import java.util.List;

public class BlossomRouterTest extends AbstractRouterTest {

    private static int TTL = 300;
    private List<ClusterListener> cListeners;

    @Override
    public void setUp() throws Exception {
        ts.putSetting(MessageRouter.MSG_TTL_S, ""+TTL);
        ts.putSetting(MessageRouter.B_SIZE_S, ""+BUFFER_SIZE);
        this.cListeners = new ArrayList<ClusterListener>();
        cListeners.add(new ClusterChecker());
        setRouterProto(new BlossomRouter(ts));
        super.setUp();
    }

    public void testRouter() throws Exception {
        singleClusterTest();
        multipleClusterTest();
        mergeCorrectnessTest();
        multipleMessageTest();
    }

    /**
     * Checks if the message will be transferred to the next hop and deleted by the sender
     * when the next hop is either in the same cluster or the receiver.
     */
    private void singleClusterTest() {
        // nothing should have happened so far
        assertEquals(mc.TYPE_NONE, mc.getLastType());

        Message m1 = new Message(h1, h3, msgId1, 1);
        h1.createNewMessage(m1);
        assertTrue(mc.next());
        assertEquals(mc.TYPE_CREATE, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h3, mc.getLastTo());

        // connect h1-h2-h3
        h1.connect(h2);
        h2.connect(h3);

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        // h1 and h2 should be assigned to the same cluster
        assertEquals(h1.getCluster(), h2.getCluster());

        // should cause relay h1 -> h2, as h2 is the only connection of h1
        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertFalse(mc.getLastFirstDelivery());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h2, mc.getLastTo());

        // should cause relay h2 -> h3, as h3 is the destination
        clock.advance(1);
        updateAllNodes();

        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.getLastFirstDelivery());
        assertEquals(h2, mc.getLastFrom());
        assertEquals(h3, mc.getLastTo());

        //Message delivered to recipient
        assertFalse(mc.next());
    }

    /**
     * h1 firstly will assigned to an own cluster and afterward
     * h1 will be assigned to the existing cluster of h2 and h5.
     * The message will be routed via two different clusters.
     */
    private void multipleClusterTest() throws Exception {
        setUp();

        Message m2 = new Message(h1, h3, msgId2, 1);
        h1.createNewMessage(m2);
        assertTrue(mc.next());
        assertEquals(mc.getLastType(), mc.TYPE_CREATE);

        h1.getDirection().setDirectionFromMovement(2, -0.5, 1);
        h2.getDirection().setDirectionFromMovement(2, -0.5, 1);
        h3.getDirection().setDirectionFromMovement(-4, 0, 1);
        h4.getDirection().setDirectionFromMovement(-4, 0, 1);
        h5.getDirection().setDirectionFromMovement(2, -0.5, 1);

        assertEquals(346, Math.round(h1.getDirection().getDirectionValue()));
        assertEquals(346, Math.round(h2.getDirection().getDirectionValue()));
        assertEquals(180d, h3.getDirection().getDirectionValue());
        assertEquals(h4.getDirection().getDirectionValue(), h3.getDirection().getDirectionValue());
        assertEquals(h2.getDirection().getDirectionValue(), h5.getDirection().getDirectionValue());

        h1.connect(h2);
        h1.connect(h4);
        h1.connect(h5);

        h2.connect(h5);

        h4.connect(h3);
        h5.connect(h3);

        Cluster h2h5Cluster = new Cluster(h2, 0.1, cListeners);
        h2h5Cluster.addToHosts(h5);
        h2h5Cluster.initializeCluster();
        assertEquals(h2.getCluster(), h5.getCluster());

        Cluster h3h4Cluster = new Cluster(h3, 0.1, cListeners);
        h3h4Cluster.addToHosts(h4);
        h3h4Cluster.initializeCluster();
        assertEquals(h3.getCluster(), h4.getCluster());

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertEquals(h1.getCluster(), h2h5Cluster);
        assertEquals(h1.getCluster(), h2.getCluster());
        assertEquals(h1.getCluster(), h5.getCluster());
        assertNotSame(h1.getCluster(), h4.getCluster());
        assertEquals(h1.getReachableClusterMembers(), 2);

        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h4, mc.getLastTo());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h5, mc.getLastTo());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h4, mc.getLastFrom());
        assertEquals(h3, mc.getLastTo());
        assertFalse(mc.next());

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.next());

        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertFalse(mc.next());

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        //Nothing should happen
        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertFalse(mc.next());
    }

    /**
     *  Blossom do not merge h1 to the cluster of h2 and h5 even if the cluster analysis suggests it.
     *  This results in the preference of existing clusters.
     */

    private void mergeCorrectnessTest() throws Exception {
        setUp();

        Message m3 = new Message(h1, h4, msgId3, 1);
        h1.createNewMessage(m3);
        assertTrue(mc.next());
        assertEquals(mc.getLastType(), mc.TYPE_CREATE);

        h1.getDirection().setDirectionFromMovement(4, 0.8, 1);
        h2.getDirection().setDirectionFromMovement(2, 0, 1);
        h3.getDirection().setDirectionFromMovement(2, -0.5, 1);
        h4.getDirection().setDirectionFromMovement(-4, 0, 1);


        assertEquals(11, Math.round(h1.getDirection().getDirectionValue()));
        assertEquals(0d, h2.getDirection().getDirectionValue());
        assertEquals(346, Math.round(h3.getDirection().getDirectionValue()));
        h4.getDirection().setDirectionFromMovement(-4, 0, 1);

        h1.connect(h2);
        h1.connect(h3);

        h2.connect(h4);

        Cluster h2h3Cluster = new Cluster(h2, 0.1, cListeners);
        h2h3Cluster.addToHosts(h3);
        h2h3Cluster.initializeCluster();
        assertEquals(353, Math.round(h2h3Cluster.getAverageDirection().getDirectionValue()));

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertNotSame(h2h3Cluster, h1.getCluster());

        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h3, mc.getLastTo());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h2, mc.getLastTo());
        assertFalse(mc.next());

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(0, h1.getNrofMessages());
        assertEquals(h2.getCluster(), h1.getCluster());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h2, mc.getLastFrom());
        assertEquals(h4, mc.getLastTo());
        assertFalse(mc.next());


        assertFalse(mc.next());
    }

    /**
     * h1 produces multiple messages and sends them via all clusters.
     */
    private void multipleMessageTest() throws Exception {
        setUp();

        Message m4 = new Message(h1, h4, msgId4, 1);
        h1.createNewMessage(m4);
        assertTrue(mc.next());
        assertEquals(mc.TYPE_CREATE, mc.getLastType());

        Message m5 = new Message(h1, h4, msgId5, 1);
        h1.createNewMessage(m5);
        assertTrue(mc.next());
        assertEquals(mc.TYPE_CREATE, mc.getLastType());

        h1.getDirection().setDirectionFromMovement(4, 0, 1);
        h2.getDirection().setDirectionFromMovement(2, -0.5, 1);
        h3.getDirection().setDirectionFromMovement(-4, 0, 1);
        h4.getDirection().setDirectionFromMovement(-4, 0, 1);

        h1.connect(h2);
        h1.connect(h3);
        h2.connect(h3);
        h3.connect(h4);

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h3, mc.getLastTo());
        assertTrue(m4.getId().equals(mc.getLastMsg().getId()));
        assertTrue(mc.next()); //2. update
        assertEquals(mc.TYPE_RELAY, mc.getLastType());

        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h3, mc.getLastTo()); //d
        assertTrue(m5.getId().equals(mc.getLastMsg().getId()));
        assertFalse(mc.next());

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h2, mc.getLastTo());
        assertTrue(m4.getId().equals(mc.getLastMsg().getId()));
        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h3, mc.getLastFrom());
        assertEquals(h4, mc.getLastTo());
        assertTrue(m5.getId().equals(mc.getLastMsg().getId()));
        assertFalse(mc.next());

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());

        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h1, mc.getLastFrom());
        assertEquals(h2, mc.getLastTo());
        assertTrue(m5.getId().equals(mc.getLastMsg().getId()));
        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_START, mc.getLastType());
        assertEquals(h3, mc.getLastFrom());
        assertEquals(h4, mc.getLastTo());
        assertTrue(m4.getId().equals(mc.getLastMsg().getId()));
        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_DELETE, mc.getLastType());
        assertTrue(mc.next());
        assertEquals(mc.TYPE_RELAY, mc.getLastType());
        assertFalse(mc.next());

        updateAllNodes();
        clock.advance(2);
        updateAllNodes();

        assertFalse(mc.next());
    }
}