Blockchain technology works best for certain scenarios. You shouldn't use it as a general purpose solution. In many cases, a centralized database is a better option. When considering using blockchain, ask yourself these questions about your scenario.

## Participants

* Do you need to support multiple partners or companies?
* Do you want to avoid a central authority? Perhaps there is not trust in any one participant. Participants may not want to be reliant on a third party.
* Do the participants share data or use a workflow that involves several or all the participants? Blockchain technology guarantees each node is consistent. Most other business to business (B2B) solutions rely on synchronization. Synchronizing data introduces breakage and expense to B2B systems. The consistency of the distributed data is a key advantage of blockchain technology.

## Performance

* Is your transaction throughput low? Depending on the blockchain protocol and consensus mechanism, transaction rates can be low.
* Is there defined business logic when interacting with other business partners? Executing business logic in a transaction can affect performance.

## Business logic

* Is your business logic simple? Executing a complex smart contract function on a public blockchain requires more cryptocurrency than a simple one.
* Is your business logic static and doesn't change? Since blockchain data is immutable, smart contract logic changes require you to deploy a new contract to a new address. Consider how you will version your business logic.

## Trust

* Is trust and integrity required between participants?
* Does the order of transactions matter?
* Do you need transaction privacy?

## Blockchain options on Azure

If you want to host your solution on Azure, there are several options you can consider.

### Templates

Solution templates provide Infrastructure as a Service (IaaS) packaged virtual machines (VMs) for many major protocols and blockchain network configurations. For example, there are solution templates provided by Microsoft to deploy blockchain consortium networks for Ethereum and Hyperledger Fabric. There are also several third-party solution templates for other popular blockchain protocols including Corda and Quorum, BlockApps, and GoChain.

Solution templates for blockchain can be found in the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/category/blockchain).

### Azure Blockchain Workbench

Use Azure Blockchain Workbench for rapid prototyping and integration with other Azure services. With Azure Blockchain Workbench, you can configure and deploy a consortium network quickly. It's ideal for development prototyping or test exploration. The goal of Azure Blockchain Workbench is to reduce development time and cost with prebuilt integrations to the cloud services needed for application development such as Azure Active Directory, Azure Key Vault, Azure Service Bus, and Azure Event Hubs.

For more information on Azure Blockchain Workbench, see the [Azure Blockchain Workbench](https://docs.microsoft.com/azure/blockchain/workbench) documentation.
