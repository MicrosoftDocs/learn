The most common way to install a dependency for your Node.js project is by installing it locally and from a global registry like the NPM. There are other ways to install the library on however and there's more places for a library to reside than a global registry. 

Individual developers might use the global registry at NPM to find and download packages they need for their apps. A company might have a whole strategy in place for what packages are ok to use and where to find them. For that reason packages might live in many different sources. Some of these sources might be publicly available and some might be restricted and only accessible for employees of a specific company. Here's a list of where packages might reside:

- **Registries**, an example of a registry might be a global registry like the NPM. It is possible to host your own registries that can be either private or public. NPM offers a service where your packages can be scoped. Using scoping solves two problems. The first is *name-collisions*. Scoped packages have a name prefix added to them, for example @my-company/my-package. The other problem it solves is by offering these packages to be *private* in the sense that they will not be listed or accessible in the public registry unless you explicitly state that you want it public. Scoped and private packages give companies a way to develop *company-specific* packages that only their employees are allowed to use.
- **Repositories**, instead of pointing to a registry it's possible to point out a GitHub URL and install the package from there.
- **Files**, a package can be installed from a zipped file. Installing from a package is a common scenario when you are trying to develop your own Node.js libraries and want to test it locally or you for some reason don't want to use a registry.

## Different ways to install

As mentioned above there are different ways to install a package. So far *local* installation to a specific project has been covered. What are the ways to install and when should you use it:

- **Local install**, local installation is the most common form of installation. You type `npm install <name of package>` and it ends up being installed to a `node_modules` directory.
- **Global install**, by providing a flag `-g` to the `install` command, a library will be installed and available to all Node.js projects on a specific machine. A global installation makes sense if you have a specific tool you want all projects to use.
- **NPX**, NPX was created partly to address the fact that it used to be hard to run a library as an executable. The only option was to install it globally, which would pollute the machine with libraries that you seldom would use. Also if you just wanted to use the library once or twice you would have to go through the motion of installing it, run it and the uninstalling it. NPX addressed that by downloading the library into memory, run the command and then remove itself once done.

### Local installation

Local installations of a package normally end up in the `node_module` directory. We can configure this though so it ends up in a directory of our choosing. Most packages you install will be installed locally in your project. Locally installed packages are only usable for that project. Other Node.js project would need to install their own copies of those packages.

### Global installation

Globally installed packages are packages that are installed and available for all Node.js applications on your machine. They end up in an OS-specific path that is not connected to any project. We can configure this path as well if we want to decide exactly where they should end up. So when should something be globally installed? Generic* programs like http servers or CLI, command-line interfaces make sense to install as a global package. What happens is the packages meant to be shipped globally is configured to produce an executable. Once installed globally this executable can be invoked from anywhere on your machine.

### NPX

NPX is an NPM package runner. It helps you run executable files that are hosted on the registry or in `node_modules/.bin`. The `.bin` directory is where executable files end up when a dependency is installed. One great thing about NPX is that it allows you to run an executable located on a registry without downloading it first. How this works is that NPX loads the needed code into the running Node process so there's no need to install anything on your machine. This fact makes NPX ideal to use if you just want to test out a library and see if it's something you want to use. In many cases, NPX therefore replaces the need to do a global install of a library.
