The package.json file is a manifest file for your Node.js project. It contains metadata information on your project. It also governs things like how your dependencies are managed, what files go into a package meant for npm, and much more. Let's take a closer look at the properties and what they mean.

## Initialize a package.json

A package.json file isn't something you author by hand. It's the result of running the `init` command. There are two main ways to run this command:

- `npm init`. This command starts a wizard that will prompt you for information about a project's name, version, description, entry point, test command, Git repository, keywords, author, and license.
- `npm init -y`. This command, with the `-y` flag, is a faster version of `npm init`. It's faster in the sense that it's *not* interactive. Instead, it assigns default values for all values you'd be asked to supply if you ran `npm init`.

The `npm init` command and the `npm init -y` command it will both generate a package.json file. A package.json file might look like this file:

```json
{
  "name": "my project",
  "version": "1.0.0",
  "description": "",
  "main": "script.js",
  "dependencies": {},
  "devDependencies": {},
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```

## package.json file contents

You can think of all the possible fields in the package.json as belonging to  the following groups:

- **Meta-information**. This group contains meta-information about the project, like its name, description, author, and keywords.
- **Dependencies**. There are two properties, `dependencies` and `devDependencies`, that are used to describe the libraries that are being used. Later in the module, you'll learn how to use these two sections to install, update, and separate dependencies.
- **Scripts**. You can place scripts in this section that do things like start, build, test, and lint a project.

### Scripts for managing your project

You're likely to want to have a way to run, test, and build any project, whether it's using Node.js or not. The Node.js runtime has recognized this need and provides guidance about what scripts that do these things should be called. The idea is to ensure that all Node.js projects use consistent names for these scripts. It's a better developer experience if you can move among Node.js projects and quickly orient yourself because you see a consistent set of actions. Various tools for DevOps and instrumentation can take advantage of this naming consistency.

You should set up a number of scripts and name them in a specific way. These specific names are expected by the developer community and various tools:

- **Start**. A start command invokes `node` with the entry file as an argument. It might look like this command: `node ./src/index.js`. This command says to invoke `node` and use the entry file `index.js`.
- **Build**. This command describes how to build your project. The build process should produce something that you can ship. For example, a build command could run a TypeScript compiler to produce the JavaScript version of the project that you want to ship.
- **Test**. This command should run the tests for your project. If you're using a third-party test library, the command should invoke the library's executable file.
- **Lint**. This command should invoke a linter program like ESLint. *Linting* finds inconsistencies in code. A linter usually offers a way to correct inconsistencies as well. Having consistent code can greatly increase its readability. This readability in turn speeds up the development of features and additions to the code.

Now that you know what kinds of scripts you should have, how do you actually name them?

Let's first look at the general syntax. Then we'll look at how you should name the scripts. Here's what the syntax of a `scripts` section typically looks like:

```json
"scripts" : {
  "<action>" : "<command>"
}
```

A more realistic example would look like this code:

```json
"scripts" : {
  "start" : "node ./dist/index.js",
  "test": "jest",
  "build": "tsc",
  "lint": "eslint"
}
```

This example uses the naming that has been described. First, you have the `start` action that starts the application. Second, the `test` action runs tests by using the testing framework `jest`. Then you have the `build` action that uses the TypeScript compiler `tsc` to compile the code from TypeScript into, for example, ES6 that the browser can understand. Finally, you have a linting tool `eslint` that looks for inconsistencies and possibly errors in the code.

You invoke actions by typing `npm run <action>`. But there are *special* actions: `start` and `test`. They're special because you can omit `run`. So instead of typing `npm run start`, you can instead save a few characters and type `npm start`.

Your project will probably have a few more scripts, but those scripts are usually specific to the project. The actions described previously are a good starting point for any Node.js project.
