As a new developer at Tailwind Traders, you need to know how to manage paths to files and folders. If you have many files or folders, manually building paths can get tedious. Node.js provides some built-in constants and utilities to make file paths easier.

## Determine the current directory with __dirname

Sometimes, you don't know which directory your program is running in. You just want it to use the path of the current directory. 

```
📂 stores
    📂 201
        📂 sales
```

Node.js exposes the full path to the current directory via the constant `__dirname`.

```javascript
console.log(__dirname);
```

If you run that code from the *sales* folder in the following folder structure, the `_dirname` value is:

```console
/stores/201/sales
```

## Work with paths with path module

Paths are a subject that comes up so frequently that Node.js includes a module called **path** specifically for working with paths.

Just like the **fs** module, the **path** module ships with Node.js and doesn't need to be installed. You just need to reference it at the top of your file.

```javascript
const path = require("path");
```

### Join paths with path.join

The **path** module works with the concept of file and folder paths, which are just strings. For instance, if you want to get the path to the *stores/201* folder, you can use the **path** module to do that.

```javascript
const currentPath = path.join("stores", "201");
console.log(currentPath); // stores/201

const fullPath = path.join(__dirname, "stores", "201");
console.log(fullPath); // /nodejs-files/stores/201

```

The reason why you would use the **path** module instead of concatenating strings is that your program might run on Windows or Linux. The **path** module formats paths correctly for whatever operating system it's running on. In the preceding example, `path.join` would return `stores\201` on Windows, with a backslash instead of a slash.

### Determine filename extensions with path.extname

The **path** module can also identify the extension of a filename. If you have a file and you want to identify if it's a JSON file, you can use the `path.extname` method.

```javascript
console.log(path.extname("sales.json"));
```

The output is:

```console
.json
```

> [!TIP]
> The **path** module doesn't care whether or not things actually exist. Paths are conceptual, not physical. It's just building and parsing strings for you.

### Get everything you need to know about a file or path

The **path** module contains many different methods that do various things. However, you can get most of the information that you need about a path or file by using the `parse` method. This method returns an object containing: the current directory you're in, the name of the file, the filename extension, and even the name of the file without the extension.

```javascript
const currentPath = path.parse("stores/201/sales.json")
console.log(currentPath);

const fullPath = path.join(__dirname, "stores", "201", "/sales.json");
console.log(path.parse(fullPath));
```

Output is: 

```console
{
  root: '',
  dir: 'stores/201',
  base: 'sales.json',
  ext: '.json',
  name: 'sales'
}
{
  root: '/',
  dir: '/workspaces/node-essentials/nodejs-files/stores/201',
  base: 'sales.json',
  ext: '.json',
  name: 'sales'
}
```

There are many more useful utility methods on the **path** module, but the methods explained here are the core concepts that you're likely to use most often. In the next exercise, you'll use the **path** module to compose paths and identify .json files.
