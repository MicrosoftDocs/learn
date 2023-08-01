Azure Virtual Desktop uses Remote Desktop Protocol (RDP) to provide remote display and input capabilities over network connections.

The connection data flow for Azure Virtual Desktop starts with a DNS lookup for the closest Azure datacenter.

The following image shows the five-step connection process for Azure Virtual Desktop running in Azure.

:::image type="content" source="../media/windows-virtual-desktop-sign-on-flow-f951e564.png" alt-text="Diagram showing the five-step connection process for Azure Virtual Desktop running in Azure.":::


1.  **When authenticated in Azure Active Directory, a token is returned to the Remote Desktop Services client.**
2.  **The gateway checks the token with the connection broker.**
3.  **The broker queries the Azure SQL database for resources assigned to the user.**
4.  **The gateway and the broker select the session host for the connected client.**
5.  **The session host creates a reverse connection to the client by using the Azure Virtual Desktop gateway.**

The inbound ports aren't opened and the gateway is acting as an intelligent reverse proxy. The gateway manages all session connectivity.

Azure Virtual Desktop hosts the client on the session hosts running on Azure. Microsoft manages portions of the services on the customer's behalf and provides secure endpoints for connecting clients and session hosts. The diagram below gives a high-level overview of the network connections used by Azure Virtual Desktop.

:::image type="content" source="../media/azure-virtual-desktop-network-connection-82f668a5.png" alt-text="Diagram showing how Azure Virtual Desktop network connections works":::


## Session connectivity

Azure Virtual Desktop uses Remote Desktop Protocol (RDP) to provide remote display and input capabilities over network connections. RDP has initially released with Windows NT 4.0 Terminal Server Edition and was continuously evolving with every Microsoft Windows and Windows Server release. From the beginning, RDP developed to be independent of its underlying transport stack, and today it supports multiple types of transport.

## Reverse connect transport

Azure Virtual Desktop is using reverse connect transport for establishing the remote session and for carrying RDP traffic. Unlike the on-premises Remote Desktop Services deployments, reverse connect transport doesn't use a TCP listener to receive incoming RDP connections. Instead, its'using outbound connectivity to the Azure Virtual Desktop infrastructure over the HTTPS connection.

## Session host communication channel

Upon startup of the Azure Virtual Desktop session host, the Remote Desktop Agent Loader service establishes the Azure Virtual Desktop broker's persistent communication channel. This communication channel on a secure Transport Layer Security (TLS) connection serves as a bus for service message exchange between the session host and Azure Virtual Desktop.

## Client connection sequence

Client connection sequence described below:

1.  Using supported Azure Virtual Desktop client user subscribes to the Azure Virtual Desktop Workspace.
2.  Azure Active Directory authenticates the user and returns the token used to enumerate resources available to a user.
3.  Client passes token to the Azure Virtual Desktop feed subscription service.
4.  Azure Virtual Desktop feed subscription service validates the token.
5.  Azure Virtual Desktop feed subscription service passes the list of available desktops and RemoteApps back to the client with a digitally signed connection.
6.  Client stores the connection configuration for each available resource in a set of rdp files.
7.  When a user selects the resource to connect, the client uses the associated rdp file and establishes the secure TLS 1.2 connection to the closest Azure Virtual Desktop gateway instance.
8.  Azure Virtual Desktop gateway validates the request and asks the Azure Virtual Desktop broker to orchestrate the connection.
9.  Azure Virtual Desktop broker identifies the session host and uses the previously established persistent communication channel to initialize the connection.
10. Remote Desktop stack initiates the TLS 1.2 connection to the same Azure Virtual Desktop gateway instance as used by the client..
11. After both client and session host connected to the gateway, the gateway starts relaying the raw data between both endpoints. Establishing the base reverse connect transport for the RDP.
12. After the base transport is set, the client starts the RDP handshake.

## Connection security

TLS 1.2 is used for all connections initiated from the clients and session hosts to the Azure Virtual Desktop infrastructure components.

For reverse connect transport, both client and session host connect to the Azure Virtual Desktop gateway. With the TCP connection in place, the client or session host validates the Azure Virtual Desktop gateway's certificate.

RDP establishes a nested TLS connection between client and session host using the session host's certificates.

By default, the certificate used for RDP encryption is self-generated by the OS during the deployment.

## Azure Virtual Desktop RDP Shortpath for managed networks

RDP Shortpath for managed networks is a feature of Azure Virtual Desktop that establishes a direct UDP-based transport between Remote Desktop Client and Session host. RDP uses this transport to deliver Remote Desktop and RemoteApp while offering better reliability and consistent latency.

 -  RDP Shortpath transport is based on the Universal Rate Control Protocol (URCP). URCP enhances UDP with active monitoring of the network conditions and provides fair and full link utilization. URCP operates at low delay and loss levels as needed by Remote Desktop.
 -  RDP Shortpath establishes the direct connectivity between the Remote Desktop client and the session host. Direct connectivity reduces dependency on the Azure Virtual Desktop gateways, improves the connection's reliability, and increases available bandwidth for each user session.
 -  The removal of extra relay reduces round-trip time, which improves user experience with latency-sensitive applications and input methods.
 -  RDP Shortpath brings support for configuring Quality of Service (QoS) priority for RDP connections through Differentiated Services Code Point (DSCP) marks.
 -  RDP Shortpath transport allows limiting outbound network traffic by specifying a throttle rate for each session.
