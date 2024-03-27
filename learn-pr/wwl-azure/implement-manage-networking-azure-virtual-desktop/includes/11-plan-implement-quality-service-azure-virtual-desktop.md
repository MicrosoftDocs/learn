RDP Shortpath for managed networks provides a direct UDP-based transport between Remote Desktop Client and Session host. RDP Shortpath for managed networks enables configuration of Quality of Service (QoS) policies for the RDP data.

QoS in Azure Virtual Desktop allows real-time RDP traffic that's sensitive to network delays to "cut in line" in front of traffic that's less sensitive. Example of such less sensitive traffic would be a downloading a new app, where an extra second to download isn't a large deal. QoS uses Windows Group Policy Objects to identify and mark all packets in real-time streams and help your network to give RDP traffic a dedicated portion of bandwidth.

If you support a large group of users experiencing any of the problems described in this unit, you probably need to implement QoS. A small business with few users might not need QoS, but it should be helpful even there.

Without some form of QoS, you might see the following issues:

 -  **Jitter** – RDP packets arriving at different rates, which can result in visual and audio glitches.
 -  **Packet loss** – packets dropped, which results in retransmission that requires another time.
 -  **Delayed round-trip time (RTT)** – RDP packets taking a long time to reach their destinations, which result in noticeable delays between input and reaction from the remote application.

The least complicated way to address these issues is to increase the data connections' size, both internally and out to the internet. Since that is often cost-prohibitive, QoS provides a way to manage the resources you have instead of adding bandwidth more effectively. To address quality issues, we recommend that you first use QoS, then add bandwidth only where necessary.

For QoS to be effective, you must apply consistent QoS settings throughout your organization. Any part of the path that fails to support your QoS priorities can degrade the quality RDP session.

## Quality of Service queues

To provide QoS, network devices must have a way to classify traffic, and must be able to distinguish RDP from other network traffic.

When network traffic enters a router, the traffic is placed into a queue. If a QoS policy isn't configured, there's only one queue, and all data is treated as first-in, first-out with the same priority. That means RDP traffic might get stuck behind traffic where a few extra milliseconds delay wouldn't be a problem.

A simple analogy is that QoS creates virtual "carpool lanes" in your data network. So some types of data never or rarely encounter a delay. Once you create those lanes, you can adjust their relative size, and much more effectively manage the connection bandwidth you have while still delivering business-grade experiences for your organization's users.

## Quality of Service implementation checklist

At a high level, do the steps listed to implement QoS:

1.  Make sure your network is ready.
2.  Make sure that RDP Shortpath for managed networks is enabled - QoS policies aren't supported for reverse connect transport.
3.  Implement insertion of DSCP markers on session hosts.

As you prepare to implement QoS, keep the guidelines listed below in mind:

 -  The shortest path to session host is best.
 -  Any obstacles in between, such as proxies or packet inspection devices, aren't recommended.

## Make sure your network is ready

If you're considering a QoS implementation, you should already have determined your bandwidth requirements and other [network requirements](/windows-server/remote/remote-desktop-services/network-guidance?context=/azure/virtual-desktop/context/context).

Traffic congestion across a network will significantly affect media quality. A lack of bandwidth leads to performance degradation and a poor user experience. As Azure Virtual Desktop adoption and usage grows, use [Log Analytics](/azure/virtual-desktop/diagnostics-log-analytics) to identify problems, and then make adjustments use QoS and selective bandwidth additions.

## VPN considerations

QoS only works as expected when implemented on all links between clients and session hosts. If you use QoS on an internal network and a user signs in from a remote location, you can only prioritize within your internal, managed network. Although remote locations can receive a managed connection by implementing a virtual private network (VPN), a VPN inherently adds packet overhead and creates delays in real-time traffic.

In a global organization with managed links that span continents, we strongly recommend QoS because bandwidth for those links is limited compared to the LAN.

## Insert DSCP markers

You could implement QoS using a Group Policy Object (GPO) to direct session hosts to insert a DSCP marker in IP packet headers identifying it as a particular type of traffic. Routers and other network devices can be configured to recognize these markings and put the traffic in a separate, higher-priority queue.

You can compare DSCP markings to postage stamps that indicate to postal workers how urgent the delivery is and how best to sort it for speedy delivery. Once you've configured your network to give priority to RDP streams, lost packets and late packets should diminish significantly.

Once all network devices are using the same classifications, markings, and priorities, it's possible to reduce or eliminate delays, dropped packets, and jitter. From the RDP perspective, the essential configuration step is the classification and marking of packets. However, for end-to-end QoS to be successful, you also need to align the RDP configuration with the underlying network configuration carefully. The DSCP value tells a correspondingly configured network what priority to give a packet or stream.

We recommend using DSCP value 46 that maps to Expedited Forwarding (EF) DSCP class.
