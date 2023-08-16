Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

This exercise you enable Azure Policy add on for an Azure Kubernetes Service cluster and verify the assignment is being enforced.

> [!NOTE]
> To complete this exercise you'll need an [Azure Subscripton](https://azure.microsoft.com/free/).

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Select the Kubernetes cluster.
3.  Select **Policies**, and select **Enable add-on**. :::image type="content" source="../media/enable-azure-policy-add-6942cb50.png" alt-text="Displays a screenshot of how to enable the Azure Policy add-on.":::
    
    
    > [!NOTE]
    > The configuration of Azure Policy takes a few minutes.

4.  The status for enabling Azure policy add-on for the cluster appears as enabled. :::image type="content" source="../media/status-azure-policy-add-88db7a40.png" alt-text="Displays a screenshot showing that the Azure Policy add-on is enabled.":::
    

5.  On the Azure portal menu, search for **Subscriptions**. Select your Azure subscription.
6.  Select Resource providers, and search for **Microsoft.PolicyInsights.** :::image type="content" source="../media/azure-policy-resource-provider-5271173d.png" alt-text="Displays a screenshot of the resource providers configuration.":::
    

Verify that the **Microsoft.PolicyInsights** Resource provider is registered.
