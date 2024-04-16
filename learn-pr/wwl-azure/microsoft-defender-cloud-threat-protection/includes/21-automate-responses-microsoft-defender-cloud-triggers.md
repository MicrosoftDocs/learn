Automating your organization's monitoring and incident response processes can greatly improve the time it takes to investigate and mitigate security incidents.

To deploy your automation configurations across your organization, use the supplied Azure Policy 'DeployIfNotExist' policies described below to create and configure workflow automation procedures.<br>

To implement these policies:

1.  From the table below, select the policy you want to apply:
    
    | **Goal**                                              | **Policy**                                                                        | **Policy ID**                        |
    | ----------------------------------------------------- | --------------------------------------------------------------------------------- | ------------------------------------ |
    | Workflow automation for security alerts               | Deploy Workflow Automation for Microsoft Defender for Cloud alerts                | f1525828-9a90-4fcf-be48-268cdd02361e |
    | Workflow automation for security recommendations      | Deploy Workflow Automation for Microsoft Defender for Cloud recommendations       | 73d6ab6c-2475-4850-afd6-43795f3492ef |
    | Workflow automation for regulatory compliance changes | Deploy Workflow Automation for Microsoft Defender for Cloud regulatory compliance | 509122b9-ddd9-47ba-a5f1-d0dac20be63c |
2.  From the relevant Azure Policy page, select **Assign**.
3.  Open each tab and set the parameters as desired:
     -  In the **Basics** tab, set the scope for the policy. To use centralized management, assign the policy to the Management Group containing the subscriptions that will use the workflow automation configuration.
     -  In the **Parameters** tab, enter the required information.
     -  (Optional), Apply this assignment to an existing subscription in the Remediation tab and select the option to create a remediation task.
4.  Review the summary page and select **Create**.
