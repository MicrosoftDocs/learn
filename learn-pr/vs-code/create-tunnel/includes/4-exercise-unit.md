In this exercise, you learn how to:

1. Create and use a tunnel through the [code CLI](https://code.visualstudio.com/docs/editor/command-line). 
1. Install the code CLI on a remote machine you want to work against.  
1. Have the code CLI establishes a tunnel between a VS Code client and your remote machine.

There are two options to obtain the CLI code: either from the VS Code download page or through the command prompt

## Using the 'code' CLI
### Get the code CLI from the VS Code download page

1. Navigate online to the VS Code Download page: https://code.visualstudio.com/#alt-downloads

:::image type="content" source="../media/0. download.png" alt-text="Download Page":::

2. Download & extract the code CLI for your operating system to ‘TestCLI’
    1. After downloading the file, you have a compressed file like such:
    :::image type="content" source="../media/13. compressed_code.png" alt-text="Image of compressed file":::
    1. Double-click the file to extract it to the TestCLI directory and you see the code file.
    :::image type="content" source="../media/14. uncompressed_code.png" alt-text="image of extracted code file":::


1. From the terminal, navigate to the TestCLI directory

### Install and unpack the code CLI through the terminal
Not all computers have a UI and if so and you can't access the VS Code download page, you can use the terminal to install the code CLI.
Assuming you created the folder TestCLI in the previously, you can use the following commands to install the code CLI.

1. From the TestCLI directory in the terminal, run the following command:

```bash
 curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
```

```bash
tar -xf vscode_cli.tar.gz
```

### Create a secure tunnel
1. Run the following command: 
```bash
code tunnel
```
This above command downloads and starts the VS Code Server on this machine and then creates a tunnel to it. 

2. Accept the license terms by logging into GitHub and submitting the provided code like below (yours is different):

:::image type="content" source="../media/1. signIn.png" alt-text="Device Activation":::

Next, click the authorize button.

:::image type="content" source="../media/2. auth.png" alt-text="Authentication Page":::

You should see a congratulations message like below:
:::image type="content" source="../media/3. congrats.png" alt-text="Confirmation":::


This code CLI outputs a vscode.dev URL tied to this remote machine, such as

```https://vscode.dev/tunnel/<machine_name>/<folder_name>``` 
:::image type="content" source="../media/4. link.png" alt-text="Provided link":::

3. Open this URL on a client of your choosing. 
1. Log into your GitHub

This process authenticates you to the tunneling service to ensure you have access to the right set of remote machines. 