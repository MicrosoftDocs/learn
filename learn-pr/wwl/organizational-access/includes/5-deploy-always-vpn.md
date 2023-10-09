

You most likely have the technologies you can use to deploy Always On VPN. Other than your DC/DNS servers, the Always On VPN deployment requires an NPS (RADIUS) server, a Certification Authority (CA) server, and a Remote Access (Routing/VPN) server. Once the infrastructure is set up, you must enroll clients, and then connect the clients to your on-premises securely through several network changes.

When preparing for Always On VPN deployment, you should ensure that you have the following components in place:

 -  Active Directory domain infrastructure, including one or more Domain Name System (DNS) servers. Both internal and external Domain Name System (DNS) zones are required, which assumes that the internal zone is a delegated subdomain of the external zone (for example, corp.contoso.com and contoso.com).
 -  Active Directory-based public key infrastructure (PKI) and Azure Active Directory Certificate Services (AD CS).
 -  Physical server, existing or new, to install Network Policy Server (NPS). If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than add a new server.
 -  Remote Access as a RAS Gateway VPN server with features supporting IKEv2 VPN connections and LAN routing.
 -  Perimeter network that includes two firewalls. Ensure that your firewalls allow the traffic necessary for both VPN and RADIUS communications to function properly.
 -  Physical server or VM on your perimeter network with two physical Ethernet network adapters to install Remote Access as a RAS Gateway VPN server. VMs require virtual LAN (VLAN) for the host.
 -  Membership in Administrators, or equivalent, is the minimum required.
 -  Management platform of your choice for deploying the Always On VPN configuration because the CSP isn't vendor-specific.

The following illustration shows the infrastructure required to deploy Always On VPN.

:::image type="content" source="../media/vpn-perimeter-diagram-97027b4d.png" alt-text="Diagram showing the Always On VPN infrastructure.":::


For more information, see [Deploy Always On VPN](/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-deploy-deployment).
