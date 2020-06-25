You can use Node.js to find and return information about files and folders.

Tailwind Traders has many physical stores all over the world. Each night, these stores create a file called "sales.json" that contains the total for all their sales for the previous day. These files are organized in folders by store ID.

In this exercise, you're going to write a Node.js program that can search for files called "sales.json" in a given folder.

## Sign into the sandbox

Make sure you activate the Microsoft Learn sandbox by clicking the "Activate Sandbox" at the top of this page.

## Clone exercise

1. Run the following command in the Cloud Shell pane on the right:

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

1. Create a new method called "findSalesFiles" that takes a "folderName" parameter

   ```javascript
   function findSalesFiles(folderName) {
     // FIND SALES FILES
   }
   ```

1. Add an array at the top which will hold the paths to all the sales files the program finds.

   ```javascript
   function findSalesFiles(folderName) {
     // this array will hold sales files as they are found
     let salesFiles = [];

     // FIND SALES FILES
   }
   ```

1. Create a method within this function called "findFiles" that also takes a "folderName" parameter.

   ```javascript
   function findSalesFiles(folderName) {
     // this array will hold sales files as they are found
     let salesFiles = [];

     function findFiles(folderName) {
       // FIND SALES FILES
     }
   }
   ```

   This new method "findFiles" is created inside of the main "findSalesMethod" so that it can execute as many times as necessary to find all the sales files and populate the "salesFiles" array. The "folderName" is the path to the current folder.

1. Inside of the "findFiles" method, read the "currentFolder" path with the `readdirsync` method.

   ```javascript
   function findSalesFiles(folderName) {
     // this array will hold sales files as they are found
     let salesFiles = [];

     function findFiles(folderName) {
       // read all the items in the current folder
       const items = fs.readdirSync(folderName, { withFileTypes: true });

       // FIND SALES FILES
     }
   }
   ```

1. Add a block to loop over each item returned from the `readdirsync` method.

   ```javascript
   function findSalesFiles(folderName) {
     // this array will hold sales files as they are found
     let salesFiles = [];

     function findFiles(folderName) {
       // read all the items in the current folder
       const items = fs.readdirSync(folderName, { withFileTypes: true });

       // iterate over each found item
       items.forEach((item) => {
         // FIND SALES FILES
       });
     }
   }
   ```

1. Add an "if" statement to determine if the item is a file or a directory.

   ```javascript
   function findSalesFiles(folderName) {
     // this array will hold sales files as they are found
     let salesFiles = [];

     function findFiles(folderName) {
       // read all the items in the current folder
       const items = fs.readdirSync(folderName, { withFileTypes: true });

       // iterate over each found item
       items.forEach((item) => {
         if (item.isDirectory()) {
           // FIND SALES FILES IN THIS FOLDER
         } else {
           // FIND SALES FILES
         }
       });
     }
   }
   ```

1. If the item _is_ a directory, call the "findFiles" method again, passing in the path to the item. If it's not, add a check to make sure the item name matches "sales.json".

   ```javascript
   function findSalesFiles(folderName) {
     // this array will hold sales files as they are found
     let salesFiles = [];

     function findFiles(folderName) {
       // read all the items in the current folder
       const items = fs.readdirSync(folderName, { withFileTypes: true });

       // iterate over each found item
       items.forEach((item) => {
         if (item.isDirectory()) {
           // search this directory for files (this is recursion!)
           findFiles(`${folderName}/${item.name}`);
         } else {
           // Make sure the discovered file is a sales.json file
           if (item.name === "sales.json") {
             // store the file path in the salesFiles array
             salesFiles.push(`${folderName}/${item.name}`);
           }
         }
       });
     }
   }
   ```

1. Call this new "findSaleFiles" function from the "main" method, passing in the "stores" folder name as the location to search for files.

   ```javascript
   function main() {
     const salesFiles = findSalesFiles("stores");
     console.log(salesFiles);
   }
   ```

## Execute the program

1. Enter the following command into the Cloud Shell to run the program...

   ```bash
   node index.js
   ```

1. The program should show the following output...

   ```bash
   [
    'stores/201/sales.json',
    'stores/202/sales.json',
    'stores/203/sales.json',
    'stores/204/sales.json',
   ]
   ```

Excellent! You've successfully written a command-line program that will traverse any directory and find all the "sales.json" files inside.

However, the way that the path to subfolders was constructed in this example is a little clumsy because it requires concatenating strings together. That's not bad, it's just that there's a better way to work with paths in Node.js. In the next section, you'll learn how to do just that using the "path" module.

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
          salesFiles.push(`${folderName}/${item.name}`);
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
