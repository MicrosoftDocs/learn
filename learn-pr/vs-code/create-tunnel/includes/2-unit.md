
## What are tunnels?
Tunnels are a networking concept that involve creating a secure and direct connection between two separate networks or devices, allowing data to be transmitted privately across different networks or the internet. There are several issues that led to the need for this technology but let's discuss a scenario and why tunnels are useful for that case.

### The problems

In a scenario where a software development team is distributed across various locations and needs to interact with a remote server containing essential resources and applications, secure and efficient access becomes a critical requirement. The server, housed within the company's data center, contains vital development tools and databases necessary for the team's work. However, due to stringent security policies, direct access to this server from external networks is heavily restricted. Traditional solutions, such as VPNs, are often cumbersome, leading to slow connections and hindering productivity. Furthermore, these solutions can be complex and resource-intensive to set up and maintain, posing additional challenges for developers. 

### Use cases for tunnels 

In the scenario mentioned earlier, a developer needs to work on an application that depends on services and databases located on the company's internal network. Rather than navigating the complexities of VPNs or exposing sensitive services to the internet, the developer can utilize Tunnels to establish a secure and direct connection from their local environment to the remote server. This approach enables seamless access to files, databases, and services as if the developer were physically connected to the remote server. Tunnels facilitate a more efficient workflow by allowing developers to edit code, perform debugging, and execute tasks directly on the remote server, all within their preferred development environment.  

## VS Code Remote-Tunnels extension 
### Why use it? 

The use of Tunnels offers a streamlined solution to many challenges so it should be no surpise tools and extensions have become availble for dev tool like VS Code. The VS Code Remote-Tunnels extension can eliminate the need for source code to be on your VS Code client machine since the extension runs commands and other extensions directly on the remote machine. This is possible because of the <a href="https://code.visualstudio.com/docs/remote/vscode-server" target="_blank">VS Code Server</a> which is a service that can run on a remote development machine, like your desktop PC or a virtual machine (VM). It allows you to securely connect to that remote machine from anywhere through a local VS Code client, without the requirement of SSH.

### Scenario – working from home 

For example, if you set up your dev environment on your laptop at home and enable tunneling; you can access your source code via an iPad (any device) from a different location to continue your development. 

:::image type="content" source="../media/8. remoteChart.png" alt-text="VS Code and Remote OS Chart":::

VS Code can provide a local-quality development experience - including full IntelliSense (completions), code navigation, and debugging - regardless of where your code is hosted.  

 

### Setting up tunnels 

There are two methods available for setting up tunnels: 

VS Code Desktop. Activate tunneling via the VS Code Desktop user interface (UI).  

Code CLI. Execute the tunnel command available in the code command-line interface (CLI).  

Regardless of the method chosen, the outcome in terms of tunneling functionality is identical, allowing you to select the approach that best suits your needs.  

### VS Code or CLI? 

If installing the complete VS Code Desktop on your remote machine isn't feasible, the CLI offers a viable alternative. On the other hand, if you're already engaged in tasks within VS Code, employing the VS Code Desktop UI to initiate tunneling for your current machine is a convenient option. 