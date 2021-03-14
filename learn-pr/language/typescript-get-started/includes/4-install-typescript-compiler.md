Your code editor might have built-in language support for TypeScript but, to transform TypeScript code into JavaScript that a browser will understand, you need to first install the TypeScript library. The library also contains the TypeScript compiler, also called *tsc*.

You can install TypeScript *globally* (available anywhere in your file system) or *locally* (available only at the project level). In this exercise, you'll install TypeScript globally. As you work more with TypeScript in larger and more complex codebases, you'll likely switch to a per-project installation to have more control over the consistency of your projects.

## Test your TypeScript installation

You might already have TypeScript installed on your machine. You can verify this by opening the Command Prompt window and entering `tsc`. If TypeScript is installed, you'll see the version and a list of compiler commands. You're now ready to use TypeScript!

If TypeScript isn't installed, you'll see a message that the command is not recognized. Continue to the next step of this exercise.

## Install Node Package Manager (npm)

You'll need a copy of Node.js as an environment to run the TypeScript package. Node.js, a JavaScript library for server-side applications, is not required to learn TypeScript. But by installing it, you also get Node Package Manager, also called *npm*, the package manager for the JavaScript language. You'll then use npm to install the TypeScript package.

If you're a JavaScript developer, npm is likely already installed on your machine. You can verify this by opening the Command Prompt window and entering `npm version`. If npm is installed, you'll see the version and a list of compiler commands, and you're ready to use npm.

If npm isn't installed, you'll see a message that the command is not recognized. To install Node.js:

1. Go to the [Node.js Downloads](https://nodejs.org/en/download?azure-portal=true) page.

2. Select any of the available versions of Node.js to download and install it.

3. To verify that npm is installed, open the Command Prompt window, and then enter `npm version`.

## Install TypeScript

TypeScript is available as a package in the npm registry as *typescript*. To install the latest version of TypeScript:

1. In the Command Prompt window, enter `npm install -g typescript`.
2. Enter `tsc` to confirm that TypeScript is installed. If it was successfully installed, this command should show a list of compiler commands and options.
