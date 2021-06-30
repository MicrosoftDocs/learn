Understanding there may be many scenarios where Event hubs is required, we present a few considerations here that offer insight into some applications of Event hubs. Using these scenarios, you may come up with other ideas on how you might utilize Event hubs.

## Anomalies detection

Detecting anomalies in credit and debit card transactions is a vital component to keeping people financially secure, yet, if thousands of devices are sending millions of events per second, tracking this can be difficult and prone to errors. You can configure parameters for Event hub to capture to your chosen Blob or Data Lake storage, such as anomalies like purchases on one card from multiple regions, and analyze and process these in real-time using Azure Stream Analytics. What’s more, you can further integrate Event hubs with Azure Functions, to get push notifications for when an event is triggered, making for a seamless pipeline.

## Medical telemetry

Telemetry devices are used for many medical purposes, such as mobile heart monitoring, EKG machines in hospitals, and pacemakers, to name a few. These devices not only accurately and quickly give off life saving data to doctors and nurses but also reduces the amount of follow-up appointments that patients need to make. This frees up valuable resources and time for medical practitioners. Consumers can set the Event hub to capture any live data that would be considered abnormal and integrate with Stream Analytics to get real-time processing and analysis of this data.

## Real-time updates

Knowing what is happening, as it happens, is vital to many organizations. E-commerce businesses, such as fashion realtors, often need to track their hourly and daily sales and inventory data. Event hubs would receive a message for every action that a customer takes, such as when a customer looks at a product, or how many pictures of the product they looked at, and any other browsing information. By integrating with other services, like Azure Function and Databricks, to read and analyze the data, users can get up to the minute information so they can update the product recommendation services as needed. Consumers can then use Microsoft's Power BI to create interactive visualizations of this data as a dashboard, making it easier to understand so you get the information you need to make the best business decisions.
