NPS performs centralized connection authentication, authorization, and accounting for wireless, RD Gateway servers, authenticating switches, VPNs, and dial-up connections. But Contoso must first configure the network policies that NPS uses to authorize connection requests, and they can also choose to configure RADIUS accounting so that NPS logs accounting information to log files on the local hard disk or in a Microsoft SQL Server database.

## Choose an NPS authentication method

NPS authenticates and authorizes a connection request before allowing or denying access when users attempt to connect to your network through NASs. When you deploy NPS, you can specify the required type of authentication method for access to your network.

The following authentication methods are supported by NPS:

* PAP
* Shiva Password Authentication Protocol (SPAP)
* CHAP
* MS-CHAP
* MS-CHAP v2
* EAP

> [!TIP]
> When you choose EAP as the authentication method, the negotiation of the EAP type occurs between the access client and the NPS server.

> [!CAUTION]
> You shouldn't use PAP, SPAP, CHAP, or MS-CHAP in a production environment as they are considered highly insecure.

## NPS accounting

You also need to consider how you should configure logging for NPS. You can log user authentication requests and accounting requests to log files in text format or database format, or you can log to a stored procedure in a Microsoft SQL Server database. Use request logging primarily for connection analysis and billing purposes, and as a security investigation tool, because it enables you to identify a hacker’s activity.

## Configure policies on NPS

NPS supports connection request policies and network policies. These are described in the following table.

| Type                      | Description                                                  |
| ------------------------- | ------------------------------------------------------------ |
| Connection request policy | Connection request policies allow you to choose whether the local NPS server processes connection requests or forwards them to another RADIUS server for processing |
| Network policy            | Network policies allow you to designate which users you authorize to connect to your network and the circumstances under which they can or can't connect. |

### Establish network policies

A network policy is a set of conditions, constraints, and settings that enable you to designate who you will authorize to connect to the network, and the circumstances under which they can or can't connect. Each network policy has four categories of properties.

| Property    | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| Overview    | Overview properties allow you to specify whether the policy is enabled, whether the policy grants or denies access, and whether connection requests require a specific network connection method or type of network access server. Overview properties also enable you to specify whether to ignore the dial-in properties of user accounts in AD DS. If you select this option, NPS uses only the network policy’s settings to determine whether to authorize the connection. |
| Conditions  | These properties allow you to specify the conditions that the connection request must have to match the network policy. If the conditions that are configured in the policy match the connection request, NPS applies the network policy settings to the connection. For example, if you specify the network access server IPv4 address (NAS IPv4 address) as a condition of the network policy, and NPS receives a connection request from a NAS that has the specified IP address, the condition in the policy matches the connection request. |
| Constraints | Constraints are additional parameters of the network policy that are required to match the connection request. If the connection request doesn't match a constraint, NPS rejects the request automatically. Unlike the NPS response to unmatched conditions in the network, if a constraint doesn't match, NPS doesn't evaluate additional network policies, and denies the connection request. |
| Settings    | The Settings properties allow you to specify the settings that NPS applies to the connection request, provided that all of the policy’s network policy conditions match and the request is accepted. |

> [!IMPORTANT]
> When you first deploy the NPS role, the two default network policies deny remote access to all connection attempts. You can then configure additional network policies to manage connection attempts.

:::image type="content" source="../media/m15-nps-1.png" alt-text="A screenshot of the Network Policy Server dialog box. The administrator has created a policy called Contoso Policy. The default policies are also visible.":::

When NPS authorizes a connection request, it compares the request with each network policy in the ordered list of policies, starting with the first policy and moving to the next item on the list. If NPS finds a policy in which the conditions match the connection request, NPS uses the matching policy and the dial-in properties of the user account to authorize the request. If you configure the dial-in properties of the user account to grant or control access through network policy, and the connection request is authorized, NPS applies the settings that you configure in the network policy to the connection:

- If NPS doesn't find a network policy that matches the connection request, NPS rejects the connection.
- If the dial-in properties of the user account are set to deny access, NPS rejects the connection request anyway.

This is summarized in the following diagram.

:::image type="content" source="../media/m15-nps-flow.png" alt-text="A diagram displays the flow process that NPS uses to determine user access based on policies." border="false":::
