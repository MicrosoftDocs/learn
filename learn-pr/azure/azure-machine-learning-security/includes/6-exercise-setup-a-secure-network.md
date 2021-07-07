An [Azure Virtual Network (VNet)](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview) is similar to a traditional network but with the added benefits provided by Azure infrastructure.

VNets to enable your resources, such as virtual machines (VMs) and ML workspaces, to securely communicate with each other and other networks or the Internet.

A Machine Learning Engineer can use them in a variety of scenarios, such as linking a VM to data stored on-premises, restricting access to a training API so that only personnel from their lab can see it, or exposing an inference endpoint to the Internet.

In this exercise, we will create a VNet and use it to secure access to our existing ML Workspace.

## Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com).

## Create a VNet

Let's create a VNet for this exercise:

1. In the Azure portal, select **Create Resource**:

   ![Azure Portal.](../media/resource_group_1.png)

2. Select **Create a resource** in the upper left-hand corner of the portal.

3. In the search box, enter **Virtual Network**. Select **Virtual Network** in the search results.

4. In the **Virtual Network** page, select **Create**.

   ![Azure Virtual Network Resource.](./raw_images/ex2/create_vnet.png)

5. In **Create virtual network**, enter or select this information in the **Basics** tab:

    <!-- :::image type="content" source="./media/quick-create-portal/create-virtual-network.png" alt-text="Create virtual network Azure portal" border="true"::: -->

   ![Azure Virtual Network form.](./raw_images/ex2/vnet_form1.png)

   | Setting              | Value                                                                                                 |
   | -------------------- | ----------------------------------------------------------------------------------------------------- |
   | **Project details**  |                                                                                                       |
   | Subscription         | Select your subscription.                                                                             |
   | Resource group       | Enter <b>MLResourceGroup</b> (or the name of the Resource Group you created in the previous exercise) |
   | **Instance details** |                                                                                                       |
   | Name                 | Enter **MLVNet**.                                                                                     |
   | Region               | Select **(US) East US**.                                                                              |



6. Select the **IP Addresses** tab, or select the **Next: IP Addresses** button at the bottom of the page.

   > [!TIP]
   > If your screen comes with the IPv4 address space and _default_ subnet setup like in the image below, skip to step 10.

   ![Azure Virtual Network IP Addresses.](./raw_images/ex2/vnet_form2.png)

7. In **IPv4 address space**, select the existing address space and change it to **10.1.0.0/16**.

8. Select **+ Add subnet**, then enter **default** for **Subnet name** and **10.1.0.0/24** for **Subnet address range**.

9. Select **Add**.

10. Select the **Review + create** tab or select the **Review + create** button.

11. Select **Create** and wait a few moments for the deployment to finish:

    ![Azure Virtual Network deployment.](./raw_images/ex2/vnet_deployment.png)

> [!IMPORTANT]
> For simplicity, we are creating a single subnet for our Virtual Network.
> A subnet is a range of IP addresses in the VNet.
> We could divide a VNet into multiple subnets for organization and security, for example, a _training_ subnet that only Data Scientists could use, and an _inference_ subnet that is publicly available.

## Secure network access to the ML Workspace

So far we've created two independent resources:

- An ML workspace (**ml-workspace**)
- A VNet (**MLVNet**)

We now have to connect these two resources so that the workspace network traffic has to go through our VNet. In other words, we want our workspace available **only** to resources that are connected to the **MLVNet** virtual network.

To accomplish that, we need to define a [Private Endpoint](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview) for _ml-workspace_.

> [!TIP]
> A Private Endpoint is a network interface that uses a private IP Address from your VNet to create secure and private connections to a resource.

## Create a Private Endpoint

1. go to "Home", select **Resource Groups**, select the **MLResourceGroup** resource group and then select your **ml_workspace** workspace:

   ![Azure Virtual Network deployment.](./raw_images/ex2/ml_workspace_home.png)

2. In the left-hand menu, select **Private endpoint connections**:

   ![Azure Virtual Private Endpoints.](./raw_images/ex2/pvt1.png)

3. Select **Private Endpoint** and fill the form with the following values:

   ![Azure Virtual Network deployment.](./raw_images/ex2/pvt2.png)

   | Setting              | Value                                                                                                 |
   | -------------------- | ----------------------------------------------------------------------------------------------------- |
   | **Project details**  |                                                                                                       |
   | Subscription         | Select your subscription.                                                                             |
   | Resource group       | Enter <b>MLResourceGroup</b> (or the name of the Resource Group you created in the previous exercise) |
   | **Instance details** |                                                                                                       |
   | Name                 | Enter **MLPrivateEndpoint**.                                                                          |
   | Region               | Select **(US) East US**.                                                                              |

4. Select the **Next: Resource >** button.

5. In the **Resource** tab, use the values below

   ![Azure Virtual Network deployment.](./raw_images/ex2/pvt3.png)

   | Setting              | Value                                                   |
   | -------------------- | ------------------------------------------------------- |
   | **Project details**  |                                                         |
   | Subscription         | Select your subscription.                               |
   | Resource type        | Enter <b>Microsoft.MachineLearninService/workspaces</b> |
   | **Instance details** |                                                         |
   | Resource \*          | Select **ml-workspace**.                                |
   | Target subresource  | Select **amlworkspace**.                                |

6. Select the **Next: Configuration >** button.

   Leave the suggested defaults:

   ![Azure Virtual Network deployment.](./raw_images/ex2/pvt4.png)

   | Setting                         | Value                     |
   | ------------------------------- | ------------------------- |
   | Virtual Network \*              | **MLVNet**                |
   | Subnet \*                       | **default (10.1.0.0/24)** |
   | Integrate with private DNS zone | **Yes**                   |

7. Select **Review + Create** to validate this deployment, then select **Create** to deploy the endpoint (this may take a few moments):

   ![Azure Virtual Network deployment.](./raw_images/ex2/pvt_final.png)

Congratulations!

You've just secured the network access to your ML workspace.

## Summary

In this unit you've covered the following topics:

- What a Virtual Network is and some of its uses
- Creating an Azure Virtual Network
- Creating subnets in a Virtual Network
- How to use Private Endpoints to secure network access to your Machine Learning Workspaces

## More Resources

To read more about Custom Roles visit:

- [What is Azure Virtual Network?](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Network concepts and best practices](https://docs.microsoft.com/en-us/azure/virtual-network/concepts-and-best-practices)
- [Secure Azure Machine Learning workspace resources using virtual networks (VNets)](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-network-security-overview)
- [What is Azure Private Endpoint?](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview)
