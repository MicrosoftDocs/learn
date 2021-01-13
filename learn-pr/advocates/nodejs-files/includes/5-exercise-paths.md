The Node.js *path* module and `__dirname` global variable are two ways to define and compose file system paths.

In the previous exercise, you wrote a program that iterates through a folder to find any of the *sales.json* files inside.

In this exercise, you'll use the *path* module and `__dirname` global variable to improve the program so that it will find any file with a .json extension.

## Include the path module

At the top of the *index.js* file, include the *path* module.

```javascript
const path = require("path");
```

## Use the current directory

In the current index.js code, you're passing the static location of the *stores* folder. We'll change that code to use the `__dirname` value instead of passing a static folder name.

1. In the `main` method, create a variable to store a path to the *stores* directory by using the `__dirname` constant.

   ```javascript
   async function main() {
     const salesDir = path.join(__dirname, "stores");

     const salesFiles = await findSalesFiles(salesDir);
     console.log(salesFiles);
   }
   ```

1. Select the <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> keys to save the file.

1. Run the program from the command line.

   ```bash
   node index.js
   ```

   Notice that the path that's now listed for the files is the full system path. This is because the `__dirname` constant returns the full path to the current location.

   ```bash
   [
     '/home/username/node-files/stores/201/sales.json',
     '/home/username/node-files/stores/202/sales.json',
     '/home/username/node-files/stores/203/sales.json',
     '/home/username/node-files/stores/204/sales.json',
   ]
   ```

## Join paths

Instead of concatenating folder names to make a new path to search, you'll change the code to use the `path.join` method. This code will then work across operating systems.

1. Change the `findFiles` method to use `path.join`.

   ```javascript
   // search this directory for files (this is recursion!)
   await findFiles(path.join(folderName, item.name));
   ```

1. Select the <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> keys to save the file.

1. Run the program from the command line.

   ```bash
   node index.js
   ```

   The output will be the same as the previous step, but the program is now more robust because it uses `path.join` instead of concatenating strings.

## Find all .json files

Instead of looking for just *sales.json* files, the program needs to search for any file with an extension of .json. To do that, use the `path.extname` method to check the file name extension.

1. Run the following command in the terminal to rename the *stores/201/sales.json* file to *stores/sales/totals.json*.

   ```bash
   mv stores/201/sales.json stores/201/totals.json
   ```

1. In the `findFiles` method, change the `if` statement to check just the file name extension. Use the `path.join` method to compose the full path to the file.

   ```javascript
   if (path.extname(item.name) === ".json") {
     // store the file path in the salesFiles array
     await salesFiles.push(path.join(folderName, item.name));
   }
   ```

1. Select the <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> keys to save the file.

1. Run the program from the command line.

   ```bash
   node index.js
   ```

   The output now shows all the .json files in any of the store ID directories.

   ```bash
   [
      '/home/username/node-files/stores/201/totals.json',
      '/home/username/node-files/stores/202/sales.json',
      '/home/username/node-files/stores/203/sales.json',
      '/home/username/node-files/stores/204/sales.json'
   ]
   ```

Great job! You've used the *path* module and the `__dirname` constant to make the program much more robust. In the next section, you'll learn how to create directories and move files between locations.

### Got stuck?

If you got stuck at any point in this exercise, here's the completed code. Remove everything in *index.js* and replace it with this solution.

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
          salesFiles.push(path.join(folderName, item.name));
        }
      }
    }
  }

  await findFiles(folderName);

  return salesFiles;
}

async function main() {
  const salesDir = path.join(__dirname, "stores");

  // find paths to all the sales files
  const salesFiles = await findSalesFiles(salesDir);
  console.log(salesFiles);
}

main();
```
