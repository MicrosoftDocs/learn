Node.js comes with many core libraries handling anything from managing files to HTTP to compressing files and more. There is however a huge ecosystem out there with third-party libraries. These libraries can be easily installed and used in your application thanks to the NPM, the Node Package Manager. 

Node.js and its ecosystem use the word *dependency* a lot. So what is a dependency? A dependency is a third-party library, a piece of reusable code that accomplishes something and can be added to your application. The third-party library is something your application *depends on* to function, hence calling it a dependency.

The third-party library can be thought of as a package and stored on a registry. A package is therefore a collection of files needed to run one or many modules. A package consist of one more many modules you can import into your application so you can take advantage of its features.

## How do I know if I need a package

So how do you know if you need a package for your project? That's a complicated question that relies on a few factors namely:

- **Should I write this code**, asking yourself if you are dealing with an area like security, for example, and you are trying to implement authentication and authorization. It's a topic that is important to *get right* to protect your data and your customer's data. There are standard patterns out there and libraries used by many developers. These libraries have implemented features you most likely will always need and are good at patching issues as they arise. You should use such libraries instead of reinventing the wheel. The main reason is that you are likely to do a less good job of writing it yourself as there are so many edge cases that need to be considered.  
- **Saving time**, you could probably build most things yourself like utility libraries or UI component libraries but it takes time. Even if the end result is comparable to what's out there, it's not a good use of your time to *reinvent the wheel*, if you don't have to.
- **Maintenance**, all libraries, and apps need maintaining sooner or later. Maintaining it means adding new features but also correcting bugs. Is it a good use of your or your teams time to maintain a library or is it better to let an OSS (Open Source Software) team handle it?

## Adopting a package

Before you install a library, you might want to inspect what dependencies it relies on. The reason these dependencies might be interesting is that it might encourage or deter you from using the package. Here are some factors worth considering when selecting a dependency for your project:

- **Size**, the sheer number of dependencies might put together become a large footprint. If you are on a limited bandwidth or have other hardware limitations, this fact might be a concern.
- **Licensing**, for a company, licensing might be interesting if its producing software they intend to sell. Having a license on a third-party library that doesn't allow for the library to be included in software you intend to sell, means the company can be put you in a bad legal situation.
- **Actively maintained**, if your package relies on a dependency that has been deprecated or hasn't seen any updates for a long this fact might be a red flag.

You can learn more about a package prior to install by navigating to the URL `https://www.npmjs.com/package/<package name>`. This link will take you to a detailed page for that package. To check dependencies, select the `dependencies` tab section and see how many and which other packages it relies on to function. Another way to achieve a similar result is to type the NPM command `npm view <package name>`.

When it comes to the listed dependencies, the sheer number might not tell the whole truth. If you actually download a package, you might end up with a `node_modules` folder containing thousands of packages. Why is that? Every package has a list of dependencies and to ensure you can use a package, all dependencies are crawled and downloaded when you hit the `npm install <package name>` command.

## Install a package

The way you install a package is by using a built-in command-line tool called NPM. By invoking the  command in a terminal, you can add a package to your Node.js project. A typical install command look like so `npm install <name of package>`. So what happens when you type the `install` command? The command-line tool connects to a global registry and fetches the code and places it in a `node_modules` directory of your project. After install, your project directory looks something like so:

```bash
-| node_modules/
---| <name of dependency>/
------| <files included in the dependency>
```

## Where to find a package

Individual developers might use the global registry at NPM to find and download packages they need for their apps. A company might have a whole strategy in place for what packages are ok to use and where to find them. For that reason, packages might live in many different sources. Some of these sources might be publicly available and some might be restricted and only accessible for employees of a specific company. Here's a list of where packages might reside:

- **Registries**, an example of a registry might be a global registry like the NPM one. It is possible to host your own registries that can be either private or public.
- **Repositories**, instead of pointing to a registry it's possible to point out a GitHub URL and install the package from there.
- **Files**, a package can be installed from a local folder or zipped file. Installing from a package is a common scenario when you are trying to develop your own Node.js libraries and want to test it locally or you for some reason don't want to use a registry.
- **Directory**, you can install right from a directory as well.
  
### The NPM registry and tool

When you type `npm install <name of dependency>`, Node.js goes to a global registry called the NPM registry and looks for the code to download. It's located at `http://npmjs.org` and is page where you can browse for packages as well, if you visit the page using a browser. The site holds packages, zipped versions of source code.  Every package has a dedicated website you can go to, to learn more on where the source code resides, and numerous other information like metrics on downloads and maintenance for example.

### NPM commands

So far you've learned how you can install dependencies using the NPM tool but it can do a lot more. In fact, the NPM command-line tool has quite a few commands. The commands help you with an array of different tasks like installing packages to help you author your package, to initialize a Node.js project and more. It's not necessary to know all the commands in detail. Starting out with Node.js you are more likely to only use a subset of all commands. As you expand your usage of Node.js, you might use more and more commands within a variety of categories.

It's helpful to think of the commands as belonging to different categories to remember what they do:

- **Managing dependencies**, there are a number of commands covering install, uninstall, and cleaning up after package installs. Additionally there are commands for updating packages as well.
- **Run scripts**, the NPM tool is capable of helping you manage different flows in your application development. Examples of application flows are running tests, building your code, or running quality improving tools to *lint* your code.
- **Configure environment**, there are many things you can configure like where your installs end up but also from where packages should be installed. It's common that you might have  a setup where you want packages both from the global NPM registry but also from a company-specific registry.
- **Package authoring and publishing**, there are several commands that will help you with tasks such as create a compressed package and also help you in pushing said package to a registry.

Should you want a full detailed list of all the commands you can type `npm --help` in the terminal.

## Production vs development dependencies

We think of dependencies as belonging to one of two different categories:

- **Production dependencies**, this type of dependency represents dependencies we need to run our application in production. Examples of content in this section are a web framework like, with which you can build web application.
- **Development dependencies**, this section represents dependencies we only need when we develop our application. Think of these dependencies as you would scaffolding for a building, when you are done building, you don't need them anymore. Examples of such dependencies are test libraries, linting tools, or bundling tools. Nonetheless, these dependencies are an important part of ensuring our application works well, but we don't need to ship our application with them.

This separation is not only conceptual. The NPM tool writes to a manifest file by adding entries to it when you download a dependency. The tool allows you to differ between the two types of dependencies by adding a flag to the install command. What this flag does it to place the name of a dependency and its version, in a section called `dependencies` or `devDependencies`. This behavior gives you a clear mental separation of what dependencies you have in your application and what type they are. Regardless of what type of dependency you installed, it still gets stored in the `node_modules` directory but the manifest file is where it differs.  

Additionally this separation of different types of dependencies is built into the NPM command-line tool as well. By specifying the `--production` flag when installing, you ensure that only `devDependencies` are being installed. This flag is used by for example CI/CD pipelines to ensure only the needed parts for the app to run is installed.

### How to install a package

A normal dependency meant to be used as part of your application, is installed using the `npm install <dependency name>`. The developer dependency is something that's not meant to be shipped to production. The way to install a developer dependency is by adding the flag `--save-dev`.

There's also packages that you can install *globally*. These packages are not something that's usually not meant to be imported into your project. For that reason, many global packages are CLI tools. Some of these packages allow themselves to be imported however like `http-server` for example.

Installing something globally means that it's not installed in a project's `node_modules` directory but a machine-specific directory so it's available for all Node.js projects on that machine. The way to install such packages is by adding the flag `-g` to the `install command` so the command would look like so instead `npm install <dependency name> -g`.

However, The tool NPX was created in part to address the fact that globally installed dependencies take up space after many them have been installed over time. On many operating systems, a globally installed tool needs to be given elevated permissions to be installed as well. The main point is still that numerous the global dependencies carry out tasks that you most likely want to perform seldom. There is therefore little need for these tools to be on your machine other than on a temporary basis. What NPX does is therefore to allow you to load in the dependency into the Node.js process and execute the command from there. After done executing, the dependency would be cleaned up and removed from your system. The NPX tool has been shipped with all major versions of NPM since version 5.2. NPX is the preferred way to use dependencies that are meant to be run seldom. To use the NPX tool just type `npx <name of package>`, it will take care of fetching the dependency and carrying out the command, and clean up.

### After install

What's listed in the `dependencies` section of your `package.json` and what's in the `node_modules` folder will differ. If you want to see exactly what packages are in the  folder, you can type `npm list`. This command might produce a long list though and it might be hard to get a grasp of what you have in there. To help with this fact, it's possible to list packages at different depths. The `list` command then looks like so:

```bash
npm list --depth=<depth>
```

At depth 0, it will list the same content as what you have in your `dependencies` section in your `package.json`. Given that you have installed the `jest` package `npm list --depth=0` will produce an output similar to the below:

```output
├── jest@26.0.1
```

If you run the command, npm list` it will list all the packages in `node_modules/` directory that was installed. Every installed package will have installed all dependencies it relied on in turn.

Depth `1` means that you want to see one level down, namely your installed packages and what primary dependencies they consist of. Running `npm list --depth=1` might produce an output like so:

```output
├─┬ jest@26.0.1
│ ├── @jest/core@26.0.1
│ ├── import-local@3.0.2
│ └── jest-cli@26.0.1
```

The idea is clear, the higher the `depth` number the more dependent packages you will see.

## Cleaning up

You are likely to sooner or later run into a scenario where you no longer need a package or you need a package other than the one you installed, that perhaps solve the task better. Regardless of the reason, you want to ensure you remove dependencies that are not used anymore. The arguments for that is except for keeping things clean, is also that it takes up space. The *space* argument becomes more apparent if you are building a SPA application with a framework like Angular, React, or Vue. Such an application is also a Node.js project and part of building the app is taking it through a *bundling* and *minification* process where different Node.js modules are concatenated and the source code is compressed. The resulting bundle/s ends up being served from a Browser. The larger that bundle is the longer it will take to send over the network before it ultimately becomes something the user can interact with. The longer the user has to wait the more likely they are to not want to use your app again.

There are two ways you can clean up dependencies you no longer want to use:

- **Uninstalling**, to uninstall a package you use the uninstall command like so `npm uninstall <name of dependency>`. This command will remove the package from the manifest file but also from the `node_modules` directory.
- **Pruning**, by running the command prune like so `npm prune` it will remove all dependencies in the `node_modules` directory that are not listed as dependencies in the manifest file. This command can be good to use if you want to remove more than one dependency and don't want to run the `uninstall` command for each dependency. Used in that way you would remove entries from the `dependencies` or `devDependencies` section and the run the `npm prune` command.
