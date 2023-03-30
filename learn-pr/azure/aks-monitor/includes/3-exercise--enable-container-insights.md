In this exercise, you’ll enable Container insights for your AKS cluster using the Azure portal. You’ll select a Log Analytics default workspace that will be automatically created for you, but you can select your own Log Analytics workspace if you already have one.

1. Log into the [Azure portal](https://portal.azure.com).
1. Select the **Monitor** menu.

    :::image type="content" source="../media/select-azure-monitor.png" lightbox="../media/select-azure-monitor.png" alt-text="Screenshot of selecting the Monitor menu in the Azure portal.":::

1. Select **Containers**, then the **Unmonitored clusters** tab. This tab includes a list of your AKS clusters that don’t have Container insights enabled.
1. Find your cluster in the list and select **Enable**. The name of the sample cluster in this learning path is **aks-contoso-video**.

1. On the **Onboarding** page, s elect **Configure**.

    :::image type="content" source="../media/unmonitored-clusters.png" lightbox="../media/unmonitored-clusters.png" alt-text="Screenshot of unmonitored clusters.":::
1. On the **Configure Container Insight** page, accept the default Log Analytics workspace which will be created for you, or select your own workspace from the drop-down list. Select **Create new** to create a new workspace.
1. Select **Configure**.  
   :::image type="content" source="../media/configure-container-insights-workspace.png" lightbox="../media/configure-container-insights-workspace.png" alt-text="Screenshot of unmonitored clusters.":::  
