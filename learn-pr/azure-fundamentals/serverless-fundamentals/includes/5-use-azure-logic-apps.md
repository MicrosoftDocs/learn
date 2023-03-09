Tailwind Traders sends its customers an invitation to participate in a customer satisfaction survey randomly after a purchase. Currently, the customer satisfaction results are aggregated, averaged, and charted. However, its customer service department sees an opportunity to reach out proactively to customers who provide low scores and leave comments with a negative sentiment.

Ideally, negative customer satisfaction scores would trigger a customer retention workflow. First, a sentiment analysis would be generated based on the free-form comments. Then, an email would be sent to the customer with an apology and a coupon code. The message would be routed to the Dynamics 365 customer service team so that it could schedule a follow-up email.

Unfortunately, no Tailwind Traders developer resources are available to take on this project. But the customer service team works with several cloud and IT professionals who might be able to construct a solution.

## Which service should you choose?

In this scenario, Azure Logic Apps is likely the best solution. A cloud or IT professional could use existing connectors to perform a sentiment analysis by using the Azure Cognitive Services connector. Then, they would send an email by using the Office 365 Outlook connector, and create a new record and follow-up email by using the Dynamics 365 customer service connector.

Because Azure Logic Apps is a low-code/no-code service, no developers are needed. A cloud or IT professional should be able to build and support this workflow.

## Why not choose Azure Functions?

Although it's possible to build the entire solution by using Azure Functions, this approach might be a challenge if no software developers can be committed to this project.

This scenario is ideal for Azure Logic Apps. Connectors already exist for each of the steps outlined in the workflow. It would take quite a bit of research, development, and testing for a developer to build a solution that utilizes all these disparate software systems.
