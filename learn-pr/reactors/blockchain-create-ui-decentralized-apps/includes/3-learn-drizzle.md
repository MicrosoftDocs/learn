In past modules, we have introduced the [Truffle Suite](https://www.trufflesuite.com/?azure-portal=true), a set of tools to make blockchain development easier. And we have previously used [Truffle](https://www.trufflesuite.com/truffle?azure-portal=true) and [Ganache CLI](https://www.trufflesuite.com/ganache?azure-portal=true) previously to help with the development, deployment and testing of smart contracts.

In this unit, we will introduce the next member of the Truffle Suite, [Drizzle](https://www.trufflesuite.com/drizzle?azure-portal=true). Drizzle is a collection of front-end libraries that make writing dapp user interfaces easier and more predictable.

:::image type="content" source="../media/drizzle.png" alt-text="Image showing the Drizzle homepage":::

## Drizzle architecture

Before getting into how to use Drizzle, let's focus on the architecture so you know the different parts of the library that you can use to build your dapp.

Drizzle is completely modular, which means you can use as much or as little of the library portions as you like.

There are three core packages:

- **drizzle** The core library responsible for account and contract instantiation and wiring up the smart contracts.
- **drizzle-react** Makes it easier to connect Drizzle with your React app.
- **drizzle-react-components** A library of useful components for common dapp functions

:::image type="content" source="../media/modular-overview.png" alt-text="Image showing the Drizzle's architecture overview":::

### Underlying technologies

Drizzle provides the mechanisms for synchronizing and managing smart contract data and is based on a [Redux](https://redux.js.org/?azure-portal=true) store.

Underlying Technologies for managing the frontend apps which interact with the smart contacts can communicate via an API using a JSON-RPC layer called the Web3 API.

- [JSON-RPC](https://www.jsonrpc.org/specification?azure-portal=true) is a stateless,light-weight remote procedure call (RPC) protocol using JSON for the payload.

- [Web3](http://web3?azure-portal=true) is the Ethereum compatible javascript API and bindings which is built using the JSON-RPC spec. Any decentralized app can use this s Web3.js for browser based DApps.

- [Redux](https://redux.js.org/?azure-portal=true) is a predictable state container for JavaScript apps.

- [React.js](https://reactjs.org/?azure-portal=true) is a JavaScript library for building user interfaces.

## Drizzle components

Drizzle includes the following components:

- [\@drizzle/store](https://github.com/trufflesuite/drizzle/blob/develop/packages/store/README.md?azure-portal=true) is the state manager of Drizzle. It handles the boilerplate for web3 connection as synchronizing Smart Contract state and events.
  - Fully reactive contract data, including state, events and transactions.
  - Declarative so as not to waste valuable cycles on unneeded data.
  - Maintains access to underlying functionality. Web3 and contract's methods are still there, untouched.
- [\@drizzle/react-plugin](https://github.com/trufflesuite/drizzle/tree/master/packages/react-plugin?azure-portal=true) defines the Drizzle Provider for a React project.
  - Abstracts away the boilerplate of creating a dapp front-end
  - Handles instantiating web3 and contracts, fetching accounts, and keeping all of this data in sync with the blockchain.
- [\@drizzle/react-components](https://github.com/trufflesuite/drizzle/tree/master/packages/react-components?azure-portal=true) is a collection of primitive web controls that transforms smart contract data types to their appropriate html controls.
  - Provides a set of useful components for common UI elements.
- [\@drizzle/vue-plugin](https://github.com/trufflesuite/drizzle/blob/develop/packages/vue-plugin/README.md?azure-portal=true) a Vue adaptor and collection of html controls to support developing a Vue dapp.
