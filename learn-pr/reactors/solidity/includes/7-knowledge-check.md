# Knowledge check

- Solidity smart contracts are run on:

  - Ethereum blockchain // incorrect. this is the name of the platform Solidity targets, but not what test are run on
  - The Ethereum virtual machine // correct. Solidity runs contracts on what's called the Ethereum virtual machine which is a sandboxed environment to self-contain all the transaction history for the contracts.
  - A virtual machine // incorrect. a virtual machine is an option to run tests in, but a specific kind of virtual machine is used for Solidity smart contracts.
  - A sandbox environment // incorrect. The Ethereum virtual machine is a sandboxed and isolated environment, but that is just a feature of the virtual machine, and not the main focus.

- Events in contracts describe actions that are taken in the contract. What is the correct syntax to define an event?
  - event PurchasedItem; //incorrect. the event must be called like a function with a set of parenthesis at the end like `event PurchasedItem()` and include any arguments inside of the parenthesis.
  - event PurchasedItem(address buyer, uint price); //correct. to define an event you used the keyword `event` and then give the event a name and describe which arguments, if any, must be included inside parenthesis.  
  - emit PurchasedItem(address buyer, uint price); //incorrect. this is the syntax to call the event and create an entry in the transactions log.
  - PurchasedItem(address buyer, uint price); //incorrect. this would be the syntax to call a function that's previously been defined, not an event.

- What is an example of a user-defined type in Solidity?

  - Structs // correct. Structs are user-defined because you can define the collection of items within a struct.
  - State variables // incorrect. State variables use defined types like uint, int, bool, and addresses to hold values that are used in contracts.
  - Addresses // incorrect. Addresses are 20 byte value types that represent an Ethereum user account. A value is specified for a given address type.
  - Arrays //incorrect. Arrays use defined types to store a collection of similar items of same type in a data structure.

- What is typically the first line of a smart contract source file?

  - A contract definition // incorrect. The contract definition is required as part of the source file, but it is not the first line.
  - A pragma directive // correct. Pragma is the keyword that you use to ask the compiler to check whether its version of Solidity matches the one required.
  - A solidity version // incorrect. A solidity version is part of the pragma directive, but does not include the keyword for the compiler to check.
  - An event // incorrect. Events are typically part of ever smart contract, but are not required, and exist inside the contract definition.
