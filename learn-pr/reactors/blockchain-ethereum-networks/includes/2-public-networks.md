The [Ethereum](https://ethereum.org/?azure-portal=true) protocol is made up of multiple public networks. Different Ethereum networks can have different properties, uses, functionality, and consensus mechanisms. There are currently four different test networks, called *testnets*, and one production network, called *mainnet*.

## An overview of mainnet

[Mainnet](https://ethereum.org/en/glossary/#mainnet), short for "main network" is the one real public Ethereum blockchain. Applications that are deployed to the mainnet can exchange and use information and interact with one another.

Once deployed, the applications can use the full potential of decentralized blockchain. There's no centralized authority and mainnet is fully decentralized. There might be different types of tokens and applications deployed to mainnnet. Once deployed on the mainnet, transactions are immutable and can't be changed. Each transaction also has real costs associated with it, which requires actual Ether (ETH). All blocks on the Ethereum mainnet can be viewed by using [Etherscan](https://etherscan.io/), which shows the latest mined blocks and transactions. All blocks can be inspected.

:::image type="content" source="../media/etherscan.png" alt-text="Screenshot showing the homepage of Etherscan.":::

## Ethereum testnets

There are four public testnets, each with a different deployment method and process. They stage and test applications in a live public environment before they deploy the applications to the mainnet.

Testnets use either [Proof of Work (PoW)](https://www.investopedia.com/terms/p/proof-work.asp?azure-portal=true) or [Proof of Authority (PoA)](https://academy.binance.com/en/articles/proof-of-authority-explained/?azure-portal=true) consensus protocols to determine how to add new blocks of transactions to the network. Here's a quick overview of each protocol:

- **PoW**: A mining rig solves a cryptographic hashing problem to mine a new block and decide which transactions are part of that block.
- **PoA**: Block validators verify their identity on a network to decide which transactions become part of the next block in the chain.

 And testnets require **test ether**, which is free and can be accessed from what are called *faucets*. You provide faucets with an account address to receive a certain amount of test ether. Using faucets has become the primary way to acquire test ether for a specific testnet. The community manages these public test networks for the benefit of developers and testing. Using a faucet protects the testnet from spam attacks since the ether is controlled by trusted parties.

## Testnet Comparison

Let’s take a look at the different [Ethereum testnets](https://ethereum.org/en/developers/docs/networks/#testnets) and associated properties.

### Ropsten

[Ropsten](https://ropsten.etherscan.io/?azure-portal=true) is a PoW consensus protocol, closest to mainnet in functionality. It's named after a Swedish subway station and has been around since 2016. Some say it has the best reproduction of the conditions on the mainnet.

- More details:
  - Supports: [Geth](https://geth.ethereum.org/?azure-portal=true) and [OpenEthereum](https://openethereum.github.io/?azure-portal=true) clients
  - Block time: 30 seconds or less
  - Faucet: [https://faucet.ropsten.be/](https://faucet.ropsten.be/?azure-portal=true)
  - Explorer: [https://ropsten.etherscan.io/](https://ropsten.etherscan.io/?azure-portal=true)
  - GitHub: [https://github.com/ethereum/ropsten](https://github.com/ethereum/ropsten/?azure-portal=true)

### Kovan

[Kovan](https://kovan-testnet.github.io/website/?azure-portal=true) is a PoA testnet named after a subway station in Singapore. Its Ether must be requested from the faucet and is controlled by trusted parties. Because of this property, it's immune to spam attacks.

- More details:
  - Supports: [OpenEthereum](https://openethereum.github.io/?azure-portal=true) clients
  - Block time: 4 seconds
  - Faucet: [https://faucet.kovan.network/](https://faucet.kovan.network/?azure-portal=true)
  - Explorer: [https://kovan.etherscan.io/](https://kovan.etherscan.io/?azure-portal=true)
  - GitHub: [https://github.com/kovan-testnet/proposal](https://github.com/kovan-testnet/proposal/?azure-portal=true)
  - Website: [https://kovan-testnet.github.io/website/](https://kovan-testnet.github.io/website/?azure-portal=true)

### Rinkeby

[Rinkeby](https://www.rinkeby.io/?azure-portal=true), a PoA testnet started by the Ethereum team in April 2017, is named after a metro station in Stockholm.

- More details:
  - Supports [Geth](https://geth.ethereum.org/?azure-portal=true) client
  - Block time: 15 seconds
  - Faucet: [https://faucet.rinkeby.io/](https://faucet.rinkeby.io/?azure-portal=true)
  - Explorer: [https://rinkeby.etherscan.io/](https://rinkeby.etherscan.io/?azure-portal=true)
  - GitHub: [https://github.com/ethereum/EIPs/issues/225](https://github.com/ethereum/EIPs/issues/225/?azure-portal=true)
  - Website: [https://www.rinkeby.io](https://www.rinkeby.io/?azure-portal=true)

### Görli

PoA cross-client testnet [Görli](https://goerli.net/?azure-portal=true) was named after a Berlin subway station. This testnet has the goal of being both widely usable across various clients. It's robust enough to guarantee consistent availability and was started by the Goerli Initiative in 2018.

- More details:
  - Supports: Most clients including [Geth](https://geth.ethereum.org/?azure-portal=true), [OpenEthereum](https://openethereum.github.io/?azure-portal=true), and [Nethermind](https://nethermind.io/?azure-portal=true)
  - Block time: 15 seconds on average
  - Faucet: [https://faucet.goerli.mudit.blog/](https://faucet.goerli.mudit.blog/?azure-portal=true)
  - Status Dashboard: [https://stats.goerli.net/](https://stats.goerli.net/?azure-portal=true)
  - Explorer: [https://goerli.etherscan.io/](https://goerli.etherscan.io/?azure-portal=true)
  - GitHub: [https://github.com/goerli/testnet](https://github.com/goerli/testnet/?azure-portal=true)
  - Website: [https://www.goerli.net](https://www.goerli.net/?azure-portal=true)

Ropsten is said to be the testnet most similar to mainnet and was historically the first major testnet. Kovan, Goerli, and Rinkeby are stable and have increased usage. Before deploying to mainnet, you're advised to deploy to and test on multiple testnets.

## Clients and APIs for deploying to **Testnets** and **Mainnet**

Ethereum is designed to offer different clients, developed by different teams using different programming languages. This variety makes the network stronger and more diverse. The ideal goal is to achieve diversity without any client dominating to reduce any single points of failure.

### Clients

Below is a summary of some common [Ethereum clients](https://ethereum.org/en/developers/docs/nodes-and-clients/#clients):

[Geth Client](https://geth.ethereum.org/?azure-portal=true)

Go Ethereum (Geth for short) is one of the original implementations of the Ethereum protocol. Currently, it's the most widespread client with the biggest user base and variety of tooling for users and developers. It's written in Go, fully open source, and licensed under the GNU LGPL v3.

[OpenEthereum](https://openethereum.github.io/?azure-portal=true)

OpenEthereum's goal is to be the fastest, lightest, and most secure Ethereum client. We're developing OpenEthereum by using the Rust programming language. OpenEthereum is licensed under the GPLv3 and can be used for all your Ethereum needs.

[Nethermind](https://nethermind.io/?azure-portal=true)

Nethermind provides the world's fastest .NET Ethereum Client and P2P Data Marketplace, along with consulting services for anyone looking to build Ethereum blockchain solutions.

### APIs

[Infura](https://infura.io/?azure-portal=true)

The Infura API suite provides instant access over HTTPS and WebSockets to the Ethereum and IPFS networks. It provides a simple, easy to use interface for connecting to the endpoints of all testnets. Infura supports both **Truffle Suite** and the **VS Code Blockchain Development Kit for Ethereum.**

[MetaMask](https://metamask.io/?azure-portal=true)

When deploying to either a testnet or mainnet, the MetaMask client provides a robust interface and wallet that connects to and interacts with Ethereum blockchains.

Using MetaMask to send Ether and tokens on a testnet is straightforward. As we've seen in previous tutorials, the client provides an easy interface to select and use different Ethereum networks. For interacting with development networks, it's simple with MetaMask to connect to Localhost 8545 or Custom RPC to connect with Ganache and Truffle. Similarly, MetaMask has predefined connections to the public testnets and mainnet. If connecting to mainnet, be careful to secure your private key since real Ether is being used.
