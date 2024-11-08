Node.js has built-in packages for tasks like file management and HTTP handling. But there's also a vast array of third-party packages offered on the NPM registry. 

## When and how to select an npm package

As a new developer at Tailwind Traders, you need to add functionality to a project. You could write the code yourself, but you decide to use an existing package. This development decision is a common scenario. 

When should you use an existing package? Here are some factors to consider:

* **Quality**: For tasks like security, using well-established packages ensures you're following best practices and handling edge cases.
* **Efficiency**: Writing your own code takes time. Using existing packages can save you significant effort.
* **Maintenance**: Libraries need updates and bug fixes. It's often more efficient to let an open-source team handle this.

Developers can find and download packages from various sources such as:

* **Registries**: Registries are collections of packages, like the npm registry. You can also host your own registry.
* **Repositories**: You can install packages directly from a GitHub URL.
* **Files**: Packages can be installed from a local folder or zipped file, useful for testing your own packages.
* **Directories**: You can also install directly from a directory.

Once you select a package, check its dependencies to consider the following factors:

* **Size**: More dependencies mean a larger footprint. Footprint size matters if you have bandwidth or hardware limitations. Remember, installing a package also installs its dependencies. This can result in a large node_modules folder.
* **Popularity**: A package's popularity can indicate its quality. 
* **Licensing**: If you plan to sell your software, ensure all dependency package licenses allow for reuse and resell.
* **Active maintenance**: Avoid dependencies that are deprecated or rarely updated.

To learn more about a package, visit their package page on NPM and their GitHub repository. You can also use the npm command: `npm view <package name>`.

## How to install a package

To install a package, use the **npm CLI** installed with Node.js. You can add a package to your Node.js project with the `npm install` command in the terminal.

```bash
npm install <name of package>
```

When you run the `install` command, the command-line tool connects to a global registry, fetches the code, and places it in a `node_modules` folder at the root of your project. 

Some **common switches** for the install command include: 
* For development-only packages, use `--save-dev`. This switch saves into the `devDependencies` property of `package.json`. These dependencies are usually format, lint, build, transpile, and test tools.
* For production-only packages, use `--production`. This switch excludes development-only packages.
* For globally available tools, use `-g`. Command-line tools are often installed globally instead of imported into projects. Global dependencies are installed in a system-wide directory, not in the proejct-level `node_modules`. However, global packages can clutter your system. The `npx` command solves this by temporarily installing packages. Use `npx <name>` to fetch a package, run it, and then remove it.

After the installation, your project directory looks like the following example:

```output
package.json
node_modules/
  <name of dependency>/
    <files included in the dependency>
src
  index.js
```

### npm CLI commands

The npm command-line tool has quite a few commands to help you with tasks like installing packages, authoring packages, and initializing Node.js projects. 

NPM commands fall into categories:

* **Manage dependencies**: Commands for installing, updating, and removing packages.
* **Run scripts**: Commands for managing development flows like testing and building code.
* **Configure environment**: Commands for setting up installation paths and package sources.
* **Author and publish packages**: Commands for creating and publishing packages.

If you want a detailed list of all commands, enter the following command in the terminal:

```bash
npm --help
```

### Verify installation

To see what's in your `package.json` folder, use `npm list`. The `npm list` command lists all the packages in the `node_modules` directory that were installed. Each installed package installed all of its own dependencies.

Because the `list` command can result in a long list, making it hard to understand, you can list packages at different depths with the list command. At depth `0`, the command lists the same content that you have in the `dependencies` section of your package.json.

```bash
npm list --depth=<depth>
```

If you installed the Jest package, `npm list --depth=0` produces output similar to this output:

```output
├── jest@26.0.1
```

## Clean up dependencies

If you no longer need a package, remove it. Removing a dependency keeps your project clean and saves space. This cleanup is especially important for Single Page Applications (SPAs) like Angular, React, or Vue. These apps bundle and compress code into a file served to the browser. The larger the file, the longer it takes to load, which can deter users.

There are two ways to clean up dependencies you no longer need:

- **Uninstall**: To uninstall a package, run the `npm uninstall <name of dependency>`. This command removes the package from the `package.json` manifest file and from the node_modules folder.
- **Prune**: Use `npm prune` to remove all unlisted dependencies from `node_modules`. Pruning is useful when you want to remove multiple dependencies without running uninstall for each. To prune:
    1. Delete the entries from dependencies or devDependencies in `package.json`.
    1. `run npm prune`.
