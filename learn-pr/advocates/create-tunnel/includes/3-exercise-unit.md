In this exercise, we will enable remote tunnel access using the VS Code UI.    


## Using the VS Code UI
### Install the Remote – Tunnels Extension 

1. Create a TestUI folder and add an index.html file with some test code.  
1. Start up VS Code 
1. Navigate to the extension marketplace in VS Code and install Remote –Tunnels 
1. Restart VS Code if necessary 
1. Click on the VS Code Account menu, select the option to Turn on Remote Tunnel Access, as demonstrated in the image below.  

:::image type="content" source="../media/6. account.png" alt-text="Account Settings":::

6. Select Turn on for this session 
1. You'll be prompted to log into GitHub.  
1. Once you're logged in, a tunnel will start up on your current machine, and you'll be able to connect to this machine remotely. 
1. Click “Copy Browser Link to Clipboard” in the popup 
:::image type="content" source="../media/7. linkPopup.png" alt-text="Tunnel Link Popup":::

10. Go to the client of you choice and from a browser, paste the vscode.dev link 
1. Answer what type of account you used to start the tunnel 
1. Begin coding! 

When you go to vscode.dev, you'll be presented with a lightweight version of VS Code running fully in the browser. With no installation required, you can open a folder on your local machine and start coding. 

*Note: The remote machine will only be reachable through a tunnel while VS Code remains running there. Once you exit VS Code it will no longer be possible to tunnel to it until you start VS Code there again or run the code tunnel CLI command.*