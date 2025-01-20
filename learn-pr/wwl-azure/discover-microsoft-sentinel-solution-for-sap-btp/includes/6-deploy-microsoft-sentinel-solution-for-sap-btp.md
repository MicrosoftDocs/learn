This unit describes how to use the SAP BTP connector to deploy the Microsoft Sentinel solution for SAP BTP systems.

## Examine prerequisites

Before you begin, verify that:

- The Microsoft Sentinel solution is enabled.
- You have a defined Microsoft Sentinel workspace, and you have read and write permissions to the workspace.
- Your organization uses SAP BTP (in a Cloud Foundry environment) to streamline interactions with SAP applications and other business applications.
- You have an SAP BTP account (which supports BTP accounts in the Cloud Foundry environment). You can also use an [SAP BTP trial account](https://cockpit.hanatrial.ondemand.com/).
- You have the SAP BTP auditlog-management service and service key (see below).
- You have the **Microsoft Sentinel Contributor** role on the target Microsoft Sentinel workspace.

## Set up the BTP account and solution

To set up the BTP account and the solution:

1. After you verify that you meet the prerequisites and sign in to your BTP account, follow the [audit log retrieval steps](https://help.sap.com/docs/btp/sap-business-technology-platform/audit-log-retrieval-api-usage-for-subaccounts-in-cloud-foundry-environment) on the SAP BTP system.
1. In the SAP BTP cockpit, select the **Audit Log Management Service**.
    :::image type="content" source="../media/btp-audit-log-management-service.png" alt-text="Screenshot that shows selecting the BTP Audit Log Management Service." lightbox="../media/btp-audit-log-management-service.png":::

1. Create an instance of the Audit Log Management Service in the BTP subaccount.

1. Create a service key and record the values for `url`, `uaa.clientid`, `uaa.clientecret`, and `uaa.url`. These values are required to deploy the data connector. For example:
    - **url**: `https://auditlog-management.cfapps.us10.hana.ondemand.com`
    - **uaa.clientid**: `00001111-aaaa-2222-bbbb-3333cccc4444|auditlog-management!b1237`
    - **uaa.clientsecret**: `aaaaaaaa-0b0b-1c1c-2d2d-333333333333`
    - **uaa.url**: `https://trial.authentication.us10.hana.ondemand.com`
1. Sign in to the [Azure portal](https://portal.azure.com), and then go to the Microsoft Sentinel service.
1. Select **Content hub** and, in the search bar, search for *BTP*.
1. Select **SAP BTP**, and then select **Install**.
    For more information about how to manage the solution components, see [Discover and deploy out-of-the-box content](/azure/sentinel/sentinel-solutions-deploy).
1. Select **Create**.
    :::image type="content" source="../media//sap-btp-create-solution.png" alt-text="Screenshot that shows how to create the Microsoft Sentinel solution  for SAP BTP." lightbox="../media/sap-btp-create-solution.png":::

1. Select the resource group and the Microsoft Sentinel workspace in which to deploy the solution.
1. Select **Next** until you pass validation, and then select **Create**.
1. When the solution deployment is finished, return to your Microsoft Sentinel workspace and select **Data connectors**.
1. In the search bar, enter **BTP**, and then select **SAP BTP**.
1. Select **Open connector page**.
1. Make sure that you meet the listed prerequisites and complete the configuration steps. When you're ready, select **Add account**.
1. Enter the parameters that you defined earlier during the configuration. The subaccount name appears as a column in the `SAPBTPAuditLog_CL` table, and you can use it to filter the logs if you have multiple subaccounts.

    > [!NOTE]
    > Retrieving audits for the global account doesn't automatically retrieve audits for the subaccount. Follow the connector configuration steps for each of the subaccounts you want to monitor, and also follow these steps for the global account. Review these account auditing configuration considerations, as described in the next section.

1. Make sure that BTP logs are flowing into the Microsoft Sentinel workspace:
    1. Sign in to your BTP subaccount and run a few activities that generate logs, such as sign-ins, adding users, changing permissions, and changing settings.
    1. Wait 20 to 30 minutes to allow the logs to start flowing.
    1. On the **SAP BTP** connector page, confirm that Microsoft Sentinel is receiving the BTP data, or query the **SAPBTPAuditLog_CL** table directly.
1. Enable the workbook and the analytics rules that are provided as part of the solution by following [these guidelines]( /azure/sentinel/sentinel-solutions-deploy?tabs=azure-portal#analytics-rule).

## Consider your account auditing configurations

The final step in the deployment process is to consider your global account and subaccount auditing configurations.

### Consider global account auditing configuration

To use the Audit Log Management Service in a subaccount under a directory in the BTP cockpit, you must first activate the service at the directory level. After that, you can activate it for the specific subaccount.

### Consider subaccount auditing configuration

To enable auditing for a subaccount, complete the steps in the [SAP subaccounts audit retrieval API documentation](https://help.sap.com/docs/btp/sap-business-technology-platform/audit-log-retrieval-api-usage-for-subaccounts-in-cloud-foundry-environment). The API documentation describes how to enable the audit log retrieval by using the Cloud Foundry CLI.

You also can retrieve the logs via the UI:

1. In your subaccount in SAP Service Marketplace, create an instance of **Audit Log Management Service**.
1. In the new instance, create a service key.
1. View the service key and retrieve the required parameters from step 4 of the configuration instructions in the data connector UI (**url**, **uaa.url**, **uaa.clientid**, and **uaa.clientsecret**).

> [!NOTE]
> We recommend that you periodically rotate the BPT subaccount client secrets. For more information, including a sample script, see [Rotate the BTP client secret](/azure/sentinel/sap/deploy-sap-btp-solution#rotate-the-btp-client-secret).
