An Ethereum network is considered to be private when the nodes of the network are isolated. In a private network, the nodes are never connected to a public network like in the mainnet or a testnet. Private Ethereum networks include development networks and consortium networks.


## Development networks

When you develop an Ethereum application, you start by running the app on a private network. You need to see how the application works before you deploy it into production. This type of private network is called a *development network*.

Building a blockchain solution in a development network is similar to designing a web app on a local server. You can design, build, test, and iterate your solution in the same environment.

On a development network, you can create, test, and iterate changes to your solution quickly. You can iterate on your solution in a development network more seamlessly and quickly than a public testnet. Tools such as [Ganache](https://www.trufflesuite.com/ganache?azure-portal=true) and [Hardhat](https://hardhat.org/?azure-portal=true) are most commonly used to run personal Ethereum development networks.


## Solutions for consortium networks

*Consortium networks* are permissioned. They require an invitation to participate. Consortium networks ensure security, privacy, compliance, and performance. 

The many options for consortium blockchains include Hyperledger Besu, R3 Corda, and Quorum. Let's explore two popular options for consortium blockchains: Hyperledger Besu and R3 Corda.


### Hyperledger Besu

[Hyperledger Besu](https://besu.hyperledger.org/en/stable/?azure-portal=true) is an open-source Ethereum client. It's developed under Apache License 2.0 and written in Java.

Besu is used to develop enterprise applications that require secure, high-performance transaction processing in a private network. It has a command-line interface and a JSON-RPC API. 

Besu runs, maintains, debugs, and monitors nodes in an Ethereum network. The API supports typical Ethereum functionalities, such as:

- Ether mining
- Smart contract development
- Decentralized application (Dapp) development

Besu is a popular Ethereum client. It's unique it can be used in either public networks or private, consortium-based networks. 

Besu can be deployed in various [ways](https://besu.hyperledger.org/development/public-networks?azure-portal=true). For more information about configuring and deploying, see the [Hyperledger Besu website](https://besu.hyperledger.org).


### R3 Corda

The [Corda platform](https://www.r3.com/corda-platform/?azure-portal=true) is a private, permissioned blockchain. It focuses on supporting trusted communication, interactions, and transactions between entities. 

[Corda Enterprise](https://www.r3.com/corda-enterprise/?azure-portal=true) provides the core attributes of the Corda open-source codebase. A key feature is support for enterprise business requirements for licensed software.

In Ethereum, client applications play a pivotal role in the transaction lifecycle. The client application obtains the signing keys and transactions before the identities are submitted to the nodes.

In the Corda platform, the client applications (commonly called [*CorDapps*](https://docs.r3.com/en/platform/corda/4.9/enterprise/cordapps/cordapp-overview.html?azure-portal=true)), live completely **on** the Corda nodes. The key and transaction signing identities exist only on the nodes and not with the client. Client applications trigger the workflow that's registered on the target Corda node, and monitor the workflow progression.

A [Corda Visual Studio Code extension](https://github.com/corda/vscode-corda?azure-portal=true) supports Corda development. To install the extension, in Visual Studio Code, select the **Extensions** icon. Then enter *Corda* to find and install the extension.
