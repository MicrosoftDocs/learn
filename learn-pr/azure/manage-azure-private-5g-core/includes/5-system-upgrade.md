To use the latest features that Azure Private 5G Core offers and maintain the support you need for your private mobile network, plan to upgrade your packet core to new releases as they're available.

When a new version is available, Azure Private 5G Core displays a message for the relevant **Packet Core Control Plane** resource through the Azure portal, reminding you to do the upgrade. The network functions of a site won't be available while you upgrade the packet core instance of the site, so [plan your upgrade](#plan-to-upgrade-a-packet-core-instance) carefully before starting the upgrade process.

A new version of the packet core may not be compatible with the version of the underlying system that you use. In that case, you'll need to [upgrade the underlying system](#upgrade-the-underlying-system) first. The Azure portal will warn you about the incompatibility between the new version and the underlying ASE system.

## Plan to upgrade a packet core instance

To minimize the impact of an upgrade to your network services, plan your upgrade process beforehand.

Follow these guidelines when you do the planning:

- Set aside an upgrade window with sufficient time reserved.

  The network functions won't be available during the upgrade and possible rollback.

- Check if you need to [upgrade the underlying system](#upgrade-the-underlying-system) first.

- Back up necessary deployment information.

  Some configuration information will be overwritten during the upgrade. The information you need to back up includes:

  - The account credentials for the packet core dashboards and the distributed tracing tool.
  - The customizations you made to the packet core dashboards.
  - The recovery steps for any UEs that can't automatically re-register.

- For a private mobile network that has multiple sites, upgrade the packet core instance in one site first.

  After the upgrade of the site, summarize what you've learned and then proceed to upgrade the packet core instances in other sites accordingly.  

- Create a test plan to make sure everything works as expected after the upgrade.

  For example, you can check the network statistics through the platform metrics or the packet core dashboards.

## Upgrade a packet core instance

To upgrade a packet core instance, take these steps:

1. Back up necessary deployment information.
1. Open the **Packet Core Control Plan** resource representing the packet core instance that you want to upgrade.
1. Select the **Upgrade version** button.

   The **Upgrade packet core version** box is displayed, as shown in the following screenshot:

   :::image type="content" source="../media/upgrade-packet-core-version.png" alt-text="A screenshot that displays the Upgrade packet core version box." border="true":::

1. Select the version to which you want to upgrade and then select **Modify**.
1. Once the upgrade is done, restore the backed-up deployment information as necessary.
1. Follow your test plan to make sure your network works as expected after the upgrade.

For detailed instructions, see [Upgrade the packet core instance in a site](/azure/private-5g-core/upgrade-packet-core-azure-portal).

If you're familiar with ARM templates, you can also use an ARM template to upgrade a packet core instance. The article [Upgrade the packet core instance in a site - ARM template](/azure/private-5g-core/upgrade-packet-core-arm-template) describes an example ARM template that you can use.

## Roll back a packet core instance

If you encountered issues after an upgrade, you can roll back the packet core instance to a previous version.

The rollback process is the same as the upgrade process. You just need to select a lower version to which you want to roll back. Similar to the upgrade process, you'll need to do similar [planning](#plan-to-upgrade-a-packet-core-instance). For example, if you made any configuration changes for the new version of the packet core, you'll need to do necessary backup before the rollback.

For detailed instructions, see [Upgrade the packet core instance in a site](/azure/private-5g-core/upgrade-packet-core-azure-portal).

## Reinstall a packet core instance

If you're experiencing issues with your deployment, reinstalling the packet core may help return it to a good state.

When you reinstall a packet core instance, Azure Private 5G Core first uninstalls the current instance, and installs a new instance with the existing site configuration.

To reinstall a packet core instance, follow the instructions for [planning](#plan-to-upgrade-a-packet-core-instance) and [performing](#upgrade-a-packet-core-instance) an upgrade. The only difference from the upgrade process is that instead of the **Upgrade version** button, you'll need to select the **Reinstall packet core** button, as shown in the following screenshot:

:::image type="content" source="../media/reinstall-packet-core.png" alt-text="A screenshot that shows the Reinstall packet core button." border="true":::

## Upgrade the underlying system

If a new version of the packet core to which you want to upgrade requires a new version of Azure Stack Edge (ASE), you'll need to upgrade the ASE before upgrading the packet core instance. The article [Packet core and ASE compatibility](/azure/private-5g-core/azure-stack-edge-packet-core-compatibility) provides more information about this version dependency.

When you upgrade ASE, the Azure Kubernetes services running on the ASE will be automatically upgraded.

> [!NOTE]
> Your packet core instance will be affected during the upgrade of its underlying ASE. Plan your service maintenance window as necessary.

For detailed instructions about upgrading ASE, see [Update your Azure Stack Edge Pro GPU](/azure/databox-online/azure-stack-edge-gpu-install-update).
