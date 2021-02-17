Your code editor may have built-in language support for TypeScript but, to transform TypeScript code into JavaScript that a browser will understand, you need to first install the TypeScript library, which also contains the TypeScript compiler (also referred to as `tsc`.)

TypeScript can be installed **globally** (available anywhere in your file system) or **locally** (only available at the project level). In this exercise, you will install TypeScript globally. As you work more with TypeScript in larger and more complex codebases, you will likely switch to a per-project installation to have more control over the consistency of your projects.

## Test your TypeScript installation

You may already have TypeScript installed on your machine. You can verify this by opening the Command Prompt and entering `tsc`. If TypeScript is installed, you'll see the version and a list of compiler commands and you're ready to use TypeScript!

If TypeScript is not installed, you'll see an error that the command is not recognized. Continue to the next step of this exercise.

## Install Node Package Manager (npm)

You'll need a copy of Node.js as an environment to run the TypeScript package. Node.js, a JavaScript library for server-side applications, is not required to learn TypeScript. But by installing it, you also get Node Package Manager (`npm`), the package manager for the JavaScript language. You'll then use `npm` to install the TypeScript package.

If you're a JavaScript developer, `npm` will likely be installed on your machine. You can verify this by opening the Command Prompt and entering `npm version`. If `npm` is installed, you'll see the version and a list of compiler commands, and you're ready to use `npm`.

If `npm` is not installed, you'll see an error that the command is not recognized. To install Node.js:

1. Go to [https://nodejs.org/en/download](https://nodejs.org/en/download?azure-portal=true).
2. Select any of the available versions of Node.js to download it and then install it.
3. Verify that `npm` is installed. Open the Command Prompt and enter `npm version`.

## Install TypeScript

TypeScript is available as a package on the `npm` registry as `"typescript"`. To install the latest version of TypeScript:

1. From the Command Prompt, enter `npm install -g typescript`.
2. Enter `tsc` to confirm that TypeScript is installed. If successful, this command should show a list of compiler commands and options.
