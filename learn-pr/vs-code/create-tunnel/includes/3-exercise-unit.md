In this exercise, we enable Remote - Tunnels access using the VS Code UI.  


## Using the VS Code UI
### Install the Remote – Tunnels extension 

1. Start up VS Code and open the TestUI folder.
:::image type="content" source="../media/20. OpenFolder.png" alt-text="VS Code TestUI folder image":::

1. Navigate to the extension marketplace in VS Code and install the Remote – Tunnels extension:
    1. Click on the Extensions icon in the Activity Bar on the side of the window.
    1. Search for Remote – Tunnels.
    1. Click Install.

:::image type="content" source="../media/12. ExtMarketPlace.png" alt-text="Installing Remote - Tunnels Image":::

3. Restart VS Code if prompted to.
4. Click on the VS Code Account image, and select the option to "Turn on Remote Tunnel Access..." as demonstrated in the image below.

:::image type="content" source="../media/6. account.png" alt-text="Accounts":::

5. Select "Turn on for this session".

:::image type="content" source="../media/5. turnOnForSession.png" alt-text="Turn on for this session image":::

6. You are prompted to log in.

:::image type="content" source="../media/19 SignInGH.png" alt-text="Prompt to sign in image":::

1. Once you're logged in, a tunnel starts up on your current machine, allowing remote connection to this machine.
1. Click “Copy Browser Link to Clipboard” in the popup for the Tunnel Link and save it.
    1. You can email the link to yourself or save it in a secure online document for later use.

:::image type="content" source="../media/7. linkPopup.png" alt-text="Tunnel Link Popup":::

9. Go to another computer (client) of your choice, retrieve the link and from a browser, paste the tunnel link from the previous step.
    1. A "client" is any device that can run a web browser and has internet access, such as a phone, tablet, or another computer.
10. Begin coding!

When you visit <a href="http://vscode.dev" target="_blank">vscode.dev</a>, you access a lightweight version of VS Code running fully in the browser, known as VS Code for the web (or vscode.dev). This allows you to open a folder on your local machine and start coding without any installation. Official docs can be found <a href="http://vscode.dev" target="_blank">here for vscode.dev</a>.

*Note: The remote machine is only reachable through a tunnel while VS Code is running there. Once you exit VS Code, tunneling to it will not be possible until you start VS Code there again or run the code tunnel CLI command.*