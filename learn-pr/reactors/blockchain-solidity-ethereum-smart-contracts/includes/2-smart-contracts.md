A smart contract is a program that's stored inside a blockchain. Smart contracts extend blockchain from data to code. They represent an agreement between parties. The agreement is coded, and when an action happens, the code runs and provides a response.

All of the terms and conditions of the contracts are programmatically defined. A definition specifies the rules, requirements, and rewards for the participants in the blockchain. It also specifies how digital assets are transferred between parties. Each smart contract is assigned a 20-byte address that uniquely identifies it.

Smart contracts run on their own, send events which trigger state transitions, and call functions. They're perfect for blockchain technology because they allow people who don't know one another to do business in a securely specified way that requires no middleman.

Smart contracts are most commonly used with Ethereum. Ethereum is the world's first programmable blockchain. It allows smart contracts to be defined to help facilitate the transfer of digital assets, like ether.

The language you'll use to write contracts is Solidity. Solidity is *Turing-complete*, which means that you can write complicated contracts in a clearly defined and coded way.  

Because every state transition is logged and immutable, you should thoroughly test the contract before you release it into a production environment. Bug fixes can be costly and can even cause critical system damage.

Smart contracts have these key properties and advantages:

- **Transparency**: Blockchain users can read smart contracts and can access them by using APIs.
- **Immutability**: Smart contract execution creates logs that can't be changed.
- **Distribution**: The output of the contract is validated and verified by nodes on the network. Contract states can be publicly visible. In some cases, even "private" variables are visible.

## Use cases

Smart contracts can benefit many industries and processes. Consider the following use cases.

**Insurance**: Smart contracts can simplify and streamline the claims process by automatically triggering a claim when certain events occur. Claim details can be recorded on the blockchain to determine the amount of compensation that users will receive. This functionality can reduce processing times and human errors.

**Voting**: Smart contracts can help make voting automatic and transparent. Each contract serves as one ballot, which represents a voter's identity. Because a blockchain is immutable, meaning that it can't be changed, votes can't be tampered with.

**Supply chains**: Smart contracts can record ownership as items move through a supply chain. The contracts confirm who's responsible for a product at any given time. At any stage, the smart contract can be used to find out exactly where the products should be. If any party in the supply chain fails to deliver on time, then every other party knows where the problem happened.

**Record keeping**: Many industries can use smart contracts to improve the speed and security of record keeping. Blockchain technology can be used to digitize records and to securely encrypt and store them. Plus, access can be gated so that only allowed individuals can access the records.

**Property ownership**: Smart contracts can record who owns property. They're a fast and cost-efficient way to record ownership. Smart contracts can also help facilitate the transfer of ownership in a timely and secure way.

## Tools for working with smart contracts

Many tools can help you effectively develop smart contracts. The following sections suggest some integrated development environments (IDEs), extensions, and frameworks that you can explore.

### IDEs

- [**Visual Studio Code**](https://code.visualstudio.com/?azure-portal=true): A code editor that's redefined and optimized for building and debugging modern web and cloud applications. In this module, we use Visual Studio Code for all exercises.
- [**Remix**](https://remix.ethereum.org/?azure-portal=true): A browser-based compiler and IDE that you can use to build Ethereum contracts in the Solidity language and to debug transactions. Remix is a great way to explore sample contracts. You can use it to write, test, and deploy your own contracts. We don't use Remix in this module, but you can try it out on your own in the contract exercises.

### Extensions

- [**Blockchain Development Kit for Ethereum**](https://marketplace.visualstudio.com/items?itemName=AzBlockchain.azure-blockchain&azure-portal=true): This extension can simplify how you create, build, and deploy smart contracts on Ethereum ledgers. In this module, we'll use the Blockchain Development Kit to write and test smart contracts.

### Frameworks

- [**Truffle Suite**](https://www.trufflesuite.com?azure-portal=true): Use the Truffle tool suite to test Ethereum contracts before you deploy them to public ledgers and incur real costs. To make your work as a developer easier, develop locally. The tool suite includes Truffle, Ganache, and Drizzle. In this module, we'll use Truffle.
- [**OpenZeppelin**](https://openzeppelin.com/?azure-portal=true): Use OpenZeppelin tools to write, deploy, and operate decentralized applications. OpenZeppelin provides two products: the contracts library and the SDK. We don't use OpenZeppelin in this module, but later you can try it out as you write secure blockchain applications.
