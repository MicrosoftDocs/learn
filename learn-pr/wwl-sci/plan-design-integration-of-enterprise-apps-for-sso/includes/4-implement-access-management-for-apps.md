## Create an Azure account and add Microsoft Entra ID Premium P2 trial licenses

The tasks in this exercise and the exercises in this learning path require you to already have and Azure subscription that you can use or to sign up for an Azure trial account. If you already have your own Azure subscription, you skip this task and continue to the next.

1.  In a web browser, go to [Azure free subscription portal](https://azure.microsoft.com/free/).
2.  Scroll down through the page to learn more about the benefits and free services available.
3.  Select **Start free**.
4.  Use the wizard to sign up for your Azure trial subscription.
5.  You need to a Microsoft Entra ID P2 license to complete some of the exercises. In the organization you created, search for and then select **Microsoft Entra ID**.
6.  In the left navigation menu, select **Getting started**.
7.  Under Getting started with Microsoft Entra ID, select **Get a free trial for Microsoft Entra ID Premium**.
8.  In the Activate pane, under **Microsoft Entra ID PREMIUM P2**, select **Free trial** and then select **Activate**.
9.  In the navigation menu on the left, select **Overview**.
10. Refresh the browser until you see Microsoft Entra ID Premium P2 under the organization name. It takes a couple of minutes.
11. You need to sign out and sign back into Microsoft Azure if you encounter any problems with expected features not being available.

## Add an app to your Microsoft Entra tenant

Here, you add an Enterprise app that you can use for the exercise.

1.  Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) using a Global Administrator account.
2.  Open the portal menu and then select **Identity**.
3.  On the **Identity menu**, under **Applications**, select **Enterprise applications**.
4.  In the **Enterprise applications** pane, select **+ New application**.
    
    :::image type="content" source="../media/new-enterprise-application-c413caf8.png" alt-text="Screenshot of the Enterprise applications screen with New application highlighted.":::
    
5.  In the **Browse Microsoft Entra Gallery** page, in the **Search application** box, enter **GitHub**.
    
    :::image type="content" source="../media/azure-active-directory-gallery-search-dd2360d5.png" alt-text="Screenshot of the browse Microsoft Entra ID Gallery screen with the search box highlighted.":::
    
6.  In the results, select **GitHub Enterprise Cloud – Enterprise Account**.
7.  In the **GitHub Enterprise Cloud – Enterprise Account**, review the settings and then select **Create**.
8.  Once the account is created, you are redirected to the **GitHub Enterprise Cloud – Enterprise Account** screen.

## Assign users to an app

Assign your administrator account to the recently added app.

1.  On the **GitHub Enterprise Cloud – Enterprise Account** screen, on the **Overview** page, under **Getting Started**, select **1. Assign users and groups**. Alternatively, in the left navigation, under **Manage**, you can select **Users and groups**.
2.  On the **Users and groups** page, on the menu, select **+Add user/group**.
3.  On the **Add Assignment** dialog, select **Users and groups**.
4.  In the **Users and groups** pane, select your administrator account and then **Select**.
    
    :::image type="content" source="../media/add-app-assignment-4da30b72.png" alt-text="Screenshot of add a user account assignment to an app with the Select button highlighted.":::
    
5.  Select **Assign**.
