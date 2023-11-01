

Azure Resource Manager Templates for deployments of infrastructure for SAP on Azure can be complex, so you'll want to use existing resources. The [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) and the [Azure Marketplace](https://portal.azure.com/#blade/Microsoft_Azure_Marketplace/MarketplaceOffersBlade/selectedMenuItemId/home) in the Azure portal are good resources to search for examples.
 
## Using a Marketplace Template: Infrastructure for SAP NetWeaver and SAP HANA example

If you start a deployment of a Marketplace item, you can use and modify the existing templates that underlie them. In this example, you'll provide additional information and edit the template through the portal, and you can download the resulting template and parameter files for future use.

### Azure Marketplace

1. Sign into the [Azure portal](https://portal.azure.com) and navigate to the Marketplace.

2. Search for **SAP** and browse the results.

3. From the list of results, select **Infrastructure for SAP NetWeaver and SAP HANA**, and then select **SAP solution template 2-tier** and **Create**.

    :::image type="content" source="../media/marketplace-0-cropped.png" alt-text="Screenshot of Azure Marketplace search results." lightbox="../media/marketplace-0.png":::

### Basics tab

1. Choose your subscription from the **Subscription** drop-down menu.

2. Next to **Resource group**, select **Create new**, and name your new resource group **SAP2tierRG**.

3. Enter the following information in the **Instance details** section:

    - Region: **East US**
    - Username: **student**
    - Authentication type: **Password**
    - Enter and confirm a strong password.

4. Go to the next tab: **SAP Configuration**.
 
    :::image type="content" source="../media/marketplace-1.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, basics tab." lightbox="../media/marketplace-1.png":::

### SAP Configuration tab

1. Enter the SAP System ID: **TST**

2. For the SAP Deployment Size drop-down list, select **Demo**.

3. Go to the next tab: **VM Sizes Configuration**.

    :::image type="content" source="../media/marketplace-2.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, S A P Configuration tab.":::

### VM Sizes Configuration tab

1. Keep the default settings:

    - SUSE OS Version: **SLES for SAP 12 SP4**
    - HANA VM Size: **1x Standard E8s v3**

2. Go to the next tab: **Network Configuration**.

    :::image type="content" source="../media/marketplace-3.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, V M Sizes Configuration tab.":::

### Network Configuration tab

1. Keep the default settings:

    - Virtual network: **(new) vnet**
    - Subnet 1: **(new) subnet-1 (10.0.0.0/24)**

2. Go to the next tab: **Review + create**.

    :::image type="content" source="../media/marketplace-4.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, Network Configuration tab.":::

### Validation

1. Review the validation results and fix any errors.

2. Select **Download a template for automation**.

    :::image type="content" source="../media/marketplace-5.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, Validation." lightbox="../media/marketplace-5.png":::

## Review the updated template

Examine the Resource Manager template to get a better understanding of its structure and the resources defined by the template. Following is a section from the top of the template.

:::image type="content" source="../media/marketplace-7.png" alt-text="Screenshot of Azure Resource Manager template with the changes made in the previous steps." lightbox="../media/marketplace-7.png":::

:::row:::
  :::column:::
    **#**
  :::column-end:::
  :::column:::
    **Information**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    `sapSystemID`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    Allowed `osType`
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    3
  :::column-end:::
  :::column:::
    Allowed `size`
  :::column-end:::
:::row-end:::

1. Read through the template to identify any items that an administrator might want to change. For example, the default value for `hanaVMSize`. 

2. Select **Deploy**. This updates the original Marketplace template, with the information you provided in the Azure portal.

3. Alternatively, if you want to store the updated template stored locally, select **Download**.

    :::image type="content" source="../media/marketplace-8.png" alt-text="Screenshot of a template with example of a value, HANA V M Size, that can be manually edited in the template.":::

## Edit template 

1. Select **Edit template** to open the Azure Resource Manager template in edit mode.

    > [!NOTE]
    > You can also select **Edit parameters**.
    
    :::image type="content" source="../media/marketplace-9-cropped.png" alt-text="Screenshot of Azure portal template, project details." lightbox="../media/marketplace-9.png":::

2. On the **Edit template** page, make any changes that you want to the Azure Resource Manager template and parameters JSON. For example, remove **Large** from the `allowedValues` under `size`.

3. Select **Save**.

4. If you want to save a local copy of the template after you make a change, select **Download** to download the file.

5. Alternatively, select **Deploy** and deploy your custom template based on the Azure Marketplace **Infrastructure for SAP NetWeaver and SAP HANA** item.
 
    :::image type="content" source="../media/marketplace-8-b-cropped.png" alt-text="Screenshot of Azure portal, editing template displaying JSON." lightbox="../media/marketplace-8-b.png":::

## Generating Azure Resource Manager Templates from deployments

To access Azure Resource Manager Templates for your previous deployments, navigate to **Settings** > **Deployments**, select your resource group, and select a deployment from the list. You'll see an overview of the deployment resources and can select **Template** to download the Template and Parameters or deploy the template in the portal.

:::image type="content" source="../media/marketplace-11.png" alt-text="Screenshot of Azure portal, template deployment.":::

## Deploying Azure Resource Manager using the CLI

You can deploy a template that you have downloaded using the CLI with your Azure credentials locally or using Bash ClouldShell CLI. For more information about the parameter file, see [Create Resource Manager parameter file](/azure/azure-resource-manager/templates/parameter-files).

To pass a local parameter file, use @ to specify a local file named *parameters.json*.

```azurecli
az deployment group create 
  --name ExampleDeployment \
  --resource-group <Resource Group Name> \
  --template-file template.json \
  --parameters '@ parameters.json' 
```

## Clean up resources

If you created any resources with deployments, clean up the resources you deployed by deleting the resource group:

1. From the Azure portal, select **Resource group** from the left menu.

2. Enter the resource group name in the **Filter by name** field.

3. Select the resource group name.

4. Select **Delete resource group** from the top menu.
