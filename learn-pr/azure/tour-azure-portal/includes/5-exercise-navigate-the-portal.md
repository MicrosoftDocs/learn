The Azure portal has several features and services available; let's look at some of the more common areas you'll tend to use. First, take a moment to hover your mouse pointer over each of the icons in the top menu bar for a few seconds each. You should see a tooltip label pop-up for each one. This label is the name of the menu item. You will use these icons later.

![Screenshot of the Azure portal icon bar with options for Azure Cloud Shell, directory and subscription, notifications, portal settings, help, and feedback.](../media/5-portal-icon-bar.png)

## All services

1. On the top left-hand side of the Azure portal, select **Show portal menu**.

    ![Screenshot of the portal menu option on the left-hand side of the portal.](../media/5-show-portal-menu.png)

1. Select **All services**. Take a couple of minutes to look through the list to get an idea of how many services Azure offers. You can filter the services that appear by using the search box near the top of the pane.

1. Select **Virtual machines**. If you don't see it, use the search box.

1. The **Virtual Machines** pane appears. You haven't created any virtual machines yet, so there are no results.

1. Select **+ Create** > **Azure virtual machine**. The **Create a virtual machine** pane appears.

1. Select the **X** in the top right-hand corner to close the **Create a virtual machine** pane.

1. Select the **X** in the top right-hand corner to close the **Virtual machines** pane.

1. Select **Microsoft Azure** on the top left-hand side to get back to the home page.

## Azure Cloud Shell

![Icon that represents the Azure Cloud Shell option on the top right-hand side menu.](../media/5-cloud-shell-icon.png)

The Azure Cloud Shell allows you to use a command-line interface (CLI) to execute commands in your Azure subscription. You can access it by selecting the (`>_`) icon in the toolbar. You can also navigate to <https://shell.azure.com> to launch a Cloud Shell in the browser independent of the portal.

The Azure Cloud Shell is available in the Sandbox environment, but the Sandbox version of the shell has reduced functionality. To use all of the Azure Cloud Shell features, use your own Azure subscription.

When you launch the shell, you'll see a Welcome window. You can choose either a **Bash** or **PowerShell** environment, depending on your personal preferences. You can also change the shell at any time through the language drop-down on the left side of the shell.

Finally, there are a variety of management and programming tools included in the created environment.

- Azure command-line tools (Azure CLI, AzCopy, etc.)
- Languages / Frameworks including .NET Core, Python, and Java
- Container management support for Docker, Kubernetes, etc.
- Code editors such as vim, emacs, code, and nano
- Build tools (make, maven, npm, etc.)
- Database query tools such as `sqlcmd`

## Directories and subscriptions

![Icon representing the directory and subscription option on the top right-hand side menu.](../media/5-subscription-icon.png)

1. Select the **Directory + Subscription** (book and filter) icon to show the **Directories + subscriptions** pane.  

    This is where you can switch between multiple subscriptions or directories. You should see that you are in the Concierge Subscription of the Microsoft Learn Sandbox directory here. If you have other Azure directories tied to the same email address, those subscriptions will be available as well.

    There is also a link to learn more about directories and subscriptions.

1. Select the **X** in the top right-hand corner to close the **Directories + subscriptions** pane.

## Notifications pane

1. On the icon bar menu bar, select the **Notifications** (bell) icon. This window lists any pending notifications.

    ![Screenshot of notifications window on the top right-hand side menu.](../media/5-notifications-pane.png)

1. If any notifications appear, hover your mouse over one of them. Select the **X** that appears in that notification to dismiss it.

1. Select **Dismiss all**. You should have no notifications showing.

1. Select the **X** in the top right-hand corner to close the **Notifications** pane.

## Settings

![Icon representing the settings panel on the top right-hand side menu.](../media/5-settings-icon.png)

1. Select the **Settings** (cog) icon to open the **Portal settings** pane, showing the **Directories + subscriptions** settings by default.

1. Select the **Signing out + notifications** tab at the left, then drop down the **Sign me out when inactive** setting and select **After one hour**.

1. Select **Enable pop-up notifications**. When this option is checked, notifications will appear as pop-up "toast"-style notifications. They will still show up in the Notifications (bell) icon as well.

1. Select **Apply** to save your **Signing out + notifications** selections.

1. Select the **Appearance + startup views** tab at the left, and under **Theme**, select one of the different colored themes and select **Apply**. Observe the changes to the portal UI. Try all of the options, and leave it set to the one you like the best.

1. Under **High contrast theme**, try the three different options.

1. Select the **Language + region** tab at the left. In the **Language** drop-down box, select **Español**. Select the **Apply** button, then select **OK** to confirm your changes. If a **Translate this page** dialog box appears, close the box. The whole Azure portal now appears in Spanish. You can select **Microsoft Azure** to view the **Home** page in Spanish, or navigate to other pages.

1. To revert back to English, select the **Settings** (cog) icon in the top menu bar, then select the **Idioma y región** tab at the left. In the **Idioma** drop-down box, select **English**. Select the **Aplicar** button, then select **Aceptar** to confirm. The portal will now appear in English again.

## Help pane

![Icon representing the feedback panel on the top right-hand side menu.](../media/5-help-icon.png)

1. Select the **Help** (`?`) icon to show the **Help** pane.

1. Select the **Help + support** button.

1. In the **Help + support** pane, select **Create a support request**. To create a new support request, you would fill in the information in each of the following sections, and then select **Create** to submit the issue.

    - **Problem description:** a summary of the issue and the issue type
    - **Recommended solution:** review suggested solutions to your issue; if none apply, select **Next**
    - **Additional details:** add more details about your issue, including your preferred contact method and contact info
    - **Review + create:** review your information and submit your support request

1. You can view the status of your support requests by selecting **All support requests**.

Support requests can only be created using an active paid subscription. Creating support requests from a free Microsoft Learn sandbox is not supported, but you can click through the process 

### Other Help information

1. Select the **Help** icon and select **View service health**.

1. Review the information on the screen about any current service issues or planned maintenance.

1. Select the **Help** icon again to explore the other **Help** menu options, such as:

    - Ask the Azure community
    - Explore Azure documentation
    - What's new
    - Azure updates

1. When you're finished, select the **X** in the top right-hand corner to close the **Help** pane.

1. Close the **Service Health** pane by selecting the **X** in the top right-hand corner.

## Feedback pane

![Icon representing the feedback panel option on the top right-hand side menu.](../media/5-feedback-icon.png)

1. Select the **Feedback** icon to open the **Send feedback to Microsoft** pane.

1. Select one of the icons to indicate whether you are satisfied with your experience.

1. Type your impressions of Azure in the **Tell us about your experience** box.

1. Select the box that says **Microsoft can email you about your feedback**, then select **Submit feedback**.

1. A **Feedback sent** notification will appear briefly. You can view this notification again by selecting the **Notifications** (bell) icon, as described earlier.

## Profile settings

1. Select your name in the top right-hand corner of the portal. Options include:

    - Sign in with another account, or sign out entirely
    - View your account profile, where you can change your password
    - Submit an idea
    - Check your permissions
    - View your bill
    - Update your contact information

    Some of these items do not appear unless you select the "..." icon.

1. Select "..." then **View my bill** to navigate to the **Cost Management + Billing - Overview** page.

1. Review the information that appears, such as **Latest billed amount** and **Invoices over time**.

1. Select the **X** in the top right-hand corner to close the **Cost Management + Billing - Overview** page.

Now that we've explored all the main areas of the Azure portal, let's look at one of the most useful features: Dashboards.
