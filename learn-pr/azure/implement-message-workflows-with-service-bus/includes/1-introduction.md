Modern applications frequently consist of multiple parts running on separate computers and devices that are distributed in diverse locations around the world. Complex networks with varying reliability and speed exist between these components. A fundamental challenge with these distributed applications is how to communicate reliably between the components.

Suppose you're a cloud developer for Contoso Bicycles, a global bicycle chain. Your employer is upgrading its technology so that customers can place orders from the web or from a mobile app. An order is sent to the customer's preferred storefront location, where store employees fill the order. As the order is filled from parts, packaged for shipping, and puts on a delivery vehicle, updates are sent to the customer's mobile app. The customer even receives location updates as the delivery vehicle heads toward them.

Contoso Bicycles previously created an online ordering system that immediately stored order data in a SQL Server database. Each store had to manually refresh the company's web orders intranet page to check for new orders for their store. In addition, during peak usage, such as bicycle orders during tourist season or sporting events, the system frequently would experience deadlock exceptions and timeouts. Finally, the system lacked central payment processing and any kind of order status tracking for the customer.

For the new, more ambitious project, Contoso Bicycles has hired a cloud architect. The company plans to begin using a distributed architecture for order communications.

In this module, you'll learn how Azure Service Bus can help build an application that is reliable, even during peak demand. You'll also learn how Azure Service Bus makes it easy to add functionality to applications. You'll be writing the C# code that's necessary to put these lessons to work. Here, you'll see how to use Service Bus queues and topics in a distributed architecture to ensure reliable communications, even at times of high demand.

## Learning objectives

In this module, you'll learn how to:

- Choose whether to use Service Bus queues or topics to communicate in a distributed application.
- Configure an Azure Service Bus namespace in an Azure subscription.
- Create a Service Bus topic and use it to send and receive messages.
- Create a Service Bus queue and use it to send and receive messages.
