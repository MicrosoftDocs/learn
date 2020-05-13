You will build different kinds of applications with Node.js. Sometimes you might want to author a library that you either want to reuse within your company or distribute to NPM so anyone can download it.

## Share your Node.js project

A lot of the fields in a `package.json` files are used if you want to distribute your Node.js project as a package. Setting those fields becomes mandatory or strongly recommended in that context. Here are some of those fields:

- **version**, the `version` property governs what version your Node.js project is currently. If you plan to publish your Node.js project as a package this is something you need to fill in. Updates to your project should not only mean updating the code but also increment the version number in a predictable way. Having this approach is called semantic versioning. You will learn more about semantic versioning in the Updating chapter in this module.
- **license**, This communicates to the consumers of your library how it can be used. There are different types of licenses. A common one is MIT which give you the right to use the software as is.
- **files**, this is about specifying what files should be included in the package you create to distribute your Node.js project. This is an array structure where you specify what should be included. The default value is `*` which says to include all files. There are some exceptions though to what files/directories always gets included/excluded. Examples of files that are always included are `package.json`, README, LICENSE and much more. Excluded examples are files starting with a dot, `.` or files that pertains to Node and NPM and are helper files and not part of your project.
Additionally the files `.npmignore` and `.gitignore` are looked at to specify what files/ directories should be excluded from a package.
- **contributors**, this field should list all the authors of a library.
- **main**, this is the entry point of your application
- **bin**, If your project is either a CLI tool that should be a single executable or if you have a larger project with many executable files you will want to install those executable files in into the PATH - specifying this field will do that for you.
- **repository**, this field should point to where the code exist. That could be a GitHub repository URL for example.

## Developing a package, use `npm link`

## Creating a package, use `npm pack`

## Upload to NPM
