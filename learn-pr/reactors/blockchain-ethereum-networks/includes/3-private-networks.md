An Ethereum network is private if its nodes are isolated and not connected to a public network, such as the mainnet or a testnet. Private networks include development networks or consortium networks.

## Development networks

When you develop an Ethereum application, you'll start by running it on a private network. You'll want to see how it works before you deploy it. Similar to how you create a local server on your computer for web development, you can create a local blockchain instance to test your blockchain solution.

On your development network, you can create, test, and iterate changes to your solution quickly. You can make changes to your solution in development more seamlessly and quickly than in a public testnet. Tools such as [Ganache](https://www.trufflesuite.com/ganache?azure-portal=true) and [Hardhat](https://hardhat.org/?azure-portal=true) are most commonly used to run personal Ethereum development networks.

## Solutions for consortium networks

Consortiums are permissioned. They require an invitation to participate. Consortiums ensure security, privacy, compliance, and performance. 

The many options for consortium blockchains include Hyperledger Besu, R3 Corda, and Quorum. Let's explore two popular options for consortium blockchains: Hyperledger Besu and R3 Corda.

### Hyperledger Besu

[Hyperledger Besu](https://besu.hyperledger.org/en/stable/?azure-portal=true) is an open-source Ethereum client. It's developed under Apache License 2.0 and written in Java.

Besu is used to develop enterprise applications that require secure, high-performance transaction processing in a private network. It has a command-line interface and a JSON-RPC API. 

Besu runs, maintains, debugs, and monitors nodes in an Ethereum network. The API supports typical Ethereum functionalities, such as:

- Ether mining.
- Smart contract development.
- Decentralized application (Dapp) development.

Besu is a popular Ethereum client. It's unique it can be used in either public networks or private, consortium-based networks. 

Besu can be deployed in various [ways](https://besu.hyperledger.org/en/stable/HowTo/Get-Started/Installation-Options/Install-Binaries/?azure-portal=true). A recent preview is available in [Azure](https://azuremarketplace.microsoft.com/marketplace/apps/consensys.hyperledger-besu-quickstart?tab=Overview?azure-portal=true).

For more information about configuring and deploying, see the [Hyperledger Besu website](https://besu.hyperledger.org/en/latest/Tutorials/Examples/Private-Network-Example/?azure-portal=true).

### R3 Corda

The [Corda platform](https://www.r3.com/corda-platform/?azure-portal=true) is a private, permissioned blockchain. It focuses on supporting trusted communication, interactions, and transactions between entities. 

[Corda Enterprise](https://www.r3.com/corda-enterprise/?azure-portal=true) offers the core attributes of Corda open source along with business requirements that enterprises expect in licensed software. The Corda protocol is built on a strong identity model, where every node's identity *must* be properly onboarded.

Signing identities exist only on the Corda nodes. Client applications in a Corda-based solution trigger the workflow that was registered on the target Corda node. They monitor the progression of the flow. By contrast, Ethereum, where client applications play a critical role in the transaction life cycle, holds the signing keys and signing transactions before they're submitted to the nodes. Essentially, Corda applications, also called [*CorDapps*](https://docs.corda.net/docs/corda-os/4.7/cordapp-overview.html?azure-portal=true), completely live on the Corda nodes.

A [Corda Visual Studio Code extension](https://github.com/corda/vscode-corda?azure-portal=true) supports Corda development. To install the extension, in Visual Studio Code, select the **Extensions** icon. Then enter *Corda* to find and install the extension.
