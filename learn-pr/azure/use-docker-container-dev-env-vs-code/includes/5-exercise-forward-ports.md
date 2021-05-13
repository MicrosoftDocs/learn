Port forwarding allows you to access a resource inside your container by forwarding the port to your local machine. When you're working on a project that requires port forwarding, you might want to modify the port that's forwarded. Or you might want a configuration different than the default. In this exercise, you'll explore and make some changes to your current port forwarding setup.

## Open the Remote Explorer

1. Press <kbd>F1</kbd> to open the Command Palette.
1. Type **remote explorer** and select **View: Show Remote Explorer**.
1. Ensure that you have **Containers** selected from the drop-down menu.
1. Observe that port 5000 is forwarded.

:::image type="content" source="../media/remote-explorer-containers.png" alt-text="Screenshot of the Remote Explorer with containers view in Visual Studio Code.":::

## Open the forwarded port

1. Select the globe icon next to **5000 -> 127.0.0.1:5000** to open your app in a browser. 
1. Notice that your app opens at http://127.0.0.1:5000/.

## Stop forwarding a port

1. Stop forwarding port 5000 by right-clicking and then selecting **Stop Forwarding Port**, or by selecting **X** next to the globe.
1. Notice that the container is still using port 5000, but the port is no longer being forwarded.
1. Try going to http://127.0.0.1:5000/. The page won't load because the container's port 5000 is no longer being properly forwarded.

:::image type="content" source="../media/port-5000-not-forwarded.png" alt-text="Screenshot that shows port 5000 not forwarded in the Forwarded Ports section of the Remote Explorer in Visual Studio Code.":::

## Forward to a new port

In case you no longer want to use localhost port 5000, let's forward to a new port.

1. Select **+** next to port 5000. (Or right-click and then select **Forward Port**.)
1. Notice that it automatically maps to port 5000. If you want to map to a different port, right-click, select **Change Local Port**, and enter a new port number. For example, enter **5001**.
1. Go to http://127.0.0.1:5001/ and notice that your web app loads.

## Stop the web app

1. Stop your web app from running by using <kbd>Ctrl</kbd> + <kbd>c</kbd> in the integrated terminal.
1. Select the globe icon next to **5000 -> 127.0.0.1:5000**.
1. Notice that your app no longer loads.

## Remove a forwarded port

1. Stop forwarding port 5000.
1. Notice that the port disappears and the view is replaced with **Forward a Port**. Because the app isn't running, it isn't using port 5000. So it doesn't list port 5000 as an available but **Not Forwarded** port as it did earlier.
1. Enter the following command in the terminal to start the project:

   ```bash
   python app.py
   ```

1. Notice that Visual Studio Code automatically takes care of port forwarding again.

Great work! You've now explored port forwarding with a dev container in Visual Studio Code.

Rather than using the Remote Explorer or the **Forward a Port** command from the Command Palette, you can specify a list of ports that you always want to forward when attaching or opening a folder in container through the `forwardPorts` property in devcontainer.json. In the next unit, we'll explore customizing our container's setup through properties like this in devcontainer.json.
