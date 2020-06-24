Node.js comes with a lot of core libraries handling anything from handling files to HTTP to Compressing files and more. There is however a huge eco system out there with third party libraries. These libraries can be easily installed and used in your application thanks to the NPM, the Node Package Manager. 

## What is NPM

NPM, the Node Package Manager is a command line tool but also an online repository. The NPM command line tool is part of the installation as you install Node.js. The online repository holds both public and private libraries. You can browse for libraries at `http://npmjs.org` but you can also do the same from the command line. Installing libraries from NPM makes them end up in `node_modules/` folder. Packages can be installed locally as well as globally. The main difference is that locally installed packages end up in `node_modules/` folder, where you ran the command. Globally installed packages is installed so all Node.js applications on your machine can access it. All globally installed modules end up in the same place and the exact place varies per OS.

## Commands

The NPM command line tool has quite a few commands. The commands help you with an array of different tasks like installing packages to help you author your package, to initialize a Node.js project and more. It's not necessary to know all the commands in detail. Starting out with Node.js you are more likely to only use a subset of all commands. As you expand your usage of Node.js you might use more and more commands within a variety of categories.

It's helpful to think of the commands as belonging to different categories to remember what they do:

- **Managing dependencies**, there are a number of commands covering install, uninstall and cleaning up after package installs. Additionally there are commands for updating packages as well.
- **Run scripts**, the NPM tool is capable of helping you manage different flows in your application development. Examples of application flows are running tests, building your code or running quality improving tools to *lint* your code.
- **Configure environment**, there are many things you can configure like where your installs end up but also from where packages should be installed. It's quite common that you might have  a set up where you want packages both from the global NPM registry but also from a company specific registry.
- **Package authoring and publishing**, there are several commands that will help you with tasks such as create a compressed package and also help you in pushing said package to a registry.

Should you want a full detailed list of all the commands you can type `npm --help` in the terminal.

## dependencies vs dev dependencies

We think of dependencies as belonging to one of two different categories:

- **dependencies**, these are dependencies we need to build our application. Examples of this is a framework like `Express` which we can use to build a web application.
- **dev dependencies**, these are dependencies we only need when we develop our application, think of these as you would scaffolding for a building. Examples of such dependencies are test libraries, linting tools or bundling tools. Those are an important part of ensuring our application works well but we don't need to ship our application with them.

Our NPM tool lets us specify what dependency should end up in what bucket through the use of a flag. By specifying `--save-dev` a package will end up as *dev dependency*.

## Package Dependencies

Before you install a library you might want to inspect what dependencies it consist of. The reason this might be interesting is that it might encourage or deter you from using the package. Here are some factors worth considering when selecting a dependency for your project:

- **Size**, the sheer number of dependencies might put together become a very large footprint. If you are on a limited bandwidth or have other hardware limitations, this might be a concern.
- **Licensing**, for a company this might be interesting if it's producing a software they intend to sell. Having a license on a 3rd party library that doesn't allow for this might put you in a bad situation.
- **Actively maintained**, if your package relies on a dependency that has been deprecated or hasn't seen any updates for a long time this might be a red flag.

You can learn more about a package prior to install by navigating to the URL `https://www.npmjs.com/package/<package name>`. This will take you to a detailed page for that package. To check dependencies, select the `dependencies` tab section and see how many and which other packages it relies on to function. Another way to achieve a similar result is to type the NPM command `npm view <package name>`.

When it comes to dependencies this might not tell the whole truth. If you actually download a package you might end up with a `node_modules` folder containing thousands of packages. Why is that? Every package has a list of dependencies and to ensure you can use a package, all dependencies are crawled and downloaded when you hit the `npm install <package name>` command.

### After install

What's listed in the `dependencies` section of your `package.json` and what's in the `node_modules` folder will differ. If you want to see exactly what packages are in the `node_modules` folder you can type `npm list`. This might be a long list though and it might be hard to get a grasp of what you have in there. To help with this it's possible to list packages at different depths. The `list` command then looks like so:

```bash
npm list --depth=<depth>
```

At depth `0` it will list the same content as what you have in your `dependencies` section in your `package.json`. Given that you have installed the `jest` package `npm list --depth=0` will produce an output similar to this:

```output
├── jest@26.0.1
```

If you run the command `npm list` it will list all the packages in `node_modules/` directory that was installed. Every installed package will have installed all dependencies it relied on in turn.

Depth `1` means that you want to see one level down, namely your installed packages and what primary dependencies they consist of. Running `npm list --depth=1` might produce an output like so:

```output
├─┬ jest@26.0.1
│ ├── @jest/core@26.0.1
│ ├── import-local@3.0.2
│ └── jest-cli@26.0.1
```

The idea is clear, the higher the `depth` number the more dependent packages you will see.
