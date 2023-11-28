Learn about local Node.js project management with npm and package management.

## Packaging and package management

NPM is Node.js's default package manager. It helps developers use external code in their projects, making it easier to build applications.

Packaging prepares your code for distribution. It bundles your code and its dependencies into a package that others can install and use. Package management involves:

- The **package.json** file, which defines your project. It contains metadata about your project and manages dependencies and package files.
- The **npm CLI tool**, which installs and manages packages from the npm registry.
- The **npm registry**, a public collection of packages you can use in your projects.

## Initialize a package.json

A `package.json` is created with the `npm init` command. There are two main ways to run this command:

* `npm init`: This command starts a step-by-step process that asks you for details about your project like its name, version, and description.
* `npm init -y`: This command is a quicker version of npm init. It skips the questions and fills in default values for you.

Here is an example of the generated `package.json` file.

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

You can think of all the possible properties in the package.json file as belonging to the following groups:

- **Meta-information**: The properties in this group define the meta-information about the project. Properties include the project name, description, author, keywords, and so on.
- **Dependencies**: There are two properties that describe the libraries being used: `dependencies` and `devDependencies`. Later in the module, you'll learn how to use these properties to install, update, and separate dependencies.
- **Scripts**: In this section, you can list scripts for project tasks, such as start, build, test, and lint.


### Scripts for managing your project

GitHub Copilot: In your `package.json` file, you should include at least four scripts with specific names:

- `start`: This runs your project. For example, it might use the command `node ./src/index.js`.
- `build`: This prepares your project for deployment. It might compile TypeScript into JavaScript, for instance.
- `test`: This runs your project's tests, typically using a testing library.
- `lint`: This checks your code for style and formatting issues using a tool like ESLint.

These script names are standard in the developer community and help keep your project organized.

### Script naming

In your package.json file, scripts are defined with an action and a command like this:

```json
"scripts" : {
  "<action>" : "<command>"
}
```

Here's an example:

```json
"scripts" : {
  "start" : "node ./dist/index.js",
  "test": "jest",
  "build": "tsc",
  "lint": "eslint"
}
```

### Run a script

Run a script in a terminal by entering the command `npm run <action>`. For example, `npm run lint`.

The `start` and `test` action are *special* in that you can omit the word `run` in the command. Rather than entering the command `npm run start`, you can enter `npm start`.

## Use a pre-defined development environment

This training module offers a development container, either in a browser or for your local computer. This container provides all the need environment so you can use this training module without having to install an IDE or Node.js. You don't need to know anything about the container to complete this training module. 