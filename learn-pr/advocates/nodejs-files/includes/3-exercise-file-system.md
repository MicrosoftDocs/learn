Tailwind Traders has many physical stores all over the world. Each night, these stores create a file called *sales.json* that contains the total for all their sales for the previous day. These files are organized in folders named by store ID.

In this exercise, you write a Node.js program that can search for files called *sales.json* in a folder.


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

    The dev container uses a Node.js LTS version such as `v20.5.1`. The exact version might be different.

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
    git clone https://github.com/MicrosoftDocs/node-essentials.git
    ```

1. Open the repository in code with the following commands in the terminal.

    ```bash
    cd node-essentials
    code .
    ```

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

    The dev container uses a Node.js LTS version such as `v20.5.1`. The exact version might be different.

1. The remaining exercises in this project take place in the context of this development container.

---


## Find the sales.json files

Your task is to find all the files in the *stores* folder.

Expand the *stores* folder and each of the numbered folders inside.

:::image type="content" source="../media/folder-structure.png" alt-text="Screenshot that shows the project folder structure.":::

### Include the fs module

1. In the `./nodejs-files` subfolder, create a *index.js* file to open it in the editor.

1. At the top of the file, add the following code to include the **fs** module in the file.

   ```javascript
   const fs = require("fs").promises;
   ```

1. Next, create the `main` function which is the entry point for your code. The last line of code in this file invokes the `main` method.

   ```javascript
   const fs = require("fs").promises;

   async function main() {}

   main();
   ```

   This is typical CommonJS boilerplate code to call an asynchronous function. 

### Write a function to find the `sales.json` files

1. Create a new function called `findSalesFiles` that takes a `folderName` parameter.

   ```javascript
   async function findSalesFiles(folderName) {
     // FIND SALES FILES
   }
   ```

1. Inside the `findSalesFiles` function, add the following code to complete these tasks:

    * (1) Add an array at the top, to hold the paths to all the sales files that the program finds.
    * (2) Read the currentFolder with the `readdir` method. 
    * (3) Add a block to loop over each item returned from the `readdir` method   using the asynchronous `for...of` loop. 
    * (4) Add an `if` statement to determine if the item is a file or a directory. 
    * (5) If the item is a directory, _recursively_ call the function `findSalesFiles` again, passing in the path to the item. 
    * (6) If it's not a directory, add a check to make sure the item name matches *sales.json*.

   ```javascript
   async function findSalesFiles(folderName) {

      // (1) Add an array at the top, to hold the paths to all the sales files that the program finds.
      let results = [];
    
      // (2) Read the currentFolder with the `readdir` method. 
      const items = await fs.readdir(folderName, { withFileTypes: true });
    
      // (3) Add a block to loop over each item returned from the `readdir` method using the asynchronous `for...of` loop. 
      for (const item of items) {
    
        // (4) Add an `if` statement to determine if the item is a file or a directory. 
        if (item.isDirectory()) {
    
          // (5) If the item is a directory, recursively call the function `findSalesFiles` again, passing in the path to the item. 
          const resultsReturned = await findSalesFiles(`${folderName}/${item.name}`);
          results = results.concat(resultsReturned);
        } else {
          // (6) If it's not a directory, add a check to make sure the item name matches *sales.json*.
          if (item.name === "sales.json") {
            results.push(`${folderName}/${item.name}`);
          }
        }
      }
    
      return results;
   }
   ```


1. Call this new `findSaleFiles` function from the `main` method. Pass in the *stores* folder name as the location to search for files.

   ```javascript
    async function main() {
      const results = await findSalesFiles("stores");
      console.log(results);
    }
   ```

1. The full application looks like: 

    ```javascript
    const fs = require("fs").promises;
    
    async function findSalesFiles(folderName) {
    
      // (1) Add an array at the top, to hold the paths to all the sales files that the program finds.
      let results = [];
    
      // (2) Read the currentFolder with the `readdir` method. 
      const items = await fs.readdir(folderName, { withFileTypes: true });
    
      // (3) Add a block to loop over each item returned from the `readdir` method using the asynchronous `for...of` loop. 
      for (const item of items) {
    
        // (4) Add an `if` statement to determine if the item is a file or a directory. 
        if (item.isDirectory()) {
    
          // (5) If the item is a directory, recursively call the function `findSalesFiles` again, passing in the path to the item. 
          const resultsReturned = await findSalesFiles(`${folderName}/${item.name}`);
          results = results.concat(resultsReturned);
        } else {
          // (6) If it's not a directory, add a check to make sure the item name matches *sales.json*.
          if (item.name === "sales.json") {
            results.push(`${folderName}/${item.name}`);
          }
        }
      }
    
      return results;
    }
    
    async function main() {
      const results = await findSalesFiles("stores");
      console.log(results);
    }
    
    main();
    ```

## Run the program

1. Enter the following command at the terminal to run the program.

   ```bash
   node index.js
   ```

1. The program should show the following output.

   ```bash
   [
    'stores/201/sales.json',
    'stores/202/sales.json',
    'stores/203/sales.json',
    'stores/204/sales.json',
   ]
   ```

Excellent! You've successfully written a command-line program that can traverse any directory and find all the *sales.json* files inside.

However, the way that the path to subfolders was constructed in this example is a little clumsy because it requires concatenating strings together. Also, you might run into issues on other operating systems (like Windows) that use different path separators. 

In the next section, you'll learn how to construct paths that work across operating systems by using the **path** module.

### Got stuck?

If you got stuck at any point in this exercise, here's the completed code. Remove everything in *index.js* and replace it with this solution.

```javascript
const fs = require("fs").promises;

async function findSalesFiles(folderName) {

  // (1) Add an array at the top, to hold the paths to all the sales files that the program finds.
  let results = [];

  // (2) Read the currentFolder with the `readdir` method. 
  const items = await fs.readdir(folderName, { withFileTypes: true });

  // (3) Add a block to loop over each item returned from the `readdir` method using the asynchronous `for...of` loop. 
  for (const item of items) {

    // (4) Add an `if` statement to determine if the item is a file or a directory. 
    if (item.isDirectory()) {

      // (5) If the item is a directory, recursively call the function `findSalesFiles` again, passing in the path to the item. 
      const resultsReturned = await findSalesFiles(`${folderName}/${item.name}`);
      results = results.concat(resultsReturned);
    } else {
      // (6) If it's not a directory, add a check to make sure the item name matches *sales.json*.
      if (item.name === "sales.json") {
        results.push(`${folderName}/${item.name}`);
      }
    }
  }

  return results;
}

async function main() {
  const results = await findSalesFiles("stores");
  console.log(results);
}

main();
```
