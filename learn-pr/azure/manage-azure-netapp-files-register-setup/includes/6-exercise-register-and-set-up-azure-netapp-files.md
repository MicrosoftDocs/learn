# Exercise – Register and Set Up Azure NetApp Files

In this exercise, you will register for Azure NetApp Files services, create a NetApp account, delegate a subnet, and request region access to Azure NetApp Files.

## Task 1 – Register for Azure Resource Provider

In this task, you use the Azure Cloud Shell to register your subscription for the Resource Provider and from Azure portal verify the registered subscription.

1. From the Azure portal, click the Azure Cloud Shell icon on the upper right-hand corner:

![This image shows a **toolbar or navigation bar** with 5 icons arranged horizontally on a dark/black background: 1. **Bell icon** 🔔 – typically for notifications 2. **Arrow/chevron icon** `>` – likely for navigation or a command prompt/terminal 3. **Gear/settings icon** ⚙️ – for settings or configuration 4. **Smiley face icon** 😊 – possibly for feedback, emoji, or user satisfaction 5. **Question mark icon** ❓ – for help or support This appears to be a **status bar or footer toolbar**, commonly found in applications like **Visual Studio Code** or similar developer tools/software interfaces.](../media/manage-azure-netapp-files-register-setup/image_006.png) pic6

1. If you have multiple subscriptions on your Azure account, select the one that you want to configure for Azure NetApp Files:

     az account set --subscription `<subscriptionId>`

2. In the Azure Cloud Shell console, enter the following command to register the Azure Resource Provider:

    az provider register --namespace Microsoft.NetApp –wait

3. In the Azure Cloud Shell console, enter the following command to verify that the Azure Resource Provider has been registered:

    az provider show --namespace Microsoft.NetApp

In the output, `SubID` is your subscription ID. The state parameter value indicates Registered.

1. From the Azure portal, click **Subscriptions**.
2. In the Subscriptions blade, click your subscription ID.
3. In the settings of the subscription, click **Resource providers** to verify that Microsoft.NetApp Provider indicates the Registered status:

![This image shows a row from an Azure portal interface displaying a **resource provider registration** entry: - **Provider name:** `Microsoft.NetApp` - **Status:** ✅ **Registered** (indicated by a green checkmark) - **Actions available:** Two clickable links — **Re-register** and **Unregister** This is typically found in the Azure subscription's **Resource providers** settings, where users can manage which Azure services (resource providers) are registered for use within their subscription.](../media/manage-azure-netapp-files-register-setup/image_007.png)

Pic7

## Task 2: Create a NetApp Account

After you have registered your subscription to use the Resource Provider. In this task, you create a NetApp account from the Azure NetApp Files pane.

1. Sign in to the Azure portal.
2. Access the Azure NetApp Files pane by using one of the following methods:
   1. Search for Azure NetApp Files in the Azure portal search box.
   2. Select All services in the navigation, and then filter to Azure NetApp Files.
3. Select **+ Add** to create a new NetApp account. The New NetApp account window appears.
4. Provide the following information for your NetApp account:
   1. **Account name**: Specify a unique name for the subscription.
   2. **Subscription**: Select a subscription from your existing subscriptions.
   3. **Resource group**: Use an existing resource group or create a new one.
   4. **Location**: Select the region where you want the account and its child resources to be located.

![# New NetApp Account Creation Form (Azure Portal) This image shows the **"New NetApp account"** creation blade in the **Azure Portal**. The form contains the following fields: - **Name**: Set to `account2` (validated with a green checkmark ✓) - **Subscription**: Set to `test` - **Resource group**: - Two options: *Create new* or *Use existing* (with **Use existing** selected) - Selected resource group: `test` - **Location**: Set to `East US` At the bottom of the form, there is: - A **"Pin to dashboard"** checkbox (unchecked) - A blue **"Create"** button - An **"Automation options"** link (for generating ARM templates) This is part of the **Azure NetApp Files** service setup process, where users configure a NetApp account as the first step before creating capacity pools and volumes.](../media/manage-azure-netapp-files-register-setup/image_008.png)

Pic8

1. Select **Create**. The NetApp account you created now appears in the Azure NetApp Files pane.

## Task 3: Delegate a subnet

In this task, you select the subnet to use for Azure NetApp Files.

1. Go to the **Virtual networks** blade in the Azure portal and select the virtual network that you want to use for Azure NetApp Files.
2. Select **Subnets** from the Virtual network blade and click the **+Subnet** button.
3. Create a new subnet to use for Azure NetApp Files by completing the following required fields in the Add Subnet page:
   1. **Name**: Specify the subnet name.
   2. **Address range**: Specify the IP address range.
   3. **Subnet delegation**: Select Microsoft.NetApp/volumes.

![# Azure "Add Subnet" Configuration Panel This image shows the **Add subnet** blade in the Azure Portal for a virtual network called **my.vnet**. The configuration includes the following settings: ## Fields Configured: | Setting | Value | |---------|-------| | **Name** | `anf.subnet` | | **Address range (CIDR block)** | `10.2.1.0/28` | | **Available range** | 10.2.1.0 - 10.2.1.15 (11 + 5 Azure reserved addresses) | | **Network security group** | None | | **Route table** | None | ## Service Endpoints - **Services**: 0 selected ## Subnet Delegation - **Delegate subnet to a service**: `Microsoft.Netapp/volumes` --- This is a typical setup for creating a **delegated subnet for Azure NetApp Files (ANF)**. The subnet is delegated to `Microsoft.Netapp/volumes`, which is a requirement for deploying Azure NetApp Files volumes. The `/28` CIDR block provides a small subnet with 16 IP addresses (11 usable after Azure reserves 5). Both the Name and Address range fields show green checkmarks indicating valid input.](../media/manage-azure-netapp-files-register-setup/image_009.png)

Pic9

## Task 4: Request region access

In this task, you create a support request from to request access to your region.

1. Go to **New Support Request** under **Support + troubleshooting**.
2. Under the **Problem description** tab, provide the required information:
   1. For **Issue Type**, select **Service and Subscription Limits (Quotas).**
   2. For **Subscription**, select your subscription.
   3. For **Quota Type**, select **Storage: Azure NetApp Files limits**.

![# Azure NetApp Files - New Support Request This screenshot shows the **Azure Portal** interface for creating a **New Support Request** for an Azure NetApp Files account named **"IE_Test"**. ## Left Navigation Panel The sidebar includes several sections: - **Settings**: Quota, Properties, Locks - **Azure NetApp Files**: Active Directory connections - **Storage service**: Capacity pools, Volumes - **Data protection**: Snapshot policies, Backups - **Storage service add-ons**: NetApp add-ons - **Automation**: Tasks (preview), Export template - **Support + troubleshooting**: **New Support Request** (highlighted with a red box) ## Main Content - Problem Description (Step 1 of 3) The form is on **Step 1: Problem description** (highlighted), with steps 2 (Recommended solution) and 3 (Additional details) visible in the workflow. The form includes three fields: | Field | Value | |-------|-------| | **Issue type** | Service and subscription limits (quotas) | | **Subscription** | *(empty - not yet selected)* | | **Quota type** | Storage: Azure NetApp Files limits | A **"Can't find your subscription? Show more"** link is available below the Subscription dropdown. A **Next** button is at the bottom to proceed to the next step. This workflow is typically used to **request quota increases** for Azure NetApp Files resources.](../media/manage-azure-netapp-files-register-setup/image_010.png)

Pic10

1. Under the Additional details tab, click Enter details in the Request Details field.

![# Azure NetApp Files - New Support Request (Step 3: Additional Details) This screenshot shows the **Azure Portal** interface for creating a **New Support Request** under a NetApp account called **"IE_Test"**. ## Current Step: 3. Additional Details The form is on step 3 of 4 in the support request workflow: 1. Problem description → 2. Recommended solution → **3. Additional details** → 4. Review + create ## Main Sections Visible: ### Problem Details - **Request details** (required) — with a link to **"Enter details"** for providing specifics about the request - **File upload** — option to attach a file ### Support Method - **Support plan**: Azure Support Plan - Standard - **Severity**: Set to **"C - Minimal impact"** (dropdown) - **Preferred contact method**: Choice between **Email** or **Phone** ## Left Navigation Panel The sidebar shows various NetApp account management options: - **Quota**, **Properties**, **Locks** - **Azure NetApp Files**: Active Directory connections - **Storage service**: Capacity pools, Volumes - **Data protection**: Snapshot policies, Backups - **Storage service add-ons**: NetApp add-ons - **Automation**: Tasks (preview), Export template - **Support + troubleshooting**: **New Support Request** (highlighted with a red box) ## Navigation Buttons **Previous** and **Next** buttons are available at the bottom to move between steps. This appears to be a **quota increase request** based on the note: *"Additional information is required to promptly process your request for a quota increase."*](../media/manage-azure-netapp-files-register-setup/image_011.png)

Pic11

1. To request region access, provide the following information in the Quota Details window that appears:
   1. In Quota Type, select Region Access.
   2. In Region Requested, select your region.

![## Azure Quota Details Form This image shows a **Quota details** dialog panel from the **Microsoft Azure portal**, used for submitting a quota increase or access request. ### Form Fields Shown: - **Quota type*** — A required dropdown field currently set to **"Region Access"** - **Region requested*** — A required dropdown field that is currently **empty/unselected** ### Other Elements: - An **✕** (close) button in the top-right corner to dismiss the panel - **ⓘ** (info) icons next to each field label for additional context/tooltips - A **"Save and continue"** button at the bottom to proceed with the request This form is typically used when a user needs to request access to a specific Azure region that isn't currently enabled for their subscription.](../media/manage-azure-netapp-files-register-setup/image_012.png)

Pic12

1. Click **Save and continue**. Click **Review + create** to create the request.
