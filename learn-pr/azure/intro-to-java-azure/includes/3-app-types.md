It's necessary to distinguish between the different types of server-side Java applications before you can choose a matching cloud solution.

## Monolithic applications

The *all in one* solution that still fits for many projects, from smaller ones over *self-contained systems* to *contain it all*, are monolithic applications. A monolithic application is a good start for prototyping and startups. It's simple to develop, debug, test, and deploy. 

Monolithic applications bring few cross-cutting concerns such as logging, caching, or monitoring. Depending on the functionality, they're scalable but only as a whole.

Traditionally, monolithic applications run on application servers.

## Microservices

Nowadays, successful businesses are expected to adapt fast, to expect the unexpected, and to fail fast and forward. To achieve a reduced time to market, more engineers get hired. But the outcome might be the opposite! It results in a longer time to market, because more communication effort is required when more engineers need to collaborate. The solution here is to divide and conquer.

Cross-functional teams should be able to deliver software features as independently as possible to other teams. They should be responsible for their own dedicated part of the business solution.

## Batch jobs

Some applications are intended to run briefly. They execute a particular workload, and then exit rather than wait for requests or user input. Batch jobs are a solution for this use case. Even though some batches can last for hours, sometimes jobs need to run once or at regular, scheduled intervals. On-premises, such jobs are often invoked from a server's crontab.

These applications are packaged into archives with the .jar extension (JAR files).

## Serverless architectures

In the world of event-driven programming, functions are handy. They're executed only on an event. A function is "triggered" by a specific type of event. Supported triggers include responding to changes in data, responding to messages, running on a schedule, or receiving an HTTP request.
