In this unit, we distinguish between the different types of Java frameworks, servers, and platforms.

## Spring Framework

The Spring Framework is an application framework and inversion of control container. Spring has historically been used to compliment the Enterprise JavaBeans (EJB) model.
Its core functionalities are:

- Dependency injection
- Aspect-oriented programming
- Business abstraction

### Spring Boot

Spring Boot runs on top of the Spring Framework and has an opinionated autoconfiguration. Spring boot applications run stand-alone and a perfect fit for microservices.

### Spring Data

Spring Data simplifies data access for relational and non-relational databases, map-reduce frameworks, and cloud-based data services.

### Spring Security

Spring Security is de-facto standard for securing Spring-based applications. It offers highly authentication and access-control, for instance Spring Security integrates well with Active Directory.

### Spring Cloud

Spring Cloud is used for distributed system. Spring Cloud comes with service discovery, configuration management, monitoring, and a good developer experience.

### Spring Batch

Spring Batch is a lightweight framework for robust batch applications vital for daily operations.

## MicroProfile and Jakarta EE

MicroProfile and Jakarta EE can be seen as the open source follow-up of the Java Enterprise Edition specifications.

### MicroProfile

Microprofile is a set of specifications for microservice Architectures. They call themselves an _open forum to optimize Enterprise Java for a microservices architecture_.  MicroProfile aims to innovate across multiple implementations and collaborate on common areas of interest.

### Jakarta EE

Jakarta EE is a set of specifications for building enterprise applications. Its modularized structure enables developers to create efficient software solutions. Jakarta EE applications can be packaged as either EAR files or WAR files.

- **WebProfile** is a subset of Jakarta EE for backend services with a Web focus. But no worries! You can add specific APIs of the Enterprise platform on top of it.

## Application servers

Java EE applications must be deployed onto Java EE-compliant application servers (such as WebLogic, WebSphere, WildFly, GlassFish, Payara, and others).

- **Apache Tomcat** is an HTTP server and a Java Servlet container. It implements the Servlet, JavaServer Pages, Java Expression Language, and Java WebSocket specifications.

- **Oracle Weblogic Server** is a unified and extensible platform for developing, deploying, and running enterprise applications. WebLogic Server offers a robust, mature implementation of Java Enterprise Edition (EE) and Jakarta EE.

- **Red Hat JBoss Enterprise Application Platform** delivers enterprise-grade security, performance for on-premise; virtual; or in private, public, or hybrid clouds.

- **WildFly** is the open source upstream for JBoss EAP. This community driven flavor is great for development and testing.

- **IBM WebSphere Application Server** (WAS) is a flexible, security-rich Java server runtime environment for enterprise applications. It focuses on high reliability. WAS supports microservices and standards-based programming models. You can modernize at your own pace, gain greater visibility across workloads, analyze enterprise applications, and advance your journey to Kubernetes.

- **Open Liberty**, is the community driven, open-source version of the WAS.

- **Oracle GlassFish** is the reference implementation of many Java EE web standards (which includes Servlet and JSP).

## Other frameworks for microservice-oriented architectures

- **Netty** is a NIO client-server framework, which enables quick and easy development of network applications such as protocol servers and clients. It greatly simplifies and streamlines network programming such as TCP and UDP socket server. Netty is an asynchronous event-driven network application framework for rapid development of maintainable high-performance protocol servers & clients.

- **Quarkus** is a Kubernetes native Java stack tailored for OpenJDK HotSpot and GraalVM. Quarkus is getting more and more momentum. By the way, there are more performance-focused frameworks like this, such as Vert.x, Helidon, Payara Micro, and KumuluzEE.

- **Micronaut** is a modern, JVM-based, full-stack framework for building modular, easily testable microservice, and serverless applications. Micronaut features a dependency injection and aspect-oriented programming runtime that uses no reflection. That makes it easier for Micronaut applications to run on GraalVM.
