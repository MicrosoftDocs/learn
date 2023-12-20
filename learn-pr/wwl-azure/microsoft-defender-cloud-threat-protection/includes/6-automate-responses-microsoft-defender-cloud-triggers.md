Automating your organization's monitoring and incident response processes can greatly improve the time it takes to investigate and mitigate security incidents.

To deploy your automation configurations across your organization, use the supplied Azure Policy 'DeployIfNotExist' policies described below to create and configure workflow automation procedures.<br>

## To implement these policies:

1. From the table below, select the policy you want to apply:<br>

:::image type="content" source="../media/workflow-automation-table-3a2e1975.png" alt-text="Screenshot showing workflow automation policies.":::
:::image type="content" source="../media/opening-azure-policy-701b9e5c.png" alt-text="Screenshot showing how to search for an Azure policy.":::


2. From the relevant Azure Policy page, select Assign.

:::image type="content" source="../media/export-policy-assign-647a5a98.png" alt-text="Screenshot showing how to assign and deploy workflow automation for Microsoft Defender for Cloud recommendations.":::


3. Open each tab and set the parameters as desired:

 -  In the **Basics** tab, set the scope for the policy. To use centralized management, assign the policy to the Management Group containing the subscriptions that will use the workflow automation configuration.
 -  In the Parameters tab, enter the required information.

:::image type="content" source="../media/parameters-tab-ec3f9bcb.png" alt-text="Screenshot showing how to edit workflow automation parameters for Microsoft Defender for Cloud recommendations.":::


 -  (Optional), Apply this assignment to an existing subscription in the Remediation tab and select the option to create a remediation task.

4. Review the summary page and select **Create**.
