Truffle is the most popular development framework for Ethereum. It can easily be installed with the help of the node package manager.

## About Truffle

With Truffle, you get some of the following benefits:

- Smart contract building, compilation, deployment, testing and more
- Network management for deploying to public & private networks
- Package management for dependencies
- Interactive console for direct contract communication
- Configurable build pipeline

## Install Truffle

From your terminal, you can install Truffle easily with the help of the node package manager. Type:

`npm install -g truffle`

To confirm truffle is installed, type:

`truffle`

That will show the version installed and present the list of commands available to use Truffle with:

:::image type="content" source="media\truffle.png" alt-text="Truffle options shown in terminal":::

## Get started with using Truffle

Now that Truffle is installed, let's use it to run the tests that were generated as part of our newSolidityProject.

You can find the test file in test/HelloBlockchain.js. Take a look through the test file to try to understand what's being tested.

1. In Visual Studio Code, go to Terminal -> New Terminal
1. In the terminal run `truffle compile`. Wait for the source files to compile successfully.
1. Then run `truffle migrate`. Wait for the migrations to finish

### Test the contract

Let's use it to run the tests that were generated as part of our newSolidityProject.

You can find the test file in test/HelloBlockchain.js. Take a look through the test file to try to understand what's being tested.

From the terminal type: `truffle test`.

Notice that the tests fail due to the following.

```markdown
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

And this indicates that I need a local Ethereum blockchain client running for the tests to access.

### Ganache CLI

The most popular local Ethereum blockchain is Ganache. We're going to use the [CLI](https://github.com/trufflesuite/ganache-cli) version to interact with it directly from the terminal. Ganache CLI is commonly used for development and testing. To install it on your project, focus your attention to the terminal. Right-click and select `New Terminal`. Once the new terminal window opens run:
`npm install -g ganache-cli`

Once Ganache CLI installs successfully, run:
`ganache-cli`

:::image type="content" source="media\start-ganache.png" alt-text="Start ganache-cli from the terminal":::

Notice that there are 10 accounts generated on this blockchain that each receive 100 test Ether to use. Each account also has a corresponding private key. And there is also a mnemonic, which is a unique twelve world phrase to access the wallet and allows transactions to be made from these accounts.

And lastly, it displays its address, which we’ll use to connect to it. By default, this will be 127.0.0.1:8545.

Now run `truffle test`.

In the terminal you will now see that all tests have passed.

:::image type="content" source="media\truffle-test.png" alt-text="Run truffle test from the terminal":::
