Now that we have a basic project setup, let's create a new token contract using the ERC20 token standard from OpenZeppelin.

## Create the new token contract

We're going to create a token contract to reward miners for creating new blocks in the blockchain.

To begin with open up the **Token20** project in Visual Studio Code. Once open, hover over the contracts folder in the Explorer, right-click and select the New File option. Save the file name as: `ERC20MinerReward.sol`. Copy the contents from below to that contract.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20MinerReward is ERC20 {

    event LogNewAlert(string description, address indexed _from, uint256 _n);

    constructor() public ERC20("MinerReward", "MRW") {}

    function _reward() public {
        _mint(block.coinbase, 20);
        emit LogNewAlert('_rewarded', block.coinbase, block.number);
    }
}
```

## What this all means

Now, let's walk through the parts of this contract.

First, we begin with importing the contract from OpenZeppelin that we want to use after the pragma directive. The notation: `import "@openzeppelin/contracts/token/ERC20/ERC20.sol";` allows the contract to find the ERC20 contract definition we'll use in our own contract.

Then we define an event called **LogNewAlert** which will be emitted or called later on in the contract.

The constructor defines a new ERC20 token named **MinerReward** with the symbol **MRW**. A contract creation, this new token will be generated.

When the reward function is called, the current block's miner, **block.coinbase**, will receive 20 MRW tokens for mining this block, and an event gets emitted.

## Build the contract

After saving the contract file, you are now ready to build the contract. We'll be using Ganache CLI as your personal blockchain for development and Truffle to run the build.

1. First, open up the file **truffle-config.js** and search for the line **solc**.
1. In the **solc** section, uncomment the version by removing the `//` and replace the version listed with `0.6.3`. Note, that this is required since the OpenZeppelin contracts specify the pragma directive as **pragma solidity ^0.6.2;**.
1. Save the file after updating the version number.
1. Open up a terminal window in VS Code, by going to **Terminal > New Terminal**.
1. Start up Ganache CLI, by typing: `ganche-cli`. You will see the information for 10 accounts generated for tests, followed by the account's private keys, and other metadata about the development server. The last line will tell you that ganache-cli is listening on 127.0.0.1:8545, the default location in port as defined in your truffle-config.js file.
1. Right-click in the terminal window and select **New Terminal**.
1. In that new terminal window, type: `truffle build`.

You should see the following output in your terminal window

```output
$ truffle build
No build configuration found. Preparing to compile contracts.

Compiling your contracts...
===========================
> Compiling ./contracts/ERC20MinerReward.sol
> Compiling ./contracts/Migrations.sol
> Compiling @openzeppelin/contracts/GSN/Context.sol
> Compiling @openzeppelin/contracts/math/SafeMath.sol
> Compiling @openzeppelin/contracts/token/ERC20/ERC20.sol
> Compiling @openzeppelin/contracts/token/ERC20/IERC20.sol
> Compiling @openzeppelin/contracts/utils/Address.sol
> Artifacts written to /Users/meaghanlewis/Projects/Token20/build/contracts
> Compiled successfully using:
   - solc: 0.6.3+commit.8dda9521.Emscripten.clang
```

Notice that in addition to the contracts defined in the contracts folder, the contracts in @openzeppelin/contracts are also compiled. Make sure that the build completes successfully before you move on.

## Wrap up

This example above is a pretty straightforward implementation of an ERC20 token. You can see how easy it is to write your own token contracts which inherit functions and events from a defined ERC token standard.

The important thing to remember is that the term “token” is simply a metaphor. It refers to assets and/or access rights that are collectively managed by a network of computers, or a blockchain network. Tokens are an important item to incorporate into your blockchain network.

To get more familiar with tokens, explore the other token contracts available from OpenZeppelin and try out creating your own token contracts.
