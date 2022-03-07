In this exercise, you'll deploy a static web app for the Altair web terminal.

## Step 1: Create the AltairWebTerminal repo

Create the *AltairWebTerminal* repo from the *AzureSphereAltair8800.terminal* GitHub template.

1. From your web browser, open the [AzureSphereAltair8800.terminal](https://github.com/AzureSphereCloudEnabledAltair8800/AzureSphereAltair8800.terminal?azure-portal=true) repo.

1. Select **Use this template**.
1. Name your repo **AltairWebTerminal**.
1. Select **Private**.
1. Select **Create repo from template**.
1. Leave the copied repo open in the web browser.

## Step 2: Clone the AltairWebTerminal repo

Clone the **AltairWebTerminal** repo from your GitHub account to your computer.

1. Copy the **AltairWebTerminal** repo address by selecting **Code** and then selecting the **Clipboard** icon for the **AltairWebTerminal** repo.

    :::image type="content" source="../media/git-clone-altair-web-terminal.png" alt-text="Screenshot that shows an example of the open AltairWebTerminal repo.":::

1. In a command prompt window, clone the **AltairWebTerminal** repo to your computer by running the following command:

        
    ```bash
    git clone <AltairWebTerminal_Repository_Address>
    ```

    Remember, you can paste the **AltairWebTerminal** repo address from the clipboard.


## Step 3: Open the Altair web terminal project

1. Open Visual Studio Code.
1. Select **File** > **Open folder**.
1. Open the *AltairWebTerminal* folder that you cloned to your computer.

## Step 4: Install the Azure Static Web Apps extension

In Visual Studio Code, install the Azure Static Web Apps extension from either of the following places:
* Go to the [Extension Marketplace](https://code.visualstudio.com/docs/editor/extension-marketplace?azure-portal=true).
* In Visual Studio Code, search for **Azure Static Web Apps** in the Extension Marketplace.

## Step 5: Deploy the Altair web terminal

1. Now that the extension is installed, in Visual Studio Code, select the F1 key.

1. Enter **create static web app**, and select **Azure Static Web Apps: Create Static Web App...(Advanced)**.
1. Select your subscription.
1. If necessary, at the prompt, sign in with your GitHub account.
1. Select **Create a new resource group**.
1. Name the resource group **AltairWebTerminal**.
1. For the name of the static web app, enter **AltairWebTerminal**.
1. For the SKU, select **Free**.
1. Choose the **Custom** build preset.
1. For the location of your application code, enter a slash character (/).
1. For the build output location, leave the value blank.
1. For the location of the new resource, select your preferred location for the static web app.

## Step 6: View the GitHub action

In the Visual Studio Code popup window, select **Open Actions in GitHub**.

The action takes about two minutes to run. When the GitHub action has finished running, the status indicator changes to green.

:::image type="content" source="../media/github-action-view.png" alt-text="Screenshot that shows an example of a completed GitHub action.":::

## Step 7: Create the Altair web terminal settings

1. To clear the GitHub action status, close and reopen Visual Studio Code.
1. Select **File** > **Open folder**.
1. Open the *AltairWebTerminal* folder, which you've already cloned to your computer, and then open the Altair web terminal *api* folder.
1. Rename the *local.settings.sample.json* file to *local.settings.json*.
1. Open the *local.settings.json* file.

   The MQTT broker configuration is prepopulated for the *test.mosquitto.org* public MQTT broker.

1. Configure the Azure IoT Central settings by using the Azure IoT Central API token and URL that you saved earlier.

1. Update the following properties values:

    * **IOT_CENTRAL_API_TOKEN**
    * **IOT_CENTRAL_URL**

When you've finished, the contents of your *local.settings.json* file should look similar to the following:

:::image type="content" source="../media/local-settings-json.png" alt-text="Screenshot that shows an example of your local.settings.json file.":::

## Step 8: Upload the Altair web terminal local settings

1. Still in Visual Studio Code, select the F1 key.

1. Type **static local**, and then select **Azure Static Web Apps: Upload Local Settings**.
1. Select your subscription.
1. For **Static Web App**, enter the name you created, **AltairWebTerminal**.
1. For environment, enter **Production**.

The Altair web terminal setting is uploaded.

## Step 9: Invite users to the Altair web terminal

To keep its security protected, the Altair web terminal requires authenticated users. This means that you'll need to invite users, including yourself, to the static web app for the Altair web terminal.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).
1. On the left pane, select **All resources**.

   :::image type="content" source="../media/azure-portal-all-resources.png" alt-text="Screenshot of the Azure portal 'All resources' command on the left pane.":::

1. In the resource filter box at the top left, type **altairwebterminal**.

   :::image type="content" source="../media/static-web-app-select.png" alt-text="Screenshot of the Azure portal resource filter box and results list, displaying the AltairWebTerminal static web app.":::

1. In the filter results list, under **Name**, select **AltairWebTerminal**.
1. On the left pane, select **Role management**, and then select **Invite**.

   :::image type="content" source="../media/static-web-app-invite.png" alt-text="Screenshot that shows how to copy the invite link.":::

1. On the **Create invitation link** pane, do the following:

   a. For **Authentication provider**, select your provider.  
   b. For **Email address**, enter your email address or user handle.  
   c. For **Role**, enter **users**.  
   d. Select **Generate**.  
   e. Next to **Invite link**, copy the link to use in the next step.

## Step 10: Activate the invitation link

Do either of the following:
* If the invitation link is for you:

   a. Paste the link into your browser address bar.  
   b. Authenticate by using your email address or user handle.  
   c. Grant consent.

* If the invitation link is for someone else, send that person the link to authenticate and grant consent.

## Step 11: Connect the Altair web terminal to your Azure Sphere device

When you're authenticated, connect to the Altair emulator. You first need to obtain the name of your device in Azure IoT Central:

1. In your browser, go to [Azure IoT Central](https://azure.microsoft.com/services/iot-central?azure-portal=true).
1. Select the **Devices** tab, select the **Altair on Azure Sphere** template, and then select your Azure Sphere device.
1. Copy the device name.
1. On the **Web Terminal** tab in the browser, paste the device name, and then select **Connect**.
1. Add the **Altair Web Terminal** page to your browser favorites.

The MQTT broker status message changes to **Connecting**. When the web terminal has connected successfully, the status changes to **Connected**.

:::image type="content" source="../media/web-terminal-connect.png" alt-text="Screenshot that shows that the web terminal has connected successfully to the MQTT broker.":::
