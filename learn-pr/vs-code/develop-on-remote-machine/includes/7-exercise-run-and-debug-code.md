Now that you're connected to your SSH server, you're ready to start coding! You need to generate a basic Node application because you're tasked with developing an Express app for your agency.

In this exercise, you'll create a basic Node project and run and debug the project code, all while connected using SSH.

## Create and run a Node.js application

To create and run your Node.js application, you'll need to run a series of commands in the terminal.

1. Open a new terminal by running the command "Terminal: Create New Terminal." From the terminal, run the following commands to update the packages in your Linux VM and install Node.js:

    ```bash
    sudo apt-get update
    ```

    ```bash
    curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    ```

    ```bash
    sudo apt-get install nodejs -y
    ```

2. Run the following command to install the Express generator: 
    
    ```bash
    sudo npm install -g express-generator
    ```

3. Run the following command to create a new Express application called myExpressApp:
    
    ```bash
    express myExpressApp --view pug
    ```

4. Open the application files by clicking Open Folder in the Explorer view. Select "myExpressApp" in the dropdown to open the folder in your VS Code window.

    :::image type="content" source="../media/7-open-folder.png" alt-text="Screenshot showing opening the myExpressApp folder.":::

5. In the next prompt, select "OK," which will open the folder containing your application files. If prompted, trust the workspace.

    :::image type="content" source="../media/7-confirm-folder.png" alt-text="Screenshot showing confirmation of opening the myExpressApp folder.":::
 
6. Open the terminal again, and run the following command to install all of the application's dependencies:
    
    ```bash
    npm install
    ```

7. Run the following command to run the application:

    ```bash
    npm start
    ```

    The application will run on your VM's `http://localhost:3000`. The next step will show you how to browse this application on your local machine.

## Browse the application

Now that the application is running, you can use Port forwarding to browse the web app on your local machine.

1. With the app still running, run the "Ports: Focus on Ports View" command in the Command Palette.

    :::image type="content" source="../media/7-focus-on-ports-view.png" alt-text="Screenshot showing the Focus on Ports View command in the Command Palette.":::

1. Click on the Forward a port button.

    :::image type="content" source="../media/7-forward-a-port.png" alt-text="Screenshot showing the Forward a Port action in the Ports view.":::

1. Specify port 3000, then hit <kbd>Enter</kbd>.

    :::image type="content" source="../media/7-specify-port-3000.png" alt-text="Screenshot showing specifying the port 3000 in the Ports view.":::

1. The server will now forward traffic on port 3000 to your local machine, so you can now browse to `http://localhost:3000` to see the running web app!
1. In the terminal, stop the app by running <kbd>Ctrl</kbd> + <kbd>C</kbd>.

## Edit and debug the application

You can use VS Code's built-in features to edit and debug the application running on the remote machine.

1. Navigate to the File Explorer in VS Code and open the app.js file.
2. Set a breakpoint on line 10 of the file by clicking in the gutter to the left of the line number. You'll see a red circle displayed.

    :::image type="content" source="../media/7-breakpoint.png" alt-text="Screenshot showing a breakpoint set at line 10 of the app.js file.":::

1. In the Run and Debug view, select Run and Debug. If prompted how to debug the application, choose Node.js.

    :::image type="content" source="../media/7-run-and-debug.png" alt-text="Screenshot showing the Run and Debug action in the Run and Debug view.":::

1. When the app runs, you'll hit the breakpoint. You can inspect variables, create watches, and navigate the call stack in the Debug view in the sidebar. You can control your debug session, like step line by line, using the debug action bar at the top.

    :::image type="content" source="../media/7-debug-experience.png" alt-text="Screenshot highlighting different parts of the debugging experience.":::

1. You can also edit the file just like you would if the code was located on your local machine. Begin to type `app.` which will trigger IntelliSense.

    :::image type="content" source="../media/7-intellisense.png" alt-text="Screenshot showing intellisense when editing code.":::

Congratulations! You successfully ran, edit, and debugged code that existed only on the remote machine.
