Azure Resource Manager Templates for deployments of infrastructure for SAP on Azure can be complex, so you should use existing resources where possible. The [Azure Quickstart Templates](https://azure.microsoft.com/resources/templates/) and the [Azure Marketplace](https://portal.azure.com/#blade/Microsoft_Azure_Marketplace/MarketplaceOffersBlade/selectedMenuItemId/home) in the Azure portal are good places to search for examples.

## Using a Marketplace Template: Infrastructure for SAP NetWeaver and SAP HANA example

If you start a deployment of a Marketplace item, you can use and modify the existing templates that underlie them. In this example, you'll provide additional information and edit the template through the portal, and you can download the resulting template and parameter files for future use.

### Azure Marketplace

1. Sign into the [Azure portal](https://portal.azure.com) and navigate to the Marketplace.

1. Search for **SAP** and browse the results.

1. From the list of results scroll to find **Infrastructure for SAP NetWeaver and SAP HANA** (if you can't find it, search for the entire name **Infrastructure for SAP NetWeaver and SAP HANA** instead).

1. Select **Infrastructure for SAP NetWeaver and SAP HANA**, select **SAP solution template 2-tier**, and then select **Create**.

    :::image type="content" source="../media/marketplace-0-cropped.png" alt-text="Screenshot of Azure Marketplace search results." lightbox="../media/marketplace-0.png":::

### Basics tab

1. Choose your subscription from the **Subscription** drop-down menu.

2. Next to **Resource group**, select **Create new**, and name your new resource group **SAP2tierRG**.

3. Enter the following information in the **Instance details** section:

    - Region: **East US**
    - Username: **student**
    - Authentication type: **Password**
    - Enter and confirm a strong password. Save the password securely (a password manager is recommended).

4. Go to the next tab: **SAP Configuration**.

    :::image type="content" source="../media/marketplace-1.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, basics tab." lightbox="../media/marketplace-1.png":::

### SAP Configuration tab

1. Enter the SAP System ID: **TST**

2. On the **SAP Deployment Size** drop-down list, select **Demo**.

3. Go to the next tab: **VM Sizes Configuration**.

    :::image type="content" source="../media/marketplace-2.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, S A P Configuration tab.":::

### VM Sizes Configuration tab

1. Keep the default settings:

    - SUSE OS Version: update from default, to **SLES for SAP 12 SP5**
    - HANA VM Size: **1x Standard E8s v3**

2. Go to the next tab: **Network Configuration**.

    :::image type="content" source="../media/marketplace-3.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, V M Sizes Configuration tab.":::

### Network Configuration tab

1. Keep the default settings:

    - Virtual network: **(new) vnet**
    - Subnet 1: **(new) subnet-1 (10.0.0.0/24)**

2. Go to the next tab: **Review + create**.

    :::image type="content" source="../media/marketplace-4.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, Network Configuration tab.":::

### Review + create tab

> [!NOTE]
> This step generates the template that you edit. Only *review* in this section, and don't *create* the infrastructure.

1. Review the validation results and fix any errors.

1. Select **View template automation**, located following the menu items (such as *Review + create*).

    :::image type="content" source="../media/marketplace-5.png" alt-text="Screenshot of Azure portal, creating infrastructure for S A P NetWeaver and S A P HANA, Validation." lightbox="../media/marketplace-5.png":::

## Review the updated template

Examine the Resource Manager template to get a better understanding of its structure and the resources defined by the template. The following items are a section from the top of the template with the numbered labels in the image indicating:

1. `sapSystemID`
2. `osType`
3. `size`

:::image type="content" source="../media/marketplace-7.png" alt-text="Screenshot of Azure Resource Manager template with the changes made in the previous steps." lightbox="../media/marketplace-7.png":::

1. Read through the template to identify any items that an administrator might want to change. For example, the default value for `hanaVMSize`.

1. Select **Deploy** to update the original Marketplace template with the information you provided, resulting in the options **Edit template**, **Edit parameters**, and **Visualize**.

    > [!NOTE]
    > Alternatively, to store the updated template locally, select **Download**.

    :::image type="content" source="../media/marketplace-8.png" alt-text="Screenshot of a template with example of a value, HANA V M Size that can be manually edited in the template.":::

## Edit template

1. Select **Edit template** to open the Azure Resource Manager template in edit mode.

    > [!NOTE]
    > You can also select **Edit parameters**.

    :::image type="content" source="../media/marketplace-9-cropped.png" alt-text="Screenshot of Azure portal template, project details." lightbox="../media/marketplace-9.png":::

2. On the Edit template page, make any changes that you want to the Azure Resource Manager template and parameters JSON. For example, remove **Large** from the `allowedValues` under `size`.

3. Select **Save**.

4. If you want to save a local copy of the template after you make a change select **Download** to download the file.

5. Alternatively, select **Deploy** to return to the **review and create** UI. Then decide if you're ready to begin the Azure deployment of your custom template based on the Azure Marketplace **Infrastructure for SAP NetWeaver and SAP HANA** item through the **review and create** tab, or make other updates.

    :::image type="content" source="../media/marketplace-8-b-cropped.png" alt-text="Screenshot of Azure portal, editing template displaying JSON." lightbox="../media/marketplace-8-b.png":::

## Access Azure Resource Manager Templates from previous deployments

To access Azure Resource Manager Templates for your previous deployments, follow these steps.

1. Select the resource group you want to export.
1. Select the link under **Deployments**.
1. Choose one of the deployments from the deployment history.
1. Select Template.
1. Download the Template and Parameters, or deploy the template in the portal.

:::image type="content" source="../media/marketplace-11.png" alt-text="Screenshot of Azure portal, template deployment.":::

## Deploy Azure Resource Manager using the CLI

You can deploy a downloaded template by using the CLI with your Azure credentials locally, or by using Bash Cloud Shell CLI. For more information about the parameter file, see [Create Resource Manager parameter file](/azure/azure-resource-manager/templates/parameter-files).

To pass a local parameter file, use @ to specify a local file named *parameters.json*:

```azurecli
az deployment group create 
  --name ExampleDeployment \
  --resource-group <Resource Group Name> \
  --template-file template.json \
  --parameters '@ parameters.json' 
```

## Clean up resources

If you created any resources with deployments, clean up the resources you deployed by deleting the resource group:

1. From the [Azure portal](https://portal.azure.com), select **Resource group** from the left menu.

2. Enter the resource group name in the **Filter by name** field.

3. Select the resource group name.

4. Select **Delete resource group** from the top menu.
