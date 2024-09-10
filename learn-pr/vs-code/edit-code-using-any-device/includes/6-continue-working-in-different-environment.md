At your startup, you value the ability to make quick code edits on-the-go, but you also sometimes need to run the code. With VS Code for the Web, it's easy to move to a more powerful environment through either the "Continue Working On..." command or by bringing your own compute with the [VS Code Remote - Tunnels extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server).

## "Continue Working On..." command

Sometimes, you want to access a different environment that can run code. In VS Code for the Web, you can seamlessly switch to working on a repository in a development environment that has support for a local file system and full language and development tooling.

Use the "Continue Working On..." command to continue working in a different environment. This command gives you the option to reopen the repository in VS Code Desktop so that you can continue your work in the full-featured editor. If you have the [GitHub Codespaces extension](https://marketplace.visualstudio.com/items?itemName=GitHub.codespaces) installed, you can also create a GitHub Codespace for the current repository. A GitHub Codespace provides cloud-based compute so that you can run your code.

## Cloud Changes

When you have uncommitted changes and continue working in a different environment, you can bring your edits to your selected development environment using Cloud Changes. If you haven't enabled Cloud Changes before, then the first time that you run the "Continue Working On..." command, you are prompted to continue working with your changes. Choosing to continue working with your changes enables Cloud Changes. You can also enable or disable this feature through the "Cloud Changes: Turn on/off Cloud Changes" command. Once Cloud Changes is enabled, your changes are automatically reflected in the environment that you choose to continue working in. 

Cloud Changes uses a VS Code service to store your pending changes. These changes are deleted from the service once they're applied to the target development environment. You must be signed into a GitHub or Microsoft account to enable Cloud Changes. 

## Remote - Tunnels

If you want a more powerful environment and to stay in the browser-based experience, you can also use the [VS Code Remote - Tunnels extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server).

:::image type="content" source="../media/6-remote-tunnels-extension.png" alt-text="Screenshot showing the VS Code Remote - Tunnels extension.":::
 
The VS Code Remote - Tunnels extension lets you connect to a remote machine, like a desktop PC or virtual machine (VM), via a secure tunnel. You can then securely connect to that machine from anywhere, without the requirement of SSH. Remote tunnels let you "bring your own compute" to VS Code for the Web, enabling more scenarios like running your code in the browser. 

In the next section, you'll use the "Continue Working On…" command to view your options for moving to a more powerful environment.