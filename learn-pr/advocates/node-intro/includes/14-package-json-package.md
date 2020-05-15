You will build different kinds of applications with Node.js. Sometimes you might want to author a library that you either want to reuse within your company or distribute to NPM so anyone can download it.

## Setup your Node.js project

There are things you want to do when it comes to preparing your Node.js project to be shared. This part involves changes fields within the `package.json` file. Here's a list of things you need to think about:

- **Specify files to include in package**,  the NPM will include/exclude some files by default but you might want to customize what goes into the package.
- **Prepare for docs**, there are certain fields that will be read and displayed at NPM so consumers of your library can find the GitHUb repo to file issues or read more on how to use your library.
- **Decide on license**, depending on what license you set the consumer of your project will be either able to use it freely or with restrictions. A common choice of license here is the MIT license that enables users to use the code as is.

### Define your package

There's a `files` property in the `package.json`. This is an array structure where you specify what should be included. The default value is `*` which says to include all files. There exist some exceptions to what files/directories always gets included/excluded. Examples of files that are always included are `package.json`, `README`, `LICENSE` and much more. Excluded examples are files starting with a dot, `.` or files that pertains to Node and NPM and are helper files and not part of your project.
Additionally the files `.npmignore` and `.gitignore` are looked at to specify what files/ directories should be excluded from a package.

Additionally you should set the `main` field to the entry point of your application.

### Prepare for docs

A lot of the fields in a `package.json` files are used if you want to distribute your Node.js project as a package. Setting those fields becomes mandatory or strongly recommended in that context. Here are some of those fields:

- **version**, the `version` property governs what version your Node.js project is currently. If you plan to publish your Node.js project as a package this is something you need to fill in. Updates to your project should not only mean updating the code but also increment the version number in a predictable way. Having this approach is called semantic versioning. You will learn more about semantic versioning in the Updating chapter in this module.
- **license**, This communicates to the consumers of your library how it can be used. There are different types of licenses. A common one is MIT which give you the right to use the software as is.
- **contributors**, this field should list all the authors of a library.
- **bin**, If your project is either a CLI tool that should be a single executable or if you have a larger project with many executable files you will want to install those executable files in into the PATH - specifying this field will do that for you.
- **repository**, this field should point to where the code exist. That could be a GitHub repository URL for example.

## Developing a package, use `npm link`

## Creating a package, use `npm pack`

## Upload to NPM

## Maintain your project

contributors, issues, versioning
