The package.json file is a manifest file for your Node.js project. It contains metadata information on your project. It also governs things like how your dependencies are managed, what files go into a package meant for npm, and much more. Let's take a closer look at the properties and what they mean.

## Initialize a package.json

A package.json file isn't something you author by hand. It's the result of running the npm `init` command. There are two main ways to run this command:

- `npm init`: This command starts a wizard that prompts you for information about a project's name, version, description, entry point, test command, Git repository, keywords, author, and license.
- `npm init -y`: This command uses the `-y` flag and is a faster version of the `npm init` command because it's *not* interactive. Instead, this command automatically assigns default values for all values you're prompted to enter by using the `npm init`.

The `npm init` and `npm init -y` commands both generate a package.json file. Here's an example:

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

You're likely to want to have a way to run, test, and build any project, whether by using Node.js or not. The Node.js runtime recognizes this need and provides guidance about how to name your scripts. The idea is to ensure that all Node.js projects use consistent script names. It's a better developer experience to be able to move among Node.js projects and quickly orient yourself because you see a consistent set of actions. Various tools for DevOps and instrumentation can take advantage of this naming consistency.

You should set up four scripts and name them in a specific way. The developer community and various tools expect the following specific names:

- `start`: Invokes the `node` command with the entry file as an argument. An example might be `node ./src/index.js`. This action invokes the `node` command and uses the entry file `index.js`.
- `build`: Describes how to build your project. The build process should produce something that you can ship. For example, a build command could run a TypeScript compiler to produce the JavaScript version of the project that you want to ship.
- `test`: Runs the tests for your project. If you're using a third-party test library, the command should invoke the library's executable file.
- `lint`: Invokes a linter program like ESLint. *Linting* finds inconsistencies in code. A linter usually offers a way to correct inconsistencies as well. Having consistent code can greatly increase readability, which speeds up the development of features and additions to the code.

### Script naming

Now that you know what kinds of scripts you should have, how do you actually name them?

Let's first look at the general syntax. Then we'll look at how you should name the scripts.

The syntax of a `scripts` section typically looks like this:

```json
"scripts" : {
  "<action>" : "<command>"
}
```

Here's a more realistic example:

```json
"scripts" : {
  "start" : "node ./dist/index.js",
  "test": "jest",
  "build": "tsc",
  "lint": "eslint"
}
```

This example uses the naming that we reviewed previously. First, you have the `start` action that starts the application. Second, the `test` action runs tests by using the `jest` testing framework. Then you have the `build` action that uses the TypeScript compiler `tsc`. This command compiles the code from TypeScript into a form the browser can interpret, such as ES6. Finally, you have the `eslint` linting tool that looks for inconsistencies and possible errors in the code.

You invoke actions by entering the command `npm run <action>`. For example, `npm run lint`.

The `start` and `test` action are *special* in that you can omit the word `run` in the command. Rather than entering the command `npm run start`, you can enter `npm start`.

These four actions are a good starting point for any Node.js project, but each project will probably have a few more scripts that are specific to the project itself.

## Use Development container for consistent development environment

A development container is a configured environment, which includes all tools and applications needed to complete a development task. This allows development teams to focus on writing code instead of chasing issues stemming from working in an environment (perhaps multiple environments) different than the production environment. 

A development container can run:

* **Remotely**: In the browser, you can use GitHub Codespaces and Visual Studio Code for the Web, using free compute time available with your GitHub account.
*  **Locally**: On your local computer, you can use Visual Studio Code [] with a configured container environment or you can start with the default environment. Docker Community edition is required.

### Remote development

[GitHub Codespaces](https://docs.github.com/codespaces) runs a development container managed by GitHub with [Visual Studio Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web) as the user interface. For the most straightforward development environment, use GitHub Codespaces so that you have the correct developer tools and dependencies preinstalled to complete this training module.

> [!IMPORTANT]
> All GitHub accounts can use Codespaces for up to 60 hours free each month with 2 core instances. For more information, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

### Local development

The [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for Visual Studio Code requires [Docker](https://docs.docker.com/) to be installed on your local machine. The extension hosts the development container locally using the Docker host with the correct developer tools and dependencies preinstalled to complete this training module.