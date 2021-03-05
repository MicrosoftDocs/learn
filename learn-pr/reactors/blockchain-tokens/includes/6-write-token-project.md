Now that we have a basic project set up, let's create a new token contract by using the ERC20 token standard from OpenZeppelin.

## Create the new token contract

We're going to create a token contract to reward miners for creating new blocks in the blockchain.

To begin, open the **Token20** project in Visual Studio Code. When the project is open, in the Explorer, right-click the **contracts** folder, and then select **New File**. Save the file name as **ERC20MinerReward.sol**. Copy the following code into that contract:

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

## Understand the code

Now, let's walk through the parts of this contract.

First, we import the OpenZeppelin contract we want to use after the pragma directive. The string `import "@openzeppelin/contracts/token/ERC20/ERC20.sol";` allows the contract to find the ERC20 contract definition we'll use in our own contract.

Then, we define an event called `LogNewAlert`, which will be emitted or called later in the contract.

The constructor defines a new ERC20 token named `MinerReward` by using the symbol `MRW`. When a contract is created, this new token is generated.

When the `reward` function is called, the current block's miner, `block.coinbase`, receives 20 MRW tokens for mining this block and an event is emitted.

## Build the contract

After you save the contract file, you're ready to build the contract. We'll be using Ganache CLI as your personal blockchain for development. We'll use Truffle to run the build.

1. Open the **truffle-config.js** file, and then search for the line `solc`.
1. In the `solc` section, uncomment the version by deleting `//`. Replace the version value with `0.6.3`. Note that this version number is required because the OpenZeppelin contracts specify the pragma directive as `pragma solidity ^0.6.2;`.
1. Save the file.
1. In Visual Studio Code, select **Terminal** > **New Terminal** to open a terminal window.
1. In the terminal, enter `ganache-cli` to start Ganache CLI. Information for about 10 accounts is generated for tests, followed by the account's private keys and other metadata about the development server. The last line tells you that `ganache-cli` is listening on 127.0.0.1:8545, the default port location, defined in your truffle-config.js file.
1. Right-click in the terminal window, and then select **New Terminal**.
1. In the new terminal window, enter `truffle build`.

The following output should appear in your terminal window:

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

Notice that, in addition to the contracts that are defined in the contracts folder, the contracts in \@openzeppelin/contracts also are compiled. Make sure that the build finishes successfully before you move on.

## Wrap up

This example is a basic and straightforward implementation of an ERC20 token. You can see how easy it is to write your own token contracts that inherit functions and events from a defined ERC token standard.

It's important to remember that the term *token* is simply a metaphor. It refers to assets or access rights that are collectively managed by a network of computers or by a blockchain network. Tokens are an important item to incorporate into your blockchain network.

To become more familiar with tokens, explore the other token contracts that are available from OpenZeppelin. Try creating your own token contracts!
