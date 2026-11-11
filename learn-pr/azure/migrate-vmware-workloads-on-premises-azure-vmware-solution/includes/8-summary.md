In this module, you learned how to plan and configure VMware HCX to migrate on-premises vSphere virtual machines into Azure VMware Solution.

You learned how to:

- Check compatibility, lifecycle support, licensing, permissions, capacity, and connectivity for the private-cloud generation you're using, including Generation 2 replication-performance limitations.
- Install HCX Cloud Manager as an add-on and obtain the HCX Connector OVA from the Azure VMware Solution vSAN datastore's `AVS_Official_HCX_Connector_Binaries` folder.
- Use the confirmed activation workflow for the on-premises Connector, configure role-mapped access to its standalone service UI, and distinguish HCX operations from appliance administration.
- Establish site pairing, configure appliance placement and network profiles, and verify the method-specific services in the service mesh.
- Prepare destination networks, including the conditional DHCP security-profile configuration, and validate any optional Network Extension before migrating VMs.
- Check method-specific workload readiness and run a low-risk pilot to size migration waves and cutover windows.
- Use RAV for the live-migration example or Bulk Migration for workloads with an approved outage, validating placement, adapter mappings, and switchover settings before starting.
- Verify migration completion, application behavior, performance, monitoring, and restored backup protection before workload-owner acceptance.
- Use a method-specific recovery plan and coordinate extension removal with gateway, routing, and DHCP handoff before retiring source resources.
- Plan Connector backup and customer-managed updates separately from Microsoft-managed Cloud Manager upgrades.

For the healthcare company, success means accepted production workloads and a controlled network transition, not just a started HCX job. Use the pilot results and application acceptance criteria to decide when each wave is ready and when source dependencies can safely be retired.

## Learn more

Use the following official references when planning and verifying your deployment. Check the documentation for your exact supported release; a versioned guide or interoperability entry isn't evidence that your workload has passed a pilot.

### Plan compatibility, licensing, and connectivity

- [Azure VMware Solution documentation](/azure/azure-vmware/), [private-cloud architecture and limits](/azure/azure-vmware/architecture-private-clouds), and [platform components](/azure/azure-vmware/introduction).
- [HCX software-version requirements](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/preparing-for-hcx-installations/software-version-requirements.html), [Connector support-policy conditions](https://knowledge.broadcom.com/external/article?legacyId=82702), and the [Product Interoperability Matrix](https://interopmatrix.vmware.com/#/Interoperability).
- [Private-cloud generations](/azure/azure-vmware/native-introduction), [Generation 2 network design](/azure/azure-vmware/native-network-design-consideration), [Generation 2 on-premises connectivity](/azure/azure-vmware/native-connect-on-premises), and [Generation 1 Global Reach connectivity](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud).
- [Plan HCX network segments](/azure/azure-vmware/plan-private-cloud-deployment#define-vmware-hcx-network-segments).
- [Portable VMware Cloud Foundation licensing requirements](/azure/azure-vmware/portable-vcf-licensing-reference) and [register portable VCF entitlement](/azure/azure-vmware/vmware-cloud-foundations-license-portability).

### Deploy and register HCX

- [Install VMware HCX in Azure VMware Solution](/azure/azure-vmware/install-vmware-hcx), including add-on installation and the AVS datastore Connector OVA path.
- [HCX binary distribution changes](https://knowledge.broadcom.com/external/article/395372) and [Azure VMware Solution known issues](/azure/azure-vmware/azure-vmware-solution-known-issues).
- [vCenter Server components and services](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere/8-0/vcenter-installation-and-setup/introduction-to-vsphere-installation-and-setup/vcenter-server-components-and-support-tools.html), including integrated authentication services.
- [HCX user accounts and roles](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/preparing-for-hcx-installations/user-account-and-role-requirements.html), [Connector activation and configuration](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/installing-the-hcx-manager-appliance/activate-and-configure-hcx-connector.html), and [HCX licensing](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/preparing-for-hcx-installations/hcx-activation-and-licensing/about-hcx-licensing.html).
- [HCX installation summary and service-UI access](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/getting-started-with-vmware-hcx-4-11/appendix-i-hcx-installation-sequence.html) and [upgrade HCX on Azure VMware Solution](/azure/azure-vmware/upgrade-hcx-azure-vmware-solutions), including configuration backup and upgrade responsibilities.

### Configure profiles, services, and transport

- [Configure VMware HCX](/azure/azure-vmware/configure-vmware-hcx), including service selection, Enterprise entitlement, profiles, and service-mesh health.
- [Add a site pair in the HCX service UI](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/creating-and-managing-site-pairs/add-a-site-pair.html) and [create a compute profile](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/configuring-and-managing-the-hcx-interconnect/configuring-the-hcx-service-mesh/create-a-compute-profile.html), including separate service and appliance-deployment resource selections.
- [Create a network profile in the HCX service UI](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/configuring-and-managing-the-hcx-interconnect/configuring-the-hcx-service-mesh/create-a-network-profile.html).
- [HCX network port and protocol requirements](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/preparing-for-hcx-installations/network-port-and-protocol-requirements.html) and the [vendor port table](https://ports.broadcom.com/home/VMware-HCX). Select the applicable release and check endpoints and direction.
- [Network underlay minimum requirements](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/preparing-for-hcx-installations/network-underlay-minimum-requirements.html) and [service-mesh configuration](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/configuring-and-managing-the-hcx-interconnect/configuring-the-hcx-service-mesh/create-a-service-mesh-for-vsphere-based-site-pairs.html).
- [HCX 4.11.4 release notes](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/hcx-4-11-release-notes/vmware-hcx-4114-release-notes.html) and [HCX service-availability changes](https://knowledge.broadcom.com/external/article/407101/deprecation-of-wan-optimization-in-vmwa.html).

### Prepare, migrate, and accept workloads

- [VMware HCX User Guide](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11.html) and [migration considerations with VMware HCX](/azure/azure-vmware/architecture-migrate).
- [RAV requirements and behavior](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/migrating-virtual-machines-with-vmware-hcx/understanding-vmware-hcx-replication-assisted-vmotion.html), [Bulk Migration requirements and behavior](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/migrating-virtual-machines-with-vmware-hcx/understanding-vmware-hcx-bulk-migration.html), and [additional migration settings](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/migrating-virtual-machines-with-vmware-hcx/additional-migration-settings.html).
- [Bulk Migration operations and best practices](https://knowledge.broadcom.com/external/article/323663/hcx-bulk-migration-operations-and-best.html), including switchover and recovery considerations.
- [HCX interoperability with backup solutions](https://knowledge.broadcom.com/external/article/328980), including snapshot restrictions, file-level protection, and backup resumption.
- [HCX health checks and best practices](https://knowledge.broadcom.com/external/article/371941/hcx-health-check-and-best-practices.html).
- [Migrate workloads to Azure VMware Solution](/azure/cloud-adoption-framework/azure-vmware-solution/migration), covering discovery, assessment, wave planning, cutover, acceptance, and decommissioning.

### Extend networks and complete the gateway handoff

- [Configure HCX Network Extension](/azure/azure-vmware/configure-hcx-network-extension) and [HCX connectivity and extension sequence](/azure/azure-vmware/enable-hcx-access-over-internet#extend-network).
- [Extend networks with HCX](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/extending-networks-with-vmware-hcx/extending-networks-using-vmware-hcx.html) and [network-extension behavior](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/extending-networks-with-vmware-hcx/about-vmware-hcx-network-extension.html).
- [DHCP on HCX-stretched networks](/azure/azure-vmware/configure-l2-stretched-vmware-hcx-networks).
- [Remove a network extension](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/extending-networks-with-vmware-hcx/removing-a-network-extension.html), including the cloud-gateway connection decision.
