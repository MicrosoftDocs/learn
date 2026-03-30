# Request region access for Azure NetApp Files

In some special situations, you might need to explicitly request access to a region. This section explains how to submit a request.

In the Azure NetApp Files portal, create a **New Support Request** under **Support + troubleshooting** page.

* Under the **Problem description** tab, you need to provide the required information:
  1. For **Issue Type**, select **Service and Subscription Limits (Quotas).**
  2. For **Subscription**, select your subscription.
  3. For **Quota Type**, select **Storage: Azure NetApp Files limits**.

![# Azure NetApp Files - New Support Request This screenshot shows the **Azure portal** interface for creating a **New Support Request** for an Azure NetApp Files account named **"IE_Test"**. ## Left Navigation Panel The sidebar contains several sections: - **Settings**: Quota, Properties, Locks - **Azure NetApp Files**: Active Directory connections - **Storage service**: Capacity pools, Volumes - **Data protection**: Snapshot policies, Backups - **Storage service add-ons**: NetApp add-ons - **Automation**: Tasks (preview), Export template - **Support + troubleshooting**: **New Support Request** (highlighted with a red box) ## Main Content - Step 1: Problem Description The form is on step **1. Problem description** (highlighted), with steps 2 (Recommended solution) and 3 (Additional details) to follow. The form includes three fields: | Field | Value | |-------|-------| | **Issue type** | Service and subscription limits (quotas) | | **Subscription** | *(empty - needs selection)* | | **Quota type** | Storage: Azure NetApp Files limits | There's also a **"Can't find your subscription? Show more"** link and a **Next** button at the bottom. This workflow is typically used to **request quota increases** for Azure NetApp Files resources.](../media/manage-azure-netapp-files-register-setup/image_004.png)

Pic4

* Under the Additional details tab, click Enter details in the Request Details field.
* To request region access, you need to provide **Quota type** and **Region requested** information.

![## Azure Quota Details Form This image shows an **Azure portal** dialog for requesting a quota increase or access. The form contains the following elements: - **Title**: "Quota details" with a close (×) button in the top-right corner - **Quota type** (required field, marked with *): A dropdown selector currently set to **"Region Access"** - **Region requested** (required field, marked with *): An empty dropdown selector where the user needs to select a specific Azure region - Both fields have information icons (ℹ) next to their labels - A **"Save and continue"** button at the bottom in blue This form is typically used when a user needs to request access to a specific Azure region that isn't currently enabled for their subscription, which is part of the Azure support/quota request workflow.](../media/manage-azure-netapp-files-register-setup/image_005.png)

Pic5
