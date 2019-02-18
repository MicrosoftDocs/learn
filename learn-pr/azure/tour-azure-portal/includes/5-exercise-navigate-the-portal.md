The Azure Portal has a lot of features and services available; let's look at some of the more common areas you'll tend to use. First, take a moment to hover your mouse pointer over each of the icons in the top menu bar for a few seconds each. You should see a tooltip label pop up for each one. This is the name of the menu item. You will use these icons later.

![Screenshot of the Azure portal icon bar](../media/5-portal-icon-bar.png)

## Services blade

1. In the left-hand pane, click **All services**. Take a couple of minutes to scroll down the list to see how many services Azure offers.

1. Click **Virtual machines**. The **Virtual Machines** blade appears. There is nothing currently showing because you have not defined any virtual machines.

1. Click the **+ Add** button. The **Create a virtual machine** blade appears, as in the previous exercise.

1. Click the **X** in the top right-hand corner to close the **Create a virtual machine** blade.

1. Click the **X** in the top right-hand corner to close the **Virtual machines** blade. 

1. You should now be back at the Dashboard page. If not, you can always click on **Dashboard** in the left-most pane.

## Notifications blade

1. On the icon bar menu bar, click the **Notifications** (bell) icon. This will list any pending notifications.

1. If any notifications appear, hover your mouse over one of them. Click the **X** that appears in that notification to dismiss it.

1. To the right of **Dismiss**, click **All**. You should have no notifications showing.

1. Click the **X** in the top right-hand corner to close the **Notifications** pane.

## Azure Cloud Shell

1. Click the **Cloud Shell** icon (`>_`) to create a Cloud Shell session.

1. You may see a Welcome window. Click **Bash** or **PowerShell**, depending on your personal preferences.

    - If you now see a window notifying you that you have no storage mounted, click **Create storage**. You may also need to click the link **Advanced settings** and manually enter names for the required storage configuration.

1. Once the Cloud Shell prompt appears, type `az help`, and press Enter.

1. Click the language drop-down on the left of the bar, and change the scripting language from PowerShell to Bash or from Bash to PowerShell, depending on which option you selected. Click **Restart** when prompted. The screen displays **Restarting your Cloud Shell**.

1. In the restarted shell, type `az help` and press Enter.

1. In the Cloud Shell window, click the **Settings** (cog) icon. Note that you can change the text size and the font.

1. Click the **X** in the top right-hand corner to close the **Cloud Shell** pane.

## Settings

1. Click the **Settings** (cog) icon to open the **Portal settings** pane.

1. Drop down the **Log me out when inactive** setting, and select **After one hour**.

1. Under **Choose a theme**, select the different colored themes and observe the changes to the portal UI. Leave it set to the one you like the best.

1. Under **High contrast theme**, try the three different options.

1. Disable Toast notifications. This means notifications will not appear as pop-up "toast"-style notifications, but will still show up in the Notifications (bell) icon as always.

1. Note the **Allow double-click on dashboard to change theme** setting, enabled by default. When enabled, you can use the mouse to cycle through the various color themes without opening this Settings menu by double-clicking the left mouse button in the Dashboard view's background area. Disable this option to avoid accidentally changing your color theme.

1. Click **Apply** to accept your changes.

1. Click the **Settings** (cog) icon in the top menu bar and, under **Language**, select **Español**, and then click the **Refresh** button. If a **Translate this page** dialog box appears, close the box. Note that the whole portal is now in Spanish.

1. Click the **Settings** (cog) icon in the top menu bar and, under **Language**, select **English**. Click the **Actualizar** button. The portal returns to English.

## Feedback blade

1. Click the **Feedback** (smiley face) icon to open the **Send us feedback** blade.

1. Type your impressions of Azure in the **Tell us about your experience** box, click the box that says **Microsoft can email you about your feedback**, and click **Submit Feedback**.

1. A **Feedback sent** message will appear, and then close. You should now be back at the Dashboard.

## Help blade

### Support requests

> [!NOTE]
> Support requests can only be created using an active paid subscription. Creating support requests from a free Microsoft Learn sandbox is not supported. The following information applies to paid subscriptions which allow new support requests to be created.

1. Click the **Help** (`?`) icon to show the **Help** blade.

1. Click the **Help + Support** button.

1. In the **Help + Support** blade, under **Support**, click **New support request**. To create a new support request, you would fill in the information in each of the following sections, and then click **Create** to lodge the issue.

    - **Basics:** the issue type
    - **Problem:** severity of the problem, a summary and description, and any additional information
    - **Contact information:** preferred contact method and the information associated with this contact method

1. You can view the status of your support requests by clicking on **All support requests**.

### What's new and other information

1. Click the **Help** icon and click **What's new**.

1. Review the features that have recently been released. Also note and explore the other **Help** menu options, such as:

- Azure roadmap
- Launch guided tour
- Keyboard shortcuts
- Show diagnostics
- Privacy + terms

1. Click the **X** in the top right-hand corner to close the **Help** blade.

1. Close the **What's new** blade. You should now be back to the Dashboard.

## Directory and subscription

1. Click the **Directory + Subscription** (book and filter) icon to show the **Directory + subscription** blade.  This is where you can switch between multiple directories if you have more than one. If you do not have additional directories, you will not be able to switch directories, but there is a link to learn more about them.

1. Click the **X** in the top right-hand corner to close the **Directory + subscription** blade.

## Profile settings

1. Click on your name in the top right-hand corner of the portal. Options include:

    - Sign in with another account, or sign out entirely
    - View your account profile, where you can change your password
    - Submit an idea
    - Check your permissions
    - View your bill
    - Update your contact information

    Note that some items do not appear unless you click the "..." icon.

1. Click "..." then **View my bill** to navigate to the **Cost Management + Billing - Invoices** page, which helps you analyze where Azure is generating costs.

1. In the **Subscription or reserved instance** dropdown menu in the right pane, select your subscription.

1. Click a billing period.

1. Note the service costs and check them against what you expect for your current subscription.

1. Click the **X** in the top right-hand corner to close the **Costs by service** blade.

1. Click the **X** in the top right-hand corner to close the **Cost Management + Billing - Invoices** page.

1. You should now be back at the Dashboard.

Now that we've explored all the main areas of the Azure portal, let's look at one of the most useful features - Dashboards.