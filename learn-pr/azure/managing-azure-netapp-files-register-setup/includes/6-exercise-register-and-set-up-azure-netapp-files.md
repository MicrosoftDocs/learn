In this exercise, you will register for Azure NetApp Files services, create a NetApp account, delegate a subnet, and request region access to Azure NetApp Files.

### Task 1 – Register for Azure Resource Provider

In this task, you use the Azure Cloud Shell to register your subscription for the Resource Provider and from Azure portal verify the registered subscription.

1. From the Azure portal, click the Azure Cloud Shell icon on the upper right-hand corner.

    ![Screenshot of Azure portal. Azure Cloud shell icon is highlighted in the screenshot.](../media/managing-azure-netapp-files-register-setup/ex-shell-icon.png)

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

    ![Screenshot of Azure portal interface. A row from an Azure portal interface is shown displaying a Resource Provider registration entry: Provider name: Microsoft.NetApp Status: Registered Actions available: Two clickable links — Re-register and Unregister. This is typically seen in the Azure subscription's Resource providers settings blade, where users can manage which Azure services (resource providers) are registered for use within their subscription.](../media/managing-azure-netapp-files-register-setup/ex-resource-provider-status.png)

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

    ![Screenshot of New NetApp account form in Azure NetApp Files pane. It shows configuration fields including Name: account2 (validated with a checkmark), Subscription: test, Resource group: test (using Use existing option), and Location: East US. The form includes a Pin to dashboard checkbox and Create and Automation options buttons.](../media/managing-azure-netapp-files-register-setup/ex-new-netapp-account.png)

5. Select **Create**. The NetApp account you created now appears in the Azure NetApp Files pane.

### Task 3: Delegate a subnet

In this task, you select the subnet to use for Azure NetApp Files.

1. Go to the **Virtual networks** blade in the Azure portal and select the virtual network that you want to use for Azure NetApp Files.
2. Select **Subnets** from the Virtual network blade and click the **+Subnet** button.
3. Create a new subnet to use for Azure NetApp Files by completing the following required fields in the Add Subnet page:
   - **Name**: Specify the subnet name.
   - **Address range**: Specify the IP address range.
   - **Subnet delegation**: Select Microsoft.NetApp/volumes.

    ![Screenshot of Add subnet blade in the Azure Portal for a virtual network called my.vnet. The screenshot shows the configuration fields Name, Address range CIDR block, Network security group, Route table, and Subnet Delegation. This is a typical setup for an Azure NetApp Files (ANF) delegated subnet.](../media/managing-azure-netapp-files-register-setup/ex-add-subnet.png)

### Task 4: Request region access

In this task, you create a support request from to request access to your region.

1. Go to **New Support Request** under **Support + troubleshooting**.
2. Under the **Problem description** tab, provide the required information:
   - For **Issue Type**, select **Service and Subscription Limits (Quotas).**
   - For **Subscription**, select your subscription.
   - For **Quota Type**, select **Storage: Azure NetApp Files limits**.

    ![Screenshot of Azure portal interface for creating a New Support Request under a NetApp account. The left navigation panel shows various sections including Settings, Azure NetApp Files, Storage service, Data protection, Storage service add-ons, Automation, and Support + troubleshooting sections. The form is on the first step (Problem description) with fields for Issue type set to Service and subscription limits (quotas), Subscription field (empty), and Quota type set to Storage: Azure NetApp Files limits. A Next button is available at the bottom.](../media/managing-azure-netapp-files-register-setup/ex-new-support-request.png)

3. Under the **Additional details** tab, click **Enter details** in the Request Details field.

    ![Screenshot of Azure portal interface for creating a New Support Request on the Additional details step. The form shows Request details (required) with a link to Enter details, File upload option, Support plan set to Azure Support Plan - Standard, Severity set to C - Minimal impact, and Preferred contact method options for Email or Phone. Previous and Next buttons are at the bottom.](../media/managing-azure-netapp-files-register-setup/ex-additional-details.png)

4. To request region access, provide the following information in the Quota Details window that appears:
   - In **Quota Type**, select **Region Access**.
   - In **Region Requested**, select your region.

    ![Screenshot of Quota details dialog panel from the Microsoft Azure portal. It shows Quota type (required field) dropdown selector set to Region Access, and Region requested (required field) dropdown selector where the user can choose the desired Azure region. Both fields have information icons for additional context. A Save and continue button and close button are at the bottom. This form is used when requesting access to a specific Azure region.](../media/managing-azure-netapp-files-register-setup/ex-quota-details.png)

5. Click **Save and continue**. Click **Review + create** to create the request.
