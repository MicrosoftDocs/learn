Node.js provides a built-in module for working with the file system. It's called the "fs" module. This is short for, you guessed it, "File System". The "fs" module is include by default in Node which means you don't need to install it from npm. This can be a bit confusing because you can't actually see this module in your file system or in your "node_modules" folder. It's simply part of the Node.js runtime. So how do you include the "fs" module in a project? You reference it just like you would any other dependency. You just have to know that it exists in Node and that you can use it. And now you do!

```javascript
const fs = require("fs");
```

The "fs" module allows you to do various operations on files and directories. It has quite a few methods to pick from. For right now, we're just going to focus on what you need to know to work with directories using the "fs" module.

## Listing contents in a directory

One of the things that you'll do with the "fs" module quite a bit is list out or "enumerate" the contents in a given directory. For instance, Tailwind Traders has a root folder called "sales" and in that folder are subfolders organized by store id. Inside those folders are the sales total files. The whole structure look like this...

```
📂 documents
    📂 letters
    📂 pictures
    📄 image.png
    📄 invoice.docx
```

To read through the contents of the , you can use the `readdir` method. Like most operations on the "fs" module, you use "readdir" both synchronously and asyncronously.

### Listing contents asynchronously

When you call an asynchronous method, it means that Node.js isn't going to wait for the operation to complete before it moves to the next line of code. You'll need to provide a "callback" which will execute when the asynchronous process is finished. Unless you specifically choose a sync operation on the "fs" module, the operation will be asynchronous.

The "readdir" returns a list of items

```javascript
fs.readdir("documents", (err, items) => {
  if (err) {
    console.log(err);
  }
  console.log(items); // [ image.png, invoice.docx, letters, pictures ]
});
```

### List contents synchronously

Synchronous methods cause Node.js to wait until the operation is finished before it moves to the next line.

```javascript
const items = fs.readdirSync("documents");
console.log(items); // [ image.png, invoice.docx, letters, pictures ]
```

Notice the order of the results returned by `readdir` and `readdirsync` methods. They are alphabetical.

## Determing content type

When you read the contents of a directory, you get back both folders and files as an array of strings. You can determine which ones are files vs which ones are directories by passing in the `withFileTypes` option. This will return an array of `Dirent` objects instead of an array of strings. The `Dirent` object has `isFile` and `isDirectory` methods that you can use to determine what type of object you are dealing with.

```javascript
const items = fs.readdirSync("documents", { withFileTypes: true });
items.forEach((item) => {
  const type = item.isDirectory() ? "folder" : "file";
  console.log(`${item.name}: ${type}`);
  // image.png: file, invoice.docx: file, letters: folder, pictures: folder
});
```

## A note about recursion

Oftentimes, you'll be given a folder with subfolders that have files and you will be asked to traverse these folders and find the files inside. To do that, you'll have to determine if an item is a folder, and then traverse that folder. You'll have to repeat this for every folder that you find.

You can do this by calling the same method over and over again everytime you find a folder, passing in the full path to the folder. When a method calls itself, that's called "recursion".

```javascript
function findFiles(folderName) {
  const items = fs.readdirSync(folderName, { withFileTypes: true });
  items.forEach((item) => {
    if (item.isDirectory()) {
      // this is a folder, so call this method again and pass in
      // the path to the folder
      findFiles(`${folderName}/{item.name}`);
    } else {
      console.log(`Found file: ${item.name} in folder: ${folderName}`);
    }
  });
}

findFiles("documents");
```

Recursion is a powerful feature of many programming languages, and one you will likely use a lot in the real world. Like in the next exercise!

In the next exercise, you'll use the "fs" module to dynamically read through Tailwind Traders main "stores" directory to find all of the "sales.json" files.
