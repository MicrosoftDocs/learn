
To assign a policy definition to your Kubernetes cluster, you must be assigned the appropriate Azure role-based access control (Azure RBAC) policy assignment operations. The Azure built-in roles **Resource Policy Contributor** and **Owner** have these operations.

Find the built-in policy definitions for managing your cluster using the Azure portal with the following steps. If using a custom policy definition, search for it by name or the category that you created it with.

1.  Select in the left pane and then search for and select **Policy**.
2.  In the left pane of the Azure Policy page, select **Definitions**. :::image type="content" source="../media/policy-definitions-list-392fc18a.png" alt-text="Displays a screenshot of the Azure Policy definitions.":::
    
3.  From the Category dropdown list box, use **Select all** to clear the filter and then select **Kubernetes**. :::image type="content" source="../media/kubernetes-policy-definitions-a786abcc.png" alt-text="Displays a screenshot of the Azure Policy definitions for Kubernetes.":::
    
4.  Select the policy definition, then select the **Assign** button. :::image type="content" source="../media/policy-assign-definition-e2e4d5b7.png" alt-text="Displays a screenshot of the policy assignment attributes.":::
    
5.  Set the **Scope** to the management group, subscription, or resource group of the Kubernetes cluster where the policy assignment applies.
    
    > [!NOTE]
    > The **Scope** must include the cluster resource when assigning the Azure Policy for Kubernetes definition.
    
    :::image type="content" source="../media/set-scope-policy-definition-676f457d.png" alt-text="Displays a screenshot of the policy definition scope.":::
    
6.  Give the policy assignment a **Name** and **Description** that you can use to identify it easily.
7.  Set the Policy enforcement to one of the values.
    
    
     -  **Enabled** \- Enforce the policy on the cluster. Kubernetes admission requests with violations are denied.
     -  **Disabled** \- Don't enforce the policy on the cluster. Kubernetes admission requests with violations aren't denied. Compliance assessment results are still available. The *Disabled* option is helpful for testing the policy definition as admission requests with violations aren't denied.
8.  Select **Next**.
9.  Set **parameter values**
10. Select **Review + create**, and select **Create**.
11. Select **Overview** in the left pane and then search for and select **Policy**.
12. Under **Name**, view the compliance for the Policy definition. :::image type="content" source="../media/policy-compliance-list-78b0d08d.png" alt-text="Displays a screenshot of the policy compliance status.":::
    
