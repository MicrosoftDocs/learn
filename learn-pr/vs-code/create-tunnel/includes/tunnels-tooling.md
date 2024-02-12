
## What are tunnels?

:::image type="content" source="../media/16-networks.jpg" alt-text="Photo of network servers.":::

Tunneling is a networking concept that involves creating a secure and direct connection between two separate networks or devices, allowing data to be transmitted privately across different networks or the internet. Let's discuss a scenario where tunneling is useful.

### The problems

There's a development team that is spread across various locations. The team needs to interact with a remote server containing essential resources and applications. Securing efficient access is critically required. The server that is housed within their company's data center contains vital development tools and databases necessary for the team's work. Given the stringent security policies, direct access to this server from external networks is heavily restricted. In such a situation, traditional solutions, such as VPNs, can be cumbersome and can lead to slow connections, which hinder productivity for developers. 

### Use cases for tunnels 

In the previously mentioned scenario, a developer needs to work on an application that depends on services and databases located on the company's internal network. Rather than navigating the complexities of VPNs or exposing sensitive services to the internet, the developer can utilize tunneling to establish a secure and direct connection from their local environment to the remote server. This approach enables seamless access to files, databases, and services as if the developer were physically connected to the remote server. Tunneling facilitates a more efficient workflow by allowing developers to edit code, perform debugging, and execute tasks directly on the remote server, all within their preferred development environment.  

## VS Code Remote - Tunnels extension 
### Why use it? 

The use of tunneling offers a streamlined solution to many challenges. Extensions are now available for development tools such as VS Code. The VS Code [Remote - Tunnels extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server) can effectively eliminate the need for source code to be on your VS Code client machine since the extension runs commands and other extensions directly on the remote machine. This approach is possible because of the [VS Code Server](https://code.visualstudio.com/docs/remote/vscode-server), which is a service that can run on a remote development machine, like your desktop PC or a virtual machine (VM), making it possible to securely connect to that remote machine from anywhere through a local VS Code client, without the requirement of SSH.

:::image type="content" source="../media/8-remote-chart.png" alt-text="Diagram of VS Code and Remote OS chart.":::

### Setting up VS Code Remote - Tunnels extension

There are two methods available for setting up tunnels:

- [VS Code Desktop.](https://code.visualstudio.com/download) Activate tunneling via the VS Code Desktop user interface (UI). VS Code is a code editor redefined and optimized for building and debugging modern web and cloud applications.

- [Code CLI.](https://code.visualstudio.com/docs/editor/command-line) Execute the tunnel command available in the code command-line interface (CLI).  The CLI lets you control how you launch the editor. From the command line, you are using the CLI when performing tasks such as opening files, installing extensions, changing the display language, and outputting diagnostics through command-line options (switches). 

:::image type="content" source="../media/9-cli.png" alt-text="Screenshot of CLI Image.":::

Regardless of the method chosen, the outcome in terms of tunneling functionality is identical, allowing you to select the approach that best suits your needs.  

### VS Code Desktop or code CLI? 

If it's not feasible to install the full VS Code Desktop on your remote machine, the CLI offers a viable alternative. On the other hand, if you're already engaged in tasks within VS Code, employing the VS Code Desktop UI to initiate tunneling for your current machine is a convenient option.

### Preparing for the exercises

In the upcoming exercises, you will be using both the VS Code Desktop and the code CLI to set up tunnels. To prepare for these exercises, you want to have some sample code in a file and folder available on your local machine. Let's dive right in:

1. Create a TestUI folder on your hard drive.  
:::image type="content" source="../media/10-folder-1.png" alt-text="Screenshot of creating Folder.":::
:::image type="content" source="../media/11-folder-2.png" alt-text="Screenshot of created Folder.":::
1. Create a TestCLI folder, repeating the previous step. 
1. Create an index.html file with the following test code. 
```html
<!DOCTYPE html> 
<html> 
<head> 
    <title>Sample Page</title> 
</head> 
<body> 
    <h1>Welcome to My Sample Page</h1> 
    <p>This is a simple HTML page with some sample content.</p> 
</body> 
</html> 
```
4. Copy the file into both the TestUI and TestCLI folders. 

    :::image type="content" source="../media/18-populated-folders.png" alt-text="Screenshot of TestUI and TestCLI Folders with index.html files.":::
