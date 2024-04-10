As a Tailwind Traders developer, you've created a robust command-line application in Node.js that can read any folder structure to find files with a .json extension. You need to read those files to summarize the data in them and then write the totals to a new file in a new directory called *salesTotals*.

## Create the salesTotals directory

1. In the `main` function, add code to: 

    * (1) Create a variable called `salesTotalsDir`, which holds the path of the *salesTotals* directory.
    * (2) Create the directory if it doesn't already exist.
    * (3) Write the total to the "totals.txt" file.

   ```javascript
    async function main() {
      const salesDir = path.join(__dirname, "stores");

      // (1) Create a variable called `salesTotalsDir`, which holds the path of the *salesTotals* directory.
      const salesTotalsDir = path.join(__dirname, "salesTotals");
    
      try {
        // (2) Create the directory if it doesn't already exist.
        await fs.mkdir(salesTotalsDir);
      } catch {
        console.log(`${salesTotalsDir} already exists.`);
      }
    
      // Calculate sales totals
      const salesFiles = await findSalesFiles(salesDir);
    
      // (3) Write the total to the "totals.txt" file with empty string `String()`
      await fs.writeFile(path.join(salesTotalsDir, "totals.txt"), String());
      console.log(`Wrote sales totals to ${salesTotalsDir}`);
    }
   ```

1. From the terminal prompt, run the program with the following code.

   ```bash
   node index.js
   ```

1. Select the **Refresh** icon in the **Files** explorer to see the new file. You created the file but it doesn't have the totals yet. The next step is to read the sales files, add up the totals, and write the grand total to the new *totals.txt* file. Next you learn how to read and parse data inside files.

## Got stuck?

If you got stuck during this exercise, here's the full code up to this point.

```javascript
const fs = require("fs").promises;
const path = require("path");

async function findSalesFiles(folderName) {

  // (1) Add an array at the top, to hold the paths to all the sales files that the program finds.
  let results = [];

  // (2) Read the currentFolder with the `readdir` method. 
  const items = await fs.readdir(folderName, { withFileTypes: true });

  // (3) Add a block to loop over each item returned from the `readdir` function using the asynchronous `for...of` loop. 
  for (const item of items) {

    // (4) Add an `if` statement to determine if the item is a file or a directory. 
    if (item.isDirectory()) {

      // (5) If the item is a directory,  recursively call the function `findSalesFiles` again, passing in the path to the item. 
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

  // (1) Create a variable called `salesTotalsDir`, which holds the path of the *salesTotals* directory.
  const salesTotalsDir = path.join(__dirname, "salesTotals");

  try {
    // (2) Create the directory if it doesn't already exist.
    await fs.mkdir(salesTotalsDir);
  } catch {
    console.log(`${salesTotalsDir} already exists.`);
  }

  // Calculate sales totals
  const salesFiles = await findSalesFiles(salesDir);

  // (3) Write the total to the "totals.txt" file with empty string `String()`
  await fs.writeFile(path.join(salesTotalsDir, "totals.txt"), String());
  console.log(`Wrote sales totals to ${salesTotalsDir}`);
}

main();
```
