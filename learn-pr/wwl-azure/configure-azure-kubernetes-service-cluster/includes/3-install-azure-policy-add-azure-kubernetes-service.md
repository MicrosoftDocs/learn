Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

In this exercise, you register the required resource provider if necessary, enable the Azure Policy add-on for an Azure Kubernetes Service cluster, and verify that the add-on is enabled. In the next exercise, you assign a policy definition and view its compliance results.

> [!NOTE]
> To complete this exercise you'll need an [Azure Subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  On the Azure portal menu, search for **Subscriptions**. Select your Azure subscription.
3.  Select Resource providers, and search for **Microsoft.PolicyInsights**.

    :::image type="content" source="../media/azure-policy-resource-provider-5271173d.png" alt-text="Screenshot of the resource providers configuration.":::

    Check the registration state of **Microsoft.PolicyInsights** in the subscription containing the AKS cluster. If the provider is **NotRegistered**, select it and then select **Register**. If it is already **Registered**, no registration action is needed.

    > [!NOTE]
    > Provider registration requires the provider's `/register/action` permission at subscription scope. If you cannot register it, ask an administrator with that permission to complete this prerequisite. A **Registering** state means registration is in progress, not necessarily that the provider is unusable: registration happens separately for each region. Do not require completion in every region solely because the overall state is still **Registering**. If the add-on reports an unregistered-provider error, verify the selected subscription and follow the [resource-provider troubleshooting guidance](/azure/governance/policy/troubleshoot/general#add-on-for-kubernetes-general-errors).

4.  Select the Kubernetes cluster.
5.  Select **Policies**, and select **Enable add-on**.

    :::image type="content" source="../media/enable-azure-policy-add-6942cb50.png" alt-text="Screenshot of how to enable the Azure Policy add-on.":::
    
    
    > [!NOTE]
    > The configuration of Azure Policy takes a few minutes.

6.  The status for enabling Azure policy add-on for the cluster appears as enabled.

    :::image type="content" source="../media/status-azure-policy-add-88db7a40.png" alt-text="Screenshot of the Azure portal highlighting the enabled status of the Azure Policy add-on.":::
    

