You're a Node.js developer at Tailwind Traders. Knowing how to set up a new Node.js project is an important skill to have. Setup includes generating a manifest file and creating some common scripts that you're likely to use throughout the project lifecycle.

## Open project in development container


A [development container](https://containers.dev/) environment is available with all dependencies required to complete every exercise in this project. You can run the development container in GitHub Codespaces or locally using Visual Studio Code.

#### [GitHub Codespaces](#tab/github-codespaces)

[GitHub Codespaces](https://docs.github.com/codespaces) runs a development container managed by GitHub with [Visual Studio Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web) as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Start the process to create a new GitHub Codespace on the `main` branch of the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository.

    > [!div class="nextstepaction"]
    > [Open this project in GitHub Codespaces](https://github.com/codespaces/new?azure-portal=true&hide_repo_select=true&ref=main&repo=278117471)

1. On the **Create codespace** page, review the codespace configuration settings and then select **Create new codespace**

    :::image type="content" source="../media/codespaces/codespace-configuration.png" alt-text="Screenshot of the confirmation screen before creating a new codespace.":::

1. Wait for the codespace to start. This startup process can take a few minutes.

1. Open a new terminal in the codespace.

    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/open-terminal-option.png" lightbox="../media/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

1. Validate that Node.js is installed in your environment:

    ```bash
    node --version
    ```
1. Close the terminal.
1. The remaining exercises in this project take place in the context of this development container.

#### [Visual Studio Code](#tab/visual-studio-code)
The [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for Visual Studio Code requires [Docker](https://docs.docker.com/) to be installed on your local machine. The extension hosts the development container locally using the Docker host with the correct developer tools and dependencies preinstalled to complete this training module.
1. Open **Visual Studio Code** in the context of an empty directory.
1. Ensure that you have the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed in Visual Studio Code.
1. Open a new terminal in the editor.
    > [!TIP]
    > You can use the main menu to navigate to the **Terminal** menu option and then select the **New Terminal** option.
    >
    > :::image type="content" source="../media/codespaces/open-terminal-option.png" lightbox="../media/codespaces/open-terminal-option.png" alt-text="Screenshot of the menu option to open a new terminal.":::
1. Clone the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository into the current directory.
    ```bash
    git clone https://github.com/MicrosoftDocs/node-essentials.git .
    ```
1. Open the folder into which you cloned the GitHub repository.
1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen in Container**.
    :::image type="content" source="../media/codespaces/reopen-container-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within the context of a development container.":::
    > [!TIP]
    > Visual Studio Code might automatically prompt you to reopen the existing folder within a development container. This is functionally equivalent to using the command palette to reopen the current workspace in a container.
    >
    > :::image type="content" source="../media/codespaces/reopen-container-toast.png" alt-text="Screenshot of a toast notification to reopen the current folder within the context of a development container.":::
1. Validate that Node.js is installed in your environment:
    ```bash
    node --version
    ```
1. Close the terminal.
1. The remaining exercises in this project take place in the context of this development container.

---

## Set up a new Node.js project

1. Open a terminal window.

2. Clone the `https://github.com/MicrosoftDocs/node-essentials/` repo by running this command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials/
   ```

3. Change to the folder that has the cloned files for this exercise:

   ```bash
   cd node-essentials/node-dependencies/3-exercise-package-json
   ```

   In this folder, you should see a **src** subfolder with an **index.js** file:

   ```output
   -| src/
   ---| index.js
   ```

4. Run the following command to initialize a Node.js project:

    ```bash
    npm init -y
    ```

   This command generates a **package.json** file that looks similar to this example:

    ```json
    {
      "name": "<your project>",
      "version": "1.0.0",
      "description": "",
      "main": "script.js",
      "dependencies": {},
      "devDependencies": {},
      "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "keywords": [],
      "author": "",
      "license": "ISC"
    }
    ```

5. Edit the package.json file and modify these property values:

    - `name`: "tailwind-trader-api"
    - `description`: "HTTP API to manage items from the Tailwind Traders database"
    - `main`: "index.js"
    - `keywords`: ["api", "database"]
    - `author`: "Sam"

   Your package.json file should now look like this code:

    ```json
    {
      "name": "tailwind-trader-api",
      "version": "1.0.0",
      "description": "HTTP API to manage items from the Tailwind Traders database",
      "main": "index.js",
      "dependencies": {},
      "devDependencies": {},
      "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "keywords": ["api", "database"],
      "author": "Sam",
      "license": "ISC"
    }
    ```

6. In the `scripts` section, add this definition for the `start` action before the definition for the `test` action:

   ```json
   "start": "node ./src/index.js",
   ```

   Save your changes and close the package.json file.

7. Start your project with the `start` action by entering this command:

   ```bash
   npm start
   ```

   You should see this output:

   ```output
   Welcome to this application
   ```

You now have a good file structure that you can build upon as your project grows.
