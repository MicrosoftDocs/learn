Working with file paths can get fairly unwieldy. In the previous exercise, it wasn't too bad because we didn't have a lot of folders to traverse. However, if you had a lot of files or folders, manually building paths can get tedious. To help with that, Node.js provides some built-in constants and utlities that you can use to work with files paths.

## Determining the current directory

Sometimes you don't know the directory where you program will run. You need it to just use the name of the current directory. Node.js exposes this via the constant `__dirname`. When I say "constant", what I mean is that you can just reference that variable anywhere in your code and it will contain the full path of whatever the current directory you are working in is.

```javascript
console.log(__dirname);
```

If you executed that code from the "documents" folder in the following folder structure...

```
📂 home
    📂 username
        📂 documents
```

...the `_dirname` value will be "/home/username/documents".

## Working with paths

Paths are a subject that comes up so frequently, Node.js includes a module called "path" specifically for working with paths. Just like the "fs" module, it ships with Node.js and doesn't need to be installed to be used. You just need to reference it at the top of your file...

```javascript
const path = require("path");
```

### Joining paths

The "path" module works with the concept of file and folder paths, which are really just strings. For instance, if you you wanted to get the path to the "stores/201" folder, you can use the path module to do that.

```javascript
console.log(path.join("stores", "201")); // stores/201
```

The reason why you would use this instead of just concatenating strings, is that your program may run on Windows or Linux. The "path" module will always format paths for your system. In the example above, `path.join` would return "stores\201" on Windows, with a backslash instead of a slash.

### Determining file extensions

The path module can also tell you what the extension of a given file is. If you had a file and you wanted to identify if it was a JSON file or not, you can use the `path.ext` method.

```javascript
console.log(path.extname("sales.json"));
```

> [!TIP]
> Note the "path" module doesn't care whether or not things actually exist. Paths are conceptual, not physical. It's just building and parsing strings for you.

### Getting everthing you need to know about a file or path

The "path" modoule contains a lot of different methods which do various things. However, you can get most of the information that you need about a path or file by using the "parse" method. This returns an object that contains the current directory you are in, the name of the file, the file extension, and even the name of the file without the extension.

```javascript
console.log(path.parse("stores/201/sales.json"));
// { root: '', dir: 'stores/201', base: 'sales.json', ext: '.json', name: 'sales' }
```

There are many more useful utility methods on the "path" module, but these are the core concepts that you will likely use the most often. In the next exercise, you'll use the "path" module to compose paths and identify .json files.
