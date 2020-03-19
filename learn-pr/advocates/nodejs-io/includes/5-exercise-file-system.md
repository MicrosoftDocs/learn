In this exercise we will learn how to work with the module `fs` to do things such as

- Read/Write files, we will learn how to do so in asynchronous and synchronous way
- List stats, we will learn how to list stat information on a file
- Open directory, here we will learn how to open up a directory and list it's file content

Pre-steps

1. Create a directory for your app
2. Navigate to your directory `cd <name of dir>`
3. Now create a JavaScript file that will contain your code, suggestion is `app.js`
4. In the same directory create a file `info.txt` and give it some sample data if you want
5. In the same directory create a folder `sub` and within create the files `a.txt`, `b.txt` and `c.txt`
Now your directory structure should look like this:

```bash
app.js
info.txt
sub -|
---| a.txt
---| b.txt
---| c.txt
```

## Read/Write files

First, start by giving your `app.js` file the following content on the top:

```javascript
const fs = require('fs');
const path = require('path');
```

Now we will work primarily with the module `fs`, but we will need the module `path` for helping us construct a path later in the exercise.

Now, add the following content to `app.js`:

```javascript
try {
  const fileContent = fs.readFileSync('info.txt', {
    encoding: 'utf8'
  });
  console.log(`Sync Content: ${fileContent}`);
} catch (exception) {
  console.error(`Sync Err: ${exception.message}`);
}

console.log('After sync call');
```

Above we are using the *synchronous* version of opening a file. We can see that through the use of a method ending in *sync*.

Follow this up by adding the asynchronous version, like so:

```javascript
fs.readFile('info.txt', (err, data) => {
  if (err) {
    console.log(`Async Error: ${err.message}`);
  } else {
    console.log(`Async Content: ${data}`);
  }
})

console.log('After async call');
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output

```bash
Sync Content: info
After sync call
After async call
Async Content: info
```

Note above how the text `After sync call` is printed right after it lists the file content from our synchronous call. Additionally note how text `After async call` is printed *before* `Async Content: info`. This means anything asynchronous happens last. This is an important realization about asynchronous operations, they may be non-blocking but they don't complete right away. So if order is important you should be looking at constructs such Promises and Async/await.

## List stats

For various reasons you may want to list detailed information on a specific file/directory. For that we have `stat()` method. This also comes in a asynchronous/synchronous version.

To use it, add the following code:

```javascript
fs.stat('info.txt', (err, stats) => {
  if (err) {
    console.error(`Err ${err.message} `);
  } else {
    const {
      size,
      mode,
      mtime
    } = stats;
    console.log(`Size ${size}`);
    console.log(`Mode ${mode}`);
    console.log(`MTime ${mtime}`);
    console.log(`Is directory ${stats.isDirectory()}`);
    console.log(`Is file ${stats.isFile()}`);
  }
})
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output

```bash
Size 4
Mode 33188
MTime Mon Mar 16 2020 19:04:31 GMT+0100 (Central European Standard Time)
Is directory false
Is file true
```

Results above may vary depending on what content you have in your file `info.txt` and when it was created.

## Open directory

Lastly, we will open up a directory using the method `readdir()`. This will produce an array of files/directories contained within the specified directory:

```javascript
fs.readdir(path.join(__dirname, 'sub'), (err, files) => {
  if (err) {
    console.error(`Err: ${err.message}`)
  } else {
    files.forEach(file => {
      console.log(`Open dir, File ${file}`);
    })
  }
})
```

Above we are constructing a directory path using the method `join()` from the `path` module, like so:

```javascript
path.join(__dirname, 'sub')
```

`__dirname` is a built-in variable and simply means the executing directory. The method call means we will look into a directory `sub` relative to where we are executing the code.

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output

```bash
Open dir, File a.txt
Open dir, File b.txt
Open dir, File c.txt
```
