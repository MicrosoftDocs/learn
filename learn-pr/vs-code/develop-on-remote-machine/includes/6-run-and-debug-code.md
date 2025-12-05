You've set up your remote machine and successfully connected to it using SSH. Now, it's ready to be loaded with your agency's application files.

## A closer look at the connection between the local and remote machines

With the Remote - SSH extension, Visual Studio Code establishes a connection between your local machine and the remote machine. Your local machine only needs your installation of Visual Studio Code. The remote machine then contains the Visual Studio Code Server, which runs commands and other extensions directly. The source code, running application, and debugger reside solely on the remote machine.

Because the connection is established from your local machine, your development experience mimics that of local development while accessing the resources on the remote machine. This means that you can run, edit, and debug on a remote machine with Visual Studio Code, just like you could if the source code was local.

## Port forwarding

When running a web application on the remote machine, it generally defaults to running on the remote machine's localhost. You can't see anything on your local machine's localhost because the web app is running on the remote machine. To browse the web app on your local machine, you can use a feature called [Port forwarding](https://code.visualstudio.com/docs/remote/ssh#_temporarily-forwarding-a-port). This feature allows you to "forward" the desired remote port to your local machine.

:::image type="content" source="../media/6-port-forwarding.png" alt-text="Screenshot showing the Port forwarding feature in Visual Studio Code.":::

In the next section, you'll set up a Node.js app on the remote machine, run, edit, and debug the code, and browse the web app locally using port forwarding.
