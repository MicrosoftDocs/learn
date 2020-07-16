The package.json file is a manifest file for your Node.js project. It contains numerous metadata information on your project but it also governs things such as how your dependencies are managed and what files go into a package meant for NPM and much more. Let's have a closer look at all the different properties and what they mean.

## Initialize a package.json

A `package.json` file is not something you author by hand but it's the result of running the `init` command. There are two major ways to run this command:

- `npm init`, this command will start a wizard where you are prompted for information around `name`, `version`, `description`, `entry point`, `test command`, `git repository`, `keywords`, `author`, `license`.
- `npm init -y`, this command including the flag `-y` is a quicker version of `npm init`. It's quicker in the sense that it's *not* interactive. Instead it assigns the default value to all fields that you were asked for when running `npm init`.

Regardless of whether you run the `npm init` or `npm init -y` command it will generate a `package.json` file. Here's what a generated `package.json` can look like:

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

## `package.json` file content

A way to look at all the possible fields in the `package.json` is to think of them as belonging to different groups. Namely the following groups:

- **meta information**, in this group we have meta information on the project like its name, description, author, keywords for example.
- **dependencies**, there are two properties, `dependencies` and `devDependencies` that are used to inform of what libraries are currently being used. We'll learn later in the module how to take advantage of these two sections to install, update and also separate our different dependencies.
- **scripts**, this section is where we place script that can do things such as for example *start*, *build*, *test*, *lint* our project.

### Scripts for managing your project

In any project, whether it's using Node.js or not, you are likely to want to have a way to *run*, *test*, and *build* your project. The Node.js runtime has recognized this behavior and has taken it a step further by guiding you what these scripts should be called. The idea is to ensure that all Node.js projects in this aspect look the same. It makes for a better developer experience if you can move between Node.js projects and quickly recognize yourself by there existing a familiar set of actions. Thanks to this naming standardization various tools for DevOps and instrumentation have been able to take advantage of this fact.

Essentially, you should set up a number of scripts and name them in a specific way. It is expected by the developer community and various tools out there rely on it. So what are these scripts?

- **Start**, setting up a start command is about essentially invoking node with the entry file as argument. An example of a start command can look like so `node ./src/index.js`. This command says to invoke node and the entry file `index.js`.
- **Build**, this command describes how to build your project. The end result of the build process should produce something that you can ship. Examples of the content of a build command can be to run a Typescript compiler to produce the JavaScript version of the project that you mean to ship.
- **Test**, this command should run the tests of your project so if you are using a third-party test library it should invoke it's executable.
- **Lint**, this command should invoke a linter program like ESLint. What *linting* does is point out inconsistencies in the code. A linter usually offers a way to correct the inconsistencies as well. Having consistent code can greatly increase its readability which in turn speeds up development of features and additions of code in general.

Ok now you have a grasp on what kind of scripts you should have, how do you actually name them?

Let's first look at the general syntax and then how you should name these scripts. Here's what the `scripts` section typically looks like from a syntactical viewpoint:

```json
"scripts" : {
  "<action>" : "<command>"
}
```

and a more real looking example could look like this:

```json
"scripts" : {
  "start" : "node ./dist/index.js",
  "test": "jest",
  "build": "tsc",
  "lint": "eslint"
}
```

The above is using the proper naming that has been hinted at so far. First you have the `start` action that starts up our application. Secondly, the `test` action runs our tests using the testing framework `jest`. Then we have the `build` action that uses the TypeScript compiler `tsc` to compile our code from TypeScript and into, for example,  ES6 that the browser can understand. Finally we have a *linting* tool `eslint` that looks for inconsistencies and possibly errors in our code.

Actions are invoked by typing `npm run <action>`. There are *special* actions however, `start`, `build`, and `test`. They are special in the sense that you can omit `run`. That means that instead of typing `npm run start` you can instead save a few characters and type `npm start`.

Most likely your project will have a few more scripts set up but those scripts are usually specific to your project. The above actions are a good starting point for any Node.js project.
