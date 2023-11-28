Node.js has built-in packages for tasks like file management and HTTP handling. But there's also a vast array of third-party packages offered on the NPM registry. 

## When to select an npm package

Deciding whether to use a package involves considering:

* **Quality**: For tasks like security, using well-established libraries ensures you're following best practices and handling edge cases.
* **Efficiency**: Writing your own code takes time. Using existing libraries can save you significant effort.
* **Maintenance**: Libraries need updates and bug fixes. It's often more efficient to let an open-source team handle this.

## How to evaluate an npm package

Before installing a library, check its dependencies. Consider these factors:

* **Size**: More dependencies mean a larger footprint. This matters if you have bandwidth or hardware limitations. Remember, installing a package also installs its dependencies. This can result in a large node_modules folder.
* **Popularity**: A package's popularity can indicate its quality. 
* **Licensing**: If you plan to sell your software, ensure the library's license allows this.
* **Active maintenance**: Avoid dependencies that are deprecated or rarely updated.

To learn more about a package, visit their package page on NPM and their GitHub repository. You can also use the npm command: `npm view <package name>`.

## How to install a package

To install a package, use the **npm CLI** installed with Node.js. You can add a package to your Node.js project with the `npm install` command in the terminal.

```bash
npm install <name of package>
```

When you run the `install` command, the command-line tool connects to a global registry, fetches the code, and places it in a `node_modules` folder for your project. After the installation, your project directory looks like this:

```output
package.json
node_modules/
  <name of dependency>/
    <files included in the dependency>
src
  index.js
```

## How to depend on a package

Developers can find and download packages from various sources. These include:

* **Registries**: These are collections of packages, like the npm registry. You can also host your own.
* **Repositories**: You can install packages directly from a GitHub URL.
* **Files**: Packages can be installed from a local folder or zipped file, useful for testing your own libraries.
* **Directories**: You can also install directly from a directory.

### npm commands

So far, you've learned how you can install dependencies by using the npm tool. But this tool can do a lot more. The npm command-line tool has quite a few commands to help you with tasks like installing packages, authoring packages, and initializing Node.js projects. 

If you want a detailed list of all commands, enter the following command in the terminal:

```bash
npm --help
```

NPM commands fall into categories:

* **Manage dependencies**: Commands for installing, updating, and removing packages.
* **Run scripts**: Commands for managing development flows like testing and building code.
* **Configure environment**: Commands for setting up installation paths and package sources.
* **Author and publish packages**: Commands for creating and publishing packages.

## Production vs. development dependencies

Dependencies are either:

**Production** : Needed for your app to run. Examples include web frameworks.
**Development**: Only needed during development, like test or linting tools.
NPM differentiates these with a flag during installation. This places the dependency in either the dependencies or devDependencies section of the manifest file. All dependencies are stored in the `node_modules` directory.

The `--production`` flag installs only production dependencies. This is useful in CI/CD pipelines.

### How to install a package

Use `npm install <name>` to add a package to your project. For development-only packages, use --save-dev.

Some packages are installed globally with `-g`. These are often command-line tools, not imported into projects. They're installed in a system-wide directory, not node_modules.

However, global packages can clutter your system. npx solves this by temporarily installing packages. Use `npx <name>` to fetch a package, run it, and then remove it.

### Verify installation

To see what's in your `package.json` folder, use `npm list`. The `npm list` command lists all the packages in the `node_modules` directory that were installed. Each installed package has also installed all of its dependencies.

Because the `list` command can result in a long list, making it hard to understand,you can list packages at different depths with the list command. At depth `0`, the command lists the same content that you have in the `dependencies` section of your package.json.

```bash
npm list --depth=<depth>
```

If you installed the Jest package, `npm list --depth=0` will produce output similar to this output:

```output
├── jest@26.0.1
```

## Clean up dependencies

If you no longer need a package, remove it. This keeps your project clean and saves space. This is especially important for Single Page Applications (SPAs) like Angular, React, or Vue. These apps bundle and compress code into a file served to the browser. The larger the file, the longer it takes to load, which can deter users.

There are two ways to clean up dependencies you no longer need:

- **Uninstall**: To uninstall a package, run the `npm uninstall <name of dependency>`. This command removes the package from the manifest file and from the node_modules folder.
- **Prune**: Use `npm prune` to remove all unlisted dependencies from `node_modules`. This is useful when you want to remove multiple dependencies without running uninstall for each. To do this, first delete the entries from dependencies or devDependencies in package.json, then `run npm prune`.
