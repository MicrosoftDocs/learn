In the previous exercise, you wrote a stunning program that iterates through any folder that it's given to find any of the `sales.json` files inside. In this exercise, you'll use the "path" module to improve that program, ensure that it will run in any folder and will find any file with a `.json` extension.

## Using the current directory

In the current `index.js` code, you are passing the static location of the "stores" folder. We'll change that code to use the `__dirname` value instead of passing a static folder name.

1. Click on the `index.js` file to open it.

1. On line 4, use the `__dirname` constant instead of the static "stores" value.

    ```javascript
    function main() {
      findSales(__dirname);
    }
    ```

1. Press <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> to save the file.

1. Execute the program from the command line

    ```bash
    node index.js
    ```

    Notice that the path that is now listed for the files is the full system path. This is because the `__dirname` constant returns the full path to the current location.

## Joining paths

Instead of concatenating folder names to make a new path to search, you'll change the code to use the `path.join` method so that this code will work across operating systems.

1. On line 12 of the `index.js` file, change the `findSales` method to use `path.join`.

    ```javascript
    // call this method again, appending the folder name to make a new path
    findSales(path.join(folderName, item.name));
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

1. On line 15 of the `index.js` file, change the `if` statement to check just the file extension.

    ```javascript
    if (path.extname(item.name) === ".json") {
      console.log(`Found ${item.name} in folder ${folderName}`);
    }
    ```

1. Press <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> + <kbd>S</kbd> to save the file.

1. Execute the program from the command line

    ```bash
    node index.js
    ```

    The output now shows all of .json files that are in any of the store id directories.

    ```bash
    Found totals.json in folder /Users/burkeholland/Dev/burkeholland/node-files/stores/201
    Found sales.json in folder /Users/burkeholland/Dev/burkeholland/node-files/stores/202
    Found sales.json in folder /Users/burkeholland/Dev/burkeholland/node-files/stores/203
    Found sales.json in folder /Users/burkeholland/Dev/burkeholland/node-files/stores/204
    ```

## Complete code for this exercise

If you got stuck anywhere in this exercise, you can copy and paste in this code which contains all of the changes.

    ```javascript
    const fs = require("fs");
    const path = require("path");
    
    function main() {
      findSales(__dirname);
    }
    
    function findSales(folderName) {
      const items = fs.readdirSync(folderName, { withFileTypes: true });
      items.forEach((item) => {
        if (item.isDirectory()) {
          // call this method again, appending the folder name to make a new path
          findSales(path.join(folderName, item.name));
        } else {
          if (path.extname(item.name) === ".json") {
            console.log(`Found ${item.name} in folder ${folderName}`);
          }
        }
      });
    }
    
    main();
    ```

Great job! You've used the "path" and `__dirname` constant to make the program much more robust. Next, you'll need to follow Tailwind Traders "best practices" for working with sales files which dictates that you move all of the files to a working directory before you do anything with them. In the next section, you'll learn how to create directories and move files between locations.