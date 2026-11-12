After site pairing and profile configuration, create a VMware HCX service mesh between the on-premises environment and Azure VMware Solution.

## What is a service mesh?

A *service mesh* defines and deploys the service appliances and transport connections needed for the selected HCX services at the paired sites. It uses the source and destination compute profiles to determine appliance placement, network configuration, and available services. A healthy service mesh provides the transport used for migration and, if selected, Network Extension.

## Confirm transport requirements

Allow UDP 4500 between the on-premises HCX service-appliance uplink addresses and their Azure VMware Solution peer uplink addresses. Complete the other endpoint-specific rules required by the installed HCX release and enabled services before creating the service mesh. Site pairing separately requires TCP 443 between the Connector and Cloud Manager.

Plan transport capacity for the migration method and the number of simultaneous migrations. Measure the underlay and meet the bandwidth, latency, and MTU requirements for the installed HCX release.

For the HCX 4.11 deployment covered here, the documented bandwidth minimum is 250 Mbps for HCX vMotion or Replication Assisted vMotion (RAV) and 50 Mbps for Bulk Migration. Meeting a minimum doesn't guarantee a migration duration or application SLA. Workload size, change rate, latency, and concurrency can require more capacity.

Use HCX Transport Analytics, where available, to understand underlay performance and plan Bulk Migration concurrency. Use pilot results to set realistic wave sizes and cutover windows.

Optional Traffic Engineering features address specific network needs. Application Path Resiliency selects an available transport path. It doesn't aggregate paths to increase throughput. TCP segment-size tuning for Network Extension isn't a substitute for adequate migration bandwidth.

## Create a service mesh

Open the on-premises HCX Connector service UI at `https://<connector-ip-or-fqdn>` on TCP 443. Sign in with a vCenter SSO account in a group mapped to an HCX role that permits these operations. This isn't the appliance management interface on TCP 9443, which uses local `admin` credentials.

After confirming routing, required ports, and available appliance resources, complete the following steps:

1. In the HCX Connector service UI, select **Infrastructure** > **Interconnect** > **Service Mesh** > **Create Service Mesh**.
2. Review the prepopulated source and destination sites, then select **Continue**. For the first mesh, these should be the sites you paired in the previous unit.
3. Select the on-premises source compute profile and the Azure VMware Solution-provided destination compute profile. Confirm the intended placement and that both profiles make the required services available. If changes are needed at the destination, use the supported feature-edit workflow rather than recreating the cloud profiles. Select **Continue**.
4. Review the services selected for the mesh. Enable **Hybrid Interconnect** and **Replication Assisted vMotion** for RAV, and confirm the applicable Enterprise entitlement. Enable **Hybrid Interconnect** and **Bulk Migration** for Bulk. If demonstrating both methods with different VMs, enable both migration services. Enable **Network Extension** only if your network plan requires it. Resolve unavailable services at either site before selecting **Continue**.
5. In **Advanced Configuration - Override Uplink Network profiles**, retain the profiles selected in the compute profiles unless your network design requires an override, then select **Continue**.
6. If using Network Extension, review **Advanced Configuration - Network Extension Appliance Scale Out**. Size the extension appliances for the eligible workload network containers, available resources, and address pools. Don't choose a switch merely because it carries vMotion. If extension isn't part of the plan, don't add extension capacity. Select **Continue**.
7. In **Advanced Configuration - Traffic Engineering**, review any optional features required by the design and their additional network requirements. Otherwise, retain the applicable defaults and select **Continue**.
8. Review the topology preview. Confirm the selected sites, services, networks, and appliance placement, then select **Continue**.
9. Enter a name for the service mesh and select **Finish**.
10. Select **View Tasks** and monitor deployment. Resolve failed tasks rather than proceeding with a partially deployed mesh.

## Verify the service mesh

1. Confirm that the services you selected report healthy status after deployment.
2. Open **Interconnect** > **Appliances** and check the appliances at both the source and destination.
3. Confirm that the required interconnect tunnels show **Up** in green.
4. Run the available service-mesh diagnostics and investigate connectivity or appliance errors before migrating production VMs.

> [!NOTE]
> If you add a service to a compute profile that's already used by a healthy mesh, open **Interconnect** > **Service Mesh**, select the affected mesh, and use **Resync**. Confirm that the resulting service selection and appliance health match the updated profile. Resync applies profile changes; it isn't a software upgrade or a substitute for troubleshooting an unhealthy mesh.

A healthy mesh is an infrastructure readiness check, not confirmation that a workload migration has succeeded. In the next unit, you'll prepare destination networks, perform a pilot, migrate VMs, and verify the applications after cutover.
