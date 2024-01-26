In this exercise, you'll learn how to create and use a tunnel through the [code CLI](https://code.visualstudio.com/docs/editor/command-line). To start using the code CLI, you should know that you need to install the code CLI on a remote machine you want to work against.  
The CLI establishes a tunnel between a VS Code client and your remote machine.

There are 2 options to obtain the CLI. From a download page or from the command prompt.

## Using the 'code' CLI
### Get the CLI from the VS Code download page

1. Create a folder called ‘TestCLI’ and add to it a simple index.html file with code in it.

2. Navigate online to https://code.visualstudio.com/#alt-downloads

:::image type="content" source="../media/0. download.png" alt-text="Download Page":::

3. Download & extract the CLI for your operating system to ‘TestCLI’
4. From the terminal, navigate to the TestCLI directory

### Install and unpack the CLI through the terminal
1. Create a folder called ‘TestCLI’ and add to it a simple index.html file with code in it.  

2. From the terminal, navigate to the TestCLI directory 

3. Run the following command:


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

2. Accept license terms by logging into GitHub and submitting provided code like below (yours will be different):

:::image type="content" source="../media/1. signIn.png"{width=50% height=50%} alt-text="Device Activation":::

Next, click the authorize button.

:::image type="content" source="../media/2. auth.png" alt-text="Download Page":::

You should see a congratualtions message like below:
:::image type="content" source="../media/3. congrats.png" alt-text="Confirmation":::


This CLI will output a vscode.dev URL tied to this remote machine, such as 

```https://vscode.dev/tunnel/<machine_name>/<folder_name>``` 
:::image type="content" source="../media/4. link.png" alt-text="Provided link":::

3. Open this URL on a client of your choosing. 
1. Log into your GitHub

This authenticates you to the tunneling service to ensure you have access to the right set of remote machines. 