/*
 * Copyright 2021 Westfälische-Wilhelms-Universität Münster, Benedikt Kluss
 */
package routing;

import core.*;
import org.renjin.script.RenjinScriptEngineFactory;
import routing.BlossomUtilities.BlossomSecurity;
import routing.BlossomUtilities.Cluster;
import routing.BlossomUtilities.AssignClusterLogic;
import routing.BlossomUtilities.Direction;
import util.Tuple;

import javax.script.ScriptEngine;
import java.util.*;
import java.util.stream.Collectors;


public class BlossomRouter extends ActiveRouter {
	private final ScriptEngine engine;
	private List<Cluster> clusterList;
	private final AssignClusterLogic assignClusterLogic;
	private HashMap<Cluster, List<Message>> operatedClusters = new HashMap<>();
	private BlossomSecurity blosSec;

	private double sleepUntilTime = 0.0;

	public static final String BLOSSOM_ROUTER = "BlossomRouter";
	//Adjustable parameters:
	private static final String MAX_HEIGHT = "maxHeight";
	private static final String SLEEP_TIME = "sleepTime";
	private static final String ADJUSTMENT_PARAMETER = "adjustmentParameter";
	private static final String CLOAKING_ENABLED = "cloakingEnabled";

	protected double maxHeight;
	protected double sleepTime;
	protected double adjustmentParameter;
	protected boolean cloakingEnabled;
	//End of adjustable parameters
	/**
	 * Constructor. Creates a new message router based on the settings in
	 * the given Settings object.
	 * @param s The settings object
	 */
	public BlossomRouter(Settings s) {
		super(s);
		this.assignClusterLogic = new AssignClusterLogic(this, cListeners);
		clusterList = new ArrayList<>();

		// create a script engine manager:
		RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();
		// create a Renjin engine:
		this.engine = factory.getScriptEngine();

		blosSec = new BlossomSecurity();

		Settings blossomSettings = new Settings(BLOSSOM_ROUTER);

		maxHeight = blossomSettings.getDouble("maxHeight");
		sleepTime = blossomSettings.getDouble("sleepTime");
		adjustmentParameter = blossomSettings.getDouble("adjustmentParameter");
		cloakingEnabled = blossomSettings.getBoolean("cloakingEnabled");
	}

	/**
	 * Copy constructor.
	 * @param r The router prototype where setting values are copied from
	 */
	protected BlossomRouter(BlossomRouter r) {
		super(r);

		this.assignClusterLogic = new AssignClusterLogic(this, cListeners);
		clusterList = new ArrayList<>();
		RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();
		// create a Renjin engine:
		this.engine = factory.getScriptEngine();

		blosSec = new BlossomSecurity();

		this.maxHeight = r.maxHeight;
		this.sleepTime = r.sleepTime;
		this.adjustmentParameter = r.adjustmentParameter;
		this.cloakingEnabled = r.cloakingEnabled;
	}

	@Override
	protected int checkReceiving(Message m, DTNHost from) {
		int recvCheck = super.checkReceiving(m, from);

		if (recvCheck == DENIED_OLD && m.getTo() == getHost()) {
			from.deleteMessage(m.getId(), false);
		}

		if (recvCheck == RCV_OK) {
			/* don't accept a message that has already traversed this node */
			if (m.getHops().contains(getHost())) {
				recvCheck = DENIED_OLD;
			}
		}

		return recvCheck;
	}

	@Override
	public void update() {
		super.update();
		if(getHost().isMalicious()) {
			dropPercentageOfMessages(20);
		}

		updateClusterRequirements();

		if (isTransferring() || !canStartTransfer()) {
			return;
		}

		if (exchangeDeliverableMessages() != null && !getHost().isMalicious()) {
			return;
		}

		if(!getDecisionForFurtherTransmission()) {
			return;
		}

		setTransmissionRequirements();

		if (!getHost().isMalicious()){
			tryOtherMessages();
		}

	}

	private void dropPercentageOfMessages(int percentage) {
		List<String> idsOfMessagesToDrop = new ArrayList<>();
		int nrOfMessagesToDrop = (int) (getMessageCollection().size() * ((double) percentage / 100) + 0.5);

		List<String> transferringMessages = getTransferringMessages();

		for(Message message: getMessageCollection()) {
			if(nrOfMessagesToDrop == 0 ) break;

			if(transferringMessages.contains(message.getId()))
				continue;

			idsOfMessagesToDrop.add(message.getId());
			nrOfMessagesToDrop--;
		}

		if (idsOfMessagesToDrop.size() != 0) {
			for (String id : idsOfMessagesToDrop) {
				this.deleteMessage(id, true);
			}
		}
	}

	private List<String> getTransferringMessages() {
		ArrayList<Connection> sendingConnection = this.sendingConnections;
		List<String> transferringMessages = new ArrayList<>();

		for (Connection con : sendingConnection) {
			transferringMessages.add(con.getMessage().getId()) ;
		}

		return transferringMessages;
	}

	/**
	 * Builds up a list with all messages that are deliverable to their destination via a connection.
	 * @return Tuple list of message and the connection to a destination.
	 */
	@Override
	protected final List<Tuple<Message, Connection>> getMessagesForConnected() {
		List<Tuple<Message, Connection>> forTuples = new ArrayList<>();

		if (getNrofMessages() != 0 && getConnections().size() != 0) {
			for (Message message : getMessageCollection()) {
				forTuples.addAll(getReceiverConnectionsForGivenMessage(message));
			}
		}

		return forTuples;
	}

	/**
	 * Finds in-between the connections of the router's host all destinations of the given message.
	 * Request if someone is the destination, which is secured by SHA-256 and both nodes validate the transfer.
	 * @param message a deliverable message with the information of a destination
	 * @return Tuple list with the given message and all connections that hold the destination of a message.
	 */
	private List<Tuple<Message, Connection>> getReceiverConnectionsForGivenMessage(Message message) {
		List<Tuple<Message, Connection>> forTuples = new ArrayList<>();
		String hashedReceiver = blosSec.transferHostToHashValue(message.getTo());

		for (Connection con : getConnections()) {
			DTNHost to = con.getOtherNode(getHost());

			if (to.getName().equals(to.getRouter().getHostNameWhenItEqualsGivenHashedHostName(hashedReceiver))) {
				forTuples.add(new Tuple<>(message, con));
			}
		}

		return forTuples;
	}

	/**
	 * Checks if the given hashed host nome correspond to the router's host.
	 * @param hashedReceiver SHA-256 hashed host name
	 * @return the plain host name
	 */
	public final String getHostNameWhenItEqualsGivenHashedHostName(String hashedReceiver) {
		String hostName = null;

		if(blosSec.isHashedHostTheGivenHost(hashedReceiver, this.getHost())) {
			hostName = getHost().getName();
		}

		return hostName;
	}

	/**
	 * Resets clusterList and operatedCluster in case the clusterList is empty.
	 */
	private void setTransmissionRequirements() {
		if (clusterList.isEmpty()) {
			this.clusterList = assignClusterLogic.getClusters();
			this.operatedClusters = new HashMap<>();
		}
	}

	/**
	 * If clusterList is not empty start further transmission, else if the router is in sleep mode don't transmit.
	 * @return decision if the router should send more messages
	 */
	private boolean getDecisionForFurtherTransmission() {
		return !this.clusterList.isEmpty() || !(sleepUntilTime > 0.0) || !(SimClock.getTime() < sleepUntilTime);
	}

	/**
	 * Updates clusterList through removing non reachable clusters
	 */
	private void updateClusterList() {
		List<Cluster> updatedClusterList = getConnections()
			.stream()
			.filter(connection -> this.clusterList.contains(connection.getOtherNode(getHost()).getCluster()))
			.map(connection -> connection.getOtherNode(getHost()).getCluster())
			.distinct()
			.collect(Collectors.toList());

		//Adds cluster of host if necessary
		Cluster clusterHost = getHost().getCluster();
		if (clusterList.contains(clusterHost) && !updatedClusterList.contains(clusterHost)) {
			updatedClusterList.add(clusterHost);
		}

		this.clusterList = updatedClusterList;
	}

	/**
	 * Sets the reachable cluster members and checks if host still belongs to cluster.
	 */
	private void updateClusterRequirements() {
		DTNHost host = getHost();
		Cluster clusterHost = host.getCluster();

		if (clusterHost != null) {
			if(!clusterHost.doesHostBelongToCluster(host)) {
				clusterHost.deleteFromHosts(host);
				host.setReachableClusterMembers(0);
			} else {
				host.setReachableClusterMembers(findReachableClusterMembers());
			}
		}

		updateClusterList();

		this.assignClusterLogic.performClusterAssigmentLogic();
	}

	/**
	 * Sets all the members of a host that are in reach coming from the connection of this router
	 * @return number of reachable cluster members
	 */
	@Override
	public final int findReachableClusterMembers() {
		int reachableClusterMember = 0;

		for (Connection c : getConnections()) {
			if (c.getOtherNode(getHost()).getCluster() == getHost().getCluster()) {
				reachableClusterMember++;
			}
		}

		return  reachableClusterMember;
	}

	/**
	 * Builds up a list of tuples with all messages which should be send to which connection
	 */
	private void tryOtherMessages() {
		List<Tuple<Message, Connection>> messages = getTupleListOfMessagesAndOperableConnections();

		if (!messages.isEmpty()) {
			sortMessagesToConnectionByDistanceToHost(messages);

			tryMessagesForConnected(messages);
		}
	}

	/**
	 * Creates a list of tuples with the messages that should get send to a cluster.
	 * @return  tuple list with all messages and connections that are operable.
	 */
	private List<Tuple<Message, Connection>> getTupleListOfMessagesAndOperableConnections() {
		List<Tuple<Message, Connection>> messages = new ArrayList<>();

		for (Connection c : getConnections()) {
			if (shouldMessageSendToConnection(c)) {
				messages.addAll(createAllMessageToConnectionTuple(c));
			}
		}
		return messages;
	}

	/**
	 * Sorts the messages that should get send to their dedicated connection by the distance to the host of this router
	 * in reversed order.
	 * It is assumed that closer directions stay longer with this host and therefore can be operated later
	 * @param messages sorted tuple list
	 */
	private void sortMessagesToConnectionByDistanceToHost(List<Tuple<Message, Connection>> messages) {
		messages.sort(Comparator.comparing(m -> getDirectionalDistanceBetweenConnection(m.getValue())));
		Collections.reverse(messages);
	}

	/**
	 * Decides if a message should get send to the given connection.
	 * Messages can be either send to the same cluster or when the clusterList contains the cluster of the other Host.
	 * The other router should be free and not transfer other messages at the moment.
	 * @param c connection between this host and another.
	 * @return Boolean if a message should be send via this connection
	 */
	private boolean shouldMessageSendToConnection(Connection c) {
		DTNHost other = c.getOtherNode(getHost());
		BlossomRouter othRouter = (BlossomRouter) other.getRouter();

		boolean toOwnCluster = this.clusterList.isEmpty() && other.getCluster() == getHost().getCluster();
		boolean otherClusterInList = clusterList.contains(other.getCluster());

		return (toOwnCluster || otherClusterInList) && !othRouter.isTransferring();
	}

	/**
	 * Builds a List of tuples with all messages this router holds to the given connection
	 * @param c connection that should get operated
	 * @return the tuple list with all message to the given connection
	 */
	private List<Tuple<Message, Connection>> createAllMessageToConnectionTuple(Connection c) {
		List<Tuple<Message, Connection>> messages = new ArrayList<>();
		Collection<Message> msgCollection = getMessageCollection();

		MessageRouter otherRouter = c.getOtherNode(getHost()).getRouter();

		for (Message m : msgCollection) {
			if (otherRouter.hasMessage(m.getId())) {
				continue; // skip messages the other one has
			}

			messages.add(new Tuple<>(m, c));
		}

		return messages;
	}

	/**
	 * When transfer is done checks if a message can be removed from this router
	 * @param con The connection whose transfer was finalized
	 */
	@Override
	protected final void transferDone(Connection con) {
		DTNHost receiver = con.getOtherNode(con.getMsgFromNode());
		Cluster messageReceivedCluster = receiver.getCluster();

		updateOperatedClusters(messageReceivedCluster, con);

		if(didClusterReceivedAllMessages(messageReceivedCluster)) {
			this.clusterList.remove(messageReceivedCluster);
		}

		if(this.clusterList.isEmpty()) {
			sleepUntilTime = SimClock.getTime() + sleepTime;
		}

		if (getHost().getCluster() == messageReceivedCluster || receiver == con.getMessage().getTo()) {
			this.deleteMessage(con.getMessage().getId(), false);
		}
	}

	/**
	 * Adds a cluster to the operatedCluster, if the does not contain the cluster already.
	 * @param messageReceivedCluster The addable cluster
	 * @param con The connection which holds the sent message.
	 */
	private void updateOperatedClusters(Cluster messageReceivedCluster, Connection con) {
		if (!this.operatedClusters.containsKey(messageReceivedCluster)) {
			this.operatedClusters.put(messageReceivedCluster, new ArrayList<>());
		}
		this.operatedClusters.get(messageReceivedCluster).add(con.getMessage());
	}

	/**
	 * gets distance between both hosts of a given connection.
	 * @param c the given connection
	 * @return circular distance between both directions.
	 */
	public final double getDirectionalDistanceBetweenConnection(Connection c) {
		Direction hostDirection = getHost().getDirection();
		Direction otherHostDirection = c.getOtherNode(getHost()).getDirection();

		return hostDirection.calculateDistanceBetweenThisDirectionAndOther(otherHostDirection);
	}

	/**
	 * Checks if all messages this router holds have reached a certain cluster.
	 * @param messageReceivedCluster the cluster which should get checked
	 * @return boolean
	 */
	protected final boolean didClusterReceivedAllMessages(Cluster messageReceivedCluster) {
		Collection<Message> carriedMessages = getMessageCollection();
		boolean clusterReceivedAllMessages = true;

		for(Message m : carriedMessages) {
			if (!didClusterReceivedMessage(messageReceivedCluster, m)) {
				clusterReceivedAllMessages = false;
				break;
			}
		}

		return clusterReceivedAllMessages;
	}

	/**
	 * Checks if a certain cluster received a message by this router.
	 * @param messageReceivedCluster the cluster which is checked.
	 * @param m the message that should get transferred.
	 * @return true when a cluster received the message already.
	 */
	private boolean didClusterReceivedMessage(Cluster messageReceivedCluster, Message m) {
		boolean clusterReceivedMessage = false;
		List<Message> sentMessages = operatedClusters.get(messageReceivedCluster);
		for (Message sentMessage: sentMessages) { //Can also hold a replica therefore the id's needs to get checked and not the object
			if(m.getId().equals(sentMessage.getId())){
				clusterReceivedMessage = true;
				break;
			}
		}
		return clusterReceivedMessage;
	}

	@Override
	public final boolean isCloakingEnabled() {
		return this.cloakingEnabled;
	}

	public final double getMaxHeight() {
		return maxHeight;
	}

	public final ScriptEngine getEngine() {
		return engine;
	}

	@Override
	public final double getAdjustmentParameter() {return adjustmentParameter; }

	@Override
	public final BlossomRouter replicate() {
		return new BlossomRouter(this);
	}

	@Override
	public final DTNHost getHost() {
		return super.getHost();
	}

	@Override
	public final List<Connection> getConnections() {
		return super.getConnections();
	}

	public final List<ClusterListener> getClusterListener() {
		return cListeners;
	}

	@Override
	public final String toString() {
		String clusterString = "";
		if (getHost().getCluster() != null && getHost().getCluster().getAverageDirection() != null) {
			clusterString = "clusterDirection: " +  getHost().getCluster().getAverageDirection().getDirectionValue();
		}

		return "Blossom{" +
				"direction:" + getHost().getDirection().getDirectionValue() +
				clusterString +
				'}';
	}
}