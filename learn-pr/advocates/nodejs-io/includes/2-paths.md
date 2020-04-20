A file path represents where a directory or file is located in your file system. It can look like this:

```bash
/path/to/file.txt
```

The path looks different depending on whether we are dealing with Linux-based or Windows-based operating system. On Windows the same path might look like this instead:

```bash
C:\path\to\file.txt
```

You need to take this into account when developing your application.

For this you have a built-in module `path` that you can use like so:

```javascript
const path = require("path");
```

The module `path` can help you with the following operations:

- Information - it can extract information from our path on things such as parent directory, filename, and file extension
- Join - you can get help joining two paths so you don't have to worry about which OS your code is run on
- Absolute path - you can get help calculating an absolute path
- Normalization - you can get help calculating the relative distance between two paths.
