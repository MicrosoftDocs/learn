When Azure Stack Hub has limited or no internet connectivity, you use PowerShell and the *marketplace syndication tool* to download the marketplace items to a machine with internet connectivity. You then transfer the items to your Azure Stack Hub environment. In a disconnected environment, you can't download marketplace items by using the Azure Stack Hub portal.

The marketplace syndication tool can also be used in a connected scenario.

There are two parts to this scenario:

 -  **Part 1**: Download from Marketplace items. On the computer with internet access, you configure PowerShell, download the syndication tool, and then download items from Azure Marketplace.
 -  **Part 2**: Upload and publish to Azure Stack Hub Marketplace. You move the files you downloaded to your Azure Stack Hub environment and then publish them to Azure Stack Hub Marketplace.

You need connectivity to get the list of products from Azure with their details, and to download everything locally. Once done, the rest of the procedure does not require internet connectivity. It creates a catalog of items you've previously downloaded for you to use in your disconnected environment.

You will need the following:

 -  Removable media to connect to your disconnected environment and transfer all the necessary artifacts.
 -  Your Azure Stack Hub deployment must be registered with Azure.
 -  The computer that has internet connectivity must have Azure Stack Hub PowerShell Module version 1.2.11 or later.
 -  To enable import of a downloaded Marketplace item, the [PowerShell environment for the Azure Stack Hub operator](/azure-stack/operator/azure-stack-powershell-configure-admin?view=azs-1910) must be configured.

Download the `Azs.Syndication.Admin` module from the PowerShell Gallery using the following command:

```powershell
Install-Module -Name Azs.Syndication.Admin -AllowPrerelease -PassThru

```

Once you have registered your Azure Stack, you can disregard the following message that appears on the Marketplace management blade, as this is not relevant for the disconnected use case:

:::image type="content" source="../media/disconnected-powershell-image-1-e40ebea7.png" alt-text="Disregard the following message that appears on the Marketplace management blade.":::


## Use the marketplace syndication tool to download marketplace items

Be sure to download the marketplace syndication tool each time you download marketplace items in a disconnected scenario. Frequent changes are made to this tool and the most current version should be used for each download.

1.  On a computer with an Internet connection, open a PowerShell console as an administrator.
2.  Sign in to the appropriate Azure cloud and AzureAD directory tenant using the Azure account that you've used to register Azure Stack Hub. To add the account, in PowerShell run `Login-AzAccount`:

```Powershell

Login-AzAccount -Environment AzureCloud -Tenant '<mydirectory>.onmicrosoft.com'


```

3.  If you have multiple subscriptions, run the following command to select the one you used for registration:

```PowerShell

Get-AzSubscription -SubscriptionID 'Your Azure Subscription GUID' | Select-AzSubscription


```

4.  If you haven't done it in the pre-requisites step already, download the latest version of the Marketplace syndication tool:

```PowerShell

Install-Module -Name Azs.Syndication.Admin -AllowPrerelease -PassThru


```

5.  To select the Marketplace items such as virtual machine images, extensions, or solution templates to download, run the following command:

```PowerShell

$products = Select-AzsMarketplaceItem


```

This displays a table that lists all the Azure Stack registrations available in the selected subscription. Choose the registration that matches the Azure Stack environment you're downloading the marketplace items for, and select **OK**.

:::image type="content" source="../media/disconnected-powershell-image-2-52176031.png" alt-text="Displays lists of all the Azure Stack registrations available in the selected subscription.":::


You should now see a second table listing all the marketplace items available for download. Select the item that you want to download and make a note of the Version. You can hold the Ctrl key to select multiple images.

:::image type="content" source="../media/disconnected-powershell-image-3-7e3db775.png" alt-text="Displays table listing all the marketplace items available for download.":::


You can also filter the list of images by using the Add criteria option.

:::image type="content" source="../media/disconnected-powershell-image-4-9326260c.png" alt-text="Displays list of images by using the Add criteria option.":::


Once you've made your selections, select **OK**.

6.  The IDs for the Marketplace items you've selected for download are saved in the $products variable. Use the command below to begin downloading the selected items. Replace the destination folder path with a location to store the files you download from Azure Marketplace:

```PowerShell

$products | Export-AzsMarketplaceItem  -RepositoryDir "Destination folder path in quotes"


```

7.  After the download completes, the item is available in the folder that you specified in the script.
8.  If the download fails, you can try again by rerunning the following PowerShell cmdlet:

```PowerShell

$products | Export-AzsMarketplaceItem  -RepositoryDir "Destination folder path in quotes"


```

9.  Export the `Azs.Syndication.Admin` module locally so that you can copy it over to the machine from which you are importing Marketplace items to Azure Stack Hub.

```PowerShell

Save-Package -ProviderName NuGet -Source https://www.powershellgallery.com/api/v2 -Name Azs.Syndication.Admin -Path "Destination folder path in quotes" -Force


```
