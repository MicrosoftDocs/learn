In this exercise, you’ll enable Container insights for your AKS cluster using the Azure portal. You’ll select a Log Analytics default workspace that will be automatically created for you, but you can select your own Log Analytics workspace if you already have one.

1. Log into the [Azure portal](https://portal.azure.com).
1. Select the **Monitor** menu.

    :::image type="content" source="../media/image2.png" lightbox="../media/image2.png" alt-text="Screenshot of selecting the Monitor menu in the Azure portal." border="true":::

3. Select **Containers** and then **Unmonitored clusters**. This tab includes a list of your AKS clusters that don’t have Container insights enabled.
1. Find your cluster in the list and click **Enable**. The name of the sample cluster in this learning path is **aks-contoso-video**.
1. On the **Onboarding** page, select your Log Analytics workspace from the drop-down list if you don’t want to use the default.
2. Click **Configure azure monitor**  to launch the configuration.

    :::image type="content" source="../media/unmonitored-clusters.png" lightbox="../media/unmonitored-clusters.png" alt-text="Screenshot of unmonitored clusters." border="true":::
