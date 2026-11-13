In this module, you planned and deployed a standard, single-zone Azure VMware Solution Generation 1 private cloud and connected it to an on-premises VMware vSphere environment by using ExpressRoute Global Reach.

You learned how to:

- Choose a deployment generation and understand why Generation 2 uses a different network and deployment workflow.
- Prepare an eligible subscription, portable VCF registration, valid host quota, a storage-policy-aware capacity assessment, and a permanent address plan.
- Deploy the standard Generation 1 private cloud and connect its managed ExpressRoute circuit to a customer VNet.
- Use Bastion and a privately addressed jumpbox to access vCenter Server and NSX Manager within the supported administrative boundaries.
- Create a customer-circuit authorization and configure the Global Reach connection through the portal or CLI.
- Configure NSX segments, optional DHCP, DNS forwarding, and appropriate connectivity checks.
- Establish capacity and health alerts with an operational owner for a deployment you'll retain.

You've prepared the private cloud and verified the required paths, but network connectivity alone doesn't complete a production migration. Before migrating with HCX, install the AVS add-on and supported on-premises Connector, confirm source compatibility, and configure site pairing, network and compute profiles, and a service mesh. Validate appliance health, tunnels, ports, and the end-to-end MTU.

Confirm workload identity, backup and recovery, usable capacity, licensing, capacity and health alert ownership, and operational readiness before moving production applications. Review the maintenance-readiness result and address any blockers when a maintenance event appears. Microsoft-managed platform maintenance and configuration backups don't replace your workload-protection responsibilities.

## Clean up a disposable deployment

Keep the deployment if you'll continue using it. After completing the entire module, remove exercise resources only if they're no longer needed.

> [!WARNING]
> Deleting the private cloud permanently deletes its workloads and data. Back up anything you must retain before proceeding.

1. Open the private cloud's **Overview** in the Azure portal and select **Delete**.
2. Enter the requested private-cloud name and deletion reason, then confirm. Allow several hours for deletion to finish.
3. Review the remaining exercise-created resources individually. Delete a jumpbox, disk, Bastion, gateway, connection, or public IP only after confirming that it's no longer needed and isn't shared. Don't delete an existing or shared resource group.

Reservation and Broadcom subscription changes are separate decisions. Deleting Azure resources must not be treated as cancellation of those commitments.

## More info

The following official references support the planning and procedures in this module.

### Planning, generations, and licensing

- [Azure VMware Solution documentation](/azure/azure-vmware/)
- [Service overview, software versions, and responsibilities](/azure/azure-vmware/introduction)
- [Plan an Azure VMware Solution deployment](/azure/azure-vmware/plan-private-cloud-deployment)
- [Azure VMware Solution pricing and minimum deployment size](https://azure.microsoft.com/pricing/details/azure-vmware/)
- [Request host quota](/azure/azure-vmware/request-host-quota-azure-vmware-solution)
- [Generation 2 overview](/azure/azure-vmware/native-introduction)
- [Create a Generation 2 private cloud](/azure/azure-vmware/native-create-azure-vmware-virtual-network-private-cloud)
- [Generation 2 network design considerations](/azure/azure-vmware/native-network-design-consideration)
- [Enable the required Generation 2 first-party applications](/azure/azure-vmware/native-first-party-principle-security)
- [Connect Generation 2 to an on-premises environment](/azure/azure-vmware/native-connect-on-premises)
- [Configure portable VCF](/azure/azure-vmware/vmware-cloud-foundations-license-portability)
- [Portable VCF licensing reference](/azure/azure-vmware/portable-vcf-licensing-reference)
- [Transition existing deployments to portable VCF](/azure/azure-vmware/license-included-service-retirement)
- [VCF platform transition](/azure/azure-vmware/architecture-vmware-cloud-foundation)
- [Azure VMware Solution platform updates](/azure/azure-vmware/azure-vmware-solution-platform-updates)
- [Create an AVS assessment with Azure Migrate](/azure/migrate/how-to-create-azure-vmware-solution-assessment)
- [Storage-policy prerequisites](/azure/azure-vmware/configure-storage-policy)
- [Storage policies and fault tolerance](/azure/azure-vmware/architecture-storage#storage-policies-and-fault-tolerance)
- [Stretched-cluster architecture](/azure/azure-vmware/architecture-stretched-clusters)
- [EVC and CPU compatibility](https://knowledge.broadcom.com/external/article/313545/vmware-evc-and-cpu-compatibility-faq.html)

### Deployment and connectivity

- [Deploy Azure VMware Solution and register its provider](/azure/azure-vmware/deploy-azure-vmware-solution)
- [Create a private cloud](/azure/azure-vmware/tutorial-create-private-cloud)
- [Deploy a stretched private cloud and connect both zones](/azure/azure-vmware/deploy-vsan-stretched-clusters)
- [Delete a private cloud](/azure/azure-vmware/tutorial-delete-private-cloud)
- [Reservation exchanges and refunds](/azure/cost-management-billing/reservations/exchange-and-refund-azure-reservations)
- [Azure CLI provider commands](/cli/azure/provider)
- [Resource-provider error diagnosis](/azure/azure-resource-manager/troubleshooting/error-register-resource-provider)
- [Network planning checklist](/azure/azure-vmware/tutorial-network-checklist)
- [Configure Azure VNet connectivity](/azure/azure-vmware/tutorial-configure-networking)
- [Configure a virtual network gateway for ExpressRoute using the Azure portal](/azure/expressroute/expressroute-howto-add-gateway-portal-resource-manager)
- [ExpressRoute gateway settings, throughput, and public-IP behavior](/azure/expressroute/expressroute-about-virtual-network-gateways)
- [Bastion configuration requirements](/azure/bastion/configuration-settings)
- [Connect to a Windows jumpbox through Bastion](/azure/bastion/bastion-connect-vm-rdp-windows)
- [Bastion with peered virtual networks](/azure/bastion/vnet-peering)
- [Bastion routing, DNS, and deployment limitations](/azure/bastion/bastion-faq)
- [Required Bastion service and target-VM NSG rules](/azure/bastion/bastion-nsg)
- [Bastion pricing behavior](/azure/bastion/bastion-faq#how-does-pricing-work)
- [ExpressRoute Global Reach](/azure/expressroute/expressroute-global-reach)
- [ExpressRoute encryption boundaries](/azure/expressroute/expressroute-about-encryption)
- [ExpressRoute feature and throughput FAQ](/azure/expressroute/expressroute-faqs)
- [ExpressRoute routing requirements and prefix limits](/azure/expressroute/expressroute-routing#route-aggregation-and-prefix-limits)
- [Connect an on-premises environment to AVS with Global Reach](/azure/azure-vmware/tutorial-expressroute-global-reach-private-cloud)
- [ExpressRoute authorization CLI commands](/cli/azure/network/express-route/auth)
- [AVS Global Reach CLI commands](/cli/azure/vmware/global-reach-connection)
- [AVS Global Reach API and address allocation](/rest/api/avs/global-reach-connections/create-or-update)
- [AVS interconnectivity and service limits](/azure/azure-vmware/architecture-networking)
- [Network transit and management return-route design](/azure/azure-vmware/architecture-network-design-considerations)
- [Arc resource bridge network and address requirements](/azure/azure-arc/resource-bridge/network-requirements)

### NSX, HCX, and operations

- [Add an NSX network segment in Azure VMware Solution](/azure/azure-vmware/tutorial-nsx-t-network-segment)
- [Create an additional NSX Tier-1 gateway](/azure/azure-vmware/tutorial-nsx-tier-1-gateway)
- [Configure DHCP](/azure/azure-vmware/configure-dhcp-azure-vmware-solution)
- [AVS DHCP resource model](/rest/api/avs/workload-networks/create-dhcp)
- [AVS DHCP server CLI](/cli/azure/vmware/workload-network/dhcp/server)
- [DHCP scope planning](/windows-server/networking/technologies/dhcp/dhcp-deploy-wps)
- [NSX DHCP server profiles](https://techdocs.broadcom.com/us/en/vmware-cis/nsx/vmware-nsx/4-2/administration-guide/networking-settings/add-an-nsx-dhcp-profile/add-an-nsx-dhcp-server-profile.html)
- [NSX Gateway and Segment DHCP configuration settings](https://techdocs.broadcom.com/us/en/vmware-cis/nsx/vmware-nsx/4-2/administration-guide/nsx-dhcp-policy-ui/configure-nsx-dhcp-service/nsx-dhcp-configuration-settings-reference.html)
- [NSX DHCP relay behavior](https://techdocs.broadcom.com/us/en/vmware-cis/nsx/vmware-nsx/4-2/administration-guide/nsx-dhcp-policy-ui/configure-nsx-dhcp-service/configure-dhcp-relay-on-an-nsx-segment.html)
- [Configure DNS forwarding](/azure/azure-vmware/configure-dns-azure-vmware-solution)
- [Configure temporary port mirroring](/azure/azure-vmware/configure-port-mirroring-azure-vmware-solution)
- [Manage and remove AVS port-mirroring profiles](/cli/azure/vmware/workload-network/port-mirroring)
- [NSX port-mirroring behavior](https://techdocs.broadcom.com/us/en/vmware-cis/nsx/vmware-nsx/4-2/administration-guide/network-monitoring/add-a-port-mirroring-session.html)
- [Enable Managed SNAT](/azure/azure-vmware/enable-managed-snat-for-workloads)
- [Internet connectivity design choices](/azure/azure-vmware/architecture-design-public-internet-access)
- [Install HCX and obtain the Connector](/azure/azure-vmware/install-vmware-hcx)
- [Configure HCX and validate its service mesh](/azure/azure-vmware/configure-vmware-hcx)
- [DHCP on HCX L2-extended networks](/azure/azure-vmware/configure-l2-stretched-vmware-hcx-networks)
- [HCX port requirements](https://ports.broadcom.com/home/VMware-HCX)
- [Cross-vCenter vMotion network requirements](https://knowledge.broadcom.com/external/article?legacyId=2106952)
- [HCX vMotion and cold-migration requirements](https://techdocs.broadcom.com/us/en/vmware-cis/hcx/vmware-hcx/4-11/vmware-hcx-user-guide-4-11/migrating-virtual-machines-with-vmware-hcx/understanding-vmware-hcx-vmotion-and-cold-migration.html)
- [Private-cloud maintenance](/azure/azure-vmware/azure-vmware-solution-private-cloud-maintenance)
- [Maintenance scheduling and restrictions](/azure/azure-vmware/maintenance-orchestration)
- [Configure AVS alerts](/azure/azure-vmware/configure-alerts-for-azure-vmware-solution)
- [Current AVS metrics](/azure/azure-vmware/configure-azure-vmware-solution-metrics)
- [AVS metric names and dimensions](/azure/azure-monitor/reference/supported-metrics/microsoft-avs-privateclouds-metrics)
- [Configure AVS Resource Health alerts](/azure/azure-vmware/configure-azure-monitor-for-resource-health-for-azure-vmware-solution)
- [Configure Service Health alerts](/azure/service-health/alerts-activity-log-service-notifications-portal)
- [Configure and test notification action groups](/azure/azure-monitor/alerts/action-groups)
- [Private-cloud configuration backup and restore](/azure/azure-vmware/architecture-private-clouds#backup-and-restore)
- [Workload VM backup options](/azure/azure-vmware/ecosystem-back-up-vms)
- [Identity and administrative access](/azure/azure-vmware/architecture-identity)