There are many things you can do when interacting with the file system like:

- Read/write files
- Read/write directories
- Read stats on a file
- Working with permissions

You interact with the file system using the built-in module `fs`. To use it import it, like so:

```javascript
const fs = require('fs')
```

## I/O operations

Here is a selection of operations you can carry out on files/directories that exist on the `fs` module.

- `readFile()`, reads the file content asynchronously
- `appendFile()`, adds data to file if it exists, if not then file is created first
- `copyFile()`, copies the file
- `readdir()`, reads the content of a directory
- `mkdir()`, creates a new directory,
- `rename()`, renames a file or folder,
- `stat()`, returns the stats of the file like when it was created, how large it is in Bytes and other info,
- `access()`, check if file exists and if it can be accessed

All the above methods exist as synchronous versions as well. All you need to do is to append the `Sync` at the end, for example `readFileSync()`.

## Async/Sync

All operations come in synchronous and asynchronous form. Node.js is single-threaded. The consequence of running synchronous operations is therefore we are blocking anything else from happening. This results in much less throughput than if your app was written in an asynchronous way.

### Synchronous operation

In a synchronous operation, you are effectively stopping anything else from happening. As a consequence, this might make your program less responsive. A synchronous file operation should have *sync* as part of the operation name, like so:

```javascript
const fileContent = fs.readFileSync('/path/to/file/file.txt', 'utf8');
console.log(fileContent);
```

### Asynchronous operation

An Asynchronous operation is nonblocking. The way Node.js deals with asynchronous operations are by using a callback model. What essentially happens is that Node.js doesn't wait for the operation to finish. What you can do is to provide a callback, a function, that will be invoked once the operation has finished. This gives rise to something called a *callback pattern*.

Below follows an example of opening a file:

```javascript
const fs = require('fs');

fs.open('/path/to/file/file.txt', 'r', (err, fileContent) => {
  if (err) throw err;
  fs.close(fd, (err) => {
    if (err) throw err;
  });
});
```

Above we see how we provide a function as our third argument. The function in itself takes an error `err` as the first argument. The second argument is usually data as a result of the operation, in this case the file content.
