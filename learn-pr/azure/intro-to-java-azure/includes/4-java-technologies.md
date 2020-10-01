# Java Technologies

It's necessary to distinguish between the different types of Java application before choosing the matching cloud solution for your deployment.

You can distinguish your type of application specification wise. The most famous ones are:

## Jakarta EE

Formerly known as Oracle's Java Enterprise Edition (Java EE), is Jakarta EE open source and aimed to be cloud native for java development. It is a set of specifications to enable java developers world wide to work together on java enterprise applications. Jakarta EE was donated to the Eclipse Foundation. Jakarta EE applications can be packaged as archives with the .ear extension (EAR files) or as archives with the .war extension (WAR files).

- **WebProfile** is a subset of Jakarta EE with some extra APIs for Backend services with web focus.

- **MicroProfile** is a subset of Jakarta EE with added Modules for Microservice Architectures. It is an open forum to optimize Enterprise Java for a microservices architecture by innovating across multiple implementations and collaborating on common areas of interest with a goal of standardization.

## Spring Framework and the Spring Family

is an application framework and inversion of control container for the Java platform. The framework's core features can be used by any Java application, but there are extensions for building web applications on top of the Java EE (Enterprise Edition) platform. Although the framework does not impose any specific programming model, it has become popular in the Java community as an addition to the Enterprise JavaBeans (EJB) model. The Spring Framework is open source.

### Spring Boot

is by far the most used framework as an alternative to application servers. At least every second web project is using Spring boot. It has become the most popular Java web framework. And it's getting more and more momentum over the last years.

### Spring Batch

Text text

## Application Servers

- **Apache Tomcat** is an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. The Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket specifications are developed under the Java Community Process.

- **Weblogic** ...

- **JBoss** ...

## Other Frameworks for Microservice-oriented Architectures

- **Netty** is a NIO client-server framework, which enables quick and easy development of network applications such as protocol servers and clients. It greatly simplifies and streamlines network programming such as TCP and UDP socket server. Netty is an asynchronous event-driven network application framework for rapid development of maintainable high-performance protocol servers & clients.

- **Spark Java** is a micro framework for creating web applications in Kotlin and Java 8 with minimal effort. The Spark framework is a simple and lightweight Java web framework built for rapid development. It was inspired by Sinatra, a popular Ruby micro framework.

- **Vert.x** is an event driven and nonblocking tool-kit. You can use Vert.x with multiple languages including Java, Kotlin, JavaScript, Groovy, Ruby, and Scala. It aims to be the most lightweight, fastest framework. It's simple but nor simplistic. Eclipse Vert.x is open source and dual-licensed under the Eclipse Public License 2.0 and Apache License 2.0.

- **Micronaut** is a modern, JVM-based, full-stack framework for building modular, easily testable microservice, and serverless applications. Micronaut features a dependency injection and aspect-oriented programming runtime that uses no reflection. That makes it easier for Micronaut applications to run on GraalVM. (???)
