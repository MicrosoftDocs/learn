Creating and deleting new files and directories programmatically is a common requirement for line-of-business applications.

So far, you've learned how to work with files and directories by using the *fs* module. You can also use the *fs* module to create, delete, copy, move, and otherwise manipulate files and directories on a system programmatically.

Here, you'll learn how to use the *fs* module to create directories and files.

## Create directories

The `mkdir` method allows creation of directories. The following method creates a folder called *newDir* inside the *201* folder.

```javascript
const fs = require("fs").promises;
const path = require("path");

await fs.mkdir(path.join(__dirname, "stores", "201", "newDir"));
```

Note that */stores/201* must already exist, or this method will fail. You can pass in an optional `recursive` flag if the file structure doesn't exist and you want the operation to create it.

```javascript
await fs.mkdir(path.join(__dirname, "newDir", "stores", "201", "newDir"), {
  recursive: true
});
```

## Make sure directories exist

If the directory that you're trying to create already exists, the `mkdir` method will throw an error. That's not good because that error will cause your program to stop abruptly. To avoid that situation, Node.js recommends that you wrap the `mkdir` method in a `try/catch` if you plan  (as we do) to manipulate the file or directory after you open it.

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

You can create files by using the `fs.writeFile` method. This method takes in a path to the file, and the data that you want to write to the file. If the file already exists, it will be overwritten.

For instance, this code creates a file called *greeting.txt* with the text "Hello World!" inside.

```javascript
await fs.writeFile(path.join(__dirname, "greeting.txt", "Hello World!"));
```

If you omit the third parameter, which is the data to be written to the file, Node.js will write "undefined" to the file. That's probably _not_ what you would ever want. To write an empty file, pass an empty string. An even better option would be to pass the `String` function, which effectively does the same thing without leaving empty quotes in your code.

```javascript
await fs.writeFile(path.join(__dirname, "greeting.txt", String()));
```

In the next exercise, you'll use your knowledge of how to create files and directories to extend the program to create a directory that will store the total of all sales files.
