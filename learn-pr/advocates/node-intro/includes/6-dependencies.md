Node.js comes with a lot of core libraries handling anything from handling files to HTTP to Compressing files and more. There is however a huge eco system out there with third party libraries. These libraries can be easily installed and used in your application thanks to the NPM, the Node Package Manager. 

## What is NPM

NPM, the Node Package Manager is a command line tool but also an online repository. The NPM command line tool is part of the installation as you install Node.js. The online repository holds both public and private libraries. You can browse for libraries at `http://npmjs.org` but you can also do the same from the command line. Installing libraries from NPM makes them end up in `node_modules/` folder. Packages can be installed locally as well as globally. The main difference is that locally installed packages end up in `node_modules/` folder, where you ran the command. Globally installed packages is installed so all Node.js applications can access it. All globally installed modules end up in the same place and the exact place varies per OS. We will talk more about this in part 8 of this module.

## Commands

The NPM command line tool has quite a few commands.

To list them all type `npm --help`. Let's list a subset of commands to get a feeling for what the tool allows us to do:

- `npm install -g npm@latest`, this command upgrades our NPM tool to the latest version.
- `npm --version`, this command lists the version of NPM we are currently on.
- `npm install` or `npm i`, this command installs a library to our project or installs it globally if we provide the flag `-g` or `--global`
- `npm init`, this command initiates a wizard that helps you initialize a Node.js project. It will ask questions on name, license, git repository and more. The end result is a manifest file `package.json`. We will cover `package.json` more in section 11 of this module. This command comes with a flag `-y` that skips the wizard and just generates a `package.json` file based on defaults.
- `npm pack`, this will create a tarball of your project, a compressed file. The tarball can be installed with `npm install <name of tarball>`. During creation of the tarball it reads the `package.json` file for things such as what files to include/exclude, what to name the tarball and more. This is an essential command to use when developing your own package.
- `npm config`, this command allows you to configure settings on the NPM installation. An example of this is for example changing where global installations end up. You can list what path is set for that with `npm config get prefix` and set a new path with `npm config set prefix=<new path>`.
- `npm upgrade`, with aliases `update` and `up`. This command upgrades packages to the latest version. It does respect semver and tags which means it will look in your `package.json` file and see what pattern you have specified on how you want things upgraded. This command can be run with a package name as an argument in which case it only attempts to updated that package. It can also be run with a global flag `-g` in which case it will attempt to upgrade packages that are globally installed over your local project.
- `npm uninstall` with aliases `remove`, `rm`, `r`, `un`, `unlink` removes the package from your system.

## dependencies vs dev dependencies

We think of dependencies as belonging to one of two different categories:

1. dependencies, these are dependencies we need to build our application. Examples of this is a framework like `Express` which we can use to build a web application.
2. dev dependencies, these are dependencies we only need when we develop our application. Examples of this is for example test runners and libraries. Those are an important part of ensuring our application works well but we don't need to ship our application with them.

Our NPM tool lets us specify what dependency should end up in what bucked through the use of the flag `--save` with the alias `-s`. By using this flag an installed package will be classified as a dev dependency.


