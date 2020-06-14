To access a file, you have to know what folder (or "directory") it resides in. Directories can be nested inside of each other. The location of a file on a system is called the file "path". For instance, if there was a file called "file.txt" that was inside a directory called "folder", which was inside another directory called "files", the file path would look like this...

```bash
/folder/files/file.txt
```

The path looks different depending on whether you are dealing with Linux-based or Windows-based operating system. On Windows the same path might look like this instead:

```bash
C:\folder\files\file.txt
```

## The Node.js path module

Paths can be tricky to figure out. This is because you frequently don't know the physical location on the system your program is running, so you can't know the path to your files. To help with this, Node.js offers a built-in module called the "path" module. This module is built-in to Node.js, and does not need to be installed as a dependency. It can be reference just by including it at the top of the file.

```javascript
const path = require("path");
```

The module `path` can help you with the following operations:

- Information - it can extract information from a path on things such as parent directory, filename, and file extension
- Join - you can get help joining two paths, so you don't have to worry about which OS your code is run on
- Absolute path - you can get help calculating an absolute path (the full path from the root of the file system)
- Normalization - you can get help calculating the relative distance between two paths.

In the next exercise, you'll see how Tailwind Traders structures their end of day sales files for each of their stores and how to use the "path" module to get information about that structure.
