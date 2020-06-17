
## Install and Upgrade - TODO

you start with installing

### Scenario 0

```bash
npm install lodash@1.0.0
```

Now we get `^1.0.0`. Running npm install on that installs `1.3.1` and updates to `^1.3.1` 

```bash
{
  "name":          "my-project",
  "version":       "1.0",                             // install   update
  "dependencies":  {                                  // ------------------
    "already-installed-versionless-module":  "*",     // ignores   "1.0" -> "1.1"
    "already-installed-semver-module":       "^1.4.3" // ignores   "1.4.3" -> "1.5.2"
    "already-installed-versioned-module":    "3.4.1"  // ignores   ignores
    "not-yet-installed-versionless-module":  "*",     // installs  installs
    "not-yet-installed-semver-module":       "^4.2.1" // installs  installs
    "not-yet-installed-versioned-module":    "2.7.8"  // installs  installs
  }
}
```

Summary: The only big difference is that an already installed module with fuzzy versioning ...

gets ignored by npm install
gets updated by npm update
Additionally: install and update by default handle devDependencies differently

npm install will install/update devDependencies unless --production flag is added
npm update will ignore devDependencies unless --dev flag is added

### Scenario 1

```bash
npm install lodash@1.0.0
```

then change `package.json` to `1.0.x`. This installs `1.0.2` but it also changes the pattern to 

```json
"dependencies": {
  "lodash": "^1.0.2"
}
```

which means if I now do `npm install lodash` or `npm upgrade lodash` this installs `1.3.1` an it changes the `package.json` entry to: 

```json
"dependencies": {
  "lodash": "^1.3.1"
}
```


### Scenario 2

```bash
npm install lodash@1.0.0
```

then `package.json` adds the following entry:

```json
"dependencies": {
  "lodash": "^1.0.0"
}
```

doing

```bash
npm install lodash
```

this installs `1.3.1`. That's the latest minor version and latest patch version. It also updated our `package.json` to:

```json
"dependencies": {
  "lodash": "^1.3.1"
}
```