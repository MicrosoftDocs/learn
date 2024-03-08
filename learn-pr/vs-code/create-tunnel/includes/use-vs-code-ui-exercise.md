In this exercise, you enable Remote - Tunnels access by using the Visual Studio Code UI.

## Install the Remote – Tunnels extension

1. Start Visual Studio Code and open the *TestUI* folder.

    :::image type="content" source="../media/20-open-folder.png" alt-text="Screenshot of the Visual Studio Code TestUI folder.":::

1. Go to **Extensions: Marketplace** in Visual Studio Code and install the Remote – Tunnels extension:
    1. Select the **Extensions** icon on the **Activity Bar** on the side of the window.
    1. Search for **Remote - Tunnels**.
    1. Select **Install**.

    :::image type="content" source="../media/12-extension-market.png" alt-text="Screenshot of Remote - Tunnels search in Extensions: Marketplace.":::

1. Restart Visual Studio Code if you're prompted to do so.
1. Select the Visual Studio Code account image and select **Turn on Remote Tunnel Access**.
    
    :::image type="content" source="../media/6-account.png" alt-text="Screenshot of Turn on Remote Tunnel Access.":::

1. Select **Turn on for this session**.
    
    :::image type="content" source="../media/5-turn-on-for-session.png" alt-text="Screenshot of the prompt Turn on for this session.":::

1. You're prompted to sign in.
    
    :::image type="content" source="../media/19-sign-in.png" alt-text="Screenshot of the prompt to sign in.":::

1. After you sign in, a tunnel starts on your current machine, which allows remote connection to this machine.

1. Select **Copy Browser Link to Clipboard** in the pop-up for the tunnel link and save it.

    You can email the link to yourself or save it in a secure online document for later use.
    
    :::image type="content" source="../media/7-link-popup.png" alt-text="Screenshot of tunnel link.":::

1. Go to another computer (client) of your choice and retrieve the link. From a browser, paste the tunnel link from the previous step.

    A *client* is any device that can run a web browser and has internet access, such as a phone, a tablet, or another computer.
    
1. Confirm the account that you used to start the tunnel and begin coding!
    
    :::image type="content" source="../media/21-last-logged-in.png" alt-text="Screenshot of prompt asking to select account used to start tunnel.":::
    
    :::image type="content" source="../media/22-client-view-ui.png" alt-text="Screenshot of the client view.":::

When you go to <a href="http://vscode.dev" target="_blank">vscode.dev</a>, you access a lightweight version of Visual Studio Code running fully in the browser. This version is known as Visual Studio Code for the Web (or `vscode.dev`). This step allows you to open a folder on your local machine and start coding without any installation.

> [!NOTE]
> The remote machine is only reachable through a tunnel while Visual Studio Code is running there. After you exit Visual Studio Code, tunneling to it won't be possible until you start Visual Studio Code there again or run the code tunnel CLI command.
