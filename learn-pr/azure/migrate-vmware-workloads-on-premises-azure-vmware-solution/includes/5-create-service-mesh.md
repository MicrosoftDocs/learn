After the site pairing, networking profiles, and compute profile configurations finish, the next step involves setting up a service mesh for VMware HCX Manager. The service mesh also allows VMware HCX Manager to migrate virtual machines (VMs) from a VMware HCX-enabled source site (on-premises) into a VMware HCX-enabled destination site (Azure VMware Solution).

## What is a service mesh?

A *service mesh* provides a dedicated infrastructure abstraction layer that helps ease network transport between a source and destination site. The service mesh allows workloads and application services to decouple the networking components required for communication between sites. The service mesh enables a secure and optimized networking transport fabric between any two sites managed by VMware HCX Manager. After you enable the service mesh, you can migrate VMware vSphere VMs to Azure VMware Solution.

## Create a service mesh

To successfully establish a service mesh with Azure VMware Solution, you must meet the following networking requirements:

|Requirement | Reason  |
|---------|---------|
| UDP ports 500/4500 | These ports need to be open between the VMware HCX Connector uplink and the Azure VMware Solution HCX Cloud uplink network profile addresses. |
| VMware HCX Manager required ports | See the VMware HCX URL at the end of this module. The URL provides a comprehensive list of required open ports between source and destination sites. |

After you confirm the networking ports and test them as open, take the following steps to enable a service mesh:

1. From within the VMware HCX Connector dashboard on-premises, under **Infrastructure**, select **Interconnect** > **Service Mesh** > **Create Service Mesh**.

    :::image type="content" source="../media/5-hcx-create-service-mesh.png" alt-text="Screenshot of options to select when you're creating a service mesh between the on-premises VMware HCX Connector and Azure VMware Solution."lightbox="../media/5-hcx-create-service-mesh.png":::

1. Review the prepopulated sites created during site pairing, then select **Continue**. If this site is the first service mesh configuration, the first screen doesn't need modification.

1. Select both the source and remote compute profiles from the dropdown lists, then select **Continue**. These selections define where VMs can use VMware HCX services for migration.

    :::image type="content" source="../media/5-select-compute-profile-source.png" alt-text="Screenshot that shows selecting the source compute profile in the on-premises VMware HCX Connector.":::

    :::image type="content" source="../media/5-select-compute-profile-remote.png" alt-text="Screenshot that shows selecting the remote compute profile in Azure VMware Solution.":::

1. Review the services to be enabled during the service mesh configuration, then select **Continue**.

    :::image type="content" source="../media/5-review-services-enabled-configuration.png" alt-text="Screenshot of where to review the services enabled for Azure VMware Solution.":::

1. In **Advanced Configuration - Override Uplink Network profiles**, select **Continue**. This is an optional configuration.

    :::image type="content" source="../media/5-advanced-configuration-optional.png" alt-text="Screenshot of the optional advanced configuration to override uplink network profiles.":::

1. In **Advanced Configuration - Network Extension Appliance Scale Out**, locate the checkbox next to the distributed switch configuration that you configured for the vMotion network profile. You should see that this checkbox is already selected. Leave the checkbox selected and select **Continue**.

1. When you reach **Advanced Configuration - Traffic Engineering**, select **Continue**.

    :::image type="content" source="../media/5-hcx-advanced-configuration-traffic-engineering.png" alt-text="Screenshot displaying that application resiliency can't be selected because there isn't an HCX Enterprise license key."lightbox="../media/5-hcx-advanced-configuration-traffic-engineering.png":::

1. Review the topology preview, then select **Continue**.

    :::image type="content" source="../media/5-hcx-review-topology-preview.png" alt-text="Screenshot of the review topology preview page during creation of the service mesh."lightbox="../media/5-hcx-review-topology-preview.png":::

1. Enter a user-friendly name for this service mesh, then select **Finish** to complete the configuration.

    :::image type="content" source="../media/5-hcx-service-mesh-finish-to-complete.png" alt-text="Screenshot of the final configuration page before creating the service mesh for VM migration."lightbox="../media/5-hcx-service-mesh-finish-to-complete.png":::

1. Select **View Tasks** to monitor the service mesh deployment.

    :::image type="content" source="../media/5-monitor-hcx-service-mesh-tasks.png" alt-text="Screenshot of the button for viewing service mesh configuration tasks in the on-premises VMware HCX Connector."lightbox="../media/5-monitor-hcx-service-mesh-tasks.png":::

1. When the service mesh deployment finishes successfully, all services show as green.

    :::image type="content" source="../media/5-hcx-service-mesh-ready-green.png" alt-text="Screenshot of a finished deployment, where the service mesh displays all services as green in the on-premises VMware HCX Connector."lightbox="../media/5-hcx-service-mesh-ready-green.png":::

1. Verify the health of the on-premises service mesh, by selecting **Interconnect** > **Appliances**. Each tunnel status should be green and indicate **Up**.

    :::image type="content" source="../media/5-hcx-interconnect-appliance-state.png" alt-text="Screenshot of checking the health status of the on-premises HCX appliances."lightbox="../media/5-hcx-interconnect-appliance-state.png":::

1. Next, verify the health of the service mesh in Azure VMware Solution. To verify, navigate to the same **Appliances** page, examine the appliances deployed underneath the on-premises appliances.

    :::image type="content" source="../media/5-interconnect-appliance.png" alt-text="Screenshot of interconnect appliances that were deployed to Azure VMware Solution by enabling the service mesh.":::

In the next unit, we cover how to migrate VMs from on-premises vSphere to Azure VMware Solution by using VMware HCX.
