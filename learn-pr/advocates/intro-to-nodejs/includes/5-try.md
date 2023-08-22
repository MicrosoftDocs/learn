In this unit, you'll create and run a Hello World Node.js script.

## Start your dev container in a browser

A [development container](https://containers.dev/) environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces in a browser or locally using Visual Studio Code.


[GitHub Codespaces](https://docs.github.com/codespaces) runs a development container managed by GitHub with [Visual Studio Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web) as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Start the process to create a new GitHub Codespace on the `main` branch of the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=main&repo=278117471)

1. On the **Create codespace** page, review the codespace configuration settings and then select **Create new codespace**

    :::image type="content" source="../media/codespace-configuration.png" alt-text="Screenshot of the confirmation screen before creating a new codespace.":::

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

## Node.js REPL

Node.js has a built-in read-eval-print loop (REPL) mode that's useful for quick code evaluation and experimentation. REPL mode is an interactive console environment where you can enter JavaScript code and have Node.js interpret and run the code and then print the output.

The Node.js REPL mode works as follows:

- **Read**: Reads and parses the user's JavaScript code input (or shows an error if the code is invalid).
- **Eval**: Evaluates the entered JavaScript code.
- **Print**: Prints the computed results.
- **Loop**: Loops and waits for the user to enter a new command (or exits if the user enters **ctrl-c** twice).

To start REPL mode, run the `node` program in the dev container.


> [!Note]
> Use right-click > **Paste** to enter a copied command in Cloud Shell or in the REPL console.

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

1. In Azure Cloud Shell, open a new editor by entering the `code` command:

   ```bash
   code
   ```

1. In the Cloud Shell code editor, create a file by entering the following code:

   > [!Note]
   > Use Ctrl + V to enter a copied command in the Cloud Shell code editor.

   ```javascript
   console.log('Hello World, from a script file.');
   ```

1. Save the file with the name **index.js** by entering the following command:

   ::: zone pivot="windows,linux"
   - For Windows and Linux, enter Ctrl + S.
   ::: zone-end

   ::: zone pivot="macos"
   - For macOS, enter Cmd + S.
   ::: zone-end
   
1. In Cloud Shell, enter the `node` command followed by the name of the file index.js:

   ```bash
   node index.js
   ```

You should see the following output:

```output
Hello World, from a script file.
```

You have now run your first Node.js JavaScript code.

## Stop your dev container


Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free per-core hours entitlement you get for your account.

> [!IMPORTANT]
> For more information about your GitHub account's entitlements, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running codespaces sourced from the [`azure-samples/minimal-api-work-with-databases`](https://github.com/azure-samples/minimal-api-work-with-databases) GitHub repository.

    :::image type="content" source="../media/codespace-dashboard.png" alt-text="Screenshot of all the running codespaces including their status and templates.":::

1. Open the context menu for the codespace and select **Delete**.

    :::image type="content" source="../media/codespace-delete.png" alt-text="Screenshot of the context menu for a single codespace with the delete option highlighted.":::