Move the files you previously downloaded to a machine that has connectivity to your Azure Stack Hub environment. The marketplace syndication tool must also be available to your Azure Stack Hub environment because you need to use the tool to perform the import operation.

The following image shows a folder structure example. *D:\\downloadfolder* contains all the downloaded marketplace items. Each subfolder is a marketplace item named by the product ID. Inside, each subfolder is the marketplace item's downloaded content.

:::image type="content" source="../media/disconnected-powershell-image-5-67cf4091.png" alt-text="Displays the folder structure example.":::


1.  Sign in to your Azure Stack Hub with an identity that has owner access to the "Default Provider Subscription".
2.  Import the syndication module and then launch the marketplace syndication tool by running the following script:

```Power

Import-AzsMarketplaceItem -RepositoryDir "Source folder path in quotes"


```

3.  After the script successfully completes, the marketplace items should be available in Azure Stack Hub Marketplace.
