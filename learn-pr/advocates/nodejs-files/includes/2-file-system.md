Large retailers will often write data to files so that it can be processed later in batch.

At Tailwind Traders, they have each of their stores write their sales totals to a file and send that file to a central location. In order to work with those files, a batch process needs to be created that knows how to work with the file system.

Here you will learn how to use Node.js to read the file system to discover files and directories.

## Including the fs module

Node.js provides a built-in module for working with the file system. It's called the "fs" module. This is short for, you guessed it, "File System".

The "fs" module is included by default in Node.js, which means you don't need to install it from npm.

This can be a bit confusing because you can't actually see the "fs" module in your file system or in your "node_modules" folder. So how do you include the "fs" module in a project? You reference it just like you would any other dependency. The "fs" module has a "promises" namespace that has promise versions of all methods. This is the preferred way to work with the "fs" module as it allows you to use `async`, and avoids the messiness of callbacks or the blocking of synchronous methods.

```javascript
const fs = require("fs").promises;
```

The "fs" module allows you to do various operations on files and directories. It has quite a few methods to pick from. For right now, we're just going to focus on what you need to know to work with directories using the "fs" module.

## Listing contents in a directory

One of the things that you'll do with the "fs" module quite a bit is list out or "enumerate" the contents in a given directory. For instance, Tailwind Traders has a root folder called "stores" and in that folder are subfolders organized by store number. Inside those folders are the sales total files. The whole structure look like this...

```
📂 stores
    📄 sales.json
    📄 totals.txt
    📂 201
    📂 202
```

### Listing contents

To read through the contents of the folder, you can use the `readdir` method. Most operations on the "fs" module have both synchronous and asynchronous options.

The "readdir" returns a list of items

```javascript
const items = await fs.readdir("stores");
console.log(items); // [ 201, 202, sales.json, totals.txt ]
```

Notice the order of the results returned by `readdir` and `readdirsync` methods: they are in alphabetical order.

## Determining content type

When you read the contents of a directory, you get back both folders and files as an array of strings. You can determine which ones are files vs which ones are directories by passing in the `withFileTypes` option. This will return an array of `Dirent` objects instead of an array of strings. The `Dirent` object has `isFile` and `isDirectory` methods that you can use to determine what type of object you are dealing with.

```javascript
const items = await fs.readdir("stores", { withFileTypes: true });
for (let item of items) {
  const type = item.isDirectory() ? "folder" : "file";
  console.log(`${item.name}: ${type}`);
  // 201: folder, 202: folder, sales.json: file, totals.txt: file
}
```

## A note about recursion

A common requirement is to have folder with subfolders, which also have subfolders. Somewhere in this tree of nested folders are files that you need. You need a program that can walk that folder tree to find the files. To do that, you'll have to determine if an item is a folder, and then search that folder for files. You'll have to repeat this for every folder that you find.

You can search nested directory structures by having a method that finds folders and then calls itself to find folders inside those folders. In this way, the program will "walk" the directory tree until it reads every folder inside. When a method calls itself, that's called "recursion".

```javascript
function findFiles(folderName) {
  const items = await fs.readdir(folderName, { withFileTypes: true });
  items.forEach((item) => {
    if (item.isDirectory()) {
      // this is a folder, so call this method again and pass in
      // the path to the folder
      findFiles(`${folderName}/${item.name}`);
    } else {
      console.log(`Found file: ${item.name} in folder: ${folderName}`);
    }
  });
}

findFiles("stores");
```

Recursion is a powerful feature of many programming languages, and one you'll likely use a lot in the real world. Like in the next exercise!

In the next exercise, you'll use the "fs" module to dynamically read through Tailwind Traders main "stores" directory to find all of the "sales.json" files.
