The [Ethereum](https://ethereum.org/?azure-portal=true) protocol is made up of multiple public networks. Different Ethereum networks can have different properties, uses, functionality, and consensus mechanisms. Ethereum currently has four test networks, called *testnets*. It has one production network, called the *mainnet*.

## Overview of the mainnet

The [*mainnet*](https://ethereum.org/en/glossary/#mainnet?azure-portal=true) (short for "main network"), is the one real public Ethereum blockchain. Applications that are deployed to the mainnet can exchange and use information and interact with one another.

Deployed applications can exercise the full capabilities of the decentralized blockchain. There's no centralized authority. The mainnet is fully decentralized. 

Different types of tokens and applications might be deployed to the mainnet. After transactions are deployed on the mainnet, they're immutable and can't be changed. 

Each transaction has real costs. These costs require ether (ETH) cryptocurrency. 

You can view all blocks on the Ethereum mainnet by using [Etherscan](https://etherscan.io?azure-portal=true). Etherscan shows the latest mined blocks and transactions. All blocks can be inspected.

:::image type="content" source="../media/etherscan.png" alt-text="Screenshot showing the home page of Etherscan.":::

## Ethereum testnets

Ethereum has four public testnets. Each testnet has a different deployment method and process. The testnets stage and test applications in a live public environment before they deploy the applications to the mainnet.

Testnets use either [proof of work (PoW)](https://www.investopedia.com/terms/p/proof-work.asp?azure-portal=true) or [proof of authority (PoA)](https://academy.binance.com/en/articles/proof-of-authority-explained/?azure-portal=true) consensus protocols to determine how to add new blocks of transactions to the network. Here's a quick overview of each protocol:

- **PoW**: A mining rig solves a cryptographic hashing problem to mine a new block and decide which transactions are part of that block.
- **PoA**: Block validators verify their identity on a network to decide which transactions become part of the next block in the chain.

Testnets require *test ether*. Test ether is free, and you can access it from *faucets*. You provide faucets with an account address to receive a certain amount of test ether. 

Faucets have become the primary way to get test ether for a testnet. The community manages public test networks for the benefit of developers and testing. Faucets protect the testnet from spam attacks because the ether is controlled by trusted parties.

## Testnet comparison

Let's take a look at the [Ethereum testnets](https://ethereum.org/en/developers/docs/networks/#testnets) and their associated properties.

### Ropsten

Ropsten is a PoW consensus protocol. It's closest to the mainnet in functionality. Ropsten is named after a Swedish subway station and has been around since 2016. Some say it has the best reproduction of the conditions on the mainnet. 

More details:
- Supported clients: 
  - [Geth](https://geth.ethereum.org/?azure-portal=true) 
  - [OpenEthereum](https://openethereum.github.io/?azure-portal=true)
- Block time: 30 seconds or less
- Ropsten-specific links:
  - [GitHub](https://github.com/ethereum/ropsten/?azure-portal=true)
    
### Kovan

[Kovan](https://kovan-testnet.github.io/website/?azure-portal=true) is a PoA testnet named after a subway station in Singapore. Its ether must be requested from the faucet and is controlled by trusted parties. Because of this property, Kovan is immune to spam attacks.

More details:
- Supported client: [OpenEthereum](https://openethereum.github.io/?azure-portal=true)
- Block time: 4 seconds
- Kovan-specific links:
  - [GitHub](https://github.com/kovan-testnet/proposal/?azure-portal=true)
  - [Website](https://kovan-testnet.github.io/website/?azure-portal=true)

### Rinkeby

[Rinkeby](https://www.rinkeby.io/?azure-portal=true) is a PoA testnet started by the Ethereum team in April 2017. It's named after a metro station in Stockholm.

More details:
- Supported client: [Geth](https://geth.ethereum.org/?azure-portal=true)
- Block time: 15 seconds
- Rinkeby-specific links:
  - [GitHub](https://github.com/ethereum/EIPs/issues/225/?azure-portal=true)
  - [Website](https://www.rinkeby.io/?azure-portal=true)

### Goerli

The PoA cross-client testnet [Goerli](https://goerli.net/?azure-portal=true) was named after a Berlin subway station. This testnet aims to be widely usable across various clients. It's robust enough to guarantee consistent availability. It began with the Goerli Initiative in 2018.

More details:
- Goerli supports most clients, including these options: 
    - [Geth](https://geth.ethereum.org/?azure-portal=true)
    - [OpenEthereum](https://openethereum.github.io/?azure-portal=true)
    - [Nethermind](https://nethermind.io/?azure-portal=true)
- Block time: 15 seconds on average
- Goerli-specific links:
  - [Faucet](https://goerlifaucet.com/)
  - [Explorer](https://goerli.etherscan.io/?azure-portal=true)
  - [GitHub](https://github.com/goerli/testnet/?azure-portal=true)
  - [Website](http://www.goerli.net/?azure-portal=true)

Ropsten is said to be the testnet most similar to the mainnet. It was the first major testnet. Kovan, Goerli, and Rinkeby are stable and have high usage. Before you deploy to the mainnet, deploy to and test on multiple testnets.

## Clients and APIs for deploying to testnets and the mainnet

Ethereum is designed to offer multiple clients. Clients can be developed by different teams and can use different programming languages. This variety makes the network stronger and more diverse. The goal is to achieve diversity without any client dominating. This design reduces the chances of any single point of failure.

### Clients

Here are some common [Ethereum clients](https://ethereum.org/en/developers/docs/nodes-and-clients/#clients?azure-portal=true):

- [Geth client](https://geth.ethereum.org/?azure-portal=true)

    Go Ethereum (also called *Geth*) is one of the first implementations of the protocol. This client has the largest user base and is the most commonly used. Geth offers a wide variety of tools for both blockchain developers and users. 

    The Geth client is written in Go and is open source. It's licensed under GNU Lesser General Public License (LGPL) version 3.

- [OpenEthereum](https://openethereum.github.io/?azure-portal=true)

    The OpenEthereum client is useful for all work with the protocol. It simplifies tasks like customization, product integration, data storage, and memory management. It aims to be the most lightweight, fast, and secure of all the Ethereum clients.

    OpenEthereum is written in the Rust programming language. It's licensed under GNU General Public License (GPL) version 3. 

- [Nethermind](https://nethermind.io/?azure-portal=true)

    Nethermind provides the world's fastest .NET Core Ethereum client and P2P data marketplace. It offers consulting services for developers of Ethereum blockchain solutions.


### APIs

Here are some common Ethereum APIs:

- [Infura](https://infura.io/?azure-portal=true)

    The Infura API suite provides instant access over HTTPS and WebSockets to the Ethereum and IPFS networks. Use this intuitive interface to connect to the endpoints of all testnets. Infura supports both *Truffle Suite* and the *Visual Studio Code Blockchain development kit for Ethereum*.

- [MetaMask](https://metamask.io/?azure-portal=true)

    When you deploy to a testnet or the mainnet, the MetaMask client provides a robust interface and wallet that connects to and interacts with Ethereum blockchains.

    Using MetaMask to send ether and tokens on a testnet is straightforward. The client provides an easy interface to select and use different Ethereum networks. When you need to interact with development networks, MetaMask simplifies connecting to localhost 8545 or custom RPC so you can connect with Ganache and Truffle. Similarly, MetaMask has predefined connections to the public testnets and the mainnet. 

    If you connect to the mainnet, be careful to secure your private key. Real ether is used for this connection.
