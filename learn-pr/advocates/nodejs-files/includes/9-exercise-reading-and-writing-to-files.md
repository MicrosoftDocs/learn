You're almost finished creating a Node.js masterpiece for Tailwind Traders. So far, your code reads any given directory, finds all ".json" files, and creates a "totals.txt" file. In this exercise, you'll complete the project by reading the ".json" files, adding up the store totals, and writing the grand total to the "totals.txt" file.

## Create method to calculate sales totals

1. At the top of `index.js`, just below the `require("path")` statement, create a function that will calculate the sales total. This method should take in the array of file paths that it can iterate over.

   ```javascript
   function calculateSalesTotal(salesFiles) {
     let salesTotal = 0;

     // READ FILES LOOP

     return salesTotal;
   }
   ```

1. Within that method, replace the "// READ FILES LOOP" with a loop that iterates over the "salesFiles" array, reads the file, parses the content as JSON, and then increments the "salesTotal" variable with the "total" value from the file.

   ```javascript
   function calculateSalesTotal(salesFiles) {
     let salesTotal = 0;
     // loop over each file path in the salesFiles array
     salesFiles.forEach((file) => {
       // read the file and parse the contents as JSON
       const data = JSON.parse(fs.readFileSync(file));
       // Add the amount in the data.total field to the salesTotal variable
       salesTotal += data.total;
     });
     return salesTotal;
   }
   ```

## Call the calculateSalesTotals Method

1. In the `main` function, add a call to the `calculateSalesTotals` function just above the `fs.writeFileSync` call.

   ```javascript
   function main() {
     const salesDir = path.join(__dirname, "stores");
     const salesTotalsDir = path.join(__dirname, "salesTotals");

     // create the salesTotal directory if it doesn't exist
     if (fs.existsSync(salesTotalsDir) === false) {
       fs.mkdirSync(salesTotalsDir);
     }

     // find paths to all the sales files
     const salesFiles = findSalesFiles(salesDir);

     // read through each sales file to cacluate the sales total
     const salesTotal = calculateSalesTotal(salesFiles);

     // write the total to the "totals.txt" file
     fs.writeFileSync(path.join(salesTotalsDir, "totals.txt"), String());
   }
   ```

## Write the total to the "totals.txt" file

1. In the `main` function, modify the `fs.writeFileSync` a block to write the value of the `salesTotal` variable to the "totals.txt" file.

   ```javascript
   function main() {
     const salesDir = path.join(__dirname, "stores");
     const salesTotalsDir = path.join(__dirname, "salesTotals");

     // create the salesTotal directory if it doesn't exist
     if (fs.existsSync(salesTotalsDir) === false) {
       fs.mkdirSync(salesTotalsDir);
     }

     // find paths to all the sales files
     const salesFiles = findSalesFiles(salesDir);
     console.log(salesFiles);

     // read through each sales file to cacluate the sales total
     const salesTotal = calculateSalesTotal(salesFiles);

     // write the total to the "totals.json" file
     fs.writeFileSync(
       path.join(salesTotalsDir, "totals.txt"),
       `${salesTotal}\r\n`,
       { flag: "a" }
     );
   }
   ```

1. Press <kbd>Cmd</kbd> / <kbd>Ctrl</kbd> + <kbd>S</kbd> to save the `index.js` file.

## Execute the program

1. Execute the program from the terminal.

   ```bash
   node index.js
   ```

   There is no output from the program. If you look in the "salesTotals/totals.txt", you will see the total of all the sales from the "sales.json" files.

1. Execute the program from the terminal again.

   ```bash
   node.index.js
   ```

1. Select the "index.js" file.

1. Select the "salesTotals/totals.txt" file.

   There is now a second line in the "totals.txt" file. Every time you run the program, the totals are added up again and a new line is written to the file.

Outstanding work! You've written a smart, robust, and handy tool that Tailwind Traders can use to process all of its stores sales every night. You make this stuff look easy. In the next section, we'll review what you learned, and a few tips to remember as you head on your merry way.

## Got stuck?

If you got stuck during this exercise, here is the full code for this project.

```javascript
const fs = require("fs");
const path = require("path");

function calculateSalesTotal(salesFiles) {
  let salesTotal = 0;
  // loop over each file path in the salesFiles array
  salesFiles.forEach((file) => {
    // read the file and parse the contents as JSON
    const data = JSON.parse(fs.readFileSync(file));
    // Add the amount in the data.total field to the salesTotal variable
    salesTotal += data.total;
  });
  return salesTotal;
}

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
  const salesTotalsDir = path.join(__dirname, "salesTotals");

  // create the salesTotal directory if it doesn't exist
  if (fs.existsSync(salesTotalsDir) === false) {
    fs.mkdirSync(salesTotalsDir);
  }

  // find paths to all the sales files
  const salesFiles = findSalesFiles(salesDir);

  // read through each sales file to cacluate the sales total
  const salesTotal = calculateSalesTotal(salesFiles);

  // write the total to the "totals.json" file
  fs.writeFileSync(
    path.join(salesTotalsDir, "totals.txt"),
    `${salesTotal}\r\n`,
    { flag: "a" }
  );
}

main();
```
