Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

To assign a policy definition to your Kubernetes cluster, you must be assigned the appropriate Azure role-based access control (Azure RBAC) policy assignment operations. The Azure built-in roles **Resource Policy Contributor** and **Owner** have these operations.

Find the built-in policy definitions for managing your cluster using the Azure portal with the following steps. If using a custom policy definition, search for it by name or the category that you created it with.

> [!NOTE]
> To complete this exercise you'll need an [Azure Subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

1. In the Azure portal, search for and select **Policy**.
2.  In the left pane of the Azure Policy page, select **Definitions**.

    :::image type="content" source="../media/policy-definitions-list-392fc18a.png" alt-text="Screenshot of the Azure Policy definitions.":::
    
3.  From the Category dropdown list box, use **Select all** to clear the filter and then select **Kubernetes**.

    :::image type="content" source="../media/kubernetes-policy-definitions-a786abcc.png" alt-text="Screenshot of the Azure Policy definitions for Kubernetes.":::
    
4.  Select the policy definition, then select the **Assign** button.

    :::image type="content" source="../media/policy-assign-definition-e2e4d5b7.png" alt-text="Screenshot of the policy assignment attributes.":::
    
5.  Set the **Scope** to the management group, subscription, or resource group of the Kubernetes cluster where the policy assignment applies.
    
    > [!NOTE]
    > The **Scope** must include the cluster resource when assigning the Azure Policy for Kubernetes definition.
    
    :::image type="content" source="../media/set-scope-policy-definition-676f457d.png" alt-text="Screenshot of the policy definition scope.":::
    
6.  Give the policy assignment a **Name** and **Description** that you can use to identify it easily.
7.  Set the Policy enforcement to one of the values.
    
    
     - **Enabled** - Apply the configured policy effect. A policy with the `Deny` effect rejects matching admission requests that violate the policy. A policy with the `Audit` effect reports noncompliance without rejecting those requests.
     - **Disabled** - Do not enforce this assignment's effect during resource creation or updates. For `Audit` and `Deny` policies, compliance assessment continues. Other policy assignments and admission controls can still reject a request.

    The **Disabled** enforcement mode differs from the `Disabled` policy effect, which turns off evaluation for that policy.

8. Select the **Parameters** tab.
9. Set the required parameter values for the selected policy. If the policy exposes an **Effect** parameter, choose a supported value appropriate to your goal, such as **Audit** for reporting without blocking or **Deny** to block violations. Setting **Policy enforcement** to **Enabled** does not change the selected effect.
10. Select **Review + create**, and select **Create**.
11. In **Policy**, select **Compliance** in the left pane.

    Use the **Scope** filter if needed to include the assignment's scope.

    Assignment synchronization and compliance reporting are asynchronous. Policy assignments can take up to 20 minutes to synchronize into a cluster. Compliance data is updated separately through periodic evaluation and reporting, so the portal might not immediately reflect a new assignment or a recent resource change.

12. Find the assignment you created in the **Name** column and select it to view its compliance details.

    :::image type="content" source="../media/policy-compliance-list-78b0d08d.png" alt-text="Screenshot of the policy compliance status.":::
    

