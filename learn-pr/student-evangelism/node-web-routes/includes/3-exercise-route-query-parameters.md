As an engineer for Tailwind Traders, create your APIs to be efficient both for the server and the client by limiting the amount of data that is sent or returned from the API.

Data usually resides in a database or other storage. The size of the data can be enormous. When a user asks for all the data for the products, the response can be thousands or even millions of records. A request like this can cause a massive strain on a database. It also takes a long time to serve and render the response on the client.

To avoid that scenario, it's a good practice to limit the size of the response:

- Use route parameters to ask for a specific record
- Use query parameters to specify a subset of records.

This exercise teaches both techniques.

## Open project in development container

#### [Remote development (browser)](#tab/github-codespaces)

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
    > :::image type="content" source="../media/codespaces/open-terminal-option.png" lightbox="../media/codespaces/open-terminal-option.png" alt-text="Screenshot of the codespaces menu option to open a new terminal.":::

1. Validate that Node.js is installed in your environment:

    ```bash
    node --version
    ```
1. Close the terminal.
1. The remaining exercises in this project take place in the context of this development container.

#### [Local development (Docker)](#tab/visual-studio-code)


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


1. To inspect the project for this module, open the `./nodejs-http/exercise-express-routing/parameters` folder in the code editor.

    The *parameters* directory should contain these files:

    | File | Purpose |
    |--|--|
    |`app.js`|This file contains the Express application.|
    |`package.json`|This file contains the dependencies for the project.|
    |`package-lock.json`|This file contains the exact versions of the dependencies.|

1. Right-click on the folder name in the file explorer, `/nodejs-http/exercise-express-routing/parameters` and select **Open in integrated terminal**. 
1. In the terminal, run the following command to install the project's dependencies:

    ```bash
    npm install
    ```

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

   app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`));
   ```

    This JavaScript code creates a basic Express.js server. It defines an array of `products` and sets up three routes: root (`/`), `/products/:id`, and `/products`. The server listens on port 3000. The routes `/products/:id` and `/products` are placeholders with no functionality yet.

    The data is hardcoded to simplify the exercise. In a real-world scenario, the data would come from a database or other storage.

## Implement product route to return a single product

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

1. When the Visual Studio Code pops up the notification of opening the browser, select **Open in browser**. 
1. Add the following to the end of the URL:

    ```text
    /products/1
    ``` 

    The output is:

   ```bash
   {
     "id": 1,
     "name": "Ivanhoe",
     "author": "Sir Walter Scott"
   }
   ```


   Congratulations! You implemented the route correctly. The app uses the route parameter `id` to find a specific product.

1. In the terminal, select Ctrl+C to stop the application.

## Implement products route to return a list of products

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

1. When the Visual Studio Code pops up the notification of opening the browser, select **Open in browser**. 
1. Add the following to the end of the URL:

    ```text
    /products?page=1&pageSize=2
    ``` 


    The output is:

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

   The response shows the first two of three records. This response means that the query parameters, `page` and `pageSize`, filtered down the response size from the complete list to two items.

1. Change the URL to use the following route, `products?page=2&pageSize=2` to change the number of pages from one to two. The response is:

   ```output
   [{
     "id": 3,
     "name": "The Bluest eye",
     "author": "Toni Morrison"
   }]
   ```

Because the code contains only three records, the second page should contain only one record. 

1. In the terminal, select Ctrl+C to stop the application.

You've now successfully applied query parameters to limit the response.
