After the site pairing, networking profiles, and compute profile configurations finish, the next step involves setting up a service mesh for HCX Manager. The service mesh allows HCX Manager to migrate VMs from an HCX enabled source site (on-premises) to an HCX enabled destination site (AVS).

## What is a service mesh?

A service mesh provides a dedicated infrastructure abstraction layer that helps ease network transport between a source and destination site. The service mesh allows workloads and application services to decouple the networking components required for communication between sites. The service mesh enables a secure and optimized networking transport fabric between any two sites managed by HCX Manager. After enabling the service mesh, VMs can be migrated to AVS.

## Create a service mesh

To successfully establish a service mesh with AVS, the following networking requirements need to be met:

|Requirement | Reason  |
|---------|---------|
| UDP ports 500/4500 | These ports need to be open between the HCX Connector 'uplink' and the AVS HCX Cloud 'uplink' network profile addresses. |
| VMware HCX Manager required ports | Reference the VMware HCX URL at the end of this module. The URL provides a comprehensive list of required open ports between source and destination sites. |

After the networking ports are confirmed and tested as open, you'll go through the following steps to enable a service mesh.

1. From within the HCX Connector dashboard on-premises, under **Infrastructure**, selects **Interconnect > Service Mesh > Create Service Mesh**.

    :::image type="content" source="../media/5-create-service-mesh.png" alt-text="Screenshot of selecting options to create a service mesh in the on-premises HCX Connector.":::

1. Review the pre-populated sites created during site pairing and select **Continue**. If this site is the first service mesh configuration, the first screen doesn't need modification.

1. Select both the source and remote compute profiles from the drop-down lists and select **Continue**. These selections define where VMs can use HCX services for migration.

    :::image type="content" source="../media/5-select-compute-profile-source.png" alt-text="Screenshot that shows selecting the source compute profile on-premises.":::

    :::image type="content" source="../media/5-select-compute-profile-remote.png" alt-text="Screenshot that shows selecting the remote compute profile in Azure VMware Solution.":::

1. Review the services that will be enabled during the service mesh configuration and select **Continue**.

1. In **Advanced Configuration - Override Uplink Network profiles** select **Continue**. Uplink network profiles connect to the network where the remote site's interconnect appliances can be reached.

1. In **Advanced Configuration - Network Extension Appliance Scale Out**, review and select **Continue**. Customers can add up to eight VLANs per appliance on-premises. If more VLANs are required, you'll deploy  another appliance to add another eight VLANs. Customers must also have the CIDR IP address space to account for other appliances. For more information, see the VMware HCX Configuration Limits link at the end of this module.

    :::image type="content" source="../media/5-extend-networks-increase-vlan.png" alt-text="Screenshot that shows where to increase the VLAN count.":::

1. In **Advanced Configuration - Traffic Engineering**, review and make any modifications if necessary and select **Continue**.

1. Review the topology preview and select **Continue**.

1. Enter a user-friendly name for this service mesh and select **Finish** to complete the configuration.

1. Select **View Tasks** to monitor the service mesh deployment.

    :::image type="content" source="../media/5-monitor-service-mesh.png" alt-text="Screenshot that shows the button for viewing tasks.":::

1. When the service mesh deployment finishes successfully, all services will show as green.

    :::image type="content" source="../media/5-service-mesh-green.png" alt-text="Screenshot that displays a finished deployment of the service mesh with all services as green.":::

1. Verify the service mesh's health by checking the appliance status.

1. Select **Interconnect > Appliances**.

    :::image type="content" source="../media/5-interconnect-appliance-state.png" alt-text="Screenshot that shows selections for checking the status of the appliance.":::

In the next unit, we'll cover how to migrate VMs from on-premises to AVS using HCX Manager. All steps will be outlined so you can successfully configure within your environment.