It's necessary to distinguish between the different types of Java application before choosing the matching cloud solution.

## Monolithic Applications

The *All in One* solution that still fits for many projects from smaller ones over *Self-contained Systems* to *Contain it all* are the Monolithic applications. A Monolithic application is a good start for prototyping and startups. It's simple to develop, easy to debug and to test, and simple to deploy. They bring little cross-cutting concerns such as logging, caching, or monitoring. Depending on the functionality, they're scalable but only as a whole.

Traditionally your monolithic applications run on application servers.

## Microservices

Nowadays the successful businesses are asked to adapt fast, to expect the unexpected, to fail fast and forward in order to succeed. To achieve a reduced time to market, more engineers get hired. But the outcome might be the opposite! It results in a higher time to market as you do have more communication effort when more engineers need to collaborate. The solution here is to divide and conquer.

Cross-functional teams should be able to deliver features as independently as possible to other teams. Therefore, they should be responsible for their own dedicated part of the software, meaning business, solution.

## Batch

Some applications are intended to run briefly. They execute a particular workload, and then exit rather than wait for requests or user input. Batch Jobs are a solution for this use-case. Even though some batches can last for hours. Sometimes jobs need to run once or at regular, scheduled intervals. On premises, such jobs are often invoked from a server's crontab.

These applications are packaged into archives with the .jar extension (JAR files).

## Serverless

Entering the world of Event-Driven Programming, functions, which are only executed on an event are handy. A function is "triggered" by a specific type of event. Supported triggers include responding to changes in data, responding to messages, running on a schedule, or as the result of an HTTP request.
