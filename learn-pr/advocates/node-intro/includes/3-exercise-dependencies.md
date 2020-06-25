As a Node.js developer at Tailwind Traders you will most likely install packages at the start of but also during the development of an app. Knowing how to install packages is a great skill to have as it enables you to build your application faster. You can incorporate the functionality of a dependency in your program instead of writing that piece of code yourself.

## Install/Uninstall packages with npm

You install package by using the NPM command-line tool. Ensure you are standing in an empty directory and have a terminal window open.

1. Type the following command in the terminal to install the package `jest`:

   ```bash
   npm install jest
   ```

   Inspect the folder. You should now see the following structure, a file `package-lock.json`, and the directory `node_modules` have been created:

   ```bash
   -| package-lock.json
   -| node_modules/
   ```

   Four things have happened when you typed the install command:

   1. A `package-lock.json` file has been created, this file contains information exactly on what packages are installed.
   1. A directory `node_modules` has been created, this directory is where all your locally installed packages will end up.
   1. An executable `jest` has been added to `node_modules/.bin` and means you can invoke your package like a command-line tool by typing `jest` in the terminal.
   1. The NPM tool has installed your package and its dependencies, it will have installed the package `jest` that we asked for. As part of how Node.js works, it will have installed all dependencies that `jest` is dependent on. If you expand the `node_modules` directory you will see a lot more packages than just `jest`, that's all the dependencies.

1. Uninstall the dependency we installed by typing the following command:

   ```bash
   npm uninstall jest
   ```

   You should get an output similar to the below:

   ```output
   removed 502 packages in 5.239s
   found 0 vulnerabilities
   ```

   As you can see `jest`, and its dependencies, was a fairly large thing to install but thanks to our `npm uninstall` command we managed to free up some space.

## Install a dev dependency

You are about to install the `jest` package once again but this time you will install it as a dev/developer dependency.

1. Initialize a Node.js project by typing the following command in the terminal:

   ```bash
   npm init -y
   ```

   It should have created a `package.json` file with the following content:

    ```json
    {
      "name": "exercises",
      "version": "1.0.0",
      "description": "",
      "main": "script.js",
      "dependencies": {},
      "devDependencies": {
      },
      "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "keywords": [],
      "author": "",
      "license": "ISC"
    }
    ```

1. Install the dependency by typing the following command in the terminal:

   ```bash
   npm install jest --save-dev
   ```

   Open up the `package.json` file and locate the `devDependencies` section. It should look like the below:

    ```json
    "devDependencies": {
      "jest": "^25.4.0"
    }
    ```

   Above we have an entry `jest` that is specified as a key-value entry with its name and a pattern for which versions it will adhere to, according to semantic versioning. How you author this pattern will be covered more in-depth in the next section in this module. To see the exact version that was installed, you can open up the file `package-lock.json` and locate an entry ` "jest": {`. This entry will tell you it installed version `25.4.0`.

### Clean up

We have two ways we could be cleaning up:

- Run `npm uninstall jest`
- Remove the `jest` entry from `package.json` and run `npm prune`

Let's try the latter.

1. Open up `package.json` and change the `devDependencies` section to:

    ```json
    "devDependencies": {}
    ```

    The above will tell the `package.json` file you no longer want this dependency. It still exists within the `node_modules` directory though.

1. To remove unused dependencies from the `node_modules` folder, type the following command:

    ```bash
    npm prune
    ```

   This command will remove all orphaned packages. An orphaned package is a package that exists in the `node_modules/` directory but is not listed in the `dependencies` or `devDependencies` section of the `package.json` file.

   You should see the following output:

   ```bash
   removed 502 packages in 6.519s
   found 0 vulnerabilities
   ```

Congrats, you successfully learned to install the package and learned to uninstall it.