The [Blockchain Development Kit for Ethereum](https://marketplace.visualstudio.com/items?itemName=AzBlockchain.azure-blockchain&azure-portal=true) is an extension that's available in Visual Studio Code. Use the extension to create, build, and deploy smart contracts on Ethereum blockchain solutions.

## Install the extension

In Visual Studio Code, on the left sidebar, select **Extensions**. Search for **Blockchain development kit**, and select it to install it.

:::image type="content" source="../media/bdk-install.png" alt-text="Screenshot showing how to install the Blockchain development kit extension in Visual Studio Code.":::

Before you use the Blockchain development kit, make sure you have installed:

- **Python**: To make sure you have Python installed, open a terminal or a Command Prompt window, and then type `python`. If Python is installed, the terminal returns the version of Python on your computer.
  
  > [!Note]
  > Most computers have Python preinstalled.
- **Node.js**: To confirm Node.js is installed, open your terminal and type `node`. If Node.js is installed, the terminal returns your computer's version of Node.js. You can also confirm that the node package manager (NPM) is installed by typing `npm` in the terminal.
- **Git**: To confirm Git is installed, open your terminal and type `git`. If Git is installed, the terminal returns a list of available git commands.

If you don't have this software installed, or if you don't have the minimum versions, the extension provides tips for how to install the tools.

## Get started

When you have all of the dependencies installed, use the Blockchain development kit to create your first project:

1. On your computer, add an empty directory for the project. To create a directory from Visual Studio Code, go to **Terminal** > **New Terminal** and then type `mkdir newSolidityProject`. Make a note of this new directory's location. You'll need it later.
1. In Visual Studio Code, go to **View** > **Command Palette**. In the search box, type `Blockchain: New Solidity Project`. As you type, a list of suggestions appears.

   :::image type="content" source="../media/new-solidity-project-selection.png" alt-text="Screenshot showing how to create a new Solidity project in Visual Studio Code.":::

1. For the type of Solidity project, select **Create basic project**.

   :::image type="content" source="../media/create-basic-project.png" alt-text="Screenshot showing the Create basic project selection in Visual Studio Code.":::

1. Use the Explorer pane to find the folder you created in step 1. Select the folder. In the lower-right corner of the window, you see **Creating new project**.

After your Solidity project is created, open the Explorer pane to see the project's files.

:::image type="content" source="../media/new-solidity-project.png" alt-text="Screenshot showing a new workspace for a Solidity project.":::

The project includes boilerplate for Solidity code. Notice the following directories:

- **contracts**: Contains the *HelloBlockchain.sol* and *Migrations.sol* contracts
- **migrations**: Contains an initial migration and a deploy contract
- **test**: Contains a test for the HelloBlockchain contract that's written in JavaScript

You also see some configuration files:

- **package.json**: Defines project details and dependencies
- **truffle-config.json**: Defines dependencies and configuration for Truffle

To save the workspace, go to **File** > **Save Workspace As**. Name it *newSolidityProject*.

Now let's get back to the project itself. First we'll focus on the *contracts* directory.

## Compile the contracts

We'll start with the *HelloBlockchain.sol* smart contract inside the *contracts* folder.

1. In the Explorer pane, in the **contracts** folder, right-click the contract name, **HelloBlockchain.sol**.
1. Select **Build Contracts** to compile the smart contract. A window in the lower-right corner indicates that contracts are building.

   :::image type="content" source="../media/build-contracts.png" alt-text="Screenshot showing the Explorer pane. For the selected contract file, the Build Contracts command is selected.":::

1. Select **View** > **Output** to see information about the compiled contract. In the window, you might need to select **Azure Blockchain** to see the output from the extension.

   :::image type="content" source="../media/compile-output.png" alt-text="Screenshot showing output information about the compiled contract. The Azure Blockchain menu item is selected.":::

## Deploy contracts

After the contract has been compiled successfully, you can deploy it locally. This step requires you to sign in to your Azure account.

1. In the Explorer pane, go to the **contracts** folder and then right-click the contract name, **HelloBlockchain.sol**.
1. Select **Deploy Contracts**.

   :::image type="content" source="../media/deploy-contracts.png" alt-text="Screenshot showing the Explorer pane. In the shortcut menu, the Deploy Contracts command is selected.":::

1. In the window that appears, select **development**. You're prompted to sign in to Azure if you aren't already signed in.

In the output window (**View** -> **Output**), you see information about the deployed migrations and contracts.

:::image type="content" source="../media/deploy-details.png" alt-text="Screenshot showing output information about the deployed migrations and contracts. The Azure Blockchain menu item is selected.":::

Here you see some key information or metadata for your deployed contract:

- The address of the contract.
- The time stamp of the block that the contract creation transaction was part of.
- The address of the account that deployed the contract.
- The account's balance (in ether) after the transaction. The balance is 100 ETH (the starting default value) minus the total cost.
- The amount of gas used and the gas price. *Gas* refers to the fee required to conduct a transaction or to execute a contract on the Ethereum blockchain platform. You can think of it like the gas you need for your car. Total cost = gas price * gas use.
  > [!Note]
  > Gas prices are shown in gwei. One gwei is worth 0.000000001 ETH.
