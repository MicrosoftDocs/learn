Let’s create a new project, with the help of Truffle, and then incorporate the OpenZeppelin contracts library. Make sure that you already have [Truffle](https://www.trufflesuite.com/truffle) and [Ganache CLI](https://github.com/trufflesuite/ganache-cli) installed before moving on.

## Create a new project

1. Open your terminal and create a new folder named **Token20**. To do that, you can enter `mkdir Token20`. I typically do this inside a folder named **Projects**, in which I store all my other development projects.
1. Go to the Token20 folder. To do that, you can enter `cd Token20`.
1. To initialize a new project, enter `truffle init`.
1. Wait for your project to be initialized, and then open it in Visual Studio Code.

You should see the following output after you use Truffle to initialize the project:

```output
$ mkdir Token20
$ cd Token20/
$ truffle init
✔ Preparing to download box
✔ Downloading
✔ cleaning up temporary files
✔ Setting up box
$ ls
contracts               migrations              test                    truffle-config.js
```

## Set up the project

When the project has been created and is open in the editor, take a look around the contents.

Next, you'll want to confirm that you have Node.js installed. To confirm that you have Node.js installed, open the terminal and enter `node`. If Node.js is installed, that command returns the version that is installed on your computer. If Node.js isn't installed on your computer, go to [Node](https://nodejs.org/) for instructions about how to download it for your platform.

Node.js comes with the node package manager (npm) installed, as well. npm helps you manage other JavaScript-built packages and applications.

1. In your terminal, enter `npm init`. That command displays a utility that walks you through the process of creating a package.json file, which describes the project and stores dependencies that are used in the project.
1. Complete the steps in the utility to easily create a package.json file.
    > [!NOTE]
    > You can press Enter at each prompt to use the default value.

## Set up OpenZeppelin

:::image type="content" source="../media/contract-library.png" alt-text="Visit OpenZeppelin to find out how to install the contracts library":::

Next, we want to integrate with the OpenZeppelin contracts library.

To do that, in the terminal, enter `npm install @openzeppelin/contracts`.

Wait for the package to install to your project successfully. You should see the following output in your terminal:

```output
+ @openzeppelin/contracts@3.2.0
added 1 package from 1 contributor and audited 1 package in 0.589s
found 0 vulnerabilities
```

Notice that a couple things happened:

1. The package was added as a dependency in the package.json file.
1. A *node_modules* folder imported all the available contracts from OpenZeppelin, in the subfolder *\@openzeppelin/contracts*. Inspecting the contents of that folder returns the following output:

  ```output
  $ ls node_modules/@openzeppelin/contracts 
  GSN		build		math		presets		utils
  README.md	cryptography	package.json	proxy
  access		introspection	payment		token
  ```

Take some time to look through the available contract source files that are now available to your project. Pay special attention to the *token* contracts. Get a better understanding of the implementation of each contract and which functions are typically made available.
