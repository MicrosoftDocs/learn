An [Azure Virtual Network (VNet)](/azure/virtual-network/virtual-networks-overview) is similar to a traditional network but with the added benefits provided by Azure infrastructure.

VNets enable your resources, such as virtual machines (VMs) and ML workspaces, to securely communicate with each other and other networks, or the Internet.

A Machine Learning engineer can use them in a variety of scenarios, such as linking a VM to data stored on-premises, restricting access to a training API so that only personnel from their lab can see it, or exposing an inference endpoint to the Internet.

In this exercise, we will create a VNet and use it to secure access to our existing ML Workspace.

## Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com).

## Create a VNet

Let's create a VNet for this exercise:

1. In the Azure portal, select **Create Resource**:

    :::image type="content" source="../media/resource_group_1.png" alt-text="Screenshot showing the Azure portal with a red border around resource groups.":::

2. Select **Create a resource** in the upper left-hand corner of the portal.

3. In the search box, enter **Virtual Network**. Select **Virtual Network** in the search results.

4. In the **Virtual Network** page, select **Create**.

    :::image type="content" source="../media/create_vnet.png" alt-text="Screenshot showing the Azure Virtual Network Resource.":::

5. In **Create virtual network**, enter or select this information in the **Basics** tab:

    <!-- :::image type="content" source="./media/quick-create-portal/create-virtual-network.png" alt-text="Create virtual network Azure portal" border="true"::: -->

    :::image type="content" source="../media/vnet_form1.png" alt-text="Screenshot showing the Azure Virtual Network form.":::

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

    :::image type="content" source="../media/vnet_form2.png" alt-text="Screenshot showing an example of the IPc4 address space.":::

7. In **IPv4 address space**, select the existing address space and change it to **10.1.0.0/16**.

8. Select **+ Add subnet**, then enter **default** for **Subnet name** and **10.1.0.0/24** for **Subnet address range**.

9. Select **Add**.

10. Select the **Review + create** tab or select the **Review + create** button.

11. Select **Create** and wait a few moments for the deployment to finish:

    :::image type="content" source="../media/vnet_deployment.png" alt-text="Screenshot showing the Azure Virtual Network deployment.":::

> [!IMPORTANT]
> For simplicity, we're creating a single subnet for our Virtual Network.
> A subnet is a range of IP addresses in the VNet.
> We could divide a VNet into multiple subnets for organization and security, for example, a _training_ subnet that only Data Scientists could use, and an _inference_ subnet that is publicly available.

## Secure network access to the ML Workspace

So far we've created two independent resources:

- An ML workspace (**ml-workspace**)
- A VNet (**MLVNet**)

We now have to connect these two resources so that the workspace network traffic has to go through our VNet. In other words, we want our workspace available **only** to resources that are connected to the **MLVNet** virtual network.

To accomplish that, we need to define a [Private Endpoint](/azure/private-link/private-endpoint-overview) for _ml-workspace_.

> [!TIP]
> A Private Endpoint is a network interface that uses a private IP Address from your VNet to create secure and private connections to a resource.

## Create a Private Endpoint

1. Go to "Home", select **Resource Groups**, select the **MLResourceGroup** resource group, and then select your **ml_workspace** workspace:

    :::image type="content" source="../media/ml_workspace_home.png" alt-text="Screenshot showing an example of step 1.":::

2. In the left-hand menu, select **Private endpoint connections**:

    :::image type="content" source="../media/pvt1.png" alt-text="Screenshot showing an example of the Azure Virtual Private Endpoints.":::

3. Select **Private Endpoint** and fill the form with the following values:

    :::image type="content" source="../media/pvt2.png" alt-text="Screenshot showing the form to fill in to complete step 3.":::

   | Setting              | Value                                                                                                 |
   | -------------------- | ----------------------------------------------------------------------------------------------------- |
   | **Project details**  |                                                                                                       |
   | Subscription         | Select your subscription.                                                                             |
   | Resource group       | Enter <b>MLResourceGroup</b> (or the name of the Resource Group you created in the previous exercise) |
   | **Instance details** |                                                                                                       |
   | Name                 | Enter **MLPrivateEndpoint**.                                                                          |
   | Region               | Select **(US) East US**.                                                                              |

4. Select the **Next: Resource >** button.

5. In the **Resource** tab, fill in using the values below:

    :::image type="content" source="../media/pvt3.png" alt-text="Screenshot showing an example of the form to fill in from step 5.":::

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

    :::image type="content" source="../media/pvt4.png" alt-text="Screenshot showing an example of the form from step 6.":::

   | Setting                         | Value                     |
   | ------------------------------- | ------------------------- |
   | Virtual Network \*              | **MLVNet**                |
   | Subnet \*                       | **default (10.1.0.0/24)** |
   | Integrate with private DNS zone | **Yes**                   |

7. Select **Review + Create** to validate this deployment, then select **Create** to deploy the endpoint (this may take a few moments):

    :::image type="content" source="../media/pvt_final.png" alt-text="Screenshot showing the your deployment is complete message.":::

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

- [What is Azure Virtual Network?](/azure/virtual-network/virtual-networks-overview)
- [Azure Virtual Network concepts and best practices](/azure/virtual-network/concepts-and-best-practices)
- [Secure Azure Machine Learning workspace resources using virtual networks (VNets)](/azure/machine-learning/how-to-network-security-overview)
- [What is Azure Private Endpoint?](/azure/private-link/private-endpoint-overview)
