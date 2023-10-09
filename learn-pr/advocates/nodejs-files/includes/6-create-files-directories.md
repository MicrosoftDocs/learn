Creating and deleting new files and directories programmatically is a common requirement for line-of-business applications.

So far, you've learned how to work with files and directories by using the *fs* module. You can also use the *fs* module to create, delete, copy, move, and otherwise manipulate files and directories on a system programmatically.

Here, you learn how to use the *fs* module to create directories and files.

## Create directories

The `mkdir` method allows creation of directories. The following method creates a folder called *newDir* inside the *201* folder.

```javascript
const fs = require("fs").promises;
const path = require("path");

await fs.mkdir(path.join(__dirname, "stores", "201", "newDir"));
```

The file structure */stores/201* must already exist, or this method fails. You can pass in an optional `recursive` flag if the file structure doesn't exist and you want the operation to create it.

```javascript
await fs.mkdir(path.join(__dirname, "newDir", "stores", "201", "newDir"), {
  recursive: true
});
```

## Make sure directories exist

If the directory you're trying to create already exists, the `mkdir` method throws an error. That situation isn't good because the error causes your program to stop abruptly. To avoid that situation, Node.js recommends you wrap the `mkdir` method in a `try/catch` if you plan (as we do) to manipulate the file or directory after you open it.

```javascript
const pathToCreate = path.join(__dirname, "stores", "201", "newDirectory");

// create the salesTotal directory if it doesn't exist
try {
  await fs.mkdir(salesTotalsDir);
} catch {
  console.log(`${salesTotalsDir} already exists.`);
}
```

## Create files

You can create files by using the `fs.writeFile` method. This method takes in a path to the file, and the data that you want to write to the file. If the file already exists, it's overwritten.

For instance, this code creates a file called *greeting.txt* with the text "Hello World!" inside.

```javascript
const pathToFile = path.join(__dirname, "greeting.txt");
await fs.writeFile(pathToFile, "Hello World!");
```

If you omit the last parameter, which is the data to be written to the file, Node.js writes "undefined" to the file. That situation is probably *not* what you would ever want. To write an empty file, pass an empty string. An even better option would be to pass the `String` function, which effectively does the same thing without leaving empty quotes in your code.

```javascript
const pathToFile = path.join(__dirname, "greeting.txt");
await fs.writeFile(pathToFile, String());
```

In the next exercise, you'll use your knowledge of how to create files and directories to extend the program to create a directory that will store the total of all sales files.
