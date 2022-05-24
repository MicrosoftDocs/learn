Truffle is the most popular development environment and testing framework for Ethereum. You can install it by using the node package manager (npm).

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

For more information about getting started with Truffle, refer to the [Truffle Quickstart](https://trufflesuite.com/docs/truffle/quickstart/).

### Ganache

The most popular local Ethereum blockchain is Ganache. You can use Ganache to develop, deploy, and test in a safe and deterministic environment. Ganache can be used from the command line, programmatically via Node.js, or in the browser. In this module, we'll use the [command line version](https://github.com/trufflesuite/ganache#command-line-use) so that we can interact with it directly from the terminal.

To install Ganache in your project, go to the terminal. Right-click and then select `New Terminal`. When the new terminal window opens, run:

`npm install ganache --global`

After Ganache is installed, run:

`ganache`

:::image type="content" source="../media/start-ganache.png" alt-text="Screenshot showing how to start Ganache from the command line by running the ganache command.":::

Notice that the blockchain has 10 generated accounts, and each receives 100 test ether to use. Each account also has a corresponding private key. Every account also has a *mnemonic*. A mnemonic is a unique 12-word phrase that provides access to the wallet and allows transactions to be made from the account.

The output also displays the blockchain's address. We'll use this address to connect to the blockchain. By default, the address is 127.0.0.1:8545.

 For more information about getting started with Ganache, see the [Ganache Quickstart](https://trufflesuite.com/docs/ganache/quickstart/).
