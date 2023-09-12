Blockchain technology works best for certain scenarios. You shouldn't use it as a general purpose solution. In many cases, a centralized database is a better option. When considering using blockchain, ask yourself these questions about your scenario.

## Participants

* Do you need to support multiple partners or companies?
* Do you want to avoid a central authority? Perhaps there isn't trust in any one participant. Participants may not want to be reliant on a third party.
* Do the participants share data or use a workflow that involves several or all the participants? Blockchain technology guarantees each node is consistent. Most other business to business (B2B) solutions rely on synchronization. Synchronizing data introduces breakage and expense to B2B systems. The consistency of the distributed data is a key advantage of blockchain technology.

## Performance

* Is your transaction throughput low? Depending on the blockchain protocol and consensus mechanism, transaction rates can be low.
* Is there defined business logic when interacting with other business partners? Executing business logic in a transaction can affect performance.

## Business logic

* Is your business logic simple? Executing a complex smart contract function on a public blockchain requires more cryptocurrency than a simple one.
* Is your business logic static and doesn't change? Since blockchain data is immutable, smart contract logic changes require you to deploy a new contract to a new address. Consider how you'll version your business logic.

## Trust

* Is trust and integrity required between participants?
* Does the order of transactions matter?
* Do you need transaction privacy?

## Blockchain options on Azure

If you want to host your solution on Azure, there are several options you can consider.

### Templates

Solution templates provide Infrastructure as a Service (IaaS) packaged virtual machines (VMs) for many major protocols and blockchain network configurations. For example, there are several third-party solution templates for popular blockchain protocols including Hyperledger Fabric, Corda, Quorum, BlockApps, and GoChain.

Solution templates for blockchain can be found in the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/category/blockchain).

### ConsenSys Quorum Blockchain Service

Quorum Blockchain Service is a fully managed ledger service for enterprises giving them the ability to grow and operate blockchain networks at scale. For more information about Quorum Blockchain Service, see [Consensys Quorum Blockchain Service](https://consensys.net/quorum/qbs/).

### Azure confidential ledger

Azure confidential ledger provides a managed and decentralized ledger for data entries backed by blockchain. You can maintain data integrity by preventing unauthorized or accidental modification with tamperproof storage. Data is protected at rest, in transit, and in use with hardware-backed secure enclaves used in Azure confidential computing. For more information about Azure confidential ledger, see [Azure confidential ledger](https://azure.microsoft.com/products/azure-confidential-ledger).

### Azure SQL Database ledger

Azure SQL Database ledger enables tamper-evidence through cryptographic verification for your centralized data stores. SQL Database ledger removes the complexity of decentralized blockchain technology. It provides many of the benefits of blockchain data integrity in a fully managed and familiar SQL environment. For more information about SQL Database ledger, see [Azure SQL Database ledger](/sql/relational-databases/security/ledger/ledger-landing-sql-server).
