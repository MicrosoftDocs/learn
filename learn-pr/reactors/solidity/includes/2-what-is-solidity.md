# Learn about Solidity

Solidity is an object-oriented language for writing smart contracts. And smart contracts are code that specify the rules and behavior of how to transfer digital assets. You use Solidity to program smart contracts for the [Ethereum blockchain platform](https://ethereum.org/). Smart contracts contain state and programmable logic. Transactions instantiate smart contracts and execute functions that change state. Therefore, smart contracts enable you to create a business workflow.

## An overview

Solidity is the most popular programming language for the Ethereum blockchain.

Solidity is a high-level language that is based off of other programming languages before it, including C++, Python, and JavaScript. That means that if you're familiar with any of those languages, looking at Solidity code will feel very familiar.

Solidity is statically typed, which means that type checking happens at compile-time as opposed to run-time as happens with dynamically typed languages. With a statically typed language, the type of each variable needs to be specified. Python and JavaScript are dynamically-typed languages, whereas C++ is statically typed.

It supports inheritance so that functions, variables, and other properties from a contract class can be used in another. And it also supports complex user-defined types like structs and enums, which will be covered in a later unit.

Solidity is an open-source programming language. You can learn more about the project and how to contribute in their [GitHub repository](https://github.com/ethereum/solidity).

## What is Ethereum

Before we go any further, you should also familiarize yourself with Ethereum.

[Ethereum](https://ethereum.org/) is one of the most popular blockchain platforms out there, right behind Bitcoin. It is a community built technology and has its own cryptocurrency called Ether (ETH) that you can buy and sell.

What makes Ethereum unique is that it is the "world's programmable blockchain", which means you can code contract definitions, referred to as smart contracts, that are used to describe how blockchain participants transfer digital assets. Solidity is the primary programming language used to develop on the Ethereum platform, and it it built and maintained by Ethereum developers.

## The Ethereum Virtual Machine

Solidity contracts run on the Ethereum Virtual Machine or EVM for short. It is a sandbox environment that is completely isolated so that it does not access anything else on the network besides the contracts it executes. You don't need to know much more about the EVM for now, but just remember that Solidity smart contracts will be deployed to and run in a virtual machine.