Microsoft Configuration Manager facilitates comprehensive management of servers supporting the secure and scalable deployment of applications and operating systems. Configuration Manager has an integrated ability to run PowerShell scripts.

You can use Configuration Manager to run a PowerShell script that automates at scale onboarding to Azure Arc-enabled servers.

Before you get started, be sure to review the [prerequisites](/azure/azure-arc/servers/prerequisites) and verify that your subscription and resources meet the requirements. For information about supported regions and other related considerations, see [supported Azure regions](/azure/azure-arc/servers/overview#supported-regions).

### Prerequisites for Configuration Manager to run PowerShell scripts<br>

The following prerequisites must be met to use PowerShell scripts in Configuration Manager:

 -  The Configuration Manager version must be 1706 or higher.
 -  To import and author scripts, your Configuration Manager account must have Create permissions for SMS Scripts.
 -  To approve or deny scripts, your Configuration Manager account must have Approve permissions for SMS Scripts.
 -  To run scripts, your Configuration Manager account must have Run Script permissions for Collections.

### Generate a service principal and prepare the installation script

Before you can run the script to connect your machines.

1.  Follow the steps to [create a service principal for onboarding at scale](/azure/azure-arc/servers/onboard-service-principal#create-a-service-principal-for-onboarding-at-scale). Assign the Azure Connected Machine Onboarding role to your service principal, and limit the scope of the role to the target Azure landing zone. Make a note of the Service Principal Secret, as you'll need this value later.
2.  Follow the steps to [generate the installation script from the Azure portal](/azure/azure-arc/servers/onboard-service-principal#generate-the-installation-script-from-the-azure-portal). While you will use this installation script later, do not run the script in PowerShell.

### Create the script in Configuration Manager

Before you begin, check in Configuration Manager Default Settings that the PowerShell execution policy under **Computer Agent** is set to **Bypass**.

1.  In the **Configuration Manager** console, select **Software Library**.
2.  In the **Software Library** workspace, select **Scripts**.
3.  On the **Home** tab, in the **Create group**, select **Create Script**.
4.  On the **Script** page of the **Create Script** wizard, configure the following settings:
    1.  **Script Name** – Onboard Azure Arc
    2.  **Script language** – PowerShell
    3.  **Import** – Import the installation script that you generated in the Azure portal.
5.  In the **Script Wizard**, paste the script generated from Azure portal. Edit this pasted script with the Service Principal Secret for the service principal you generated.
6.  Complete the wizard. The new script is displayed in the **Script** list with a status of `Waiting for approval`.

### Approve the script in Configuration Manager

With an account that has Approve permissions for SMS Scripts, do the following:

1.  In the **Configuration Manager** console, select **Software Library**.
2.  In the **Software Library** workspace, select **Scripts**.
3.  In the **Script** list, choose the script you want to approve or deny. Then, on the **Home** tab, in the **Script** group, select **Approve/Deny**.
4.  In the **Approve or deny** script dialog box, select **Approve** for the script.
5.  Complete the wizard, then confirm that the new script is shown as **Approved** in the **Script** list.

### Run the script in Configuration Manager

Select a collection of targets for your script by doing the following:

1.  In the **Configuration Manager** console, select **Assets and Compliance**.
2.  In the **Assets and Compliance** workspace, select **Device Collections**.
3.  In the **Device Collections** list, select the collection of devices on which you want to run the script.
4.  Select a collection of your choice, and then select **Run Script**.
5.  On the **Script** page of the **Run Script** wizard, choose the script you authored and approved.
6.  Click **Next**, and then complete the wizard.

### Verify successful connection to Azure Arc

The script status monitoring will indicate whether the script has successfully installed the Connected Machine Agent to the collection of devices. Successfully onboarded Azure Arc-enabled servers will also be visible in the [Azure portal](https://aka.ms/hybridmachineportal).

:::image type="content" source="../media/verify-onboard-configuration-manager-powershell-6185878b.png" alt-text="Screenshot of the Azure portal showing successful onboarding of Azure Arc-enabled servers.":::
