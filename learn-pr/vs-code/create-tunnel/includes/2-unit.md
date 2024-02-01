
## What are tunnels?

:::image type="content" source="../media/16. Networks.jpg" alt-text="Network Server Image":::

Tunnels are a networking concept that involves creating a secure and direct connection between two separate networks or devices, allowing data to be transmitted privately across different networks or the internet. There are several issues that led to the need for this technology but let's discuss a scenario and why tunnels are useful for that case.

### The problems

There's a development team that is spread across various locations. The team needs to interact with a remote server containing essential resources and applications. Having secure and efficient access is a critical requirement. The server, housed within their company's data center, contains vital development tools and databases necessary for the team's work. Due to stringent security policies, direct access to this server from external networks is heavily restricted. In such a situation, traditional solutions, such as VPNs, can be cumbersome, leading to slow connections and hindering productivity for developers. 

### Use cases for tunnels 

In the scenario mentioned earlier, a developer needs to work on an application that depends on services and databases located on the company's internal network. Rather than navigating the complexities of VPNs or exposing sensitive services to the internet, the developer can utilize Tunnels to establish a secure and direct connection from their local environment to the remote server. This approach enables seamless access to files, databases, and services as if the developer were physically connected to the remote server. Tunnels facilitate a more efficient workflow by allowing developers to edit code, perform debugging, and execute tasks directly on the remote server, all within their preferred development environment.  

## VS Code Remote - Tunnels extension 
### Why use it? 

The use of Tunnels offers a streamlined solution to many challenges.  Extensions are now available for dev tool like VS Code. The VS Code Remote - Tunnels extension can eliminate the need for source code to be on your VS Code client machine since the extension runs commands and other extensions directly on the remote machine. This approach is possible because of the <a href="https://code.visualstudio.com/docs/remote/vscode-server" target="_blank">VS Code Server</a>, which is a service that can run on a remote development machine, like your desktop PC or a virtual machine (VM). It allows you to securely connect to that remote machine from anywhere through a local VS Code client, without the requirement of SSH.

:::image type="content" source="../media/8. remoteChart.png" alt-text="VS Code & Remote OS Image":::

### Setting up VS Code Remote - Tunnels extension 

There are two methods available for setting up tunnels: 

VS Code Desktop. Activate tunneling via the VS Code Desktop user interface (UI).  

code CLI. <a href="https://code.visualstudio.com/docs/editor/command-line" target="_blank">Command Line Interface</a> Execute the tunnel command available in the code <a href="https://code.visualstudio.com/docs/editor/command-line" target="_blank">command-line interface (CLI)</a> .  The CLI lets you control how you launch the editor. From the command line, you are using the CLI when performing tasks such as opening files, installing extensions, changing the display language, and outputing diagnostics through command-line options (switches). 

:::image type="content" source="../media/9. CLI.png" alt-text="CLI Image":::

Regardless of the method chosen, the outcome in terms of tunneling functionality is identical, allowing you to select the approach that best suits your needs.  

### VS Code Desktop or code CLI? 

If installing the complete VS Code Desktop on your remote machine isn't feasible, the CLI offers a viable alternative. On the other hand, if you're already engaged in tasks within VS Code, employing the VS Code Desktop UI to initiate tunneling for your current machine is a convenient option.

### Preparing for Exercises

In the upcoming exercises, you are using both the VS Code Desktop and the code CLI to set up tunnels. To prepare for these exercises, you want to have some sample code in a file and folder available on your local machine. Let's dive right in.:

1. On your hard drive, create a TestUI folder  
:::image type="content" source="../media/10. Folder 1.png" alt-text="Creating Folder Image":::
:::image type="content" source="../media/11. Folder 2.png" alt-text="Created Folder Image":::
1. Repeat step 1 and create a TestCLI folder  
1. Create an index.html file with the following test code 
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
4. Copy the file to both TestUI & TestCLI folder. 