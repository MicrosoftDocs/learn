So far, you've learned how to work with files, directories using the "fs" module. The "fs" module can also be used to create, delete, copy, move and otherwise manipulate files and directories on a system programatically.

## Creating directories

The `mkdir` and `mkdirsync` methods allow creation of directories. Just like with the `readdir` method, the `mkdir` function is asynchronous and requires a callback. The `mkdirsync` is synchronous and does not.

The following method creates a folder called "newDirectory" inside of the "201" folder.

```javascript
const fs = require("fs");
const path = require("path");

fs.mkdirsync(path.join(__dirname, "stores", "201", "newDir"));
```

Note that "/stores/201" must already exist, or this method will fail. You can pass in an optional "recursive" flag if you want the operation to create the file structure if it doesn't exist.

```javascript
fs.mkdirsync(path.join(__dirname, "newDir", "stores", "201", "newDir"), {
  recursive: true
});
```

## Making sure directories exists

If the directory that you're trying to create already exists, the `mkdirsync` method will throw an error. That's not good because you'll need to handle the error, or your program will terminate. To avoid that messy situation, you'll want to use the `existsSync` to ensure that the directory doesn't already exist.

```javascript
const pathToCreate = path.join(__dirname, "stores", "201", "newDirectory");
if (fs.existsSync(pathToCreate)) {
  console.log(`${pathToCreate} already exists`);
} else {
  fs.mkdirSync(pathToCreate);
}
```

## Creating files

Files can be created with the `fs.writeFile` and `fs.writeFileSync` methods. This method takes in a path to the file, and the data that you want to write to the file. If the file already exists, it will be overwritten.

For instance, this code creates a file called "greeting.txt" with the text "Hello World!" inside.

```javascript
fs.writeFileSync(path.join(__dirname, "greeting.txt", "Hello World!"));
```

If you omit the third parameter, which is the data to be written to the file, Node.js will write "undefined" to the file. That's probably _not_ what you would ever want. To write an empty file, pass an empty string. An even better option would be to pass the `String` function, which effectively does the same thing, but without empty quotes hanging out awkwardly in your code.

```javascript
fs.writeFileSync(path.join(__dirname, "greeting.txt", String()));
```

In the next exercise, you'll use your new found knowledge of how to create files and directories to extend the program to create a directory where the total of all sales files will be stored.
