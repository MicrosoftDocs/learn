
In this exercise, you will register for Azure NetApp Files services, create a NetApp account, delegate a subnet, and request region access to Azure NetApp Files.

### Task 1 – Register for Azure Resource Provider

In this task, you use the Azure Cloud Shell to register your subscription for the Resource Provider and from Azure portal verify the registered subscription.

1. From the Azure portal, click the Azure Cloud Shell icon on the upper right-hand corner.

    ![This image shows an Azure portal resource provider registration entry for Microsoft.NetApp. It displays Provider name: Microsoft.NetApp, Status: Registered (indicated by a green checkmark), and Actions links for Re-register and Unregister. This is typically found in the Azure subscription's Resource providers settings.](../media/managing-azure-netapp-files-register-setup/image006.png)

2. If you have multiple subscriptions on your Azure account, select the one that you want to configure for Azure NetApp Files:

    `az account set --subscription <subscriptionId>`

3. In the Azure Cloud Shell console, enter the following command to register the Azure Resource Provider:

    `az provider register --namespace Microsoft.NetApp --wait`

4. In the Azure Cloud Shell console, enter the following command to verify that the Azure Resource Provider has been registered:

    `az provider show --namespace Microsoft.NetApp`

    In the output, `<SubID>` is your subscription ID. The state parameter value indicates `Registered`.

5. From the Azure portal, click **Subscriptions**.
6. In the Subscriptions blade, click your subscription ID.
7. In the settings of the subscription, click **Resource providers** to verify that Microsoft.NetApp Provider indicates the Registered status:

    ![This image shows the New NetApp account blade in the Azure Portal with fields including Name: account2 (validated with a checkmark), Subscription: test, Resource group: test (using Use existing option), and Location: East US. The form includes a Pin to dashboard checkbox and Create and Automation options buttons.](../media/managing-azure-netapp-files-register-setup/image007.png)

### Task 2: Create a NetApp Account

After you have registered your subscription to use the Resource Provider, in this task, you create a NetApp account from the Azure NetApp Files pane.

1. Sign in to the Azure portal.
2. Access the Azure NetApp Files pane by using one of the following methods:
   - Search for Azure NetApp Files in the Azure portal search box.
   - Select All services in the navigation, and then filter to Azure NetApp Files.
3. Select **+ Add** to create a new NetApp account. The New NetApp account window appears.
4. Provide the following information for your NetApp account:
   - **Account name**: Specify a unique name for the subscription.
   - **Subscription**: Select a subscription from your existing subscriptions.
   - **Resource group**: Use an existing resource group or create a new one.
   - **Location**: Select the region where you want the account and its child resources to be located.

    ![This image shows the Add subnet blade in the Azure Portal under the virtual network my.vnet. The configuration includes Name field with anf.subnet, Address range CIDR block 10.2.1.0/28 (10.2.1.0 - 10.2.1.15), Network security group set to None, Route table set to None, and Subnet Delegation set to Microsoft.Netapp/volumes. This is a typical configuration for creating a delegated subnet for Azure NetApp Files.](../media/managing-azure-netapp-files-register-setup/image008.png)

5. Select **Create**. The NetApp account you created now appears in the Azure NetApp Files pane.

### Task 3: Delegate a subnet

In this task, you select the subnet to use for Azure NetApp Files.

1. Go to the **Virtual networks** blade in the Azure portal and select the virtual network that you want to use for Azure NetApp Files.
2. Select **Subnets** from the Virtual network blade and click the **+Subnet** button.
3. Create a new subnet to use for Azure NetApp Files by completing the following required fields in the Add Subnet page:
   - **Name**: Specify the subnet name.
   - **Address range**: Specify the IP address range.
   - **Subnet delegation**: Select Microsoft.NetApp/volumes.

![This screenshot shows the Azure Portal interface for creating a New Support Request within a NetApp account named IE_Test. The left navigation panel shows settings and various sections. The form is on the Problem description tab with fields for Issue type set to Service and subscription limits (quotas), Subscription (empty), and Quota type set to Storage: Azure NetApp Files limits. A Next button is available at the bottom.](../media/managing-azure-netapp-files-register-setup/image009.png)

### Task 4: Request region access

In this task, you create a support request from to request access to your region.

1. Go to **New Support Request** under **Support + troubleshooting**.
2. Under the **Problem description** tab, provide the required information:
   - For **Issue Type**, select **Service and Subscription Limits (Quotas).**
   - For **Subscription**, select your subscription.
   - For **Quota Type**, select **Storage: Azure NetApp Files limits**.

    ![This screenshot shows the Azure Portal interface for creating a New Support Request on the Additional details step. The form shows Request details (required) with a link to Enter details, File upload option, Support plan set to Azure Support Plan - Standard, Severity set to C - Minimal impact, and Preferred contact method options for Email or Phone. Previous and Next buttons are at the bottom.](../media/managing-azure-netapp-files-register-setup/image010.png)

3. Under the **Additional details** tab, click **Enter details** in the Request Details field.

    ![This image shows a Quota details dialog panel from the Microsoft Azure portal. It contains Quota type (required field) dropdown selector set to Region Access, and Region requested (required field) dropdown selector where the user can choose the desired Azure region. Both fields have information icons for additional context. A Save and continue button and close button are at the bottom. This form is used when requesting access to a specific Azure region.](../media/managing-azure-netapp-files-register-setup/image011.png)

4. To request region access, provide the following information in the Quota Details window that appears:
   - In **Quota Type**, select **Region Access**.
   - In **Region Requested**, select your region.

    ![This image shows a Quota details dialog panel from the Microsoft Azure portal. It contains Quota type (required field) dropdown selector set to Region Access, and Region requested (required field) dropdown selector where the user can choose the desired Azure region. Both fields have information icons for additional context. A Save and continue button and close button are at the bottom. This form is used when requesting access to a specific Azure region.](../media/managing-azure-netapp-files-register-setup/image012.png)

5. Click **Save and continue**. Click **Review + create** to create the request.
