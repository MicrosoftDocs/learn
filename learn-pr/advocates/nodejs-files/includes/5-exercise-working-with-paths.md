In the previous exercise, you wrote a stunning program that iterates through any folder that it's given to find any of the `sales.json` files inside. In this exercise, you'll use the "path" module to improve that program, ensure that it will run in any folder and will find any file with a `.json` extension.

## Using the current directory

In the current `index.js` code, you are passing the static location of the "stores" folder. We'll change that code to use the `__dirname` value instead of passing a static folder name.

1. Click on the `index.js` file to open it.

1. On line 4, create a variable to store a path to the "stores" directory, using the `__dirname` constant.

   ```javascript
   function main() {
     const salesDir = path.join(__dirname, "stores");

     const salesFiles = findSalesFiles(salesDir);
     console.log(salesFiles);
   }
   ```

1. Press <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> to save the file.

1. Execute the program from the command line

   ```bash
   node index.js
   ```

   Notice that the path that is now listed for the files is the full system path. This is because the `__dirname` constant returns the full path to the current location.

   ```bash
   [
     '/home/username/node-files/stores/201/sales.json',
     '/home/username/node-files/stores/202/sales.json',
     '/home/username/node-files/stores/203/sales.json',
     '/home/username/node-files/stores/204/sales.json',
   ]
   ```

## Joining paths

Instead of concatenating folder names to make a new path to search, you'll change the code to use the `path.join` method so that this code will work across operating systems.

1. On line 27 of the `index.js` file, change the `findFiles` method to use `path.join`.

   ```javascript
   // search this directory for files (this is recursion!)
   findFiles(path.join(folderName, item.name));
   ```

1. Press <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> to save the file.

1. Execute the program from the command line

   ```bash
   node index.js
   ```

   The output will be the same as the previous step, but the program is now more robust because it uses `path.join` instead of concatenating strings.

## Finding all .json files

Instead of looking for just `sales.json` files, this program needs to search for any JSON file that might be present. To do that, use the `path.extname` method to check the file extension.

1. Execute the following command in the terminal to rename the "stores/201/sales.json" file to "stores/sales/totals.json".

   ```bash
   mv stores/201/sales.json stores/201/totals.json
   ```

1. On line 30 of the `index.js` file, change the `if` statement to check just the file extension. Use the `path.join` method to compose the full path to the file.

   ```javascript
   if (path.extname(item.name) === ".json") {
     // store the file path in the salesFiles array
     salesFiles.push(path.join(folderName, item.name));
   }
   ```

1. Press <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> to save the file.

1. Execute the program from the command line

   ```bash
   node index.js
   ```

   The output now shows all of .json files that are in any of the store id directories.

   ```bash
   [
      '/home/username/node-files/stores/201/totals.json',
      '/home/username/node-files/stores/202/sales.json',
      '/home/username/node-files/stores/203/sales.json',
      '/home/username/node-files/stores/204/sales.json'
   ]
   ```

Great job! You've used the "path" and `__dirname` constant to make the program much more robust. Next, you'll need to follow Tailwind Traders "best practices" for working with sales files which dictates that you move all of the files to a working directory before you do anything with them. In the next section, you'll learn how to create directories and move files between locations.

### Got Stuck?

If you got stuck at any point in this exercise, here is the completed code. Remove everything in `index.js` and replace it with this solution.

```javascript
const fs = require("fs");
const path = require("path");

function findSalesFiles(folderName) {
  // this array will hold sales files as they are found
  let salesFiles = [];

  function findFiles(folderName) {
    // read all the items in the current folder
    const items = fs.readdirSync(folderName, { withFileTypes: true });

    // iterate over each found item
    items.forEach((item) => {
      // if the item is a directory, it will need to be searched
      if (item.isDirectory()) {
        // call this method recursively, appending the folder name to make a new path
        findFiles(path.join(folderName, item.name));
      } else {
        // Make sure the discovered file is a .json file
        if (path.extname(item.name) === ".json") {
          // store the file path in the salesFiles array
          salesFiles.push(path.join(folderName, item.name));
        }
      }
    });
  }

  findFiles(folderName);

  return salesFiles;
}

function main() {
  const salesDir = path.join(__dirname, "stores");

  // create the salesTotal directory if it doesn't exist
  if (fs.existsSync(salesTotalsDir) === false) {
    fs.mkdirSync(salesTotalsDir);
  }

  // find paths to all the sales files
  const salesFiles = findSalesFiles(salesDir);
  console.log(salesFiles);
}

main();
```
