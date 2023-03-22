In the previous unit, you learned how to make the bot available on Microsoft Teams. Now, learn how to wrap the bot into a Teams app by using Developer Portal.

## Use Developer Portal to create a basic app

Developer Portal for Teams makes it easy to start creating or integrating your own Teams apps, whether you develop custom apps for your enterprise or software as a service (SaaS) applications. Developer Portal streamlines the creation of the manifest and package for your app and provides useful tools like the Adaptive Cards editor and a Scene studio. For more information, see [Developer Portal for Teams](/microsoftteams/platform/concepts/build-and-test/teams-developer-portal).

1. Open Microsoft Teams.

1. Select **Apps** in the lower-left corner of the window. All of the published applications display. Keep in mind that Microsoft Teams is an organization-specific platform.

1. To create the health bot app, search for and select **Developer Portal**.

   :::image type="content" source="../media/3-teams-developer-portal-search.png" alt-text="Screenshot that shows search results for Developer Portal.":::

1. Select **Add**.

   :::image type="content" source="../media/3-teams-developer-portal-add.png" alt-text="Screenshot that shows the Add button.":::

1. The **Developer Portal** app opens. Select the **Apps** tab at the top of the page, and then select **New App**.

   :::image type="content" source="../media/3-teams-developer-portal-new-app.png" alt-text="Screenshot that shows the Apps tab and the New app button.":::

1. Enter a short name for the app, such as **ParamedicBot**, and then select **Add**.

1. Enter the following values under **Basic information**:

    - **Full name**: A paramedic bot built on Azure Health Bot platform
    - **Short description**: Simple bot collecting information from the user
    - **Full description**: Simple bot collecting information from the user and storing the data in the SQL database
    - **Version**: 1.0.0
    - **Developer or company name**: Contoso
    - **Website**: `https://github.com/`
    - **App URLs**: `https://github.com/`

    Because this bot is a demo, use `https://github.com/` for all of the URL values.

   :::image type="content" source="../media/3-teams-app-basic-information.png" alt-text="Screenshot that shows the Basic information values.":::

1. You can also provide an Azure Active Directory app ID. To learn how to generate one, see [create an Azure AD application and service principal that can access resources](/azure/active-directory/develop/howto-create-service-principal-portal). This step is optional.

1. Under **Configure**, select **Branding**. Branding is about the appearance of the app, such as the icon.

1. Select **Color icon**. Choose an image. The image dimensions should be 192 x 192 pixels. Because this bot is a health bot, we're using the official Health Bot icon. You can also choose an accent color.

   :::image type="content" source="../media/3-teams-app-branding.png" alt-text="Screenshot that shows the Branding section with the Color Icon button selected.":::

1. Under **Advanced**, select **App content**. Select the **Loading indicator** and **Full-screen mode** checkboxes.

    :::image type="content" source="../media/3-teams-app-advanced.png" alt-text="Screenshot that shows the App content menu and Loading Indicator and Full-screen mode checkboxes selected.":::

1. Under **Configure**, select **App features**, and then select **Bot**.

   :::image type="content" source="../media/3-teams-app-features-bot.png" alt-text="Screenshot that shows the App features section with Bot selected.":::

1. Now set up the bot. Because we already have the bot configured on the Azure Health Bot platform, select **Enter a bot ID**. This ID is the same one you copied for the Teams channel in the previous unit. It's a unique ID that's specific to your bot.

1. Under **Select the scopes in which people can use this command**, select **Personal** and **Team**, and then select **Save**.

   :::image type="content" source="../media/3-teams-app-existing-bot-setup.png" alt-text="Screenshot that shows the Bot ID entered and the scopes selected.":::

1. To preview the bot, select **Preview in Teams**.

1. Under **Publish**, you can review your app package, publish to your organization, or publish to the Teams store. You must have IT admin rights to publish the bot for your organization.

The app is now ready! You've wrapped the bot into a Teams app. It can now be shipped to anyone in the organization.
