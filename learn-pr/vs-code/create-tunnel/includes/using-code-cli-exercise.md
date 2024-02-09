In this exercise, you learn how to:

1. Create and use a tunnel through the [code CLI](https://code.visualstudio.com/docs/editor/command-line). 
1. Install the code CLI on a remote machine you intend to work on.
1. Establish a tunnel between a Visual Studio Code (VS Code) client and your remote machine using the code CLI.

There are two options to obtain the code CLI: either from the VS Code download page or through the command prompt.

## Using the 'code CLI'
### Get the code CLI from the VS Code download page

1. Navigate online to the <a href="https://code.visualstudio.com/#alt-downloads" target="_blank">VS Code download page.</a>
    
    :::image type="content" source="../media/0-download.png" alt-text="Screenshot of download Page.":::

2. Download & extract the code CLI for your operating system into the ‘TestCLI’ directory
    
    a. After downloading the file, you have a compressed file.
    
     :::image type="content" source="../media/13-compressed-code.png" alt-text="Screenshot of compressed file.":::

    b. Double-click the file to extract it to the TestCLI directory, and you see the code file.
    
    :::image type="content" source="../media/14-uncompressed-code.png" alt-text="Screenshot of extracted code file.":::


1. From the terminal, navigate to the TestCLI directory.

### Install and unpack the code CLI through the terminal
If you don't have access to a UI or the VS Code download page, you can use the terminal to install the code CLI. Assuming you created the TestCLI folder, use the following commands to install the code CLI from within the TestCLI directory in the terminal.

From the TestCLI directory in the terminal, run the following command:

```bash
 curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
```

```bash
tar -xf vscode_cli.tar.gz
```

### Create a secure tunnel
1. Run the following command to download and start the VS Code Server on this machine and then create a tunnel to it. 
```bash
code tunnel --accept-server-license-terms
```

2. Copy/save the provided link and code.
    
    :::image type="content" source="../media/23-tunnel-link.png" alt-text="Screenshot of link to log in on client with code.":::

3. On your client, open the previously saved link in a web browser and enter the code that was provided in the terminal (note: your code is different) & click continue to activate.
    
    :::image type="content" source="../media/1-sign-in.png" alt-text="Screenshot of device activation page.":::

4. Click continue to authenticate.
    
    :::image type="content" source="../media/27-sign-in-before-auth.png" alt-text="Screenshot of single sign-on page.":::

5. Then, click the authorize button.
    
    :::image type="content" source="../media/2-auth.png" alt-text="Screenshot of authentication page.":::

6. You should see a congratulatory message indicating success.
    
    :::image type="content" source="../media/3-congrats.png" alt-text="Screenshot of confirmation.":::


The code CLI outputs a vscode.dev URL specific to this remote machine, such as
```https://vscode.dev/tunnel/<machine_name>/<folder_name>``` 
:::image type="content" source="../media/4-link.png" alt-text="Screenshot of tunnel link for client.":::

This process authenticates you to the tunneling service, ensuring you have access to the designated remote machines.

7. Open this URL on a client of your choice. 
8. Click "Allow" to give the 'Remote - Tunnels' extension permission to sign in.
    
    :::image type="content" source="../media/25-remote-asks-permission.png" alt-text="Screenshot of Remote - Tunnels extension permission to sign in.":::
9. Click "Yes, I trust the author's" to give access to the folder.
    
    :::image type="content" source="../media/26-trust.png" alt-text="Screenshot of do you trust the author's prompt.":::

10. Begin coding!
    
    :::image type="content" source="../media/24-cli-view.png" alt-text="Screenshot of code.":::