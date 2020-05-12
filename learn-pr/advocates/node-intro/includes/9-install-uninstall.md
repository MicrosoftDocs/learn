There are different ways to install a package, from a registry, from a file or even from a GitHub repository. You can also use use the public NPM registry as well as private registries on NPM and elsewhere.

## Ways of installing

The command `npm install --help` gives you all the different ways for installing a package. Currently the output looks like this:

```bash
npm install (with no args, in package dir)
npm install [<@scope>/]<pkg>
npm install [<@scope>/]<pkg>@<tag>
npm install [<@scope>/]<pkg>@<version>
npm install [<@scope>/]<pkg>@<version range>
npm install <alias>@npm:<name>
npm install <folder>
npm install <tarball file>
npm install <tarball url>
npm install <git:// url>
npm install <github username>/<github project>
```

### Scoping & Private registries

There are four different options above how to install a package that starts with the word `@scope`, what is that? All packages on the NPM registry needs to have a unique name. However if we *scope* our packages we can be more flexible on this. *Scoping* means that we add like a namespace to our packages that they group under. Packages can be scoped on user-level or org-level. Which it is depends on how you sign up to NPM as you can sign up as a user or as an organization.

Instead of your package having a globally unique name in the registry you now have package names looking like so `@my-company/my-package`. Scoped packages are private by default but can be made public if given a command-line flag.

This is a paid service on NPM but there are other providers out there that provides this service. You can even circumvent the need for a private registry and point to a private GitHub repository in your `package.json` file.

Scoping your packages and making them private is something you likely want to do if you create packages that are specific for your organization/company.

### Installing from files

Additionally to installing from a registry like NPM you can also install from a tarball, a compressed file. So when would I install from a tarball? One scenario is during the development of a Node.js library that your authoring. Once you want to test your library you can create the tarball in the fby typing `node pack`. Then you can place yourself in a project where you want to test out the library and install it like you would a package on NPM using the name of the package.

### Installing from GitHub

There are two ways of installing from GitHub either by using the Git URL or on the format of `<username>/<reponame>`

## Local versus global installs

You've learned that the package can come from a multitude of sources. There's another dimension to this namely where we install it:

- local installation, locally installed package end up under a `node_modules` directory in our project
- global installation, globally installed packages is globally available for all Node.js applications on your machine and as such is not installed in the project directory.

### Local installation

Local installations of a package normally end up in the `node_module` directory. We can configure this though so it ends up in a directory of our choosing. Most packages you install will be installed locally in your project. Locally installed packages are only usable for that project. Other Node.js project would need to install their own copies of those packages.

### Global installation

Globally installed packages are packages that are installed and available for all Node.js applications on your machine. They end up in an OS specific path that is not connected to any project. We can configure this path as well if we want to decide exactly where they should end up. So when should something be globally installed? Usually *generic* programs like http servers or CLI, command line interfaces make sense to install as a global package. What happens is the packages meant to be shipped globally is configured to produce an executable. Once installed globally this executable can be invoked from anywhere on your machine.

### NPX




