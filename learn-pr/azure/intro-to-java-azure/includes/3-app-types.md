# Types of Java Applications

It is necessary to distinguish between the different types of Java application before choosing the matching cloud solution for your deployment. In the following you will find a list of application types, most Java applications are one of.

## Monolithic applications

The *All in One* solution which still fits for a lot of projects from smaller ones to *Self-contained Systems* are the Monolithic applications. A Monolithic application is a good start for prototyping and Startups as it is simple to develop, easy to debug and to test as well as simple to deploy. They bring little cross-cutting concerns such as logging, caching or monitoring. Depending on the functionality they are scalable but only as a whole.

The most famous ones are:

- **Jakarta EE**, formerly known as Oracle's Java Enterprise Edition (Java EE), is open source and aimed to be cloud native for java development. It is a set of specifications to enable java developers world wide to work together on java enterprise applications. Jakarta EE was submitted to the Eclipse Foundation. Jakarta EE applications can be packaged as archives with the .ear extension (EAR files) or as archives with the .war extension (WAR files).

- **Spring Framework** is an application framework and inversion of control container for the Java platform. The framework's core features can be used by any Java application, but there are extensions for building web applications on top of the Java EE (Enterprise Edition) platform. Although the framework does not impose any specific programming model, it has become popular in the Java community as an addition to the Enterprise JavaBeans (EJB) model. The Spring Framework is open source.

- **Apache Tomcat** is an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. The Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket specifications are developed under the Java Community Process.

The distinction between the Monolithic and Microservices-oriented-pattern is fluent.

## Microservices

Nowadays the successful businesses are asked to adapt very fast, to expect the unexpected, to fail fast and forward in order to succeed. In order to reduce the time to market more engineers get hired. higher time to market -> more communication effort -> divide and conquer

![Two guys from LegoMasters explaining that they will go to divide and conquer.](https://media.giphy.com/media/ZEr8iZHmjZfABEPGRk/source.gif)

Next, a list of the most used frameworks for Microservices can be found:

- **Spring Boot** is by far the most used framework as an alternative to application servers. At least every second web project is using Spring boot. It has become the most popular Java web framework. And it is getting more and more momentum over the last years.

- **Netty** is a NIO client server framework which enables quick and easy development of network applications such as protocol servers and clients. It greatly simplifies and streamlines network programming such as TCP and UDP socket server. Netty is an asynchronous event-driven network application framework for rapid development of maintainable high performance protocol servers & clients.

- **Spark Java** is a micro framework for creating web applications in Kotlin and Java 8 with minimal effort. The Spark framework is a simple and lightweight Java web framework built for rapid development. It was inspired by Sinatra, a popular Ruby micro framework.

- **Vert.x** is a event driven and non blocking tool-kit. You can use Vert.x with multiple languages including Java, Kotlin, JavaScript, Groovy, Ruby and Scala. It aims to be the most lightweight, fastest framework. It is simple but nor simplistic. Eclipse Vert.x is open source and dual-licensed under the Eclipse Public License 2.0 and Apache License 2.0.

- **Micronaut** is a modern, JVM-based, full-stack framework for building modular, easily testable microservice and serverless applications. Micronaut features a dependency injection and aspect-oriented programming runtime that uses no reflection. This makes it easier for Micronaut applications to run on GraalVM. (???)

- **MicroProfile** is an open forum to optimize Enterprise Java for a microservices architecture by innovating across multiple implementations and collaborating on common areas of interest with a goal of standardization. (??) Wildfly Swarm, TomEE

## Batch

Some applications are intended to run briefly, execute a particular workload, and then exit rather than wait for requests or user input. Sometimes such jobs need to run once or at regular, scheduled intervals. On premises, such jobs are often invoked from a server's crontab.

These applications are packaged into archives with the .jar extension (JAR files).

## Serverless

Entering the world of Event-Driven Programming, functions which are only executed on a event are very handy. A function is "triggered" by a specific type of event. Supported triggers include responding to changes in data, responding to messages, running on a schedule, or as the result of an HTTP request.
