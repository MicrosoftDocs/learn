A file path represents where a directory or file is located in your file system. It can look like this:

```bash
/path/to/file.txt
```

The path looks different depending on whether we are dealing with Linux based or Windows based operating system. On Windows the same path might look like this instead:

```bash
C:\path\to\file.txt
```

We need to take this into account when developing our application.

For this w have the built-in module `path` that we can use like so:

```javascript
const path = require("path");
```

The module `path` an help us with the following operations:

- Information, it can extract information from our path on things such as parent directory, filename and file extension
- Join, we can get help joining two paths so we don't have to worry about which OS our code is run on
- Absolute path, we can get help calculating an absolute path
- Normalization, we can get help calculating the relative distance between two paths.
