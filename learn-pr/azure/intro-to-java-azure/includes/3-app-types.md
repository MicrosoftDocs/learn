# Types of Java Applications

It's necessary to distinguish between the different types of Java application before choosing the matching cloud solution for your deployment.

## Monolithic Applications

The *All in One* solution that still fits for numerous projects from smaller ones over *Self-contained Systems* to *Contain it all* are the Monolithic applications. A Monolithic application is a good start for prototyping and Startups. It's simple to develop, easy to debug and to test as well as simple to deploy. They bring little cross-cutting concerns such as logging, caching, or monitoring. Depending on the functionality, they are scalable but only as a whole.

Traditionally your monolithic applications run on application servers.

The distinction between the Monolithic and Microservices-oriented-pattern is fluent.

## Microservices

Nowadays the successful businesses are asked to adapt fast, to expect the unexpected, to fail fast and forward in order to succeed. In order to reduce the time to market, more engineers get hired. higher time to market -> more communication effort -> divide and conquer

![Two guys from LegoMasters explaining that they will go to divide and conquer.](https://media.giphy.com/media/ZEr8iZHmjZfABEPGRk/source.gif)

## Batch

Some applications are intended to run briefly, execute a particular workload, and then exit rather than wait for requests or user input. Sometimes such jobs need to run once or at regular, scheduled intervals. On premises, such jobs are often invoked from a server's crontab.

These applications are packaged into archives with the .jar extension (JAR files).

## Serverless

Entering the world of Event-Driven Programming, functions, which are only executed on an event are handy. A function is "triggered" by a specific type of event. Supported triggers include responding to changes in data, responding to messages, running on a schedule, or as the result of an HTTP request.
