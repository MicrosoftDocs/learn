> **Note:** This procedure requires an active Azure subscription. Please take careful note of naming conventions to facilitate the removal of all resources created for this project later. Be aware that creating and using Azure resources may increase your Azure consumption and costs.

## Step 1: Create a Resource Group
To manage all resources in one place, create a resource group.

1. Sign in to the [Azure Portal](https://portal.azure.com).
2. In the left-hand menu, select **Resource groups**.
3. Click **+ Create**.
4. Enter a name for the resource group (e.g., `project-rg`).
5. Choose a region close to you to minimize latency and cost.
6. Click **Review + create**, then **Create**.

:::image type="content" source="../media/virtual-machine-overview.png" alt-text="Screenshot of the virtual machine overview blade.":::

## Step 2: Create a Virtual Network
Create a virtual network to enable communication between resources.

1. In the Azure Portal, search for **Virtual networks** and click **+ Create**.
2. Select the resource group created in Step 1.
3. Enter a name for the virtual network (e.g., `project-vnet`).
4. Choose the same region as the resource group.
5. Under **IP Addresses**, add a subnet named `primarySubnet`.
6. Click **Review + create**, then **Create**.

## Step 3: Create a Linux Virtual Machine
Deploy a cost-effective Linux VM in the virtual network.

1. Search for **Virtual machines** and click **+ Create**.
2. Select the resource group and region.
3. Enter a name for the VM (e.g., `project-vm`).
4. Choose **Ubuntu Server 20.04 LTS** as the image.
5. Select a small VM size (e.g., `Standard_B1s`) to minimize cost.
6. Configure authentication and networking to use `primarySubnet`.
7. Click **Review + create**, then **Create**.

## Step 4: Create a Storage Account
Provision a storage account with a container and file share.

1. Search for **Storage accounts** and click **+ Create**.
2. Select the resource group and region.
3. Enter a unique name for the storage account.
4. Choose **Standard** performance and **Locally-redundant storage (LRS)**.
5. Click **Review + create**, then **Create**.
6. After deployment, go to the storage account.
7. Under **Containers**, create a new container.
8. Under **File shares**, create a new file share.
