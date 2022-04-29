Now that you have an Azure Automation account, you'll also need to create an Azure Automation Run As account.

The Azure Automation Run As account allows access to your Azure resources.

An Azure Automation Run As account provides authentication for managing resources in Azure with Azure cmdlets. When you create a Run As account, it creates a new service principal user in Azure Active Directory and assigns the Contributor role to the service principal user at the subscription level. An Azure Run As account is a great way to authenticate securely with certificates and a service principal name without needing to store a username and password in a credential object.

Any user who's a member of the Subscription Admins role and coadministrator of the subscription can create a Run As account.

To create a Run As account in your Azure Automation account:

1.  In the Azure portal, select **All services**. In the list of resources, enter and select **Automation accounts**.
2.  On the **Automation accounts** page, select the name of your Azure Automation account.:::image type="content" source="../media/create-run-as-account-1-107fc59b.png" alt-text="Image showing how to create a Run As account in the Azure portal.":::
    

3.  In the pane on the left side of the window, select **Run As accounts** under the **Account Settings** section.:::image type="content" source="../media/create-run-as-account-2-7841bf88.png" alt-text="Image showing how to configure account settings for Run As account.":::
    

4.  Select **Azure Run As account**. When the **Add Azure Run As account** pane appears, review the overview information, and then select **Create** to start the account creation process.
5.  Wait a few minutes for Azure to create the Run As account. You can track the creation progress in the menu under Notifications.
6.  When the process finishes, it will create an account in the specified Azure Automation account. Select **Azure Run As account**.
