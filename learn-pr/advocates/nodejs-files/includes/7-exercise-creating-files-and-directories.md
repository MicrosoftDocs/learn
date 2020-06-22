So far you've created a robust command-line application in Node.js that can read any folder structure that it's given to find any files with a `.json` extension. You'll need to read those files summarize the data in them and then write the totals to a new file in a new directory called "salesTotals". In this exercise, you'll create the "salesTotals" directory and "totals.txt" file where the sales totals will eventually go.

## Create the "salesTotals" directory

1. In the `main` function, create a variable called "salesTotalsDir", which holds the path of the "salesTotals" directory.

   ```javascript
   function main() {
     const salesDir = path.join(__dirname, "stores");
     const salesTotalsDir = path.join(__dirname, "salesTotals");

     // find paths to all the sales files
     const salesFiles = findSalesFiles(salesDir);
   }
   ```

1. In the `main` function, add code to create the directory if it doesn't already exist.

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
   }
   ```

## Write the "totals.txt" file

1. In the `main` function, add the code to create an empty file called "totals.txt" inside the newly created "salesTotals" directory.

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

     // write an empty file called "totals.txt"
     fs.writeFileSync(
       path.join(salesTotalsDir, "totals.txt"), String());
     );
   }
   ```

1. Run the program by executing from the terminal prompt...

   ```bash
   node index.js
   ```

   There will be no output, but a new folder called "salesTotals" will be created. Inside, you should see a new file called "totals.txt". That file will be empty.

Your code looks awesome! Great job!

You're almost finished. The last step is to read the sales files, add up the totals, and write the grand total to the new "totals.txt" file. Next you'll learn how to read and parse data inside of files.

## Got stuck?

If you got stuck during this exercise, here is the full code up to this point.

```javascript
const fs = require("fs");
const path = require("path");

function calculateSalesTotal(salesFiles) {
  let salesTotal = 0;
  salesFiles.forEach((file) => {
    const data = JSON.parse(fs.readFileSync(file));
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

  // write the total to the "totals.txt" file
  fs.writeFileSync(
    path.join(salesTotalsDir, "totals.txt"), String());
  );
}

main();
```
