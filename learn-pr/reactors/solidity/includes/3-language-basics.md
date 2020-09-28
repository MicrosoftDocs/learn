# Understand the language basics

All Solidity contracts usually include:

- Pragma directives
- State Variables
- Functions
- Events

There is of course, more than that you need to know to program production level smart contracts, but these are the four things that will get you off on the right foot.

If you have an understanding of these concepts, you can get started writing smart contracts right away!

## Pragma directives

**Pragma** is the keyword that you use to ask the compiler to check whether its version of Solidity matches the one required. If it matches that means your source file can run successfully, if not then the compiler will error.

You should always make sure to include the latest version of Solidity in your contract definition. To find the current version of Solidity, visit the [Solidity website](https://solidity.readthedocs.io/). Then you can use that version in your source file.

A version pragma directive looks like:
`pragma solidity ^0.7.0;`

This line means that the source file will compile with a compiler greater than the version `0.7.0`, up until `0.7.9`. Starting in version `0.8.0` there will likely be breaking changes introduced that the source file cannot compile successfully.

## State variables

State variables are key to any Solidity source file. They are variables whose values are permanently stored in contract storage.

```solidity
pragma solidity >0.7.0 <0.8.0;

contract Marketplace {
    uint price; // State variable  
```

> [!NOTE]
> Contract source files always start with the definition **contract _ContractName_**.

In this example, the state variable is named `price` with type **uint**. The integer type uint indicates that this variable is an unsigned integer with 256 bits. That means it can store positive numbers in the range of 0 to 2^256 -1.

For all variable definitions you must specify the type as well as the variable name.

Additionally, you can specify the visibility of a state variable as:

- **public:** part of the contract interface and can be accessed from other contracts
- **internal:** only accessed internally from the current contract
- **private:** only visible for the contract they are defined in

## Functions

Functions are executable units of code within a contract. Functions describe a single action to take to achieve one task. They are reusable and can also be called from other source files like libraries. They behave very similarly to functions in other programming languages.

A simple example to define a function is this:

```solidity
pragma solidity >0.7.0 <0.8.0;

contract Marketplace {
    function buy() public {
        // ...
    }
}
```

This shows a function with that name `buy` that has a public visibility, meaning that it can be accessed by other contracts. Functions can use one of the following visibility specifiers: **public**, **private**, **internal** and **external**.

A function can be called internally or externally from another contract. Functions can accept parameters and return variables to pass parameters and values between them. Here is an example of a function that both accepts a parameter, which is an integer called `price` and returns an integer:

```solidity
pragma solidity >0.7.0 <0.8.0;

contract Marketplace {
    function buy(uint price) public returns (uint) {
        // ...
    }
}
```

### Function modifiers

Function modifiers can be used to change the behavior of functions. They work by checking a condition before the function executes. For example, checking that only a user designated as a seller can list an item for sale.

```solidity
pragma solidity >0.7.0 <0.8.0;

contract Marketplace {
    address public seller;

    modifier onlySeller() {
        require(
            msg.sender == seller,
            "Only seller can put an item up for sale."
        );
        _;
    }

    function listItem() public view onlySeller {
        // ...
    }
}
```

This example introduces a couple new things:

- A variable with a type **address** which will store the 20 byte Ethereum address of the seller user (we will explain this more in a following unit)
- A modifier called `onlySeller` which describes that only a seller can list an item
- A special symbol `_;` to indicate where the function body gets inserted
- A function definition that uses the modifier `onlySeller`

Additional function modifiers that can be used in the function definition are:

- **pure** to describe functions that don't allow modifications or access of state
- **view** to describe functions that don't allow modifications of state
- **payable** to describe functions that can receive Ether

## Events

Events describe actions that are taken in the contract. Events have parameters like functions do that need to be specified when the event is called.

To call an event, you must use the keyword **emit** with the event name and it's parameters.

```solidity
pragma solidity >0.7.0 <0.8.0;

contract Marketplace {
    event PurchasedItem(address buyer, uint price);

    function buy() public {
        // ...
        emit PurchasedItem(msg.sender, msg.value);
    }
}
```

When you call an event, the event is captured as a transaction in the transaction log, which is a special data structure in the blockchain. These logs are associated with the address of the contract, are incorporated into the blockchain, and stay there forever. The log and its event data is not accessible from within contracts, and cannot be modified.
