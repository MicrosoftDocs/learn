An [Azure Virtual Network (VNet)](/azure/virtual-network/virtual-networks-overview) is similar to a traditional network but with the added benefits provided by Azure infrastructure.

VNets enable your resources, such as virtual machines (VMs) and ML workspaces, to securely communicate with each other and other networks or the internet.

A Machine Learning engineer can use them in a variety of scenarios, such as linking a VM to data stored on-premises, restricting access to a training API so that only personnel from their lab can see it, or exposing an inference endpoint to the internet.

In this exercise, we'll create a VNet and use it to secure access the workspace we created in the previous exercise. While this exercise gives an intuition about the mechanics of securing a workspace, this is not a complete solution. Refer to the documentation linked at the end of the exercise for complete instructions.

> [!WARNING] 
>
> This exercise will only give a basic intuition as to the process involved in securing an ML workspace's network environment. For complete step-by-step process for a production environment, follow the link at the end of this exercise.

> [!WARNING] 
>
> This exercise will block access to the affected workspace and should not be performed on a production workspace.

## Prerequisites

- Basic knowledge of networking concepts.
- An Azure account and a subscription.
- A resource group Azure Machine Learning Workspace as created in the previous exercise.

## Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com/).

## Create a VNet

Let's create a VNet for this exercise:

1. In the Azure portal, Select **Create a resource** in the upper left-hand corner of the portal.

2. In the search box, enter **Virtual Network**. Select **Virtual Network** in the search results.

3. In the **Virtual Network** page, select **Create**.

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing the virtual network page with a red box around create.](../media/create-vnet.png)

4. In **Create virtual network**, enter or select this information in the **Basics** tab:

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing how to fill in the Azure Virtual Network form.](../media/vnet-form-1.png)

   | Setting              | Value                                                        |
   | -------------------- | ------------------------------------------------------------ |
   | **Project details**  |                                                              |
   | Subscription         | Select your subscription.                                    |
   | Resource group       | Enter **MLResourceGroup** (or the name of the Resource Group you created in the previous exercise) |
   | **Instance details** |                                                              |
   | Name                 | Enter **MLVNet**.                                            |
   | Region               | Select **(US) East US**.                                     |

5. Select the **IP Addresses** tab, or select the **Next: IP Addresses** button at the bottom of the page.

   > [!TIP] 
   >
   > If your screen comes with the IPv4 address space and *default* subnet setup like in the image below, skip to step 9.

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing Azure Virtual Network IP Addresses page.](../media/vnet-form-2.png)

6. In **IPv4 address space**, select the existing address space and change it to **10.1.0.0/16**.

7. Select **+ Add subnet**, then enter **default** for **Subnet name** and **10.1.0.0/24** for **Subnet address range**.

8. Select **Add**.

9. Select the **Review + create** tab or select the **Review + create** button.

10. Select **Create** and wait a few moments for the deployment to finish:

    > [!div class="mx-imgBorder"]
    > ![Screenshot showing the deployment complete page from step 11.](../media/vnet-deployment.png)

> [!IMPORTANT] 
>
> For simplicity, we are creating a single subnet for our Virtual Network. A subnet is a range of IP addresses in the VNet. We could split a VNet into multiple subnets for organization and security, for example, a *training* subnet that only Data Scientists could use, and an *inference* subnet that is publicly available.

## Testing workspace access

We just added a VNet to our resource group, but is it restricting access to our **ml-workspace**?

We can test that using [Azure Machine Learning Studio](/azure/machine-learning/overview-what-is-machine-learning-studio) to access the contents of the workspace.

> [!TIP] 
>
> The Azure Machine Learning Workspace is a web portal with high-level tools for model training, deployment, and asset management.

1. Select **Home** to go back to the home page

2. Select the **ml-workspace** in the list of recent resources:

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing the Azure portal with a red box around ml-workspace.](../media/workspace-1.png)

3. Select the **Studio web URL** for your workspace:

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing the studio web url to select.](../media/workspace-2.png)

4. Azure Machine Learning Studio should open in a new tab or window. Scroll down until you can see the tabs below (Runs, Compute, Models, and Datasets):

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing the workspace with no warnings.](../media/workspace-no-warnings.png)

Each tab above represents a "folder" that stores the resources you and your team would use in Machine Learning.

Although you probably don't have any objects there yet, like in the image above, there should be no warnings or error messages, meaning that there's no network access restrictions on those resources yet.

## Secure network access to the ML Workspace

So far we've created two independent resources:

- An ML workspace (**ml-workspace**)
- A VNet (**MLVNet**)

We now have to connect these two so that the workspace network traffic has to go through our VNet. In other words, we want our workspace available **only** to resources that are connected to the **MLVNet** virtual network.

To accomplish that, we need to define a [Private Endpoint](/azure/private-link/private-endpoint-overview) for the *ml-workspace* resource.

> [!TIP] 
>
> A Private Endpoint is a network interface that uses a private IP Address from your VNet to create secure and private connections to a resource.

## Create a Private Endpoint

1. Go to "Home", select **Resource Groups**, select the **MLResourceGroup** resource group, and then select your **ml_workspace** workspace:

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing the machine learning workspace page.](../media/ml-workspace-home.png)

2. In the left-hand menu, select **Private endpoint connections**:

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing where to select private endpoint connections with a red box.](../media/private-endpoint-1.png)

3. Select **Private Endpoint** and fill the form with the following values:

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing how to fill in the private endpoint form.](../media/private-endpoint-2.png)

   | Setting              | Value                                                        |
   | -------------------- | ------------------------------------------------------------ |
   | **Project details**  |                                                              |
   | Subscription         | Select your subscription.                                    |
   | Resource group       | Enter **MLResourceGroup** (or the name of the Resource Group you created in the previous exercise) |
   | **Instance details** |                                                              |
   | Name                 | Enter **MLPrivateEndpoint**.                                 |
   | Region               | Select **(US) East US**.                                     |

4. Select the **Next: Resource >** button.

5. In the **Resource** tab, use the values below

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing how to fill in the resources form.](../media/private-endpoint-3.png)

   | Setting              | Value                                                 |
   | -------------------- | ----------------------------------------------------- |
   | **Project details**  |                                                       |
   | Subscription         | Select your subscription.                             |
   | Resource type        | Enter **Microsoft.MachineLearningService/workspaces** |
   | **Instance details** |                                                       |
   | Resource *           | Select **ml-workspace**.                              |
   | Target subresource   | Select **amlworkspace**.                              |

6. Select the **Next: Configuration >** button.

   Leave the suggested defaults:

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing how to fill in the configuration form.](../media/private-endpoint-4.png)

   | Setting                         | Value                     |
   | ------------------------------- | ------------------------- |
   | Virtual Network *               | **MLVNet**                |
   | Subnet *                        | **default (10.1.0.0/24)** |
   | Integrate with private DNS zone | **Yes**                   |

7. Select **Review + Create** to validate the deployment, then select **Create** to deploy the endpoint (this can take a few moments):

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing the deployment complete page.](../media/private-endpoint-4.png)

## Testing the network configuration

We can make sure our workspace is inside the VNet now by testing if we still have access to its resources:

1. Reload the Azure Machine Learning Studio window (or [open the Studio](https://ml.azure.com/) again):

   > [!div class="mx-imgBorder"]
   > ![Screenshot showing the workspace with warnings on the page.](../media/workspace-with-warnings.png)

2. As the warning shows, access to those resources is now blocked. That happens because your workspace is now inside the VNet, and it's configured to block all requests that don't originate from within the *default* subnet we created (remember we're trying to access it from the **outside** of the network perimeter).

### Secured but inaccessible

You've just secured the network access to your ML workspace.

Notice that in the same way you can't access it, neither can any other resources in your organization that aren't part of the subnet.

Opening things up so that resources can connect requires some strategical planning!

We recommend reading our [how to secure a workspace using a vnet](//azure/machine-learning/how-to-secure-workspace-vnet) guide for more in-depth reference.

## Summary

In this unit you've covered the following topics:

- What a Virtual Network is and some of its uses
- Creating an Azure Virtual Network
- Creating subnets in a Virtual Network
- How to use Private Endpoints to secure network access to you Machine Learning workspaces
- Accessing a workspace using Azure Machine Learning Studio and check if resources are blocked
