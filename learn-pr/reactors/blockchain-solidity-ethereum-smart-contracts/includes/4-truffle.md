Truffle is the most popular development framework for Ethereum. You can install it by using the node package manager (NPM).

## About Truffle

Truffle provides the following benefits:

- Smart contract building, compilation, deployment, and testing
- Network management for deploying to public and private networks
- Package management for project dependencies
- Interactive console for direct contract communication and management
- Configurable build pipeline to automatically run checks and configure projects

## Install Truffle

You can install Truffle by using the node package manager. In the terminal, type:

`npm install -g truffle`

To confirm that Truffle is installed, type:

`truffle`

The output shows the installed version and presents the list of commands available for Truffle:

:::image type="content" source="../media/truffle.png" alt-text="Screenshot of the terminal, showing the Truffle version and the available commands.":::

## Get started with Truffle



1. In Visual Studio Code, go to **Terminal** > **New Terminal**.
1. In the terminal, run `truffle compile`. Wait for the source files to compile successfully.
1. Run `truffle migrate`. Wait for the migrations to finish.

### Test the contract

Let's run the tests that were generated as part of newSolidityProject.

You can find the test in *test/HelloBlockchain.js*. Look through the test file to try to understand what's being tested.

In the terminal, type `truffle test`.

The test fails because Truffle can't connect to the Ethereum client:

```output
Could not connect to your Ethereum client with the following parameters:
    - host       > 127.0.0.1
    - port       > 8545
    - network_id > *
Please check that your Ethereum client:
    - is running
    - is accepting RPC connections (i.e., "--rpc" option is used in geth)
    - is accessible over the network
    - is properly configured in your Truffle configuration file (truffle-config.js)
```

This output indicates that you need a running local Ethereum blockchain client that the tests can access.

### Ganache CLI

The most popular local Ethereum blockchain is Ganache. We'll use the [CLI version](https://github.com/trufflesuite/ganache-cli) so that we can interact with it directly from the terminal. Ganache CLI is commonly used for development and testing. 

To install Ganache CLI in your project, go to the terminal. Right-click and then select `New Terminal`. When the new terminal window opens, run: 

`npm install -g ganache-cli`

After Ganache CLI is installed, run:

`ganache-cli`

:::image type="content" source="../media/start-ganache.png" alt-text="Screenshot showing how to start Ganache C L I from the terminal by running the ganache-c l i command.":::

Notice that the blockchain has 10 generated accounts, and each receives 100 test ether to use. Each account also has a corresponding private key. Every account also has a *mnemonic*. A mnemonic is a unique 12-word phrase that provides access to the wallet and allows transactions to be made from the account.

The output also displays the blockchain's address. We'll use this address to connect to the blockchain. By default, the address is 127.0.0.1:8545.

Now run `truffle test` again.

In the terminal, you see that all tests have passed.

:::image type="content" source="../media/truffle-test.png" alt-text="Screenshot showing the terminal. The output shows that the Truffle tests have passed.":::
