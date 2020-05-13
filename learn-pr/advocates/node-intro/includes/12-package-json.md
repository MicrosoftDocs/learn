The package.json file is manifest file for your Node.js project. It contains a lot of metadata information on your project but it also governs things such as how your dependencies are managed and what files goes into a package meant for NPM and much more. Let's have a closer look at all the different properties and what they mean.

## Initialize a package.json

A `package.json` file is not something you author by hand but it's the result of running the `init` command. There are two major ways to run this command:

- `npm init`, this will start a wizard where you are prompted for information around `name`, `version`, `description`, `entry point`, `test command`, `git repository`, `keywords`, `author`, `license`
- `npm init -y`, this version of the command including the flag `-y` is a quicker version of `npm init`. It's quicker in the sense that it's *not* interactive. Instead it assigns the default value to all fields that you were asked for when running `npm init`.

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

- **meta information**, in this group we have meta information on the project like it's name, description, author, keywords for example.
- **dependencies**, there are two properties `dependencies` and `devDependencies` that is used to inform of what libraries is currently being used. Any installed dependencies end up in `node_modules` folder in your project. If a team is working on a Node.js project you are likely to store it somewhere so everyone can access it, a place like GitHub for example. You wouldn't store the `node_modules` folder in GitHub though as it can quickly become quite large with all downloaded dependencies. Instead you would fetch the project from GitHub and run the `npm install` command. The `npm` command would then read from the `package.json` file and the `dependencies` and `devDependencies` sections and fetch the listed libraries.
There's a difference between them `dependencies` are libraries that is needed to build the project, for example a library to connect to a database .`devDependencies` are libraries we use to *manage* the project, for example a test library. A test library isn't strictly needed to build a project ut we need it at development time to write tests.
- **scripts**, this is a section where we place script that can do things such as for example *start*, *build*, *test*, *lint* our project.

## Setup Scripts

We've already stated that this is the place where you place scripts that helps you with different actions regarding your project, but let's have a closer look. One of the first things that is beneficial to do once you have a generated a `package.json` is to set up the `scripts` section of the file. The `scripts` section is an object consisting of key-value pair entries separated by a comma. The idea is to have an *action* as a key and the value being the command invoked. An example of that can look like so:

```json
"scripts" : {
  "<action>" : "<command>"
}
```

Actions are usually invoked by typing `npm run <action>`. There are *special* actions however, `start` and `build`. They are special in the sense that you can omit `run`. That means that instead of typing `npm run start` you can instead save a few characters and type `nmp start`.

Let's list some actions that you are likely to set up

- Start action, setting up a start action is about essentially invoking node with the entry file as argument. An example of this can look like so `node ./src/index.js`. This says to invoke node and the entry file `index.js`. 
- Build, this is about building our project. The end result of the build process should produce something that you can ship. Examples of this can be to run a Typescript compiler to produce the JavaScript version of the project that you mean to ship.
- Test, this should run the tests of your project so if you are using a 3rd party test library it should invoke it's executable.

What actions you set up after this is up to the project you are building but the above actions are the most common ones.

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
