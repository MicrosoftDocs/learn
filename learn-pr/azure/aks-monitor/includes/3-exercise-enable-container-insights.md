In this exercise, you'll enable Container insights for your AKS cluster using the Azure portal. You’ll select a Log Analytics default workspace that will be automatically created for you, but you can select your own Log Analytics workspace if you already have one.

1. Log into the [Azure portal](https://portal.azure.com).
1. Search for and select **Monitor**.

    :::image type="content" source="../media/3-select-azure-monitor.png" lightbox="../media/3-select-azure-monitor.png" alt-text="Screenshot of selecting Monitor in the Azure portal.":::

1. Select **Containers** under **Insights** in the left-hand menu, then select the **Unmonitored clusters** tab. This tab includes a list of your AKS clusters that don’t have Container insights enabled.
1. Find your cluster in the list and select **Enable**. The name of the sample cluster in this learning path is **aks-contoso-video**.

1. On the **Onboarding** page, select **Configure**.

    :::image type="content" source="../media/3-unmonitored-clusters.png" lightbox="../media/3-unmonitored-clusters.png" alt-text="Screenshot of the onboarding page for unmonitored clusters.":::
1. On the **Configure Container Insight** page, accept the default Log Analytics workspace which will be created for you, or select your own workspace from the drop-down list. Select **Create new** to create a new workspace.
1. Select **Configure**.  
   :::image type="content" source="../media/3-configure-container-insights-workspace.png" lightbox="../media/3-configure-container-insights-workspace.png" alt-text="Screenshot of the Configure container insights page.":::  
