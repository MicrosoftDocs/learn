You've been tasked with creating a simple API using the framework Express. The online retailer wants to evaluate Express to see if it's easy to work with. As part of that evaluation, they want you to build a web application that serves different routes. 



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


## Create a basic web app with Express

Create a basic application that handles requests.

1. Open a terminal in the dev container.
1. Create a new folder named `my-express-app`, and enter the following commands:

   ```bash
   mkdir my-express-app
   cd my-express-app
   npm init -y
   npm install express

   ```
   
   The `init` command creates a default **package.json** file for your Node.js project. The `install` command installs the Express framework.

1. In a code editor, open the package.json file.

   In the `dependencies` section, locate the `express` entry:
   
   ```bash
   "dependencies": {
     "express": "^4.18.1"
   ```
  
   This entry indicates the Express framework is installed.

1. In a code editor in the `my-express-app` folder, create a file named **app.js**, and add the following code:

   ```javascript
   const express = require('express');
   const app = express();
   const port = 3000;

   app.get('/', (req, res) => res.send('Hello World!'));

   app.listen(port, () => console.log(`Example app listening on port ${port}! http://localhost:${port}/`));
   ```

   The code creates an instance of an Express application by invoking the `express()` method.
  
   Notice how the code sets up a route to slash `/`, the root, with the syntax:
   
   > `app.get('/', (req, res) => res.send('Hello World!'));`

   After setting up the route, the code starts the web application by invoking the `listen()` method:

   > `app.listen(port, () => console.log(`Example app listening on port ${port}!`));`

1. Save your changes to the app.js file.

1. Open a terminal for this subfolder by right-clicking the subfolder name and selecting **Open in integrated terminal**.
1. In the terminal, run the following command to start the Express web application:

   ```bash
   node app.js
   ```

   You should see the following output:

   ```output
   Example app listening at http://localhost:3000
   ```

   This output means your app is up and running and ready to receive requests.

1. You can right-click and select the URL in the terminal or you can open the browser when Visual Studio Code pops up a notification asking if you want to **Open in browser**. You should see the following output:
   
   ```output
   Hello World!
   ```

1. In the terminal, press Ctrl + C to stop the web Express program.


## Create a web app that returns JSON data

Use the same app.js file to add a new route.

1. In a code editor, open the app.js file. Add the following code after the existing `app.get` syntax after the code for the first route, `/`:

   ```javascript
   app.get("/products", (req,res) => {
     const products = [
     {
       id: 1,
       name: "hammer",
     },
     {
       id: 2,
       name: "screwdriver",
     },
     {
       id: 3,
       name: "wrench",
     },
    ];

    res.json(products);
   });
   ```

1. Make sure your app.js file looks like this example:

   ```javascript
   const express = require("express");
   const app = express();
   const port = 3000;

   app.get("/", (req, res) => res.send("Hello World!"));

   app.get("/products", (req,res) => {
      const products = [
        {
          id: 1,
          name: "hammer",
        },
        {
          id: 2,
          name: "screwdriver",
        },
        ,
        {
          id: 3,
          name: "wrench",
        },
      ];

     res.json(products);
   })

   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

1. Save your changes to the app.js file and close the file.

1. In the terminal, run the following command to restart the web Express app:

   ```bash
   node app.js
   ```

   You should see the following output:

   ```output
   Example app listening at http://localhost:3000
   ```

1. In a browser, return to the tab from the previous step and add the new route, `/products`, to the end of the URL. You should see the following output:

   ```output
   [{"id":1,"name":"hammer"},{"id":2,"name":"screwdriver"},{"id":3,"name":"wrench"}]
   ```

1. In the terminal, press Ctrl + C to stop the web Express program.

Congratulations! You implemented a second route that can serve up static JSON data.
