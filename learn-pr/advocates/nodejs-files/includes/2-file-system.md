Tailwind Traders has each of its stores write its sales total to a file and send that file to a central location. To use those files, the company needs to create a batch process that can work with the file system.

Here, you learn how to use Node.js to read the file system to discover files and directories.

## Include the fs module

Node.js provides a built-in module, **fs** (short for _file system_), for working with the file system. Because it is part of the Node.js runtime, you don't need to install it; you reference it just as you would any other dependency. 

The **fs** module has a `promises` namespace that has `promise` versions of all methods. Using the `promise` namespace is the preferred way to work with the **fs** module because it allows you to use `async` to avoid the messiness of callbacks or the blocking of synchronous methods.

```javascript
const fs = require("fs").promises;
```

You can use the **fs** module to do various operations on files and directories. It has several methods to pick from. For now, we're going to focus on what you need to know to work with directories.

## List contents in a directory with fs.readdir

One task that you often do with the **fs** module is list out or *enumerate* the contents in a directory. For instance, Tailwind Traders, has a root folder called *stores*. In that folder are subfolders organized by store number. Inside those folders, are the sales-total files. The structure looks like this:

```
📂 stores
    📄 sales.json
    📄 totals.txt
    📂 201
    📂 202
```

To read through the contents of the folder, you can use the async `readdir` method. Most operations on the **fs** module have both synchronous (postpended with `Sync`) and asynchronous options. The results are returned in alphanumeric order.

```javascript
const fs = require("fs").promises;

async function main() {
    const items = await fs.readdir("stores");
    console.log(items);
}
main();
```

The alphanumeric-sorted list of items looks like this:

```console
[ '201', '202', '203', '204' ]
```

## Determine content type with isDirectory

When you read the contents of a directory, you get back both folders and files as an array of strings. You can determine which strings are files and which ones are directories by passing in the `withFileTypes` option. This option returns an array of `Dirent` objects instead of an array of strings. The `Dirent` object has `isFile` and `isDirectory` methods that you can use to determine what type of object you're dealing with.

```javascript
const fs = require("fs").promises;

async function main() {
    const items = await fs.readdir("stores", { withFileTypes: true });
    for (let item of items) {
        const type = item.isDirectory() ? "folder" : "file";
        console.log(`${item.name}: ${type}`);
    }
}
main();
```

The alphanumeric-sorted list of items looks like this:

```console
201: folder
202: folder
203: folder
204: folder
```

## A note about recursion

Often, you may need to work with complex directory structures that include multiple nested folders, each potentially containing more subfolders and files. In such cases, you need a way to navigate through this tree-like structure to find specific files.

To achieve this, you can create a function that identifies if an item is a folder. If it is, the function then searches within that folder for more files. This process is repeated for every folder that is found.

This is achieved by using a technique called *recursion*, where the function calls itself to search within the newly found folders. This allows the program to "walk" through the entire directory tree, reaching into every nested folder until all folders have been explored.


```javascript
const fs = require("fs").promises;

async function findFiles(folderName) {

    let results = []

    results.push(`${folderName}`);

    const items = await fs.readdir(folderName, { withFileTypes: true });

    for (const item of items) {
        if (item.isDirectory()) {

            // RECURSION - calling the function from within itself
            const resultsReturned = await findFiles(`${folderName}/${item.name}`);
            results = results.concat(resultsReturned);
        } else {
            results.push(`${folderName}/${item.name}`);
        }
    }

    return results;
}

findFiles("stores").then((results) => console.log(results));
```

The output looks like: 

```console
[
  'stores',
  'stores/201',
  'stores/201/sales.json',
  'stores/202',
  'stores/202/sales.json',
  'stores/203',
  'stores/203/sales.json',
  'stores/204',
  'stores/204/sales.json'
]
```

## Use a predefined development environment

This training module offers a development container, either in a browser or for your local computer. This container provides all the needed environment so you can use this training module without having to install an IDE or Node.js. You don't need to know anything about the container to complete this training module.