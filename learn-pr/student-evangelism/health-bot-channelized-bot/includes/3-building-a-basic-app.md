In the previous unit we did go through the steps to channelize the bot to Microsoft Teams using the ID that we obtained from the Health Bot platform. Now lets further see how to wrap up this bot into a Teams App using Microsoft Teams App Studio.

## Creating basic app Microsoft Teams App Studio

App Studio makes it easy to start creating or integrating your own Microsoft Teams apps, whether you develop custom apps for your enterprise or SaaS applications for Teams around the world by streamlining the creation of the manifest and package for your app and providing useful tools like the Card Editor and a React control library. For more information, see [Manage your apps with App Studio for Microsoft Teams](/microsoftteams/platform/concepts/build-and-test/app-studio-overview).

Firstly, open the Microsoft Teams App.

If it's not installed on the PC, [download and install Teams](https://www.microsoft.com/microsoft-teams/group-chat-software).

:::image type="content" source="../media/3-teams-app-studio.png" alt-text="Screenshot of Teams app studio.":::

- Once the app is launched, click the "Apps" on the bottom left corner of the screen. Here all published applications can be seen. Note that Microsoft Teams is Organization specific platform. Now to create health bot app, search for the "App Studio" in the search bar.

   :::image type="content" source="../media/3-app-studio-search.png" alt-text="Screenshot of Teams app search for app studio.":::

- Select the App Studio from the dropdown.

   :::image type="content" source="../media/3-app-studio-add.png" alt-text="Screenshot of Teams app studio add button.":::

- Upon clicking on the App studio, a dialog popup appears on the screen. Click on the "Add" button.

   :::image type="content" source="../media/3-create-new-app.png" alt-text="Screenshot of creating new app button.":::

- This redirects to a new page, On the top there is **Manifest Editor, Validation, Card editor, UI tools ,Chat and About section**. Click on the Manifest Editor and then select **Create a new app**

   :::image type="content" source="../media/3-app-id-generation.png" alt-text="Screenshot of generating new app ID.":::

There are 3 main sections in creating a new app.

- Details
- Capabilities
- Finish

Firstly, in the Details section there is "App Details". This is where all the App data will be filled.

- **Short name:** For this bot Enter "ParamedicBot" in this field. This will be the App name which will be displayed.

- **Full name:** Enter the full name of the app. In this scenario, enter "Paramedic bot built on Azure Health Bot".

The next section here is identification, this is where we enter the app ID. Since we do not have one, click on "Generate" and this will generate a new ID.

- **Package name:** Enter **para.app** in this field for this particular bot.

- **Version:** Enter 1.0.0 since it's the first version.

The next section is **"Descriptions"**.

:::image type="content" source="../media/3-descriptions.png" alt-text="Screenshot of descriptions.":::

There are two fields here, **Short Description** and **Full description**.

- **Short Description:** A very brief description within 80 characters. This will serve as the description of the app when we are viewing it in the overview section. Enter " Simple bot collecting information from the user" for this particular application.

- **Full description:** This has full description of 4000 words or less. Here we can explain in detail about the bot.Here Enter "Simple bot collecting information from the user and storing the data in the SQL Database".

The next section is **Developer Information** section. Here we are supposed to provide the details about the developer and the website of the developer.

**Developer/Company name:** Enter "Contoso".

**Website:** This refers to the website of the developer. Since this is a demo we are giving the web-address of [Github](https://github.com/).

:::image type="content" source="../media/3-branding.png" alt-text="Screenshot of Branding.":::

The next section is the App URLs.

Here again we are intended to provided the Website for referring the privacy statement of the application and Terms of use. Since this is a demo, we are again providing the web-address of [GitHub](https://github.com/).

**Privacy statement:** The web-address of [GitHub](https://github.com/).

**Terms of use:** The web-address of [GitHub](https://github.com/).

The next section here is **Branding**. This section is all about the appearance of the app. For example, the icon.

In the Full Color section click on the update button and select an image. The image should be of **192x192** dimension. Similarly, an accent color also can be chosen. Here since it's a health Bot we are using the official Health Bot icon.

:::image type="content" source="../media/3-bots-section.png" alt-text="Screenshot of Bots section.":::

Finally, tick the Loading Indicator and Fullscreen Mode check boxes.

Now the second main section is **Capabilities**.

This is where the Bot is being integrated to the Teams app platform.

Click on **Bots**.

:::image type="content" source="../media/3-bots-setup.png" alt-text="Screenshot of Bots setup section.":::

Once the bots section is selected, to enable the health bot , we will have to setup the bot. Select **Setup** .

:::image type="content" source="../media/3-existing-bots.png" alt-text="Screenshot of Existing Bots section.":::

Since we have the bot already configured on the Azure Health Bot platform, we will have to choose the **Existing Bot**.

:::image type="content" source="../media/3-existing-bot-setup.png" alt-text="Screenshot of Existing Bots section setup.":::

Upon clicking the Existing Bot section, Select the **Connect to a different bot id**. The Bot ID can be obtained from the Azure health bot platform. This is the same id we used in the previous unit. This is a unique id and varies from user to user.

In the scope section, click on Select **Personal** and **Team**.

:::image type="content" source="../media/3-azure-ad-app-id.png" alt-text="Screenshot of Azure AD app id":::

In the Finish section, we have 4 sub sections:

- Languages
- Domains and Permissions
- App manifesto
- Test and Distribute

In the Domains and Permissions section, we can provide Azure Active Directory App ID. To learn how generate one, see [create an Azure AD application and service principal that can access resources](/azure/active-directory/develop/howto-create-service-principal-portal). This step is optional.

:::image type="content" source="../media/3-test-and-distribute.png" alt-text="Screenshot of test and distribute":::

Finally, Test and Distribute, here we can Install, Download and Publish the app that is built. You will be IT admin rights to install it!  The bot app is ready! We have successfully wrapped up the bot into Teams app and now can be shipped to anyone in the organization.
