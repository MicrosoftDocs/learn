Data usually resides in a database or an endpoint. The size of the data can be enormous. When a user asks for all the data for a specific resource, the response can be thousands or even millions of records. A request like this can cause a massive strain on a database. It also takes a long time to serve the response.

To avoid that scenario, it's a good practice to limit the size of the response:

- Use route parameters to ask for specific records.
- Use query parameters to specify a subset of records.

This exercise teaches both techniques.

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

## Set up files for project


1. To inspect the repo, run the following command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-routing/parameters
   ```

  The *parameters* directory should contain these files:

  - app.js
  - package.json
  - package-lock.json

1. The *package.json* file contains the dependency `express`. In the terminal, run the following command to install it:

    ```bash
    npm install
    ```

    `npm` reads from the `dependencies` section in *package.json*.

   > [!NOTE]
   > If you see a warning about an old version of `npm`, follow the instructions to fix the issue before you move to the next step.

1. Open *app.js* to inspect it. The file should look like this:

   ```javascript
   const express = require('express')
   const app = express()
   const port = 3000

   const products = [
   {
     id: 1,
     name: "Ivanhoe",
     author: "Sir Walter Scott",
   },
   {
     id: 2,
     name: "Colour Magic",
     author: "Terry Pratchett",
   },
   {
     id: 3,
     name: "The Bluest eye",
     author: "Toni Morrison",
   },
   ];

   app.get('/', (req, res) => res.send('Hello API!'));

   app.get("/products/:id", (req, res) => {});

   app.get('/products', (req, res) => {});

   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

   The *app.js* file shows a skeleton of a program. Your next job is to implement the routes.

## Implement two routes

The code contains an Express application. The next step is to implement two routes:

- `/products/:id`: This route should return a single product.
- `/products`: This route should return all products, or as many products that query parameters ask for.

1. To implement the route `/products/:id`, locate the following code in the *app.js* file in the *parameters* directory:

   ```javascript
   app.get("/products/:id", (req, res) => {});
   ```

   Replace it with this code:

   ```javascript
   app.get("/products/:id", (req, res) => {
     res.json(products.find(p => p.id === +req.params.id));
   });
   ```

1. In the terminal, run the following command to run the app:

   ```output
   node app.js
   ```

1. Open a browser and go to `http://localhost:3000/products/1`. You should see the following output:

   ```bash
   {
     "id": 1,
     "name": "Ivanhoe",
     "author": "Sir Walter Scott"
   }
   ```

   Congratulations! You implemented the route correctly. The app uses the route parameter `id` to find a specific product.

1. To implement the route `/products`, locate the following code:

   ```javascript
   app.get("/products", (req, res) => {});
   ```

   Replace it with this code:

   ```javascript
   app.get("/products", (req, res) => {
     const page = +req.query.page;
     const pageSize = +req.query.pageSize;
  
     if (page && pageSize) {
       const start = (page - 1) * pageSize;
       const end = start + pageSize;
       res.json(products.slice(start, end));
     } else {
       res.json(products);
     }
   });
   ```

1. In the terminal, run the following command to start the app and test the code:

   ```bash
   node app.js
   ```

1. Open a browser and go to `http://localhost:3000/products?page=1&pageSize=2`. You should see the following output in the browser:

   ```output
   [{
     "id": 1,
     "name": "Ivanhoe",
     "author": "Sir Walter Scott"
   },
   {
     "id": 2,
     "name": "Colour Magic",
     "author": "Terry Pratchett"
   }]
   ```

   The response shows the first two of three records. This response means that the query parameters, `page` and `pageSize`, filtered down the response size.

1. Change the URL to `http://localhost:3000/products?page=2&pageSize=2` to change the number of pages from one to two. The response should look like this:

   ```output
   [{
     "id": 3,
     "name": "The Bluest eye",
     "author": "Toni Morrison"
   }]
   ```

   Because the code contains only three records, the second page should contain only one record. 
   
   You've now successfully applied query parameters to limit the response.
