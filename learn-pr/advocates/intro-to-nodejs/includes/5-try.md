In this unit, you create and run a Node.js script.

## Start your dev container in a browser

A [development container](https://containers.dev/) environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces in a browser or locally using Visual Studio Code.

[GitHub Codespaces](https://docs.github.com/codespaces) runs a development container managed by GitHub with [Visual Studio Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web) as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Start the process to create a new GitHub Codespace on the `main` branch of the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=main&repo=278117471)

1. On the **Create codespace** page, review the codespace configuration settings, and then select **Create codespace**

    :::image type="content" source="../media/codespaces/codespace-configuration.png" alt-text="Screenshot of the confirmation screen before creating a new codespace.":::

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/codespaces/open-terminal-option.png" lightbox="../media/codespaces/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

## Node.js REPL

Node.js has a built-in read-eval-print loop (REPL) mode that's useful for quick code evaluation and experimentation. REPL mode is an interactive console environment where you can enter JavaScript code and have Node.js interpret and run the code and then print the output.

The Node.js REPL mode works as follows:

- **Read**: Reads and parses the user's JavaScript code input (or shows an error if the code is invalid).
- **Eval**: Evaluates the entered JavaScript code.
- **Print**: Prints the computed results.
- **Loop**: Loops and waits for the user to enter a new command (or exits if the user enters **ctrl-c** twice).

To start REPL mode, run the `node` program in the terminal of the dev container.


> [!Note]
> Use right-click > **Paste** to enter a copied command in the REPL console.

```bash
node
```

The REPL environment opens. You should see the REPL prompt:

```console
>
```

Enter the following code in the REPL console (right-click > **Paste**):

```console
console.log('Hello World, from the REPL.')
```

This code prints a "Hello World, from the REPL." message in the REPL console:

```output
Hello World, from the REPL.
```

To exit the REPL console, enter Ctrl + C twice. 

## Create a Node.js script

Node.js also supports running code from files.

1. Create a new folder named **hello-world** in the dev container.
1. Open the new folder in a terminal by right-clicking the folder name, then selecting **Open in Integrated Terminal**.
1. In the terminal, initialize the node project.

    ```console
    npm init -y
    ```

1. Install a Node package, `node-fetch` to make async HTTP requests.

    ```console
    npm install node-fetch
    ```

1. Open the `package.json` file and add the following property to allow top-level async/await.

    ```json
    "type":"module",
    ```

1. Create a file named **index.js** in the new folder.

1. Copy the following code into the **index.js** file:

    :::code language="javascript" source="~/../microsoftdocs-node-essentials/nodejs-intro-esm/5-try/index-1.js":::

1. In the terminal, enter the `node` command followed by the name of the file index.js:

   ```bash
   node index.js
   ```

    You should see the following output:

   ```output
    Hello World, from a script file.
   ```

You have now run your first Node.js JavaScript code. 

- Question: Is console.log synchronous or asynchronous?
- Answer: The `console.log` method appears in development to execute immediately and is therefore assumed to be async. There's no guarantee of async behavior for this method so it must be considered synchronous. Because the code execution *can* block until the `console.log` method is finished, you're cautioned from keeping `console.log` statements in your code in production.

## Add a top-level asynchronous function

The following top-level asynchronous code requests an HTTP JSON data source then displays it.

1. Add the following code to the `index.js` file to create an asynchronous HTTP request:

    :::code language="javascript" source="~/../microsoftdocs-node-essentials/nodejs-intro-esm/5-try/top-level-async-await.js":::

    The `https.get` method makes an HTTP request to the Node.js website and returns the response. The `get` method takes two parameters: the URL to request and a callback function that is called when the response is received. The callback function takes a single parameter, `res`, which is the response object.

1. Rerun the application:

    ```javascript
    node index.js
    ```

1. The order of the console logs is as follows:

    ```output
    start
    statusCode: 200
    end
    ```

From the output, you can see the event loop in action. The HTTP method is called and put in the task queue, waiting for it to return. The event loop takes the next task, which is the console.log method.

## Stop your dev container

Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free per-core hours entitlement you get for your account.

> [!IMPORTANT]
> For more information about your GitHub account's entitlements, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running Codespaces sourced from the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository.

    :::image type="content" source="../media/codespaces/codespace-dashboard.png" alt-text="Screenshot of all the running Codespaces including their status and templates.":::

1. Open the context menu for the codespace and select **Delete**.

    :::image type="content" source="../media/codespaces/codespace-delete.png" alt-text="Screenshot of the context menu for a single codespace with the delete option highlighted.":::
