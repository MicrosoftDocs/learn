Event hubs is a big data event streaming service. Event hubs represents the front door to receive incoming data - sitting between:

* **Event publishers**, such as applications on mobile devices, and
* **Event consumers**, such as a storage blob or a real-time dashboard.

As an example scenario, consider a home security company that monitors 100,000 homes. Every minute, it gets data from various sensors—such as a motion detector, door/window open sensor, and glass break detector—installed in each home. Alerts are raised for any incidents, and the data is processed and stored in a storage blob. Event Hubs ingests data from the sensors, where these events are then processed. The processed event data is then projected to a user-friendly web page for residents to monitor the activity of their home, in near real time.

Event Hubs is a PaaS, full-managed service. It simplifies the creation and maintenance of reliable, scalable data pipelines. Data can be compiled and organized from multiple sources, before it’s stored or sent to an event consumer. You’re provided with a single platform for your systems to ingest, buffer, store, and process data, at scale, while multiple clients with multiple purposes can receive and process the same message.

One of the main benefits of Event Hubs is its compatibility with common languages and tools. **Data can be read and processed using languages such as Python and Go**, and it’s compatible with common protocols, Apache Kafka applications, the Spring Framework for Java, and more. Further, Event Hubs emits exhaustive metrics that provide the state of your resources to Azure Monitor. They also let you assess the overall health of the Event Hubs service not only at the namespace level but also at the entity level.

Data can be compiled and organized, from multiple sources, before sending it to an event consumer. Event Hubs decouples the production of an event stream from the consumption of those events, allowing you to create modular data pipelines.

## Security and privacy

By default, all Event hubs resources are secure and can only be accessed by the account owner. To grant access you can offer authorized access using Azure Active Directory or Shared Access Signatures (SAS) for whenever a client tries to access an Event Hubs resource. Azure Active Directory provides role-based access control, so you can grant permissions to a security principal, such as a user or a group, using a token. You can also utilize SAS to provide limited and delegated access to Event hubs resources using time or valid use constraints. Microsoft recommends using Azure Active Directory for maximum security, as you don’t need to store the access tokens, which reduces potential security risks of a compromised SAS.