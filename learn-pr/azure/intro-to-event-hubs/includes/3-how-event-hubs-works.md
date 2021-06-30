To use Event hubs, you need an Azure subscription, which you can create for free. Event hubs is available in basic, standard, premium, or dedicated pricing tiers, depending on your needs. 

Event hubs is available in these languages:
* .NET Core
* Java
* Python
* JavaScript
* Go
* C (send only)
* Apache storm

Unlike some messaging services, like Azure Service Bus Queues for example, Event Hubs does not use a 'push' model. Instead, Event Hubs holds the message in its cache for it to be read. When a message is read form the EventHub, it is not deleted—messages are only deleted once the retention time has passed.

This service is scalable up to terabytes of data and millions of events per second, and can process from a number of data sources, such as telemetry, iOT devices, web and phone apps, sensors, metrics, and more.