<a name='create-an-azure-account-and-add-azure-active-directory-premium-p2-trial-licenses'></a>

## Create an Azure account and add Microsoft Entra ID P2 trial licenses

The tasks in this exercise and the exercises in this learning path require you to already have and Azure subscription that you can use or to sign up for an Azure trial account. If you already have your own Azure subscription, you may skip this task and continue to the next.

1.  In a web browser, go to [Azure portal](https://azure.microsoft.com/free/).
2.  Scroll down through the page to learn more about the benefits and free services available.
3.  Select **Start free**.
4.  Use the wizard to sign up for your Azure trial subscription.
5.  You will need to add a Microsoft Entra ID P2 license to complete some of the exercises. In the organization you created, search for and then select **Microsoft Entra ID**.
6.  In the left navigation menu, select **Getting started**.
7.  Under Getting started with Microsoft Entra ID, select **Get a free trial for Microsoft Entra ID P1 or P2**.
8.  In the Activate pane, under **Microsoft Entra ID P2**, select **Free trial** and then select **Activate**.
9.  In the navigation menu on the left, select **Overview**.
10. Refresh the browser until you see Microsoft Entra ID P2 under the organization name. It may take a couple of minutes.
11. You may need to sign out and sign back into Microsoft Azure if you encounter any problems with expected features not being available.

<a name='add-an-app-to-your-azure-ad-tenant'></a>

## Add an app to your Microsoft Entra tenant

Here, you’ll add an Enterprise app that you can use for the exercise.

1.  Sign in to the [Azure portal](https://portal.azure.com/) using a Global Administrator account.
2.  Open the portal menu and then select **Microsoft Entra ID**.
3.  On the **Microsoft Entra ID** blade, under **Manage**, select **Enterprise applications**.
4.  In the **Enterprise applications** pane, select **+ New application**.
    
    :::image type="content" source="../media/new-enterprise-application-c413caf8.png" alt-text="Screenshot of the Enterprise applications screen with New application highlighted.":::
    
5.  In the **Browse Microsoft Entra Gallery (Preview)** blade, in the **Search application** box, enter **GitHub**.
    
    :::image type="content" source="../media/azure-active-directory-gallery-search-dd2360d5.png" alt-text="Screenshot of the Browse Microsoft Entra Gallery screen with the search box highlighted.":::
    
6.  In the results, select **GitHub Enterprise Cloud – Enterprise Account**.
7.  In the **GitHub Enterprise Cloud – Enterprise Account**, review the settings and then select **Create**.
8.  Once the account is created, you will be redirected to the **GitHub Enterprise Cloud – Enterprise Account** blade.

## Assign users to an app

Assign your administrator account to the recently added app.

1.  On the **GitHub Enterprise Cloud – Enterprise Account** blade, on the **Overview** page, under **Getting Started**, select **1. Assign users and groups**. Alternatively, in the left navigation, under **Manage**, you can select **Users and groups**.
2.  On the **Users and groups** page, on the menu, select **+Add user/group**.
3.  On the **Add Assignment** blade, select **Users and groups**.
4.  In the **Users and groups** pane, select your administrator account and then **Select**.
    
    :::image type="content" source="../media/add-app-assignment-4da30b72.png" alt-text="Screenshot of add a user account assignment to an app with the Select button highlighted.":::
    
5.  Select **Assign**.
