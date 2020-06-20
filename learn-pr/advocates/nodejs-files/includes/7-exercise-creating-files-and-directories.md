So far you've created a robust command line application in Node.js that can read any folder structure that it's given to find any files with a `.json` extension. You'll need to read those files summarize the data in them and then write the totals to a new file in a new directory called "salesTotals". In this exercise, you'll create the "salesTotals" directory and "sales.json" file where the sales totals will eventually go.

## Create the "salesTotals" directory

1. In the `main` function, create a variable called "salesTotalsDir" which holds the path of the "salesTotals" directory.

   ```javascript
   function main() {
     const salesDir = path.join(__dirname, "stores");
     const salesTotalsDir = path.join(__dirname, "salesTotals");

     // path to the "salesTotals" directory
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

## Write the "totals.json" file

1. In the `main` function, add the code to create an empty file called "totals.json" inside the newly created "salesTotals" directory.

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

     // write an empty file called "totals.json"
     fs.writeFileSync(
       path.join(salesTotalsDir, "totals.json"), String());
     );
   }
   ```

1. Run the program by executing from the terminal prompt...

   ```bash
   node index.js
   ```

   There will be no output, but a new folder called "salesTotals" will be created. Inside, you should see a new file called "totals.json". That file will be empty.

## Complete code

If you got stuck during this exercise, here is the full code up to this point.

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

  // write the total to the "totals.json" file
  fs.writeFileSync(
    path.join(salesTotalsDir, "totals.json"),
    JSON.stringify(salesTotal)
  );
}
```

This looks awesome! Great job! You're almost finished. The last step is to read the sales files, add up the totals inside and write that total to the new "totals.json" file. That sounds like a lot, but reading files in Node.js is pretty easy. Next you'll learn how to read and parse data inside of files.
