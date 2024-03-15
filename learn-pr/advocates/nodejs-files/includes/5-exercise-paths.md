As a developer at Tailwind Traders, you're about to enhance a program by using the Node.js **path** module and `__dirname` global variable. This will allow the program to dynamically locate and process any .json files, regardless of where the program is run from.

## Include the path module

At the top of your existing *index.js* file, include the **path** module.

```javascript
const path = require("path");
```

## Use the current directory

In the current index.js code, you're passing the static location of the *stores* folder. Let's change that code to use the `__dirname` value instead of passing a static folder name.

1. In the `main` method, create a variable to store a path to the *stores* directory by using the `__dirname` constant.

   ```javascript
   async function main() {
     const salesDir = path.join(__dirname, "stores");

     const salesFiles = await findSalesFiles(salesDir);
     console.log(salesFiles);
   }
   ```

1. Run the program from the command line.

   ```bash
   node index.js
   ```

   Notice that the path that's now listed for the files is the full system path, because the `__dirname` constant returns the full path to the current location.

   ```bash
   [
      '/workspaces/node-essentials/nodejs-files/stores/201/sales.json',
      '/workspaces/node-essentials/nodejs-files/stores/202/sales.json',
      '/workspaces/node-essentials/nodejs-files/stores/203/sales.json',
      '/workspaces/node-essentials/nodejs-files/stores/204/sales.json'
   ]
   ```

## Join paths

Instead of concatenating folder names to make a new path to search, you change the code to use the `path.join` method. This code can then work across operating systems.

1. Change the `findFiles` method to use `path.join`.

   ```javascript
   // previous code - with string concatentation
   const resultsReturned = await findSalesFiles(`${folderName}/${item.name}`);

   // current code - with path.join
   const resultsReturned = await findSalesFiles(path.join(folderName,item.name));
   ```

1. Run the program from the command line.

   ```bash
   node index.js
   ```

   The output is the same as the previous step, but the program is now more robust because it uses `path.join` instead of concatenating strings.

## Find all .json files

Instead of looking for just *sales.json* files, the program needs to search for any file with an extension of .json. To do that, use the `path.extname` method to check the filename extension.

1. Run the following command in the terminal to rename the *stores/201/sales.json* file to *stores/sales/totals.json*.

   ```bash
   mv stores/201/sales.json stores/201/totals.json
   ```

1. In the `findSalesFiles` function, change the `if` statement to check just the filename extension.

   ```javascript
   if (path.extname(item.name) === ".json") {
     results.push(`${folderName}/${item.name}`);
   }
   ```

1. Run the program from the command line.

   ```bash
   node index.js
   ```

   The output now shows all the .json files in any of the store ID directories.

   ```bash
   [
      '/home/username/node-essentials/nodejs-files/stores/201/totals.json',
      '/home/username/node-essentials/nodejs-files/stores/202/sales.json',
      '/home/username/node-essentials/nodejs-files/stores/203/sales.json',
      '/home/username/node-essentials/nodejs-files/stores/204/sales.json'
   ]
   ```

Great job! You've used the **path** module and the `__dirname` constant to make the program much more robust. In the next section, you'll learn how to create directories and move files between locations.

### Got stuck?

If you got stuck at any point in this exercise, here's the completed code. Remove everything in *index.js* and replace it with this solution.

```javascript
const fs = require("fs").promises;
const path = require("path");

async function findSalesFiles(folderName) {

  // (1) Add an array at the top, to hold the paths to all the sales files that the program finds.
  let results = [];

  // (2) Read the currentFolder with the `readdir` method. 
  const items = await fs.readdir(folderName, { withFileTypes: true });

  // (3) Add a block to loop over each item returned from the `readdir` method using the asynchronous `for...of` loop. 
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

  // find paths to all the sales files
  const salesFiles = await findSalesFiles(salesDir);
  console.log(salesFiles);
}

main();
```
