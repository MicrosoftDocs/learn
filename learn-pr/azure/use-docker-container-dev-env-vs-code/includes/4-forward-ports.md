Now that you have a web app running on your machine through a dev container, let's understand how you can access that app through port forwarding.

## What is port forwarding?

Containers are isolated environments. So if you want to access a server, service, or other resource inside your container, you'll need to forward the port to your local machine (which is known as the host).

## How do we forward ports in containers?

In the last exercise, Visual Studio Code forwarded the port for your container automatically. The notification read, "127.0.0.1:5000 on remote is now forwarded to 127.0.0.1:5000 locally." It means that your web app was running at port 5000 in the dev container and was sent to port 5000 of your host machine.

Although both the remote and local ports matched here (port 5000), that might not always be the case. For example, a remote server listening on port 3000 might be mapped to port 4123 on localhost if 3000 was already in use on localhost. You can then connect to this remote server by using http://localhost:4123. Accessing http://localhost:4123 will feel just like you're accessing a local server, which is the power of port forwarding!

## How do we view or modify forwarded ports?

You can forward a new port for the duration of the session by running the **Forward a Port** command from the Command Palette (<kbd>F1</kbd>).

You can work with your forwarded ports by going to the **Forwarded Ports** section of the Remote Explorer. There, you can view what ports are currently forwarded or add a new port. You can also right-click and modify your port or open it in a browser, as shown in the following screenshot.

:::image type="content" source="../media/forward-port-right-click.png" alt-text="Screenshot of right-click options in the Forwarded Ports section of the Remote Explorer in Visual Studio Code.":::

In the next section, you'll take a closer look at your forwarded ports and make some changes to understand forwarding even better.
