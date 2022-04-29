The mobile device management (MDM) authority setting determines how you manage your devices. By default, the Intune free trial sets your MDM authority to Intune.

If you are changing your tenant to support Intune, you will need to change your MDM authority configuration. Possible configurations are the following choices:

- **Microsoft Intune** - This cloud-only management configuration includes the full set of capabilities that Microsoft Intune offers.
- **Intune co-management** - This configuration integrates Microsoft Intune with Microsoft Endpoint Configuration Manager. Configuration Manager allows you to manage on-premises Windows 10/11 devices. For more information, see [Enable co-management in Configuration Manager](/mem/configmgr/comanage/tutorial-co-manage-clients?azure-portal=true#enable-co-management-in-configuration-manager).
- **Basic Mobility and Security for Microsoft 365** - If you have this configuration activated, you'll see the MDM authority set to "Office 365". If you want to start using Intune, you'll need purchase an Intune license or sign up for the Intune free trial.
- **Basic Mobility and Security for Microsoft 365 [coexistence](/mem/intune/fundamentals/mdm-authority-set?azure-portal=true#coexistence)** - You can add Intune to your tenant if you're already using Basic Mobility and Security for Microsoft 365 and set the management authority to either Intune or Basic Mobility and Security for Microsoft 365 for each user to dictate which service will be used to manage their MDM-enrolled devices. Each user's management authority is defined based on the license assigned to the user: If the user has only a license for Microsoft 365 Basic or Standard, their devices will be managed by Basic Mobility and Security for Microsoft 365. If the user has a license entitling Intune, their devices will be managed by Intune. If you add a license entitling Intune to a user previously managed by Basic Mobility and Security for Microsoft 365, their devices will be switched to Intune management. Be sure to have Intune configurations assigned to users to replace Basic Mobility and Security for Microsoft 365 before switching users to Intune, otherwise their devices will lose Basic Mobility and Security for Microsoft 365 configuration and won't receive any replacement from Intune.

## Confirm your tenant's MDM authority

To confirm that your MDM authority is set to Intune, use the following steps:

1. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Tenant administration** > **Tenant status**.
2. Under the **Tenant details** tab, find **MDM authority**.

For more information, see [Set the mobile device management authority](/mem/intune/fundamentals/mdm-authority-set?azure-portal=true).