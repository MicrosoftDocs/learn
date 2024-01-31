In this exercise, we will enable Remote - Tunnels access using the VS Code UI.    


## Using the VS Code UI
### Install the Remote – Tunnels Extension 

1. Start up VS Code
1. Navigate to the extension marketplace in VS Code and install the Remote – Tunnels extension
    1. Click on the Extensions icon in the Activity Bar on the side of the window
    1. Search for Remote – Tunnels
    1. Click Install

:::image type="content" source="../media/12. ExtMarketPlace.png" alt-text="Installing Remote - Tunnels Image":::

1. Restart VS Code if necessary
1. Click on the VS Code Account menu and select the option to Turn on Remote Tunnel Access, as demonstrated in the image below
:::image type="content" source="../media/6. account.png" alt-text="Accounts":::


3. Select "Turn on for this session"
:::image type="content" source="../media/5. turnOnForSession.png" alt-text="Turn on for this session image":::

1. You'll be prompted to log into GitHub
1. Once you're logged in, a tunnel will start up on your current machine, and you'll be able to connect to this machine remotely
1. Click “Copy Browser Link to Clipboard” in the popup
:::image type="content" source="../media/7. linkPopup.png" alt-text="Tunnel Link Popup":::

10. Go to another computer (client) of your choice, and from a browser, paste the link copied to your clipboard from the previous step. 
    1. A "client" is any device that can run a web browser and has access to the internet like a phone, tablet, or another computer.
1. Begin coding!

When you go to <a href="http://vscode.dev" target="_blank">vscode.dev</a>, you'll be presented with a lightweight version of VS Code running fully in the browser. This is VS Code for the web (aka vscode.dev). With no installation required, you can open a folder on your local machine and start coding. Official docs can be found <a href="http://vscode.dev" target="_blank">here for vscode.dev</a>.

*Note: The remote machine will only be reachable through a tunnel while VS Code remains running there. Once you exit VS Code it will no longer be possible to tunnel to it until you start VS Code there again or run the code tunnel CLI command.*