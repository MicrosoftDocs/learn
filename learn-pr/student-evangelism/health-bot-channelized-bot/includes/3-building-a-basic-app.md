In the previous unit, you learned how to make the bot available on Microsoft Teams. Now you'll learn how to wrap the bot into a Teams app by using App Studio.

## Create a basic app by using App Studio

App Studio for Teams makes it easy to start creating or integrating your own Teams apps, whether you develop custom apps for your enterprise or SaaS applications for use around the world. App Studio streamlines the creation of the manifest and package for your app and provides useful tools like the Card Editor and a React control library. For more information, see [Manage your apps with App Studio for Microsoft Teams](/microsoftteams/platform/concepts/build-and-test/app-studio-overview).

1. Open Microsoft Teams.

   > [!NOTE] 
   > If you don't have Teams, [download and install it](https://www.microsoft.com/microsoft-teams/group-chat-software).


1. Select **Apps** in the lower-left corner of the window. You'll see all the published applications. (Keep in mind that Microsoft Teams is an organization-specific platform.) 

   :::image type="content" source="../media/3-teams-app-studio.png" alt-text="Screenshot that shows published apps in Teams.":::
1. To create the health bot app, search for **App Studio** in the search box. Select **App Studio** in the search results:
   :::image type="content" source="../media/3-app-studio-search.png" alt-text="Screenshot that shows search results for App Studio.":::

1. Select **Add** in the resulting window:
   :::image type="content" source="../media/3-app-studio-add.png" alt-text="Screenshot that shows the Add button.":::


1. A new page will open. At the top of the page, select **Manifest editor**. Then select **Create a new app**:
   :::image type="content" source="../media/3-create-new-app.png" alt-text="Screenshot that shows the Create a new app button.":::

   There are three main steps to creating a new app:

   - Details
   - Capabilities
   - Finish

1. In the **Details** section, select **App details**. You enter all the App data here.

   :::image type="content" source="../media/3-app-id-generation.png" alt-text="Screenshot of generating new app ID.":::

- **Short name:** For this bot Enter "ParamedicBot" in this field. The short name is the displayed App name.

- **Full name:** Enter the full name of the app. In this scenario, enter "Paramedic bot built on Azure Health Bot".

The next section here is identification which where you enter the app ID. Because you don't have an ID, select **Generate** to generate a new ID.

- **Package name:** Enter **para.app** in this field for this particular bot.

- **Version:** Enter 1.0.0 since it's the first version.

The next section is **"Descriptions"**.

:::image type="content" source="../media/3-descriptions.png" alt-text="Screenshot of descriptions.":::

There are two fields here, **Short Description** and **Full description**.

- **Short Description:** A brief description within 80 characters. This field serves as the description of the app when we are viewing it in the overview section. Enter "Simple bot collecting information from the user" for this particular application.

- **Full description:** This field is the full description of 4000 words or less. Here we can explain in detail about the bot. Enter "Simple bot collecting information from the user and storing the data in the SQL Database".

The next section is **Developer Information** section. Here we are supposed to provide the details about the developer and the website of the developer.

**Developer/Company name:** Enter "Contoso".

**Website:** This field refers to the website of the developer. Since this bot is a demo, provide the web-address of [GitHub](https://github.com/).

:::image type="content" source="../media/3-branding.png" alt-text="Screenshot of Branding.":::

The next section is the App URLs.

Here again you should provide the Website for referring the privacy statement of the application and Terms of use. Since this bot is a demo, we are again providing the web-address of [GitHub](https://github.com/).

**Privacy statement:** The web-address of [GitHub](https://github.com/).

**Terms of use:** The web-address of [GitHub](https://github.com/).

The next section here is **Branding**. This section is all about the appearance of the app. For example, the icon.

In the Full Color section, select the update button and choose an image. The image should be of **192x192** dimension. Similarly, an accent color also can be chosen. Here since it's a health Bot we are using the official Health Bot icon.

:::image type="content" source="../media/3-bots-section.png" alt-text="Screenshot of Bots section.":::

Finally, tick the Loading Indicator and Fullscreen Mode check boxes.

Now the second main section is **Capabilities**.

Here is where the Bot is being integrated to the Teams app platform.

Select **Bots**.

:::image type="content" source="../media/3-bots-setup.png" alt-text="Screenshot of Bots setup section.":::

Once the bots section is selected, you'll have to set up the bot. Select **Setup** .

:::image type="content" source="../media/3-existing-bots.png" alt-text="Screenshot of Existing Bots section.":::

Since we have the bot already configured on the Azure Health Bot platform, we will have to choose the **Existing Bot**.

:::image type="content" source="../media/3-existing-bot-setup.png" alt-text="Screenshot of Existing Bots section setup.":::

Upon clicking the Existing Bot section, select the **Connect to a different bot id**. The Bot ID can be obtained from the Azure health bot platform. This is the same ID we used in the previous unit. It's a unique ID and varies from user to user.

In the scope section, select **Personal** and **Team**.

:::image type="content" source="../media/3-azure-ad-app-id.png" alt-text="Screenshot of Azure AD app ID":::

In the Finish section, we have four sub sections:

- Languages
- Domains and Permissions
- App manifesto
- Test and Distribute

In the Domains and Permissions section, we can provide Azure Active Directory App ID. To learn how generate one, see [create an Azure AD application and service principal that can access resources](/azure/active-directory/develop/howto-create-service-principal-portal). This step is optional.

:::image type="content" source="../media/3-test-and-distribute.png" alt-text="Screenshot of test and distribute":::

Finally, Test and Distribute, here we can install, download, and publish the app that is built. You will be IT admin rights to install it!  The bot app is ready! We have successfully wrapped up the bot into Teams app and now can be shipped to anyone in the organization.
