
## What are point-to-site VPN gateways?

If you've individuals working remotely, then a point-to-site connection is a secure way of allowing them to connect to Azure resources using Windows, Linux or macOS.

:::image type="content" source="../media/4-point-to-site.png" alt-text="A diagram showing a sample point-to-site connection." border="false":::

The key steps to deploy a point-to-site VPN gateway are:

- Create the virtual network that will connect to the on-premises network.

- Create a gateway subnet on your virtual network.

- Create a VPN gateway.

- Generate a root certificate.

- Generate client certificates.

- Add VPN to a client address pool.

- Specify the tunnel type and authentication type.

- Upload the root certificate public key information.

- Install the exported client certificate.

- Configure settings for VPN clients.

- Connect to Azure.

This unit will help to troubleshoot the steps outlined above. It will outline the key problems with the various ways of connecting point-to-site VPNs:

- Certificate-based VPNs

- RADIUS authentication

- Azure AD authentication

- OpenVPN connectivity

## Describe supported protocols for point-to-site VPNS

Point-to-site VPNs support three protocols:

- OpenVPN&reg; is an SSL/TLS based VPN protocol and can be used to connect from Android, iOS (version11.0 and above), Windows, Linux, and Mac devices (macOS versions10.13 and above).

- Secure Socket Tunneling Protocol (SSTP) is a proprietary TLS-based VPN protocol that's only supported on Windows devices.

- IKEv2 VPN is a standards-based IPsec VPN solution used to connect from Mac devices (macOS 10.11 and above).

## What tools can be used to troubleshoot point-to-site VPN gateways?

Troubleshooting a point-to-site VPN can be difficult, but there are tools available that can help to highlight areas before they become a problem.

Microsoft Sentinel helps to prevent cyber-attacks. It detects threats and uses Artificial Intelligence (AI) to investigate and respond. It keeps you informed by creating incidents that you can investigate and resolve.

### Azure Activity Log events

The activity log is accessible from most menus within the Azure portal and will display different information depending on what part of the network you've selected. If you select a virtual network gateway, you'll see activity logs about that gateway. Activity logs can be downloaded as csv files for further analysis.

### Azure Monitor

Azure Monitor also identifies issues before they become a problem. It monitors and diagnoses networking issues without having to log into your virtual machine. Azure Monitor enables you to:

- Trigger package capture.

- Diagnose routing issues.

- Analyze network security group flow logs.

- Gain visibility and control over your Azure network.

:::image type="content" source="../media/4-azure-monitor.jpg" alt-text="A diagram showing an overview of Azure Monitor features." border="false":::

## Network Watcher

Network Watcher is an area where a range of monitoring and diagnostic tools are available.

:::row:::
    :::column:::
        
    :::column-end:::
    :::column:::
        :::image type="content" source="../media/4-network-watcher.png" alt-text="Screenshot of Network watcher troubleshooting area." lightbox="../media/4-network-watcher.png":::
    :::column-end:::
    :::column:::
        
    :::column-end:::
:::row-end:::




## Troubleshoot issues with certificate-based connections

This section looks at key areas to troubleshoot when you create a certificate-based VPN connection.

### Create a VNet

If you amended the address range from the default, did you manually add the subnet? The subnet range is auto populated from the default address space. If you then amend the default address space, you must manually change the subnet.

### Gateway issues

Typical gateway-related error messages or problems are:

- File download error: Target URI isn't specified.

- The connection is established, but you can't connect to Azure resources.

Typical troubleshooting solutions are:

- Check your VNet address range as you might not have enough IP addresses in the range you created in the virtual network.

- Have you specified the correct VPN type? Most configurations use a gateway type of VPN and a VPN that's route-based rather than policy-based.

- Does the selected SKU support the features you need to use? For instance, if you've Mac clients connecting to your network, you can't have a basic SKU. Is the SKU large enough for the bandwidth and CPU required?

- Have you selected the correct virtual network? If you can't see the network, check that you've entered the correct subscription and region.

- Have you reset the gateway?

### Certificates

Typical errors likely to be certificate-based are:

- A certificate that can be used with this Extensible Authentication Protocol couldn't be found. (Error 798.)

- A certificate chain processed but terminated in a root certificate that isn't trusted by the trust provider.

- Failed to save virtual network gateway &lt;gateway name&gt;. Data for certificate &lt;certificate ID&gt; is invalid.

- The message received was unexpected or badly formatted. (Error 0x80090326.)

- Can't install the VPN client.

- Point-to-site clients are suddenly unable to connect.

For any errors relating to certificates, it's worth checking the following:

- Have you obtained the trusted.cer file for the root certificate?

- Have you exported the public certificate data (not the public keys) as a Base4 encoded X.509.cer file?

- Check the status of the root certificate in the Azure portal to see if it has been revoked. If it's OK, delete and reinstall the certificate.

- Have you removed any carriage returns from the text file as the file must be one continuous line?

- Have you only copied the information between Begin Certificate and End Certificate?

- Have you installed the certificate on each client computer?

- Has the certificate rolled over? if so, download and deploy the point-to-site package on all clients again.

### VPN client configuration

Typical client-side messages or problems are:

- Custom script (to update your routing table) failed. (Error 8007026f.)

- Failed to download the file. Error details: error 503. The server is busy.

- VPN clients can't access network file shares.

- VPN Client Error: The remote connection wasn't made because the attempted VPN tunnels failed. (Error 800.)

Some key areas to investigate are:

- The connection might be a temporary network problem, so try downloading the VPN package again after a short time.

- Did you export the client certificate as a .pfx file?

- Delete any shortcuts and open the VPN package directly.

- Check the certificate is installed by opening Manage user certificates and selecting Trusted Root Certification Authorities\Certificates. Ensure that the correct certificate is listed.

- Update Network Interface drivers.

- Disable the caching of domain credentials from the following key.

   :::image type="content" source="../media/4-disable-domain.png" alt-text="Screenshot of code to disable caching of domain credentials.":::

- Check the VPN is active by opening an elevated command prompt and running:

Command prompt

ipconfig/all.

The results should have an IP address contained within the Client Address Pool as specified in your configuration.

:::image type="content" source="../media/4-ip-configure.png" alt-text="Screenshot showing typical results from running ipconfig/all.":::

### Connection problems

Common error messages are:

- The network connection between your computer and the VPN server couldn't be established because the remote server isn't responding.

- The message received was unexpected or badly formatted. (Error 0x80090326.)

- Custom script (to update your routing table) failed. (Error 8007026f.)

Typical solutions are:

- Are you using the correct protocol? Windows only supports IKEv2 if updates are installed, and a registry key locally set.

- Check the user-defined routes (UDR) are set up properly.

## Troubleshoot issues with RADIUS authentication

A RADIUS server integrates with the Active Directory (AD) Server to allow users to sign in using their organization domain credentials. For point-to-site connections using [RADIUS authentication](/azure/vpn-gateway/point-to-site-how-to-radius-ps) you require the following:

- A route-based VPN gateway.

- A RADIUS server, either deployed on the Azure VNet or on-premises, or two servers for high availability.

- A VPN client configuration package for the Windows devices that will connect to the VNet.

:::image type="content" source="../media/4-radius-setup.png" alt-text="A diagram showing the integration of a RADIUS server." border="false":::

Although many of the principles are like site-to-site, there are some important differences:

### Virtual network

- Have you set up three subnet configurations? Some setups use names such as FrontEnd, BackEnd and GatewaySubnet. You can change the names of FrontEnd and BackEnd, but you must not alter GatewaySubnet.

- Have you requested a dynamically assigned Public IP address for the VPN gateway?

### RADIUS server

- Have you checked the settings on the RADIUS server before creating and configuring the virtual network gateway? Common problems are incorrect settings on the RADIUS server.

- Have you configured the VPN gateway as a RADIUS client on the RADIUS and specified the virtual network GatewaySubnet?

- Have you obtained the RADIUS server's IP address and the shared secret that RADIUS clients should use to talk to the server?

- VPN

### VPN gateway

- Have you set up the gateway as VPN and the VPN type as RouteBased?

- Have you set up a [client configuration package](/azure/vpn-gateway/point-to-site-vpn-client-configuration-radius)?

### RADIUS Server and client address pool information

- Have you entered the Radius secret correctly?

- Check you've run the [correct configuration](/azure/vpn-gateway/point-to-site-how-to-radius-ps) for the connection you require.

- SSTP

- OpenVPN

- IKEv2

- SSTP and IKEv2

## Troubleshoot Azure AD authentication issues

When using Azure AD for authentication, you must use the OpenVPN protocol. You can't use a Basic SKU.

To set up an Azure authentication you need two user accounts: a Global Admin account for setting up the gateway and a User account for everyday servicing.

The following checklist can help you troubleshoot VPN connections using point-to-site and Azure Active Directory authentication:

1. Have you opened the Azure VPN client screen and viewed the status log for any error messages?

   :::image type="content" source="../media/4-azure-status-screen.png" alt-text="Screenshot of A Z status log screen." lightbox="../media/4-azure-status-screen.png":::

- Have you cleared the signed-in information and tried to connect?

   :::image type="content" source="../media/4-azure-sign-in-screen.png" alt-text="Screenshot of sign-in screen." lightbox="../media/4-azure-sign-in-screen.png":::

- Have you run diagnostics on the connection?

   :::image type="content" source="../media/4-azure-diagnostic-page.png" alt-text="Screenshot of Azure A D diagnostic page." lightbox="../media/4-azure-diagnostic-page.png":::

- Have you viewed the client log files?

   :::image type="content" source="../media/4-azure-log-directory.png" alt-text="Screenshot of Log Directory area within Azure AD." lightbox="../media/4-azure-log-directory.png":::

## Troubleshoot OpenVPN connectivity issues

If the Open VPN tunnel is failing to connect to an OpenVPN Access Server, the following pointers will help:

- Have you checked the OpenVPN Access Server log files? If you've trouble starting the server, stop it, remove the logs, then start and stop the log immediately to remove unnecessary information. The following commands should be used to obtain the log file:

:::image type="content" source="../media/4-open-vpn-commands.png" alt-text="Open V P N commands to obtain log files.":::

Check the client log files:

- For Windows use - C:\Program Files (x86)\OpenVPN Technologies\OpenVPN Client\etc\log\openvpn_(unique_name).log.

- For Mac use - /Library/Application Support/OpenVPN/log/openvpn_(unique_name).log.

- Have you opened the required three ports: TCP 443, TCP 943, and UDP 1194?

If the OpenVPN tunnel is established, but you can't reach a specific endpoint, these tools might help you to visualize the traffic, to test which path it follows:

- TCPdump ‒ a Linux command-line tool that can visualize network packets.

- WireShark ‒ a Windows GUI tool to visualize network packets.

- Ping ‒ a testing tool to determine if a message can be sent back and forth between a source and destination.

- Traceroute ‒ displays every hop between a source and destination address.

## Use alerts to troubleshoot

Alerts can be set up in the Azure portal or PowerShell to monitor VPN gateway metrics and tunnel resource logs, to quickly detect issues.

**To view the metrics and create alerts**

Go to the virtual gateway resource within the Azure portal. Select **Overview** to see the total tunnel ingress and egress metrics. Other metrics for [monitoring VPN gateways](/azure/vpn-gateway/monitor-vpn-gateway) can be viewed by clicking the Metrics sections and selecting the required metric from the dropdown list. Alerts can be created for any metric by selecting **Alerts** from the **Monitoring** tab. For a resource alert, you select **Create** from the **Log Analytics** page.

## Troubleshoot macOS point-to-site issues

Are you using the correct version? Point-to-site only uses OS version 10.11 or higher.

1. Go to Network Settings, then press Command + Shift, type VPN, and check the following:

   - Server Address – have you entered the server address as a complete Fully Qualified Domain Name (FQDN)?

   - Remote ID ‒ is the remote ID the same as the Server Address (Gateway FQDN)?

   - Local ID – is the local ID the same as the subject of the client certificate?

   :::image type="content" source="../media/4-mac-os-settings.jpg" alt-text="[Screenshot of macOS X setting screen.":::

1. Select **Authentication Settings** – select **Certificate** from the dropdown list then check you've the correct certificate.

   :::image type="content" source="../media/4-mac-os-certificate-authentication.png" alt-text="Screenshot of macOS X authentication certificate screen.":::

1. Still In **Authentication Settings**, change the dropdown to show **Username** and check the credentials are correct.

   :::image type="content" source="../media/4-mac-os-username-authentication.png" alt-text="Screenshot of macOS X authentication username screen.":::

1. If you still experience problems, download Wireshark and run a packet capture.

   1. Filter on **isakmp**, check the **SA proposal** under **Payload: Security Association**, and then check that the source and corresponding destination IP addresses match.

## Troubleshoot client configuration issues

Gateway issues

Examples of possible gateway issues related to certificate are:

- Have you uploaded an Azureclient.pfx certificate without enabling strong private key protection?

- Have you uploaded the AzureRoot.cer certificate?

- Have you checked to see if the certificate has been revoked? This happens if the certificate becomes corrupted.

- Can some people connect whilst others can't? You might need to install another certificate to trust the affected gateway.

- Are you unable to save the certificate? Check whether there are any spaces in the name or if it starts with a number.

Routing

- Are you using non BGP Transit Routing? It isn't supported as BGP is the recommended model.

- Are you running multiple VNets and connecting using an S2S VPN, but some clients can't access particular VNets? You need to use BGP for clients to access the additional VNets.

- If you make changes to the topology of the network, you need to download the VPN client package for Windows again for the changes to be applied.

Split tunneling

Split tunneling can help to reduce high loads and is recommended when you've many remote users or cloud-based services. Different models can be adopted depending on the volume of remote users and/or the number of cloud-based services you've.

you've five options to improve the efficiency of your network:

- VPN Forced Tunnel ‒ 100 percent of traffic goes into VPN tunnel, including on-premises, internet, and all O365/M365. Where many employees work remotely, this can hinder performance of corporate traffic as a high load is being put onto the infrastructure.

- VPN Forced Tunnel with exceptions ‒ the VPN tunnel is used by default, and a few scenarios are allowed to go direct to the Microsoft 365 service. This ensures the traffic that requires the tunnel has a lower contention for resources.

- VPN Forced Tunnel with broad exceptions – the VPN tunnel is used by default with broad exceptions that are allowed to go direct, such as all Microsoft 365, All Salesforce, and All Zoom. This further reduces the load on the corporate VPN infrastructure.

- VPN Selective Tunnel ‒ traffic with a corporate IP address is sent through the VPN tunnel and the internet path is used for all other services. If your services are largely stored in the cloud, then this option is the main model to work towards, although your corporation does need to adopt the Zero Trust model.

- No VPN ‒ uses modern security approaches like Zscaler ZPA, and Azure Active Directory (Azure AD) Proxy/MCAS instead of a VPN.
