In past modules, we introduced the [Truffle Suite](https://www.trufflesuite.com/?azure-portal=true), a set of tools that make blockchain development easier. And we've used [Truffle](https://www.trufflesuite.com/truffle?azure-portal=true) and [Ganache CLI](https://www.trufflesuite.com/ganache?azure-portal=true) to help with the development, deployment, and testing of smart contracts.

This unit introduces the next member of the Truffle Suite, [Drizzle](https://www.trufflesuite.com/drizzle?azure-portal=true). Drizzle is a collection of front-end libraries that make writing dapp user interfaces easier and more predictable.

:::image type="content" source="../media/drizzle.png" alt-text="Screenshot that shows the Drizzle home page.":::

### About Drizzle

Drizzle is built with JavaScript. It works particularly well with and has great support for [React](https://reactjs.org/?azure-portal=true), which is the most popular JavaScript library for building front-end user interfaces. However, there's also an option to use front-end JavaScript frameworks like [Vue.js](https://vuejs.org?azure-portal=true) or [Angular](https://angular.io?azure-portal=true).

Drizzle helps to synchronize and manage smart contract data. This is significant so that all the blockchain data stays in sync with your app interface. It uses a [Redux](https://redux.js.org/?azure-portal=true) store. Redux is a state container for JavaScript apps that makes it easy to track all transactions. Plus, it helps applications behave consistently for all users and any environment they use.

Drizzle apps interact with smart contacts by using a JSON-RPC layer called the Web3 API.

[JSON-RPC](https://www.jsonrpc.org/specification?azure-portal=true) is a stateless, lightweight remote procedure call (RPC) protocol that uses JSON for the payload. This specification defines several data structures and the rules around their processing.

To talk to an Ethereum node from a JavaScript application, the [Web3 API](https://web3js.readthedocs.io?azure-portal=true) is needed. Web3 is the Ethereum-compatible JavaScript API and has bindings that are built through the JSON-RPC protocol.

## Drizzle components

Before we get into how to use Drizzle, let's focus on the main libraries that you can use to build your dapp.

Drizzle is modular, which means you can use as much or as little of the library portions as you want.

The three core packages are:

- **drizzle**: The core library responsible for web3, account, and contract instantiation. It's also used to wire up the smart contracts to the dapp.
- **drizzle-react**: A library that abstracts the core Drizzle functionality into usable React components.
- **drizzle-react-components**: A library of useful user interface components for common dapp functions. The library currently includes ContractData, ContractForm, and LoadingContainer.

:::image type="content" source="../media/modular-overview.png" alt-text="Screenshot that shows Drizzle's architecture overview.":::

## Install and use Drizzle

Drizzle can be installed with the help of the node package manager (npm). To install Drizzle all you need to do is go to your terminal and type: `npm install drizzle --save`.

Then when you're ready to use Drizzle, you can import the packages that you want to use in your project like the following:

```javascript
import { Drizzle } from "@drizzle/store";
import { newContextComponents } from "@drizzle/react-components";
import { DrizzleContext } from "@drizzle/react-plugin";
```
