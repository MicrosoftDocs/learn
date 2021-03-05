In this exercise, you see how resource locks help prevent accidental deletion of your Azure resources.

To do so, you create a resource group from the Azure portal. Think of a resource group as a container for related Azure resources. Then you add a lock to your resource group and verify that you can't delete the resource group.

You then add a storage account to your resource group and see how the lock from the parent resource group prevents the storage account from being deleted. A storage account is a container that groups a set of Azure Storage services together.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

## Create the resource group

Here you create a resource group that's named **my-test-rg**.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and sign in.

1. At the top of the page, select **Resource groups**.

1. Select **+ New**. The **Create a resource group** page appears.

1. In the **Basics** tab, fill in the following fields.

    | Setting | Value |
    | -- | -- |
    | **Project details**| |
    | Subscription | *Your Azure subscription* |
    | Resource group | **my-test-rg** |
    | **Resource details**| |
    | Region | **(US) East US** |

    You can also select a region that's closer to you.

1. Select **Review + create**, and then select **Create**.

## Add a lock to the resource group

Add a resource lock to the resource group. To do so:

1. From the Azure portal, select your resource group, **my-test-rg**.

1. Under **Settings**, select **Locks**, and then select **Add**.

    :::image type="content" source="../media/7-portal-add-lock.png" alt-text="A screenshot of the Azure portal showing how to add a resource lock.":::

1. Fill in these fields.

    | Setting | Value |
    | -- | -- |
    | Lock name | **rg-delete-lock** |
    | Lock type | **Delete** |

1. Select **OK**.

    You see that the resource lock is applied to your resource group.

    :::image type="content" source="../media/7-portal-rg-lock.png" alt-text="A screenshot of the Azure portal showing the resource lock. The lock type is Delete, and the scope is the parent resource group.":::

## Verify that the resource group is protected from deletion

Here, you verify protection by attempting to delete the resource group.

1. From the top of the page, select **my-test-rg** to go to your resource group's overview page.

    :::image type="content" source="../media/7-portal-select-rg.png" alt-text="A screenshot of the Azure portal showing the location of the link to the resource group's overview page.":::

1. Select **Delete resource group**.

    :::image type="content" source="../media/7-portal-delete-rg.png" alt-text="A screenshot of the Azure portal showing the Delete resource group button.":::

1. At the prompt, enter **my-test-rg**, and then select **OK**.

    You see a message that tells you that the resource group is locked and can't be deleted.

    :::image type="content" source="../media/6-delete-locks-failed.png" alt-text="A screenshot of the failure message. The message tells you that the resource can't be deleted because it's locked.":::

## Protect a storage account from accidental deletion

Here, you add a storage account to your resource group and see how the lock from the parent resource group prevents the storage account from being deleted. To do so:

1. From the Azure portal, at the top of the page, select **Home** to return to the start page.

1. Select **Storage accounts**. Then select **+ New**. The **Create storage account** page appears.

1. In the **Basics** tab, fill in the following fields.

    > [!NOTE]
    > Replace **NNN** with a series of numbers. The numbers help to ensure that your storage account name is unique.

    | Setting | Value |
    | --- | --- |
    | **Project details**| |
    | Subscription | *Your Azure subscription* |
    | Resource group | **my-test-rg** |
    | **Instance details**| |
    | Storage account name | **mysaNNN** |
    | Location | **(US) East US** |
    | Performance | **Standard** |
    | Account kind | **StorageV2 (general purpose v2)** |
    | Replication | **Locally redundant storage (LRS)** |

    As before, you can also select a region that's closer to you.

1. Select **Review + create**, and then select **Create**.

    The deployment might take a few moments to complete.

1. Select **Go to resource**.

1. At the top of the page, select **Delete**.

    :::image type="content" source="../media/7-portal-delete-sa.png" alt-text="A screenshot of the Azure portal showing the location of the Delete button.":::

    You see a message that tells you the resource or its parent is locked and can't be deleted. Here's an example that shows the error message for a storage account that's named **mysa1234**.

    :::image type="content" source="../media/6-delete-failed.png" alt-text="A screenshot of the Azure portal showing the error message. The error message states that the storage account can't be deleted because the resource or its parent resource group is locked.":::

Although you didn't create a lock specifically for the storage account, the lock you created for the parent resource group prevents you from deleting the resource. In other words, the storage account inherits the lock from the parent resource group.

## Delete the resource group and the storage account

You no longer need your resource group or storage account. Here you remove both.

When you delete a resource group, you also delete its child resources, such as the storage account you previously created.

To delete the resource group, you first need to remove the resource lock.

1. From the Azure portal, select **Home** > **Resource groups** > **my-test-rg** to go to your resource group.

1. Under **Settings**, select **Locks**.

1. Locate **rg-delete-lock**, and select **Delete** on that same row.

1. Select **Overview**, and then select **Delete resource group**.

1. At the prompt, enter **my-test-rg**, and then select **OK**.

    The deletion operation might take a few moments to complete.

1. When the operation completes, select **Home** > **Resource groups**.

    You see that the **my-test-rg** resource group no longer exists in your account. Your storage account is also deleted.

Nice work. You can now apply resource locks to help prevent the accidental deletion of your Azure resources.
