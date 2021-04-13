We can use [Truffle boxes](https://www.trufflesuite.com/boxes?azure-portal=true) as boilerplates or templates that can contain helpful modules, Solidity contracts and libraries, front-end views, and more. We can even get complete example dapps.

For this exercise, we'll use the [Drizzle box](https://www.trufflesuite.com/boxes/drizzle?azure-portal=true). This box will help us quickly and easily build our first dapp and provide an overview of Drizzle's capabilities.

The Drizzle box comes with several out-of-the-box smart contracts to check out. It also comes with a simplified truffle-config.js file that's designed for development and testing.

## Use Drizzle to wire smart contacts to a front-end server

Unboxing Drizzle results in essentially two separate projects within a
single directory: a **truffle** project and a **drizzle-react client**
project. If you already have experience with Truffle, the directory structure will look familiar in the area for smart contracts. The
main difference is how you wire it to Web3. You also need to take configurations for modification into account.

## Get started with the Drizzle box

We'll begin by creating a new directory to house the Truffle Drizzle project. Make sure that you already have Truffle installed.

1. Open your terminal and create a new empty directory by entering `mkdir drizzle_tutorial`.
2. Go to the directory by entering `cd drizzle_tutorial`.
3. After you're in the **drizzle_tutorial** folder, indicate that you want to use the Truffle Drizzle box by entering `truffle unbox drizzle`. 

   Wait a few minutes for the box to be set up. You'll then see the message **Unbox successful, sweet!**.
4. Open the project in Visual Studio Code, and look at the folder structure.

## Compile and migrate the project

The Truffle Drizzle box comes with three contracts that use the Drizzle components for connecting to a dapp. The **contracts** directory contains the files **ComplexStorage.sol**, **SimpleStorage.sol**, and **TutorialToken.sol**. The Drizzle tutorial uses them.

Let's compile and migrate these contracts before we explore the app components in detail.

1. From within Visual Studio Code, open the terminal by going to **Terminal** > **New Terminal**. Then start the Ganache CLI by entering `ganache-cli`.
1. Right-click on any of the contracts and select **Build Contracts**. Wait for the build and compilation to successfully finish.
1. Right-click on any of the contracts again and select **Deploy Contracts**. When the window for deploy destination appears, select the **develop** network. Wait a minute for the migration to complete successfully.

## Explore the dapp components

The Drizzle box includes code that uses the Drizzle libraries to connect the smart contracts to the dapp's front end. That code exists within the **app/** folder.

The files in the **app/** folder that are of interest for connecting the smart contract to the dapp are:

- **MyComponent.js**
- **drizzleOptions.js**
- **App.js**

Let's explore how the files work together to wire up the smart contracts to the dapp.

### MyComponent.js

The **MyComponent.js** file creates the component for connecting the SimpleStorage, ComplexStorage, and TutorialToken smart contracts with the front end.

### drizzleOptions.js

The **drizzleOptions.js** file is used to create an **options** object and pass in the desired contract artifacts for Drizzle to instantiate. The **options** object sets up and instantiates the Drizzle store.

### App.js

**App.js** contains the code for the main app. It requires importing React and the Drizzle libraries. It must also import the component file that interacts directly with the smart contract.

## Run the dapp

Focusing your attention back on the terminal window, run the following commands:

- `cd app` to move into the **app/** folder.
- `npm rebuild` to run the build and recompile changes in the **app/** folder.
- `npm run start` to start the web-pack development server for React. It opens a new browser window for the React project.

Your browser should now open with a window that shows a dapp where you can interact with the SimpleStorage, TutorialToken, and ComplexStorage contracts.

:::image type="content" source="../media/drizzle-dapp.png" alt-text="Screenshot that shows the dapp that's generated from the Drizzle box.":::
