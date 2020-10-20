Now let’s look at how to incorporate an ERC20 token in our contracts.

## Create a new project

First, we're going to create a new blockchain project with the help of OpenZeppelin.

Make sure that you already have [Truffle](https://www.trufflesuite.com/truffle) and [Ganache CLI](https://github.com/trufflesuite/ganache-cli) installed.

1. Open your terminal and create a new folder called **Token20**. To do that you can type: `mkdir Token20`. I typically do this inside a folder called **Projects** where I store all my other development projects.
1. Navigate to the Token20 folder. To do that you can type: `cd Token20`.
1. Type `truffle init` to initialize a new project
1. Wait for your project to be initialized, and then open it in Visual Studio Code.

You should see the following after initializing the project with Truffle.

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

## Setup the project

Once the project has been created and opened in the editor, take a look around the contents.

Next, you'll want to confirm that you have Node.js installed. If you don't, you can visit the [Node](https://nodejs.org/) website for instructions about how to download it for your platform. To confirm that you have Node.js installed, open the terminal and type: `node`. This will return the version that you have installed on your machine.

Node.js comes with the node package manager (npm) installed as well. This will help you manage other JavaScript built packages and applications.

Going to your terminal, type:
`npm init`

That will open a utility that walks you through the process to create a package.json file which describes the project and stores dependencies that are used in the project. Follow the steps in the utility to easily create a package.json, noting that you can press enter at each prompt to use the default value.

## Setup OpenZeppelin

:::image type="content" source="../media/contract-library.png" alt-text="Visit OpenZeppelin to find out how to install the contracts library":::

Now we want to integrate with the OpenZeppelin contracts library.

To do that go to the terminal window and type:
`npm install @openzeppelin/contracts`

Wait for the package to install to your project successfully. You should see the following in your terminal window:

```output
+ @openzeppelin/contracts@3.2.0
added 1 package from 1 contributor and audited 1 package in 0.589s
found 0 vulnerabilities
```

Notice that a couple things happened:

1. The package was added as a dependency in the **package.json** file
1. There is a **node_modules** folder that has imported all of the available contracts from OpenZeppelin under **@openzeppelin/contracts**.

```output
$ ls node_modules/@openzeppelin/contracts 
GSN		build		math		presets		utils
README.md	cryptography	package.json	proxy
access		introspection	payment		token
```

Take some time to look through the available contract source files now available to your project, paying special attention to the **token** contracts. Get a better understanding of the implementation of each contract and which functions are typically made available.
