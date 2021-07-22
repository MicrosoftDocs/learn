In the previous unit, you learned how to make the bot available on Microsoft Teams. Now you'll learn how to wrap the bot into a Teams app by using App Studio.

## Create a basic app by using App Studio

App Studio for Teams makes it easy to start creating or integrating your own Teams apps, whether you develop custom apps for your enterprise or SaaS applications for use around the world. App Studio streamlines the creation of the manifest and package for your app and provides useful tools like the Card Editor and a React control library. For more information, see [Manage your apps with App Studio for Microsoft Teams](/microsoftteams/platform/concepts/build-and-test/app-studio-overview).

1. Open Microsoft Teams.

   > [!NOTE]
   > If you don't have Teams, [download and install it](https://www.microsoft.com/microsoft-teams/group-chat-software).

1. Select **Apps** in the lower-left corner of the window. You'll see all the published applications. (Keep in mind that Microsoft Teams is an organization-specific platform.) 

   :::image type="content" source="../media/3-teams-app-studio.png" alt-text="Screenshot that shows published apps in Teams." lightbox="../media/3-teams-app-studio.png":::

1. To create the health bot app, search for **App Studio** in the search box. Select **App Studio** in the search results:

   :::image type="content" source="../media/3-app-studio-search.png" alt-text="Screenshot that shows search results for App Studio." lightbox="../media/3-app-studio-search.png":::

1. Select **Add** in the resulting window:

   :::image type="content" source="../media/3-app-studio-add.png" alt-text="Screenshot that shows the Add button." lightbox="../media/3-app-studio-add.png":::

1. A new page will open. At the top of the page, select **Manifest editor**. Then select **Create a new app**:

   :::image type="content" source="../media/3-create-new-app.png" alt-text="Screenshot that shows the Create a new app button." lightbox="../media/3-create-new-app.png":::

   There are three main steps to creating a new app:

   - Details
   - Capabilities
   - Finish

1. In the **Details** section, select **App details**. Enter these values:

   - **Short name:** For this bot, enter **ParamedicBot**. The short name is the displayed app name.

   - **Full name:** Enter the full name of the app. In this scenario, enter **A Paramedic bot built on Azure Health Bot platform**.

1. Under **Identification**, you enter the app ID. Because you don't have an ID, select **Generate** to generate a new ID.

1. In the **Package Name** box, enter **Para.app**.

1. In the **Version** box, enter **1.0.0** because you're creating the first version:

     :::image type="content" source="../media/3-app-id-generation.png" alt-text="Screenshot that shows App details values." lightbox="../media/3-app-id-generation.png":::

   There are two fields under **Descriptions**: **Short description** and **Full description**.

1. In the **Short description** box, enter a description of 80 characters or less. This description appears in the overview section. Enter **Simple bot collecting information from the user**.

1. In the  **Full description** box, enter a description of 4,000 words or less. You can include more detail here. Enter **Simple bot collecting information from the user and storing the data in the SQL database**.

   Under **Developer information**, we'll provide the details about you and your website.

1. In the **Developer/Company Name** box, enter **Contoso**.

1. The **Website** box is where you'll normally enter your website. Because this bot is a demo,  enter `https://github.com/`:

   :::image type="content" source="../media/3-descriptions.png" alt-text="Screenshot that shows the developer information values."  lightbox="../media/3-descriptions.png" :::

   Under **App URLs**, you'll normally provide the website for the application's privacy statement and terms of use. Because this bot is a demo, use **https://github.com/** for both of these values.

   **Branding** is about the appearance of the app. For example, the icon.

1. Under **Full color**, select **Update**. Choose an image. The image dimensions should be 192 x 192. Because this bot is a health bot, we'll use the official Health Bot icon. You can also choose an accent color.

   :::image type="content" source="../media/3-branding.png" alt-text="Screenshot that shows the branding values." lightbox="../media/3-branding.png":::

1. Finally, select the **Loading indicator** and **Fullscreen Mode** checkboxes.

   The second main section is the **Capabilities** section. In this section, the bot is integrated to the Teams app platform.

1. Under **Capabilities**, select **Bots**:

   :::image type="content" source="../media/3-bots-section.png" alt-text="Screenshot that shows the Bots selection in the left pane." lightbox="../media/3-bots-section.png":::

1. Select **Set up**:

   :::image type="content" source="../media/3-bots-setup.png" alt-text="Screenshot that shows the Set up button." lightbox="../media/3-bots-setup.png":::

1. Now you'll set up the bot. Because we already have the bot configured on the Azure Health Bot platform, select **Existing bot**:

   :::image type="content" source="../media/3-existing-bots.png" alt-text="Screenshot that shows the Existing bot tab."  lightbox="../media/3-existing-bots.png":::

1. Select **Connect to a different bot id**. You can get the bot ID from the Azure Health Bot service. This ID is the same one you used in the previous unit. It's a unique ID that's specific to your bot.

1. Under **Scope**, select **Personal** and **Team**:

   :::image type="content" source="../media/3-existing-bot-setup.png" alt-text="Screenshot that shows the Existing bot setup values."  lightbox="../media/3-existing-bot-setup.png":::

   There are four subsections in the **Finish** section:

   - Languages
   - Domains and permissions
   - App manifesto
   - Test and distribute

1. Under **Domains and permissions**, you can provide an Azure Active Directory app ID. To learn how to generate one, see [create an Azure AD application and service principal that can access resources](/azure/active-directory/develop/howto-create-service-principal-portal). This step is optional.

   :::image type="content" source="../media/3-azure-ad-app-id.png" alt-text="Screenshot that shows where to add an Azure AD app ID."  lightbox="../media/3-azure-ad-app-id.png":::

1. Under **Test and Distribute**, you can install, download, and publish the app: 

   :::image type="content" source="../media/3-test-and-distribute.png" alt-text="Screenshot that shows the Install, Download, and Publish buttons."  lightbox="../media/3-test-and-distribute.png":::

You have IT admin rights to install the bot. 

The app is now ready! You've wrapped the bot into a Teams app. It can now be shipped to anyone in the organization.
