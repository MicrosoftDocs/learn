Tailwind Traders sends out invitations to participate in a customer satisfaction survey randomly after a purchase. Currently, the customer satisfaction is aggregated, averaged, and charted. However, the customer service department sees an opportunity to be proactive and reach out to customers who provide extremely low scores and leave comments with a negative sentiment.

Ideally, responses with negative customer satisfaction scores would trigger a customer retention workflow.  First, a sentiment analysis would be generated based on the free-form comments, an email sent to the customer with an apology and a coupon code, and the message would be routed to a Dynamics 365 Customer Service so that a follow-up email could be scheduled.

Unfortunately, there's no developer resources available to take on this projects, however the customer service team works with several cloud and IT professionals who might be able to construct a solution.

## Which service should we choose?

In this scenario, Azure Logic Apps would likely be the best solution.  A cloud or IT professional could use existing connectors to perform a sentiment analysis using the Cognitive Services connector, send an email using the Office 365 Outlook connector, and create a new record and follow-up using the Dynamics 365 Customer Service connector.

Since Azure Logic Apps is a low-code/no-code service, no developers would be needed.  A cloud or IT professional should be able to build and support this workflow.

## Why not choose Azure Functions?

While it is possible to build this entire solution using Azure Functions, it might be challenge given that no software developers can be committed to this project.  Furthermore, this is an ideal scenario for Azure Logic Apps.  Connectors already exist for each of the steps outlined in the workflow.  It would take quite a bit of research, development, and testing for a developer to build a solution that utilizes all of these disparate software systems.