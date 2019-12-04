Your organization uses different resources for production and development environments. Some resources that were created for development work were put into the same resource group as production resources. You need to be able to identify which resources belong to a development resource group.

In this unit, you'll create both development and production resources and put them all in a production resource group. You'll tag all your resources appropriately. You'll then filter the resources to identify all your development resources from a single location.

[!include[](../../../includes/azure-subscription-prerequisite.md)]

## Create resources

Create a resource group to act as the production resource group.

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal.
1. Select **Resource groups** > **Add**.
1. Enter **production-learn-rg** as the name for the resource group.
1. Select **Review + create** > **Create**.
1. Use the following quickstart template to create a virtual machine (VM) in your production resource group: [Deploy a simple Windows VM](https://azure.microsoft.com/resources/templates/101-vm-simple-windows/).  
1. Select **Deploy to Azure** on the template page.
1. For **Resource group**, select  **production-learn-rg**.
1. Enter a username, password, and **DNS Label Prefix**.
1. Select **Purchase**.

Now you need to create some additional resources that you will eventually move to a development resource group.

1. Select **Create a resource** on the left-hand side of the Azure portal.
1. Search for **Storage account** and select **Create**.
1. Select the resource group **production-learn-rg**.
1. Enter a unique storage account name that starts with the prefix **dev**.
1. Select **Review + create** > **Create**.
1. Create another storage account by repeating step 1 to 4 again.

You now have a production resource group with two additional storage accounts that you will move to a development resource group.

## Apply tags to your resources

Now, use the Azure portal to apply tags to resources so you can identify and locate them later.

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal.
1. Select **Resource groups** then select your production resource group. You will see all the resources in your resource group.
1. Select the **checkbox** next to the **name** field for both storage accounts.

    ![Select your development resources](../media/3-select-dev-resources.png)

1. Select **Assign tags** at the top-right side. In the Assign Tags pane, you'll see your resources. You can set tags on each of these resources.
1. Enter "environment" in the **name** field, and enter "development" in the **value** field as shown below:

    ![Assign development tags](../media/3-assign-tags.png)

1. Select **Save**. Your resources have now been tagged with "development".
1. Complete steps 1 to 6 again to label your remaining resources with a "production" tag. You'll then ensure each resource has been tagged appropriately.

## Filter and identify your development resources

Now you'll filter your resources and find your  development tagged resources all in one place.  Complete the followings steps:

1. Select the **search box** at the top of the Azure portal.
1. Enter "tags" in the **search box** as shown below.

    ![Search for tags in the search box](../media/3-search-tags.png)

1. Select **Tags**.
1. You can now see all the tags you created earlier.
1. Select the **environment:development** tag.
1. All your development resources are now listed in one place.

Keep your portal instance open to use later.
