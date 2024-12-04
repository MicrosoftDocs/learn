In this unit, we distinguish between the different types of Java frameworks, servers, and platforms.

## Spring Framework

The Spring Framework is an application framework and inversion of control (IoC) container. Spring has historically been used to complement the Enterprise JavaBeans (EJB) model. Its core functionalities are:

- Dependency injection
- Aspect-oriented programming
- Business abstraction

### Spring Boot

Spring Boot runs on top of the Spring Framework and has an opinionated autoconfiguration. Spring Boot applications run standalone and are a perfect fit for microservices.

### Spring Data

Spring Data simplifies data access for relational and non-relational databases, MapReduce frameworks, and cloud-based data services.

### Spring Security

Spring Security is the *de facto* standard for securing Spring-based applications. It offers a high level of authentication and access control. For instance, Spring Security integrates well with Active Directory.

### Spring Cloud

Spring Cloud is used for distributed systems. Spring Cloud comes with service discovery, configuration management, monitoring, and a good developer experience.

### Spring Batch

Spring Batch is a lightweight framework for robust batch applications that are vital for daily operations.

## MicroProfile and Jakarta EE

MicroProfile and Jakarta Enterprise Edition (EE) can be seen as the open-source follow-up of the Java EE specifications.

MicroProfile is a set of specifications for microservice architectures. It calls itself an *open forum to optimize Enterprise Java for a microservices architecture*. MicroProfile aims to innovate across multiple implementations and collaborate on common areas of interest.

Jakarta EE is a set of specifications for building enterprise applications. Its modularized structure enables developers to create efficient software solutions. You can package Jakarta EE applications as either EAR files or WAR files.

WebProfile is a subset of Jakarta EE for back-end services with a web focus, but don't worry! You can add specific APIs of the enterprise platform on top of it.

## Application servers

Java EE applications must be deployed onto Java EE-compliant application servers (WebLogic, WebSphere, WildFly, GlassFish, Payara, and others).

- **Apache Tomcat** is an HTTP server and a Java Servlet container. It implements the Servlet, Java Server Pages (JSP), Java Expression Language, and Java WebSocket specifications.

- **Oracle WebLogic Server** is a unified and extensible platform for developing, deploying, and running enterprise applications. WebLogic Server offers a robust, mature implementation of Java EE and Jakarta EE.

- **Red Hat JBoss Enterprise Application Platform** delivers enterprise-grade security and performance for both on-premises and virtual implementations, or in private, public, or hybrid clouds.

- **WildFly** is the open-source upstream for JBoss EAP. This community-driven variety is great for development and testing.

- **IBM WebSphere Application Server** (WAS) is a flexible, security-rich Java server runtime environment for enterprise applications. It focuses on high reliability. It supports microservices and standards-based programming models. You can modernize at your own pace, gain greater visibility across workloads, analyze enterprise applications, and advance your journey to Kubernetes.

- **Open Liberty** is the community-driven, open-source version of WAS.

- **Oracle GlassFish** is the reference implementation of many Java EE web standards (including Servlet and JSP).

## Other frameworks for microservice-oriented architectures

- **Netty** is a nonblocking I/O (NIO) client/server framework. It enables quick and easy development of network applications such as protocol servers and clients. It greatly simplifies and streamlines network programming, such as TCP and UDP socket servers. Netty is an asynchronous, event-driven network application framework for rapid development of maintainable, high-performance protocol servers and clients.

- **Quarkus** is a Kubernetes-native Java stack that's tailored for OpenJDK HotSpot and GraalVM. Quarkus is gaining more and more momentum. By the way, there are more performance-focused frameworks like this, such as Vert.x, Helidon, Payara Micro, and KumuluzEE.

- **Micronaut** is a modern, JVM-based, full-stack framework for building modular, easily testable microservice and serverless applications. Micronaut features a dependency injection and aspect-oriented programming runtime that uses no reflection. That makes it easier for Micronaut applications to run on GraalVM.
