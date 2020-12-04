In past modules, we introduced the [Truffle Suite](https://www.trufflesuite.com/?azure-portal=true), a set of tools to make blockchain development easier. And we used [Truffle](https://www.trufflesuite.com/truffle?azure-portal=true) and [Ganache CLI](https://www.trufflesuite.com/ganache?azure-portal=true) to help with the development, deployment, and testing of smart contracts.

This unit introduces the next member of the Truffle Suite, [Drizzle](https://www.trufflesuite.com/drizzle?azure-portal=true). Drizzle is a collection of front-end libraries that make writing dapp user interfaces easier and more predictable.

:::image type="content" source="../media/drizzle.png" alt-text="Screenshot that shows the Drizzle home page.":::

## Drizzle architecture

Before getting into how to use Drizzle, let's focus on the architecture so you know the different parts of the library that you can use to build your dapp.

Drizzle is completely modular, which means you can use as much or as little of the library portions as you like.

There are three core packages:

- **drizzle**: The core library responsible for account and contract instantiation and wiring up the smart contracts.
- **drizzle-react**: Makes it easier to connect Drizzle with your React app.
- **drizzle-react-components**: A library of useful components for common dapp functions.

:::image type="content" source="../media/modular-overview.png" alt-text="Screenshot that shows Drizzle's architecture overview.":::

### Underlying technologies

Drizzle provides the mechanisms for synchronizing and managing smart contract data. It's based on a [Redux](https://redux.js.org/?azure-portal=true) store.

Underlying technologies for managing the front-end apps that interact with the smart contacts can communicate via an API by using a JSON-RPC layer called the Web3 API:

- [JSON-RPC](https://www.jsonrpc.org/specification?azure-portal=true) is a stateless, lightweight remote procedure call (RPC) protocol that uses JSON for the payload.

- [Web3](http://web3?azure-portal=true) is the Ethereum-compatible JavaScript API and bindings that are built through the JSON-RPC specification. Any decentralized app can use Web3.js for browser-based dapps.

- [Redux](https://redux.js.org/?azure-portal=true) is a predictable state container for JavaScript apps.

- [React.js](https://reactjs.org/?azure-portal=true) is a JavaScript library for building user interfaces.

## Drizzle components

Drizzle includes the following components:

- [\@drizzle/store](https://github.com/trufflesuite/drizzle/blob/develop/packages/store/README.md?azure-portal=true) is the state manager of Drizzle. It handles the boilerplate for Web3 connection as synchronizing state and events for smart contracts.
  - Fully reactive contract data, including state, events, and transactions.
  - Declarative so you don't waste valuable cycles on unneeded data.
  - Maintains access to underlying functionality. Web3 and your contract's methods are still there, untouched.
- [\@drizzle/react-plugin](https://github.com/trufflesuite/drizzle/tree/master/packages/react-plugin?azure-portal=true) defines the Drizzle provider for a React project.
  - Abstracts away the boilerplate of creating a dapp front end.
  - Handles instantiating web3 and contracts, fetching accounts, and keeping all of this data in sync with the blockchain.
- [\@drizzle/react-components](https://github.com/trufflesuite/drizzle/tree/master/packages/react-components?azure-portal=true) is a collection of primitive web controls that transforms smart contract data types to their appropriate HTML controls.
  - Provides a set of useful components for common UI elements.
- [\@drizzle/vue-plugin](https://github.com/trufflesuite/drizzle/blob/develop/packages/vue-plugin/README.md?azure-portal=true) is a Vue adapter and collection of HTML controls to support developing a Vue dapp.
