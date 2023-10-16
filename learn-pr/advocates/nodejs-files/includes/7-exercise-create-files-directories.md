The *fs* module in Node.js lets you create new files and directories programmatically.

So far, you've created a robust command-line application in Node.js that can read any folder structure to find files with a .json extension. You need to read those files to summarize the data in them and then write the totals to a new file in a new directory called *salesTotals*.

In this exercise, you create the *salesTotals* directory and *totals.txt* file where we can eventually write the sales totals.

## Create the salesTotals directory

1. In the `main` function, create a variable called `salesTotalsDir`, which holds the path of the *salesTotals* directory.

   ```javascript
   async function main() {
     const salesDir = path.join(__dirname, "stores");
     const salesTotalsDir = path.join(__dirname, "salesTotals");

     // find paths to all the sales files
     const salesFiles = await findSalesFiles(salesDir);
   }
   ```

1. In the `main` function, add code to create the directory if it doesn't already exist.

   ```javascript
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
   }
   ```

## Write the totals.txt file

1. In the `main` function, add the code to create an empty file called *totals.txt* inside the newly created *salesTotals* directory.

   ```javascript
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

     // write an empty file called "totals.txt"
     await fs.writeFile(path.join(salesTotalsDir, "totals.txt"), String());
   }
   ```

1. Press <kbd>Ctrl+S</kbd> or <kbd>Cmd+S</kbd> to save the file.

1. From the terminal prompt, run the program with the following code.

   ```bash
   node index.js
   ```

1. Select the **Refresh** icon in the **Files** explorer.

   :::image type="content" source="../media/refresh-file-explorer.png" alt-text="Screenshot of the Refresh icon in the Files explorer of the Cloud Shell editor.":::

You created the file but it doesn't have the totals yet. The next step is to read the sales files, add up the totals, and write the grand total to the new *totals.txt* file. Next you learn how to read and parse data inside files.

## Got stuck?

If you got stuck during this exercise, here's the full code up to this point.

```javascript
const fs = require("fs").promises;
const path = require("path");

async function findSalesFiles(folderName) {
  // this array will hold sales files as they are found
  let salesFiles = [];

  async function findFiles(folderName) {
    // read all the items in the current folder
    const items = await fs.readdir(folderName, { withFileTypes: true });

    // iterate over each found item
    for (item of items) {
      // if the item is a directory, it will need to be searched
      if (item.isDirectory()) {
        // call this method recursively, appending the folder name to make a new path
        await findFiles(path.join(folderName, item.name));
      } else {
        // Make sure the discovered file is a .json file
        if (path.extname(item.name) === ".json") {
          // store the file path in the salesFiles array
           await salesFiles.push(path.join(folderName, item.name));
        }
      }
    }
  }

  await findFiles(folderName);

  return salesFiles;
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

  // write the total to the "totals.txt" file
  await fs.writeFile(path.join(salesTotalsDir, "totals.txt"), String());
  console.log(`Wrote sales totals to ${salesTotalsDir}`);
}

main();
```
