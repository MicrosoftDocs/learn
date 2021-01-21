Now that we have a smart contract, and have successfully deployed it to our development network, we will focus this exercise on deploying to the Ropsten test network.

## Exercise overview

For this tutorial, we will deploy to Ropsten using MetaMask with test ether. The process for deploying requires setting up an [Infura](http://www.infura.io/) account to connect and deploy to the Ropsten testnet. Once deployed, we can use the [Ropsten Testnet Explorer](https://ropsten.etherscan.io/) to inspect the blocks that have been deployed to the testnet.

## Exercise setup

### Set up Metamask

If you haven’t done so already, install and set up Metamask by visiting [metamask.io](https://metamask.io) and following the prompts. Once you are signed into your account in the browser, you can move on to the next step.

### Add Ether to Metatmask Ropsten test network

Using your Metamask account, connect to the Ropsten test network. You can get some test Ether from the [Ropsten Test Faucet](https://faucet.ropsten.be) by following these steps:

1. Open MetaMask.
1. Connect to Ropsten.
1. Copy the address of your account to the clipboard.

    :::image type="content" source="../media/metamask-0-eth-connect.png" alt-text="Screenshot showing the Metamask browser extension to copy the account address.":::

1. Open a browser window or tab, and go to [https://faucet.ropsten.be/](https://faucet.ropsten.be/).
1. Request Ether by entering your testnet account address and selecting the button **Send me test Ether**.

    :::image type="content" source="../media/ropsten-test-faucet-request-ether.png" alt-text="Screenshot showing how to request test Ether on the Ropsten faucet.":::

1. Go back to Metamask and verify that you now have Ether in your account.

    :::image type="content" source="../media/metamask-ropsten-test-with-1-ether.png" alt-text="Screenshot showing the Metamask browser extension with 1 Ether.":::

### Install HDWalletProvider and fs

You'll need [HDWalletProvider](https://www.npmjs.com/package/@truffle/hdwallet-provider) as a wallet-enabled web3 provider to provide your secret mnemonic and connection network address and [fs](https://www.npmjs.com/package/fs) to read from your filesystem.

To install both of those, focus your attention back to the **todolist** project in Visual Studio Code. Open the terminal window and run the following commands:

1. `npm init`
1. `npm install fs`
1. `npm install @truffle/hdwallet-provider`

Wait for the installations of fs and HDWalletProvider to complete. You may see a number of warnings but unless there are errors, they can be ignored.

### Set up Infura and link the endpoints to the Ropsten Test Network

[Infura](https://infura.io/) development suite provides instant, scalable API access to the Ethereum networks. Infura is a hosted Ethereum node cluster which gives users the ability to run an application on a public network. Infura gives users the ability to deploy and interact with public networks.

Setting up an account is easy and has no cost. Go to the [Infura website](http://www.infura.io/) and do the following:

1. Set up an account and confirm your email address.
1. Select **Ethereum**, then **Create new project**, and then name the project **TodoList**.
1. Under the **Keys** section, change the endpoint to **Ropsten** using the dropdown.

It should look similar to the Test Project below.

:::image type="content" source="../media/infura-test-project.png" alt-text="Screenshot showing the process of creating an Infura project.":::

## Connect to Ropsten

Focus your attention back on the **todolist** project folder in Visual Studio Code.

1. In the Truffle configuration file, **./truffle-config.js**, un-comment the lines for **HDWallet Provider**, **InfruaKey**, **fs**, and **mnemonic**:

    ```javascript
     const HDWalletProvider = require('@truffle/hdwallet-provider');
     const infuraKey = "fj4jll3k.....";

     const fs = require('fs');
     const mnemonic = fs.readFileSync(".secret").toString().trim();
    ```

1. Go to your Infura account to get the infuraKey. In Infura, this is called the **Project ID** and also visible as part of the Ropsten endpoint.

    :::image type="content" source="../media/infurakey.png" alt-text="Screenshot focused on the Ropsten endpoint to copy.":::

1. Press the clipboard icon next to **Project ID** to copy and head back to the **./truffle-config.js** to paste in the infuraKey. Below is a sample of what this looks like, but note, your key will be different:

    ```javascript
    const infuraKey = "f6bfe21890a84b9fa27def74bafb0b1b";
    ```

1. Create a file called **.secret** and copy your mnemonic to that file. To get your mnemonic, go to MetaMask and navigate to **Settings** > **Security & Privacy**. Select **Reveal Seed Phrase**. Enter your Metamask password to verify and then select **Copy to clipboard**.

    >[!Note]
    >Do not share this with anyone or they will be able to access your account! If you are using **git**, make sure to include **.secret** in your **.gitignore** file.

    :::image type="content" source="../media/reveal-metamask-seed-phrase.png" alt-text="Screenshot to show how to reveal seed phrase in Metamask.":::

1. Use the code below to read the seed phrase from the file **.secret** and trim all the white spaces:

    ```javascript
    const mnemonic = fs.readFileSync(".secret").toString().trim();
    ```

1. Now define the network by un-commenting the Ropsten network settings in **truffle-config.js**. Make sure that your configuration looks like the following:

    ```javascript
    ropsten: {
       provider: () => new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/${infuraKey}`),
       network_id: 3,       // Ropsten's id
       gas: 5500000,        // Ropsten has a lower block limit than mainnet
       confirmations: 2,    // # of confs to wait between deployments. (default: 0)
       timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
       skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
     },
    ```

## Deploy to Ropsten

To deploy to Ropsten, run the following command from the Visual Studio Code terminal: 

`truffle migrate --network ropsten`

If your connection is successful, you will see the following output:

```output
Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.

Warning: Both truffle-config.js and truffle.js were found. Using truffle-config.js.

Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.


Starting migrations...
======================
> Network name:    'ropsten'
> Network id:      3
> Block gas limit: 8000029 (0x7a121d)


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x2f456acc5f842ddf0eb151742e47dd6e8ec5e48d73b1f150e2908cb56e0bf174
   > Blocks: 1            Seconds: 29
   > contract address:    0x789101d0B0Ffa4f8f87E67AF8ff8F84bD519752D
   > block number:        9398701
   > block timestamp:     1609784599
   > account:             0x896587D82C895F30433cade401068C2791A6936F
   > balance:             0.99616138
   > gas used:            191931 (0x2edbb)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.00383862 ETH

   Pausing for 2 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 9398702)
   > confirmation number: 2 (block: 9398703)

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.00383862 ETH


2_deploy_contracts.js
=====================

   Deploying 'TodoList'
   --------------------
   > transaction hash:    0xad8066308e9cc8503400c86a43674d856a71e02696e2c21b3e55f566df5afc36
   > Blocks: 0            Seconds: 8
   > contract address:    0x48112BE8d0E6e7bA892aFa2d4Ab58e9c43dd37De
   > block number:        9398706
   > block timestamp:     1609784870
   > account:             0x896587D82C895F30433cade401068C2791A6936F
   > balance:             0.98513544
   > gas used:            508959 (0x7c41f)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01017918 ETH

   Pausing for 2 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 9398707)
   > confirmation number: 2 (block: 9398708)

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:          0.01017918 ETH


Summary
=======
> Total deployments:   2
> Final cost:          0.0140178 ETH
```

## Verify deployment of contract

### On Metamask

Inspect Metamask to verify that the Ether used to deploy the contract.

### On Ropsten Etherscan

Go to [ropsten.etherscan.io](https://ropsten.etherscan.io), enter the contract address, and then inspect your contract.

:::image type="content" source="../media/ropsten-etherscan-with-deployed-contract.png" alt-text="Screenshot showing the contract deployed in Etherscan .":::

You can also open a new terminal window within Visual Studio Code and similar to interacting with your contract on the Ganache development blockchain, you can interact with your contract with the **truffle console**. The sample code below displays two networks which are active. Continue to interact with and inspect transactions using *truffle console* and *Ropsten Etherscan*.
