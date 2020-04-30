As a Node.js developer at Tailwind Traders you will most likely install packages at the start of but also during a the development of an app. Knowing how to install packages is a great thing to know as it enables you to build your application faster. You can incorporate the functioanlity of a dependency in your program instead of writing it yourself.

## Install/Uninstall packages with npm

To install a package with the NPM tool we use the command:

```bash
npm install <package name>
```

Run the following command to install the package `jest`:

```bash
npm install jest
```

This will have done four things:

1. Created a `package-lock.json` file, this is a file that contains information exactly on what packages are installed.
2. Created a directory `node_modules`, this is where all your locally installed packages will end up.
3. Added an executable `jest` to `node_modules/.bin`. This means we can invoke our package like a command line tool by typing `jest` in the terminal
4. Installed our package and its dependencies, it will have installed the package `jest` that we asked for. As part of how Node.js works it will have installed all dependencies that `jest` is dependant on. If you expand the `node_modules` directory you will see a lot more packages than just `jest`, that's all the dependencies.

### Check our installation

If you run the command `npm list` it will list all the packages in `node_modules/` directory that was installed. Every installed package will have installed all dependencies it relied on in turn.

As you can see from running `npm list` it becomes a very long and deep list. If you add the flag `depth` you will see how this response is filtered.

```bash
npm list --depth=1
```

It should produce a result similar to this:

```bash
└─┬ jest@25.4.0
  ├── @jest/core@25.4.0
  ├── import-local@3.0.2
  └── jest-cli@25.4.0 extraneous
```

It's very useful that we are able to list packages at different depths as sometimes we care about the full result and sometimes we just want to know the immediate dependencies as we do with the argument `--depth=1`.

### Cleaning up

We can uninstall the dependency we just installed by typing the following command:

```bash
npm uninstall jest
```

You should get an output similar to this:

```bash
removed 502 packages in 5.239s
found 0 vulnerabilities
```

As you can see `jest`, and its dependencies, was a fairly big thing to install but thanks to our `npm uninstall` command we managed to free up some space.

## Install a dev dependency

You are about to install the `jest` package once again but this time you will install it as a dev/developer dependency. To do that you will need to do two different things:

1. Create a `package.json` file, this manifest file will ensure we can save information on what is dependency and what's a dev dependency.
2. Run an install command with the flag `--save-dev` which indicates it's a dev dependency

### Create a package.json

You can use the `npm init -y` command to create a `package.json` file. Giving the `npm init` command the `-y` flag will ensure we are relying on defaults.

Type the following the terminal:

```bash
npm init -y
```

It should have created a `package.json` file with the following content:

```json
{
  "name": "exercises",
  "version": "1.0.0",
  "description": "",
  "main": "script.js",
  "dependencies": {},
  "devDependencies": {
    
  },
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```

### Install dependency

Type the following command in the terminal:

```bash
npm install jest --save-dev
```

Open up the `package.json` file and locate the `devDependencies` section. It should look like the below:

```json
"devDependencies": {
  "jest": "^25.4.0"
}
```

Above we have an entry `jest` that is specified as a key-value entry with its name and a pattern for which versions it will adhere to according to semantic versioning. How you author this pattern will be covered more in-depth in the next section in this module. To see the exact version that was installed we can open up the file `package-lock.json` and locate a section ` "jest": {`. This will tell you it installed the version `25.4.0`.

### Clean up

We have two ways we could be cleaning up:

1. Run `npm uninstall jest`
2. Remove the `jest` entry from `package.json` and run `npm prune`

Let's try the latter. Open up `package.json` and change the `devDependencies` section to:

```json
"devDependencies": {
}
```

Save the file and run the following command:

```bash
npm prune
```

This command will remove all orphaned packages. An orphaned package is a package that exist in the `node_modules/` directory but is not listed in the `dependencies` or `devDependencies` section of the `package.json` file.

You should see the following output:

```bash
removed 502 packages in 6.519s
found 0 vulnerabilities
```