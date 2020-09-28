## Install the extension

[Blockchain Development Kit for Ethereum](https://marketplace.visualstudio.com/items?itemName=AzBlockchain.azure-blockchain) is an extension you can use in Visual Studio Code. The extension makes it easy to create, build, and deploy smart contracts on Ethereum ledgers.

Simply go to **Extensions** and search for **Blockchain Development Kit** and install it.

:::image type="content" source="../media/bdk-install.png" alt-text="Install Blockchain Development Kit":::

## Get started

### Create a New Solidity Project with the extension

Once you have all the dependencies installed, you can now use the Blockchain Development Kit to create your first project.

1. Start by adding a new empty directory to your computer for the project. Note: You can open your terminal and type `mkdir newSolidityProject` to create a new directory. Keep note of where this new empty directory is, but you don't need it yet.
2. Open Visual Studio Code.
3. Go to View -> Command Palette. In the search box type: `Blockchain: New Solidity Project`. You'll notice that as you begin to type "Blockchain" a list of commands will be presented.

:::image type="content" source="../media/new-solidity-project-selection.png" alt-text="Select New Solidity project option":::

4. For the type of solidity project, select **Create basic project**.

:::image type="content" source="../media/create-basic-project.png" alt-text="Create basic project":::

5. Use the UI file explorer pop up to find the folder you created in step 1. Select the folder and in the bottom right-hand of the window you'll see **Creating new project**
6. Sit back and wait for your new Solidity project to be created.

Once it is, open the Explorer and take a look at all the files that were created in the project.

:::image type="content" source="../media/new-solidity-project.png" alt-text="New workspace for solidity project":::

In this project, you will have a boiler plate of Solidity code that you can use. Notice that you have directories for:

- **contracts:** Contains the **HelloBlockchain.sol** and **Migrations.sol** contracts
- **migrations:** Contains an initial migration and a deploy contract.
- **test:** Contains a test for the HelloBlockchain contract written in JavaScript

You'll also have some other config files:

- **package.json:** To define project details and dependencies
- **truffle-config.json:**. To define dependencies and configuration for Truffle

Go ahead and go to `File -> Save Workspace As...` and save the workspace with name **newsolidityproject**.

Then focus your attention back to the project itself. For now we will only focus on the **contracts/** directory.

## Compile the contracts

We will start by using the **HelloBlockchain.sol** smart contract inside of the contracts folder.

1. Go to contracts/HelloBlockchain.sol
Right click HelloBlockchain.sol
2. Click on **Build Contracts** to compile the smart contract. Notice the window appear in the bottom right that says: "Building contracts"
3. Select View -> Output to see information about the compiled contract. Note: In the dropdown window you may need to select "Azure Blockchain" to see output from the extension

:::image type="content" source="../media/build-contracts.png" alt-text="Build contracts":::

In the output window (View -> Output) you can see information about the contracts compilation:

:::image type="content" source="../media/compile-output.png" alt-text="Build contracts output":::

## Deploy contracts

After the contract has compiled successfully, you can deploy the contract locally. This step requires you to sign into your Azure account.

1. Go to contracts/HelloBlockchain.sol
2. Right click HelloBlockchain.sol
3. Click on **Deploy Contracts** and select development in the window that appears. Here you will be prompted to sign in to Azure if you are not already.

:::image type="content" source="../media/deploy-contracts.png" alt-text="Deploy contracts":::

4. In the output window (View -> Output) you can see information about the deployed migrations and contracts

:::image type="content" source="../media/deploy-details.png" alt-text="Deploy details in output window":::

Here you see some key information, or metadata about the contract you just deployed:

- The address of the contract
- Time stamp of the block that the contract creation transaction was a part of
- The address of the account that deployed the contract
- The balance (in Ether) that the account has after this transaction was made. The balance is 100 ETH (the starting default value) minus the `total cost`
- The amount of gas used and the gas price. Gas refers to the fee, required to successfully conduct a transaction or execute a contract on the Ethereum blockchain platform. You can think of it of the gas you need to put into your car to drive places.
- Note: Gas prices are denoted in gwei, with are worth 0.000000001 ETH.
- Total cost = gas price * gas use
