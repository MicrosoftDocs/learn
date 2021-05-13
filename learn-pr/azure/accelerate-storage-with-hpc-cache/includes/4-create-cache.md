Now that we met the prerequisites, the next step is to create the HPC Cache instance in the Azure portal. In this unit, we'll walk through the pages of the wizard to set up a new cache.

From the Azure portal, enter HPC into the search bar at the top. Select **HPC Caches** under the **Services** heading. Select **New** in the upper-left corner or **Create HPC cache** at the bottom to launch the HPC Cache creation wizard.

:::image type="content" source="../media/4-create-the-cache-01-search-for-hpc.png" alt-text="Diagram showing how to search for the HPC Cache service.":::

## Select the Azure settings for HPC Cache

On the **Basics** page, we need to choose or define the environment settings that we want to use for HPC Cache. The settings include things like the Azure subscription, resource group, virtual network, and cache name.

1. Begin by selecting the Azure subscription where you want to run HPC Cache. Assuming you set up a custom DNS server, select the resource group with that server.

   :::image type="content" source="../media/4-create-the-cache-02-basics-tab.png" alt-text="Diagram showing the Basics tab of the Azure HPC Cache creation wizard.":::

1. Provide a name for your cache. There are restrictions for the characters that can be used in cache names. For example, spaces are not permitted, so use a hyphen instead. A common convention is to enter *company-location-cache* for the name (for example *microsoft-atlanta-cache*).

   - Choose an Azure region that is closest to your data. Azure HPC Cache is only available in specific regions.
   - Select the virtual network where your custom DNS server is. If you don't have a virtual network, create a new one.
   - Choose the dedicated subnet where HPC cache will run.

1. Select **Next: Cache** to move to the next page of the wizard.

## Choose the best size for your cache

When it comes to sizing your cache, you want to find the right balance between size and cost. You don't want to purchase something too large and pay for more than you need. Similarly, you don't want the cache too small or it won't be able to store the data you need it to hold. In this case, the cache would continue to remove data and send more read requests to the storage server.

Ideally, you have a best-guess estimate of the amount of data needed for your HPC workload. There's more information at the top of the cache page where you can select a link to  learn more about appropriately sizing your Azure HPC Cache instance.

In summary, you want to choose a size that can store the working set of your data. For example, your storage might have 100 TB of data, but your HPC workload only reads about 8 TB.

1. Begin by choosing a maximum throughput. Higher throughput values correspond to faster and more expensive resources.

   :::image type="content" source="../media/4-create-the-cache-03-cache-tab.png" alt-text="Diagram showing the Cache tab of the Azure HPC Cache creation wizard.":::

   The cache size is dependent on the maximum throughput. The greater the throughput, the greater the available cache sizes. In the previous example, 6 TB is too small, so you want to create a cache that can store 12 TB of data.

1. Select **Next: Disk Encryption Keys*** to move to the next page of the wizard.

## Modify the default encryption by using customer-managed keys (CMK)

Azure HPC Cache data is encrypted with Microsoft-managed keys by default. This encryption secures all of your data when it's stored in Azure.

If you want to provide your own customer-managed keys, select the **Customer managed** option. You'll need to provide a key vault, key, and version.

Select **Next: Tags** to move to the next page of the wizard.

## Manage resource costs by using tags

Tags help you label and manage your Azure resources. With tags, you can run reports to see how different groups are using Azure resources.

For example, if you're using tags to track department resource costs, you could add your custom tags here.

Select **Next: Review + Create** to move to the last page of the wizard.

## Review + Create

The **Review + Create** page is the final step in creating the cache. It checks all the user input to better insure a successful cache creation.

On this page, an automated validation check is performed. This check verifies that the information provided on the previous pages will create a valid cache.

If the validation check fails, red circles appear above the pages that need attention. If the validation check passes, the **Create** button becomes available.

:::image type="content" source="../media/4-create-the-cache-04-review-and-create-tab.png" alt-text="Screenshot showing the Review and Create tab of the Azure HPC Cache creation wizard.":::

Before you create your cache, review the information on this page. Confirm that the information is correct and understand the costs associated with using the cache. If you need to make changes, select the page tabs at the top to return to those pages. Update the fields and return to the **Review + Create** page.

The create process takes over 20 minutes. When you're ready to create the cache and its corresponding resources, select **Create**.

## Summary

In this unit, we walked through the wizard to set up Azure HPC Cache. We began by finding the HPC Cache service and choosing our subscription. For our cache, we selected the resource group, provided a name, and then selected the region closest to us, the virtual network, and the subnet.

We then chose the smallest cache size that would hold our HPC working set. If we use our own encryption keys or tags, we added them to the cache's configuration.

Finally, we reviewed our settings and began the cache creation process.
