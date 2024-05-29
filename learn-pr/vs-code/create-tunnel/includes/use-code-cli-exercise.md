In this exercise, you learn how to:

- Create and use a tunnel through the [code CLI](https://code.visualstudio.com/docs/editor/command-line).
- Install the code CLI on a remote machine you intend to work on.
- Establish a tunnel between a Visual Studio Code client and your remote machine by using the code CLI.

You can get the code CLI either from the Visual Studio Code download pane or through the command prompt.

## Get the code CLI from the Visual Studio Code download pane

1. Go to the [Visual Studio Code download pane](https://code.visualstudio.com/#alt-downloads).
    
    :::image type="content" source="../media/0-download.png" alt-text="Screenshot of the download pane.":::

1. Download and extract the code CLI for your operating system into the *TestCLI* directory.
    
    1. After you download the file, you see that you have a compressed file.
    
     :::image type="content" source="../media/13-compressed-code.png" alt-text="Screenshot of a compressed file.":::

    1. Double-click the file to extract it to the *TestCLI* directory, and you see the code file.
    
    :::image type="content" source="../media/14-uncompressed-code.png" alt-text="Screenshot of an extracted code file.":::

1. From the terminal, go to the *TestCLI* directory.

## Install and unpack the code CLI through the terminal

If you don't have access to a user interface or the Visual Studio Code download pane, you can use the terminal to install the code CLI. After you create the *TestCLI* folder, use the following commands to install the code CLI from within the *TestCLI* directory in the terminal:

```bash
 curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
```

```bash
tar -xf vscode_cli.tar.gz
```

## Create a secure tunnel

1. Run the following command to download and start the Visual Studio Code Server on this machine and then create a tunnel to it:

    ```bash
    code tunnel --accept-server-license-terms
    ```
    
1. Copy and save the provided link and code.
    
    :::image type="content" source="../media/23-tunnel-link.png" alt-text="Screenshot of link to sign in on client with code.":::

1. On your client, open the previously saved link in a web browser and enter the code that was provided in your terminal. Select **Continue** to activate.
    
    :::image type="content" source="../media/1-sign-in.png" alt-text="Screenshot of the Device Activation pane.":::

1. Select **Continue** to authenticate.
    
    :::image type="content" source="../media/27-sign-in-before-auth.png" alt-text="Screenshot of the Single sign-on pane.":::

1. Select **Authorize**.
    
    :::image type="content" source="../media/2-auth.png" alt-text="Screenshot of the authentication pane.":::

1. You see a congratulatory message that indicates success.
    
    :::image type="content" source="../media/3-congrats.png" alt-text="Screenshot of confirmation.":::

    The code CLI outputs a `vscode.dev` URL specific to this remote machine, such as
    ```https://vscode.dev/tunnel/<machine_name>/<folder_name>```.
    :::image type="content" source="../media/4-link.png" alt-text="Screenshot of a tunnel link for a client.":::
    
    This process authenticates you to the tunneling service and ensures that you have access to the designated remote machines.
    
1. Open the URL on a client of your choice.
1. Select **Allow** to give the Remote - Tunnels extension permission to sign in.
    
    :::image type="content" source="../media/25-remote-asks-permission.png" alt-text="Screenshot of the Remote - Tunnels extension permission to sign in.":::
1. Select **Yes, I trust the authors** to give access to the folder.
    
    :::image type="content" source="../media/26-trust.png" alt-text="Screenshot of the prompt Yes, I trust the authors.":::

1. Begin coding!
    
    :::image type="content" source="../media/24-cli-view.png" alt-text="Screenshot of code.":::
