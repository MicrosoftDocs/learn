# Create a NetApp account

Creating a NetApp account enables you to set up a capacity pool so that you can create a volume. You use the Azure NetApp Files pane to create a new NetApp account.

* * A NetApp account serves as an administrative grouping of the constituent capacity pools.
  * A NetApp account isn't the same as your general Azure storage account.
  * A NetApp account is regional in scope.
  * You can have multiple NetApp accounts in a region, but each NetApp account is tied to only a single region.

You need to first sign in to the Azure portal and access the Azure NetApp Files pane by using one of the following methods:

* * Search for Azure NetApp Files in the Azure portal search box.
  * Select All services in the navigation, and then filter to Azure NetApp Files.

From the Azure NetApp Files you can select **+** **Add** to create a new NetApp account. In the New NetApp account window provide the following information for your NetApp account:

* * **Account name**: Specify a unique name for the subscription.
  * **Subscription**: Select a subscription from your existing subscriptions.
  * **Resource group**: Use an existing resource group or create a new one.
  * **Location**: Select the region where you want the account and its child resources to be located.

![## New NetApp Account Creation Form (Azure Portal) This image shows the **"New NetApp account"** blade in the **Azure Portal** with the following configuration fields: | Field | Value | |-------|-------| | **Name** | `account2` (validated with a ✓) | | **Subscription** | `test` | | **Resource group** | `Use existing` selected → `test` | | **Location** | `East US` | ### Additional Options: - **Pin to dashboard** checkbox (unchecked) - Two action buttons at the bottom: - **Create** (blue button) - **Automation options** (link) This is a standard Azure resource creation form for provisioning an **Azure NetApp Files** account, which is used for enterprise-grade file storage workloads in Azure. The user is setting up the account in an existing resource group called "test" within the East US region.](../media/manage-azure-netapp-files-register-setup/image_002.png)

Pic2
