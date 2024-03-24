You're almost finished creating a Node.js masterpiece for Tailwind Traders. So far, your code reads any folder, finds all `.json` files, and creates a `totals.txt` file in the `salesTotals` folder.

In this exercise, you complete the project by reading the `.json files`, adding up the store totals, and writing the grand total to the `salesTotals/totals.txt` file.

## Create a method to calculate sales totals

1. At the top of index.js, just below the `require("path")` statement, create a function that calculates the sales total. This method should take in the array of file paths that it can iterate over.

   ```javascript
   async function calculateSalesTotal(salesFiles) {
     let salesTotal = 0;

     // READ FILES LOOP

     return salesTotal;
   }
   ```

1. Within that function, replace `// READ FILES LOOP` with a loop that:

    * (1) Iterates over the `salesFiles` array.
    * (2) Reads the file.
    * (3) Parses the content as JSON.
    * (4) Increments the `salesTotal` variable with the `total` value from the file.

   ```javascript
    async function calculateSalesTotal(salesFiles) {
      
      // Final sales total
      let salesTotal = 0;
      
      // (1) Tterates over the `salesFiles` array.
      for (file of salesFiles) {
        
        // (2) Reads the file.
        const fileContents = await fs.readFile(file)
    
        // (3) Parses the content as JSON.
        const data = JSON.parse(fileContents);
    
        // (4) Increments the `salesTotal` variable with the `total` value from the file.
        salesTotal += data.total;
      }
      return salesTotal;
    }
   ```

## Call the calculateSalesTotals method

1.  In the `main` function, modify the code to: 

    * (1) Add a call to the `calculateSalesTotals` function just above the `fs.writeFile` call.
    * (2) Modify the `fs.writeFile` block to write the value of the `salesTotal` variable to the *totals.txt* file.
    
    ```javascript
    async function main() {
      const salesDir = path.join(__dirname, "stores");
      const salesTotalsDir = path.join(__dirname, "salesTotals");
    
      try {
        await fs.mkdir(salesTotalsDir);
      } catch {
        console.log(`${salesTotalsDir} already exists.`);
      }
    
      const salesFiles = await findSalesFiles(salesDir);
    
      // (1) Add a call to the `calculateSalesTotals` function just above the `fs.writeFile` call.
      const salesTotal = await calculateSalesTotal(salesFiles);
    
      // (2) Modify the `fs.writeFile` block to write the value of the `salesTotal` variable to the *totals.txt* file.
      await fs.writeFile(
        path.join(salesTotalsDir, "totals.txt"),
        `${salesTotal}\r\n`,
        { flag: "a" }
      );
    }
    ```

## Run the program

1. Run the program from the terminal.

   ```bash
   node index.js
   ```

    ```console
    185933.76
    ```

1. Open the `./salesTotals/totals.txt` file to see the total of all the sales from the *sales.json* and *totals.json* files: 185933.76.

1. Run the program from the terminal again.

   ```bash
   node index.js
   ```

    ```console
    185933.76
    185933.76
    ```

   The *totals.txt* file now has a second line. Every time you run the program, the totals are added up again and a new line is written to the file.

Outstanding work! You've written a smart, robust, and handy tool that Tailwind Traders can use to process all of its stores' sales every night. In the next section, we'll review what you learned and a few tips to remember.

## Got stuck?

If you got stuck during this exercise, here's the full code for this project.

```javascript
const fs = require("fs").promises;
const path = require("path");

async function calculateSalesTotal(salesFiles) {
  
  // Final sales total
  let salesTotal = 0;
  
  // (1) Tterates over the `salesFiles` array.
  for (file of salesFiles) {
    
    // (2) Reads the file.
    const fileContents = await fs.readFile(file)

    // (3) Parses the content as JSON.
    const data = JSON.parse(fileContents);

    // (4) Increments the `salesTotal` variable with the `total` value from the file.
    salesTotal += data.total;
  }
  return salesTotal;
}

async function findSalesFiles(folderName) {

  // (1) Add an array at the top, to hold the paths to all the sales files that the program finds.
  let results = [];

  // (2) Read the currentFolder with the `readdir` method. 
  const items = await fs.readdir(folderName, { withFileTypes: true });

  // (3) Add a block to loop over each item returned from the `readdir` function using the asynchronous `for...of` loop. 
  for (const item of items) {

    // (4) Add an `if` statement to determine if the item is a file or a directory. 
    if (item.isDirectory()) {

      // (5) If the item is a directory, recursively call the function `findSalesFiles` again, passing in the path to the item. 
      const resultsReturned = await findSalesFiles(path.join(folderName, item.name));
      results = results.concat(resultsReturned);
    } else {
      // (6) If it's not a directory, add a check to make sure the item name matches *sales.json*.
      if (path.extname(item.name) === ".json")
        results.push(`${folderName}/${item.name}`);
    }
  }

  return results;
}

async function main() {
  const salesDir = path.join(__dirname, "stores");
  const salesTotalsDir = path.join(__dirname, "salesTotals");

  // create the salesTotal directory if it doesn't exist
  try {
    await fs.mkdir(salesTotalsDir);
  } catch {
    console.log(`${salesTotalsDir} already exists.`);
  }

  // find paths to all the sales files
  const salesFiles = await findSalesFiles(salesDir);

  // read through each sales file to calculate the sales total
  const salesTotal = await calculateSalesTotal(salesFiles);

  // write the total to the "totals.json" file
  await fs.writeFile(
    path.join(salesTotalsDir, "totals.txt"),
    `${salesTotal}\r\n`,
    { flag: "a" }
  );
  console.log(`Wrote sales totals to ${salesTotalsDir}`);
}

main();
```

Congratulations! You've read the files, parsed the JSON, and written the total to a file. You've completed the project!
## Cleanup development container

After completing the project, you may wish to clean up your development environment or return it to its typical state.

#### [Remote development (browser)](#tab/github-codespaces)

Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free per-core hours entitlement you get for your account.

> [!IMPORTANT]
> For more information about your GitHub account's entitlements, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running codespaces sourced from the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository.

    :::image type="content" source="../media/codespaces/codespace-dashboard.png" alt-text="Screenshot of all the running codespaces including their status and templates.":::

1. Open the context menu for the codespace and select **Delete**.

    :::image type="content" source="../media/codespaces/codespace-delete.png" alt-text="Screenshot of the context menu for a single codespace with the delete option highlighted.":::

#### [Local development (Docker)](#tab/visual-studio-code)

You aren't necessarily required to clean up your local environment, but you can stop the running development container and return to running Visual Studio Code in the context of a local workspace.

1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen Folder Locally**.

    :::image type="content" source="../media/codespaces/reopen-local-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within your local environment.":::

> [!TIP]
> Visual Studio Code will stop the running development container, but the container still exists in Docker in a stopped state. You always have the option to deleting the container instance, container image, and volumes from Docker to free up more space on your local machine.

---