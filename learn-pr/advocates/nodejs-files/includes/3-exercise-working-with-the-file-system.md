Tailwind Traiders has a lot of brick and morter locations. Each night, these locations write a file called `sales.json` to a folder that has an id that corresponds to their store id. This file contains their sales totals for the whole day. In this exercise, you're going to write a Node.js function which can take a central location and then find all of the `sales.json` files inside it, no matter where they are.

## Sign into the sandbox

Make sure you activate the Microsoft Learn sandbox by clicking the "Activate Sandbox" at the top of this page.

## Clone exercise

1. Copy the following command into the Sandbox and press "enter".

   ```bash
   git clone https://github.com/burkeholland/node-files && cd node-files
   ```

1. Open the Cloud Shell editor by typing the following command in the Cloud Shell and pressing "enter".

   ```bash
   code .
   ```

1. Expand the "stores" folder and each of the numbered folders inside.

   :::image type="content" source="../media/folder-structure.png" alt-text="project folder structure":::

## Find the sales.json files

You're going to need to find all of those files given only the top-most location - the stores folder.

### Including the "fs" module

1. Click on the "index.js" file to open it in the editor.

1. Include the "fs" module at the top of the file.

   ```javascript
   const fs = require("fs");
   ```

1. Create a `main` method. This method will be the entry point for your code. The last line of code in this file will invoke the `main` method.

   ```javascript
   const fs = require("fs");

   function main() {}

   main();
   ```

### Write a method to find the `sales.json` files

1. Copy the following method and paste it above the "main" function.

   ```javascript
   function findSalesFiles(folderName) {
     // this array will hold sales files as they are found
     let salesFiles = [];

     function findFiles(folderName) {
       // read all the items in the current folder
       const items = fs.readdirSync(folderName, { withFileTypes: true });

       // iterate over each found item
       items.forEach((item) => {
         // if the item is a directory, it will need to be searched for files
         if (item.isDirectory()) {
           // search this directory for files (this is recursion!)
           findFiles(`${folderName}/${item.name}`);
         } else {
           // Make sure the discovered file is a sales.json file
           if (item.name === "sales.json") {
             // store the file path in the salesFiles array
             salesFiles.push(path.join(folderName, item.name));
           }
         }
       });
     }

     // find the sales files
     findFiles(folderName);

     // return the array of found file paths
     return salesFiles;
   }
   ```

2. Call this new function from the "main" method, passing in the "stores" folder name as the location to search for files. Here is the completed code for the exercise.

   ```javascript
   function main() {
     const salesFiles = findSalesFiles("stores");
     console.log(salesFiles);
   }
   ```

## Execute the program

1. Press <kbd>Cmd</kbd>/<kbd>Ctrl</kbd> + <kbd>S</kbd> to save the `index.js` file.

1. Close the Cloud Shell editor by pressing <kbd>Ctrl</kbd> + <kbd>Q</kbd>.

1. Enter the following command into the Cloud Shell to run the program...

   ```bash
   node index.js
   ```

1. The program should show the following output...

   ```bash
   [
    '/home/username/node-files/stores/201/sales.json',
    '/home/username/node-files/stores/202/sales.json',
    '/home/username/node-files/stores/203/sales.json',
    '/home/username/node-files/stores/204/sales.json',
   ]
   ```

Excellent! You have successfully written a command line program that will traverse any directory that it is given and find the "sales.json" files inside. However, the way that the path to the right folder was constructed in this example is a little clumsy - it requires appending a lot of strings together. There is a preferred way to work with paths in Node.js. In the next section you'll learn how to do just that using the "path" module.

### Got Stuck?

If you got stuck at any point in this exercise, here is the completed code. Remove everything in `index.js` and replace it with this solution.

```javascript
const fs = require("fs");

function findSalesFiles(folderName) {
  // this array will hold sales files as they are found
  let salesFiles = [];

  function findFiles(folderName) {
    // read all the items in the current folder
    const items = fs.readdirSync(folderName, { withFileTypes: true });

    // iterate over each found item
    items.forEach((item) => {
      // if the item is a directory, it will need to be searched for files
      if (item.isDirectory()) {
        // search this directory for files (this is recursion!)
        findFiles(`${folderName}/${item.name}`);
      } else {
        // Make sure the discovered file is a sales.json file
        if (item.name === "sales.json") {
          // store the file path in the salesFiles array
          salesFiles.push(path.join(folderName, item.name));
        }
      }
    });
  }

  // find the sales files
  findFiles(folderName);

  // return the array of found file paths
  return salesFiles;
}

function main() {
  const salesFiles = findSalesFiles("stores");
  console.log(salesFiles);
}

main();
```
