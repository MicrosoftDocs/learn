Big data apps must be able to process increased throughput by scaling out to meet increased transaction volumes.

Suppose you work in the credit card department of a bank. You're part of a team that manages the system responsible for fraud testing to determine whether to approve or decline each transaction. Your system receives a stream of transactions and needs to process them in real time.

The load on your system can spike during weekends and holidays. The system must handle the increased throughput efficiently and accurately. Given the sensitive nature of the transactions, even the slightest error can have a considerable impact.

Azure Event Hubs is a big data streaming platform and event ingestion service. It can receive and process millions of events per second. Data sent to an event hub can be transformed and stored by using any real-time analytics provider or batching/storage adapters. It can also be configured to scale dynamically, when required, to handle increased throughput.

In this module, you learn how to connect Event Hubs to your app and reliably process large transaction volumes.

## Learning objectives

In this module, you will:

- Create an event hub using the Azure CLI.
- Configure apps to send or receive messages through an event hub.
- Evaluate your event hub performance using the Azure portal.
