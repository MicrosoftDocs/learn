
## What are tunnels?

:::image type="content" source="../media/16-networks.jpg" alt-text="Photo of network servers.":::

Tunneling is a networking concept that involves creating a secure and direct connection between two separate networks or devices. Creating a tunnel allows data to be transmitted privately across different networks or the internet. Let's discuss a scenario where tunneling is useful.

## The problems

A development team is spread across various locations. The team needs to interact with a remote server that contains essential resources and applications. Securing efficient access is critically required. The server that's housed within their company's datacenter contains vital development tools and databases necessary for the team's work. Due to the stringent security policies, direct access to this server from external networks is heavily restricted. In such a situation, traditional solutions like virtual private networks (VPNs) can be cumbersome and lead to slow connections, which hinder productivity for developers.

## Use cases for tunnels

In the preceding scenario, a developer needs to work on an application that depends on services and databases located on the company's internal network. Rather than dealing with VPNs or exposing sensitive services to the internet, the developer can use tunneling to establish a secure and direct connection from their local environment to the remote server. This approach enables seamless access to files, databases, and services as if the developer were physically connected to the remote server. Tunneling facilitates a more efficient workflow by allowing developers to edit code, perform debugging, and execute tasks directly on the remote server, all within their preferred development environment.

## Visual Studio Code Remote - Tunnels extension

The use of tunneling offers a streamlined solution to many challenges. Extensions are now available for development tools such as Visual Studio Code. The Visual Studio Code [Remote - Tunnels extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server) can effectively eliminate the need for source code to be on your Visual Studio Code client machine because the extension runs commands and other extensions directly on the remote machine. This approach is possible because of [Visual Studio Code Server](https://code.visualstudio.com/docs/remote/vscode-server). This service can run on a remote development machine, like your desktop PC or a virtual machine (VM). It makes it possible to securely connect to the remote machine from anywhere through a local Visual Studio Code client, without the requirement of the Secure Shell protocol.

:::image type="content" source="../media/8-remote-chart.png" alt-text="Diagram of Visual Studio Code and Remote OS chart.":::

### Set up the Visual Studio Code Remote - Tunnels extension

Two methods are available to set up tunnels:

- [Visual Studio Code Desktop](https://code.visualstudio.com/download): Activate tunneling via the Visual Studio Code Desktop user interface (UI). Visual Studio Code is a code editor redefined and optimized for building and debugging modern web and cloud applications.
- [Code command-line interface (CLI)](https://code.visualstudio.com/docs/editor/command-line): Execute the tunnel command available in the code CLI. The CLI lets you control how you open the editor. From the command line, you use the CLI when you perform tasks such as opening files, installing extensions, changing the display language, and outputting diagnostics through command-line options (switches).

  :::image type="content" source="../media/9-cli.png" alt-text="Screenshot of the code command-line interface.":::

If it's not feasible to install Visual Studio Code Desktop on your remote machine, the CLI offers a viable alternative. On the other hand, if you're already engaged in tasks within Visual Studio Code, using the Visual Studio Code Desktop UI to initiate tunneling for your current machine is a convenient option.

Regardless of the method that you choose, the outcome in terms of tunneling functionality is identical. Select the approach that best suits your needs.

### Prepare for the exercises

In the upcoming exercises, you use both the Visual Studio Code Desktop and the code CLI to set up tunnels. To prepare for these exercises, you should have some sample code in a file and folder available on your local machine. Let's dive right in.

1. Create a *TestUI* folder on your hard drive.

    :::image type="content" source="../media/10-folder-1.png" alt-text="Screenshot of creating a folder.":::

    :::image type="content" source="../media/11-folder-2.png" alt-text="Screenshot of the created folder.":::
1. Create a *TestCLI* folder, repeating the previous step.
1. Create an *index.html* file with the following test code:

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

1. Copy the file into both the *TestUI* and *TestCLI* folders.

    :::image type="content" source="../media/18-populated-folders.png" alt-text="Screenshot of the TestUI and TestCLI folders with index.html files.":::
