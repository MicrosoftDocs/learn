In this exercise, you'll deploy the Altair Web Terminal Azure Static Web App.

## Create a copy of the AltairWebTerminal repository

Create a copy of the **AltairWebTerminal** repository from the **AzureSphereAltair8800.terminal** GitHub template.

1. From your web browser, open the [AzureSphereAltair8800.terminal](https://github.com/AzureSphereCloudEnabledAltair8800/AzureSphereAltair8800.terminal?azure-portal=true) repo.
1. Select **Use this template**.
1. Name your repository **AltairWebTerminal**.
1. Select **Private**.
1. Select **Create repository from template**.
1. Leave the web browser open on the copied repository.

## Clone the AltairWebTerminal repository

Clone the **AltairWebTerminal** repository from your GitHub account to your computer.

1. Copy the **AltairWebTerminal** repository address to the clipboard.

    1. Select **Code**.
    1. Select the **Clipboard** icon for **AltairWebTerminal** repository.

        :::image type="content" source="../media/git-clone-altair-web-terminal.png" alt-text="Screenshot that shows an example of the open AltairWebTerminal repository.":::

1. Clone the **AltairWebTerminal** repository to your computer.
    1. Open a command prompt.
    1. Clone the **AltairWebTerminal** repository. 
        Remember, you can paste the **AltairWebTerminal** repository address from the clipboard.

        ```bash
        git clone <AltairWebTerminal_Repository_Address>
        ```

## Open the Altair Web Terminal project

1. Start Visual Studio Code.
1. From the Visual Studio Code main menu, select **File**, then **Open folder**.
1. Open the **AltairWebTerminal** folder you cloned to your computer.

## Install the Visual Studio Static Web Apps Extension

Install the Visual Studio Code Static Web Apps Extension from the [Extension Marketplace](https://code.visualstudio.com/docs/editor/extension-marketplace?azure-portal=true), or in Visual Studio Code, search for Static Web Apps in the Extension Marketplace and install it.

## Deploy the Altair Web Terminal

1. Still in Visual Studio Code, press **F1**
1. Type **create static web app**, and select **Azure Static Web Apps: Create Static Web App...(Advanced)**.
1. Select your subscription.
1. You may be prompted to sign in with your GitHub account.
1. Select **Create a new resource group**.
1. Name the resource group **AltairWebTerminal**.
1. Enter the name of the static web app: Enter **AltairWebTerminal**.
1. Select the **Free** sku.
1. Choose **Custom** build preset.
1. Enter the location of your application code. Enter **/**.
1. Enter the build output location. Ensure left **blank**.
1. Select a location for the new resource. Select your preferred location for the Static Web App.

## Browser the GitHub Action

1. Select **Open Actions in GitHub** from the Visual Studio Code popup.
1. Wait until the GitHub action has completed. The action will take approximately 2 minutes to run. When the GitHub Action completes, the status indicator will change to a green tick.

    :::image type="content" source="../media/github-action-view.png" alt-text="Screenshot that shows an example of the GitHub action running.":::

## Create the Altair Web Terminal settings

1. Close Visual Studio Code to clear the GitHub Action status.
1. Start Visual Studio Code.
1. From the Visual Studio Code main menu, select **File**, then **Open folder**.
1. Open the **AltairWebTerminal** folder you cloned to your computer.
1. Navigate to the Altair Web Terminal **api** folder.
1. Rename the **local.settings.sample.json** file to **local.settings.json**.
1. Open the **local.settings.json** file.

The MQTT broker configuration is prepopulated for the **test.mosquitto.org** public MQTT broker.

Configure the IoT Central settings using the IoT Central API Token and URL that you saved to Notepad.

Update the following properties values:

1. **IOT_CENTRAL_API_TOKEN**
1. **IOT_CENTRAL_URL**

When completed, your **local.settings.json** file will look similar to the following.

:::image type="content" source="../media/local-settings-json.png" alt-text="Screenshot that shows an example of your local.settings.json file.":::

## Upload the Altair Web Terminal local settings

1. Still in Visual Studio Code, press **F1**
1. Type **static local**, and select **Azure Static Web Apps: Upload Local Settings...**.
1. Select your subscription.
1. Select the **Static Web App**. Enter the name you created **AltairWebTerminal**.
1. Select environment. Enter **Production**.

The setting will then be uploaded.

## Invite users to the Altair Web Terminal

The Altair Web Terminal is secure and requires authenticated users so you'll need to invite users, including yourself to the Altair Web Terminal Static Web App.

1. From the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **All resources**.

   :::image type="content" source="../media/azure-portal-all-resources.png" alt-text="Screenshot that shows how to select the all resources in the Azure portal.":::

1. Filter resources by name. Type **AltairWebTerminal** in the filter dialog box.
1. Select on the **AltairWebTerminal** Static Web App.

   :::image type="content" source="../media/static-web-app-select.png" alt-text="Screenshot that shows how to select the AltairWebTerminal Static Web App.":::

1. Select **Role management**, followed by **Invite**.
1. Select your **Authentication provider**.
1. Enter your **Email address** or **User handle**.
1. For Role, type **users**.
1. Then Select **Generate**.
1. Finally, copy the Invite link to the clipboard.

## Activate the Invite link

1. If the invite link is for you, then paste the **Invite link** into your browser address bar.
1. Authenticate using your email address or user handle.
1. Grant consent.

1. If the invite link is for someone else, send the link to them to authenticate and grant consent.

   :::image type="content" source="../media/static-web-app-invite.png" alt-text="Screenshot that shows how to copy the invite link.":::

## Connect the Altair Web Terminal to your Azure Sphere

When authenticated, connect to the Altair emulator. You'll need the name of your device in IoT Central.

1. From your web browser, navigate to the IoT Central portal.
1. Open the Devices tab, select the **Altair on Azure Sphere** template, then select your Azure Sphere device.
1. Copy the device name to the clipboard.
1. Navigate to the Web Terminal tab in your web browser.
1. Paste the device name and select **Connect**.
1. Add the Altair Web Terminal page to your web browser favorites.

The MQTT broker status message changes to **Connecting...**, when it has successfully connected, the status will change to **Connected**.

:::image type="content" source="../media/web-terminal-connect.png" alt-text="Screenshot that shows how to connect the web terminal to the MQTT broker.":::
