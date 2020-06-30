Now that you know about all the possibilities, you'll need to create a strategy for the specific workload which your Azure SQL Database or Azure SQL Managed Instance is a part of.

## Making the right choices

A big part of this process is stepping back and thinking about the requirements of your workload. Some questions to consider include:

- Do you need long term backups? Or is 1-35 days long enough?
- What are your RTO and RPO needs?
- After reviewing the SLA, what service tier makes the most sense?
- Do you need Availability Zones?
- Do you need geo-replicated HADR or failover groups?
- Is your application ready?

The answers to these questions will help you in narrowing down what configuration you should deploy to meet your availability requirements.

The last question, *Is your application ready?*, if often overlooked by the data professional. However, this consideration is crucial to actually achieving the SLA you desire. You need to make sure that not only your database is meeting your availability requirements, but also that your application is meeting those requirements. Additionally, you'll want to make sure that the connectivity between the data and the application(s) meets your requirements. As an example, if your application and database are in different regions, this will increase the network latency. You should, as a best practice, place your application and data as close together as possible.

## Monitoring availability

TODO -- Bob can you help me with this bit? You've spent a lot of time here and there are quite a few things in the notes. What do we want to say here?