In this exercise, you see how resource locks help prevent accidental deletion of your Azure resources.

To do so, you create a resource group from the Azure portal. Think of a resource group as a container for related Azure resources. Then you add a lock to your resource group and verify that you can't delete the resource group.

You then add a storage account to your resource group and see how the lock from the parent resource group prevents the storage account from being deleted. A storage account is a container that groups a set of Azure Storage services together.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

## Create the resource group

Here you create a resource group that's named **my-test-rg**.

1.  Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.
2.  At the top of the page, select **Resource groups**.
3.  Select **+ New**. The **Create a resource group** page appears.
4.  In the **Basics** tab, fill in the following fields.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Project details**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        *Your Azure subscription*
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        **my-test-rg**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Resource details**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Region
      :::column-end:::
      :::column:::
        **(US) East US**
      :::column-end:::
    :::row-end:::
    
    
    You can also select a region that's closer to you.
5.  Select **Review + create**, and then select **Create**.

## Add a lock to the resource group

Add a resource lock to the resource group. To do so:

1.  From the Azure portal, select your resource group, **my-test-rg**.
2.  Under **Settings**, select **Locks**, and then select **Add**.<br>:::image type="content" source="../media/7-portal-add-lock-ebc3d24c.png" alt-text="A screenshot of the Azure portal showing how to add a resource lock.":::
    
3.  Fill in these fields.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Lock name
      :::column-end:::
      :::column:::
        **rg-delete-lock**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Lock type
      :::column-end:::
      :::column:::
        **Delete**
      :::column-end:::
    :::row-end:::
    
4.  Select **OK**. You see that the resource lock is applied to your resource group.<br>:::image type="content" source="../media/7-portal-rg-lock-21f1ce60.png" alt-text="A screenshot of the Azure portal showing the resource lock. The lock type is Delete, and the scope is the parent resource group.":::
    

## Verify that the resource group is protected from deletion

Here, you verify protection by attempting to delete the resource group.

1.  From the top of the page, select **my-test-rg** to go to your resource group's overview page.<br>:::image type="content" source="../media/7-portal-select-rg-e25ad6d2.png" alt-text="A screenshot of the Azure portal showing the location of the link to the resource group's overview page.":::
    
2.  Select **Delete resource group**.<br>:::image type="content" source="../media/7-portal-delete-rg-e8bb66bb.png" alt-text="A screenshot of the Azure portal showing the Delete resource group button.":::
    
3.  At the prompt, enter **my-test-rg**, and then select **OK**. You see a message that tells you that the resource group is locked and can't be deleted.<br>:::image type="content" source="../media/6-delete-locks-failed-b3e41330.png" alt-text="A screenshot of the failure message. The message tells you that the resource can't be deleted because it's locked.":::
    

## Protect a storage account from accidental deletion

Here, you add a storage account to your resource group and see how the lock from the parent resource group prevents the storage account from being deleted. To do so:

1.  From the Azure portal, at the top of the page, select **Home** to return to the start page.
2.  Select **Storage accounts**. Then select **+ New**. The **Create storage account** page appears.
3.  In the **Basics** tab, fill in the following fields.
    
    > [!NOTE]
    > Replace **NNN** with a series of numbers. The numbers help to ensure that your storage account name is unique.
    
    :::row:::
      :::column:::
        **Setting**
      :::column-end:::
      :::column:::
        **Value**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Project details**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Subscription
      :::column-end:::
      :::column:::
        *Your Azure subscription*
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Resource group
      :::column-end:::
      :::column:::
        **my-test-rg**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        **Instance details**
      :::column-end:::
      :::column:::
        
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Storage account name
      :::column-end:::
      :::column:::
        **mysaNNN**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Location
      :::column-end:::
      :::column:::
        **(US) East US**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Performance
      :::column-end:::
      :::column:::
        **Standard**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Account kind
      :::column-end:::
      :::column:::
        **StorageV2 (general purpose v2)**
      :::column-end:::
    :::row-end:::
    :::row:::
      :::column:::
        Replication
      :::column-end:::
      :::column:::
        **Locally redundant storage (LRS)**
      :::column-end:::
    :::row-end:::
    
    
    As before, you can also select a region that's closer to you.
4.  Select **Review + create**, and then select **Create**. The deployment might take a few moments to complete.
5.  Select **Go to resource**.
6.  At the top of the page, select **Delete**.<br>:::image type="content" source="../media/7-portal-delete-sa-807786f0.png" alt-text="A screenshot of the Azure portal showing the location of the Delete button.":::
    <br>You see a message that tells you the resource or its parent is locked and can't be deleted. Here's an example that shows the error message for a storage account that's named **mysa1234**.<br>:::image type="content" source="../media/6-delete-failed-9a007e18.png" alt-text="A screenshot of the Azure portal showing the error message. The error message states that the storage account can't be deleted because the resource or its parent resource group is locked.":::
    

Although you didn't create a lock specifically for the storage account, the lock you created for the parent resource group prevents you from deleting the resource. In other words, the storage account inherits the lock from the parent resource group.

## Delete the resource group and the storage account

You no longer need your resource group or storage account. Here you remove both.

When you delete a resource group, you also delete its child resources, such as the storage account you previously created.

To delete the resource group, you first need to remove the resource lock.

1.  From the Azure portal, select **Home** &gt; **Resource groups** &gt; **my-test-rg** to go to your resource group.
2.  Under **Settings**, select **Locks**.
3.  Locate **rg-delete-lock**, and select **Delete** on that same row.
4.  Select **Overview**, and then select **Delete resource group**.
5.  At the prompt, enter **my-test-rg**, and then select **OK**. The deletion operation might take a few moments to complete.
6.  When the operation completes, select **Home** &gt; **Resource groups**. You see that the **my-test-rg** resource group no longer exists in your account. Your storage account is also deleted.

Nice work. You can now apply resource locks to help prevent the accidental deletion of your Azure resources.
