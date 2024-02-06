In this exercise, you learn how to:

1. Create and use a tunnel through the [code CLI](https://code.visualstudio.com/docs/editor/command-line). 
1. Install the code CLI on a remote machine you intend to work on. 
1. Establish a tunnel between a VS Code client and your remote machine using the code CLI.

There are two options to obtain the code CLI: either from the VS Code download page or through the command prompt.

## Using the 'code CLI'
### Get the code CLI from the VS Code download page

1. Navigate online to the <a href="https://code.visualstudio.com/#alt-downloads" target="_blank">VS Code download page.</a>
    1. :::image type="content" source="../media/0. download.png" alt-text="Download Page":::

2. Download & extract the code CLI for your operating system into the ‘TestCLI’ directory.
    1. After downloading the file, you have a compressed file.
    :::image type="content" source="../media/13. compressed_code.png" alt-text="Image of compressed file":::
    1. Double-click the file to extract it to the TestCLI directory, and you will see the code file.
    :::image type="content" source="../media/14. uncompressed_code.png" alt-text="image of extracted code file":::


1. From the terminal, navigate to the TestCLI directory.

### Install and unpack the code CLI through the terminal
If you don't have access to a UI or the VS Code download page, you can use the terminal to install the code CLI. Assuming you have already created the TestCLI folder, use the following commands to install the code CLI from within the TestCLI directory in the terminal.

1. From the TestCLI directory in the terminal, run the following command:

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

2. Copy/save the provided link and code as shown below.
    1. :::image type="content" source="../media/23. TunnelLink.png" alt-text="Image of link to login on client with code":::

3. On your client, open the previously saved link in a web browser and enter the code that was provided in the terminal (note: your code will be different) & click continue to activate.
    1. :::image type="content" source="../media/1. signIn.png" alt-text="Device Activation":::
4. Click continue to authenticate.    
    1. :::image type="content" source="../media/27. SignIn-BeforeAuth.png" alt-text="Device Activation":::

4. Then, click the authorize button.
    1. :::image type="content" source="../media/2. auth.png" alt-text="Authentication Page":::

5. You should see a congratulatory message indicating success.
    1. :::image type="content" source="../media/3. congrats.png" alt-text="Confirmation":::


The code CLI outputs a vscode.dev URL specific to this remote machine, such as
```https://vscode.dev/tunnel/<machine_name>/<folder_name>``` 
:::image type="content" source="../media/4. link.png" alt-text="Tunnel link for client image":::

This process authenticates you to the tunneling service, ensuring you have access to the designated remote machines.

6. Open this URL on a client of your choice. 
7. Click "Allow" to give the 'Remote - Tunnels' extension permission to sign in.
    1. :::image type="content" source="../media/25. RemoteAsksPermission.png" alt-text="Remote - Tunnels extension permission to sign in image":::
1. Click "Yes, I trust the authors" to give access to the folder.
    1. :::image type="content" source="../media/26. Trust.png" alt-text="Do you trust the authors image":::

9. Begin coding!
    1. :::image type="content" source="../media/24. CLI_View.png" alt-text="Code tmage":::



