We can use [Truffle Boxes](https://www.trufflesuite.com/boxes?azure-portal=true) as boilerplates or templates that can contain helpful modules, Solidity contracts & libraries, front-end views and more; all the way up to complete
example dapps.

For this exercise we'll be using the [**Drizzle box**](https://www.trufflesuite.com/boxes/drizzle?azure-portal=true). This box will help us quickly and easily build our first dapp and provide an overview of Drizzle's capabilities.

The **Drizzle** box comes with several out of the box smart contracts to check out and a
simplified **truffle-config.js** designed for development and testing.
If using a prior **truffle project,** first create a clean and empty
folder, **unbox** **Drizzle**, then copy over the current project -
smart contracts, migrations, and other project-specific files.

Using Drizzle to wire smart contacts to a front-end server

Unboxing Drizzle results in essentially two separate projects within a
single directory: a **truffle** project and a **drizzle-react client**
project. If you already have experience with **Truffle**, then
directory structure will look familiar in the smart contract area. The
primary difference will be how you wire it to **Web3** and
configurations modification which need to be taken into account.

## Get started with the Drizzle Box

We'll begin by creating a new directory which will be used to house the Truffle Drizzle project. You'll need to make sure that you already have **Truffle** installed.

1. Open your terminal and create a new empty directory by typing: `mkdir drizzle_tutorial`
2. Then navigate to the directory by typing: `cd drizzle_tutorial`
3. Once in the dirzzle_tutorial folder, you can indicate that you want to use the Drizzle Truffle box by typing: `truffle unbox drizzle`. Wait a few minutes for the box to setup. Once it's complete you'll see the message: **Unbox successful, sweet!**
4. Open up the project in VS Code, and take a look at the folder structure.

## Compile, Migrate and test the project

The **Truffle Drizzle-Box** comes with three contracts that use the
drizzle components for connecting to a Dapp. The contracts directory
contains the files: **ComplexStorage.sol**, **SimpleStorage.sol** and
**TutorialToken.sol** which are used by the **Drizzle** tutorial.

We'll want to compile, migrate, and test these contracts first before exploring the app components in detail.

1. From within VS Code, open up the terminal by going to **Terminal -> New Terminal**. Then start up Ganache CLI by typing: `ganache-cli`.
1. Open up another terminal window by right-clicking into the terminal and selecting **New Terminal**.
1. In that new terminal window, type `truffle compile` to compile the contracts. Wait for the compilation to successfully complete.
1. Once the compilation is complete, you can now test the contracts. The Truffle box comes with the file **simplestorage.js** for testing the **Simple Storage** smart contract. In the terminal window, type: `truffle test`.
1. After the tests successfully run, you can now deploy the contracts. The migrations folder has JavaScript files that help you deploy contracts to the network of your choice.**2_deploy_contracts.js** located in the migrations folder will migrate the smart contracts in this project. Type `truffle migrate --network develop`. Then wait for the migration to successfully complete.

## Explore the dapp components

The Drizzle Box includes code using the Drizzle libraries to connect the
smart contracts to the dapp's front-end. That code exists within the **app/** directory.

The files in the **app/** folder which are of interest for connecting the smart contract to the dapp are:

- **app.js**
- **drizzleOptions.js**
- **MyComponent.js.**

Next let's explore how the files work together to wire up the smart contracts to the dapp.

### MyComponent.js

The file **MyComponent.js** creates the component for connecting the SimpleStorage, ComplexStorage and TutorialToken smart contracts with the front-end.

### drizzleOptions.js

**drizzleOptions.js** is used to create an **options** object and pass in the desired contract artifacts for **Drizzle** to instantiate. The **options** object sets up and instantiates the
Drizzle store.

### App.js

**App.js** contains the code for the main app. It requires importing React and the Drizzle libraries. It must also import the component file which interacts directly with the smart contract.

## Run the dapp

1. Focusing your attention back on the terminal window, run the following commands:

- `cd app` to move into the app/ folder
- `npm rebuild` to run the build and recompile changes in the app/ folder
- `npm run start` to start the web-pack dev server for React and opens up a new browser window for the React project.

Your browser should now open with a window showing a dapp where you can interact with the contracts: SimpleStorage, TutorialToken, and ComplexStorage.

:::image type="content" source="../media/drizzle-dapp.png" alt-text="Image showing the dapp that is generated from the Drizzle box":::
