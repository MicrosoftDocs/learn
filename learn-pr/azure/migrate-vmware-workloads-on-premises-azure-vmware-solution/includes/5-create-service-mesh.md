After the site pairing, networking profiles, and compute profile configurations finish, the next step involves setting up a service mesh for VMware HCX (HCX) Manager. The service mesh also allows HCX Manager to migrate VMs from an HCX enabled source site (on-premises) into an HCX enabled destination site (Azure VMware Solution - AVS).

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

    :::image type="content" source="../media/5-create-service-mesh.png" alt-text="Screenshot of options to select when creating a service mesh between the on-premises HCX Connector and AVS.":::

1. Review the pre-populated sites created during site pairing and select **Continue**. If this site is the first service mesh configuration, the first screen doesn't need modification.

    :::image type="content" source="../media/5-pre-populated-sites.png" alt-text="Screenshot of pre-populated site pairing created earlier in the last Learn unit of the module.":::

1. Select both the source and remote compute profiles from the drop-down lists and select **Continue**. These selections define where VMs can use HCX services for migration.

    :::image type="content" source="../media/5-select-compute-profile-source.png" alt-text="Screenshot that shows selecting the source compute profile in the on-premises HCX Connector.":::

    :::image type="content" source="../media/5-select-compute-profile-remote.png" alt-text="Screenshot that shows selecting the remote compute profile in Azure VMware Solution.":::

1. Review the services that will be enabled during the service mesh configuration and select **Continue**.

    :::image type="content" source="../media/5-review-services-enabled-configuration.png" alt-text="Screenshot of where to review the services enabled for Azure VMware Solution.":::

1. In **Advanced Configuration - Override Uplink Network profiles** select **Continue**. This is an optional configuration you don't need to make.

    :::image type="content" source="../media/5-advanced-configuration-optional.png" alt-text="Screenshot of the optional advanced configuration to override uplink network profiles.":::

1. In **Advanced Configuration - Network Extension Appliance Scale Out**, leave the check mark in the box next to the distributed switch configuration you configured for the vMotion network profile and then select **Continue**.

1. When you reach **Advanced Configuration - Traffic Engineering**, select **Continue**. You don't have an HCX Enterprise key for this configuration.

    :::image type="content" source="../media/5-advanced-configuration-traffic-engineering.png" alt-text="Screenshot displaying that application resiliency can't be selected because there is not an HCX Enterprise license key.":::

1. Review the topology preview and select **Continue**.

    :::image type="content" source="../media/5-review-topology-preview.png" alt-text="Screenshot of the review topology preview pane during creation of the service mesh.":::

1. Enter a user-friendly name for this service mesh and select **Finish** to complete the configuration.

    :::image type="content" source="../media/5-create-service-mesh-finish.png" alt-text="Screenshot of the final configuration pane before creating the service mesh for VM migration.":::

1. Select **View Tasks** to monitor the service mesh deployment.

    :::image type="content" source="../media/5-monitor-service-mesh.png" alt-text="Screenshot of the button for viewing service mesh configuration tasks in the on-premises HCX Connector.":::

1. When the service mesh deployment finishes successfully, all services will show as green.

    :::image type="content" source="../media/5-service-mesh-green.png" alt-text="Screenshot of a finished deployment where the service mesh displays all services as green in the on-premises HCX Connector.":::

1. Verify the on-premises service mesh's health by selecting **Interconnect > Appliances** to view the health of the on-premises deployment. The tunnels should be green and say "Up".

    :::image type="content" source="../media/5-interconnect-appliance-state.png" alt-text="Screenshot of checking the health status of the on-premises HCX appliances.":::

1. Next, verify the service mesh's health in AVS by examining the appliances deployed underneath the on-premises appliances in the same **Appliance** pane.

    :::image type="content" source="../media/5-interconnect-appliance-avs.png" alt-text="Screenshot of interconnect appliances that were deployed to AVS by enabling the service mesh.":::

In the next unit, we'll cover how to migrate VMs from on-premises to AVS using HCX Manager. All steps will be outlined so you can successfully configure within your environment.