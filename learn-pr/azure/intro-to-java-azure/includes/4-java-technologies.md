You can distinguish between the types of Java applications according to specifications. Here are the most famous ones.

## Spring Framework and the Spring ecosystem

The Spring Framework is an application framework and inversion of control container for the Java platform. Any Java application can use the framework's core features, but there are extensions for building web applications on top of the Java EE (Enterprise Edition) platform. 

Although the framework doesn't impose any specific programming model, it has become popular in the Java community as an addition to the Enterprise JavaBeans (EJB) model. The Spring Framework is open source and supports:

- Dependency injection
- Aspect-oriented programming
- Business abstraction

### Spring Boot

Spring Boot is by far the most used framework as an alternative to application servers. It runs on top of the Spring Framework and simplifies the life of developers. 

Spring Boot has become so successful that more than half of all Java web applications are already using it. It has become the most popular Java web framework. And it has gained more and more momentum over the past few years. 

The opinionated autoconfiguration of Spring Boot makes it easy to use. Spring Boot applications run standalone, so they can be a perfect fit for microservices.

### Spring Data

Spring Data simplifies data access, no matter which technologies you use: relational and non-relational databases, map-reduce frameworks, and cloud-based data services.

### Spring Security

Spring Security is the de facto standard for securing Spring-based applications. It offers highly authentication and access control. For instance, Spring Security integrates well with Active Directory.

### Spring Cloud

Spring Cloud is the de facto standard for where to deploy your Java services if you have a distributed system. It's the most stable and mature technology for that use case. Spring Cloud comes with service discovery, scalability, configuration management, monitoring, and a good developer experience.

### Spring Batch

Spring Batch is a lightweight framework for robust batch applications that are vital for daily operations.

## MicroProfile and Jakarta EE

MicroProfile and Jakarta EE can be seen as the open-source Java for enterprises.

MicroProfile is a set of specifications for microservice architectures. It calls itself an _open forum to optimize Enterprise Java for a microservices architecture_. MicroProfile aims to innovate across multiple implementations and collaborate on common areas of interest. The goal is standardization.

Jakarta EE aims to be cloud native for Java development. It's a set of specifications to enable Java developers worldwide to work together on Java enterprise applications. The modularized structure enables developers to create straightforward and efficient software solutions. 

Jakarta EE was donated to the Eclipse Foundation. Jakarta EE applications can be packaged as archives with the .ear extension (EAR files) or as archives with the .war extension (WAR files).

WebProfile is a properly defined subset of Jakarta EE for back-end services with web focus. But don't worry! You can add specific APIs of the enterprise platform on top of it.

## Application servers

Java EE applications must be deployed onto Java EE-compliant application servers (WebLogic, WebSphere, WildFly, GlassFish, Payara, and others).

- **Apache Tomcat** is the most used HTTP server and a Java Servlet container. It's an open-source implementation of the Java Servlet, JavaServer Pages, Java Expression Language, and Java WebSocket technologies. The Java Servlet, JavaServer Pages, Java Expression Language, and Java WebSocket specifications are developed under the Java Community Process.

- **Oracle WebLogic Server** is a unified and extensible platform for developing, deploying, and running enterprise applications, such as Java, for on-premises and in the cloud. WebLogic Server offers a robust, mature, and scalable implementation of Java EE and Jakarta EE.

- **Red Hat JBoss Enterprise Application Platform** (JBoss EAP) delivers enterprise-grade security, performance, and scalability. Whether on-premises, virtual, or in private, public, or hybrid clouds, JBoss EAP can help you deliver apps faster, everywhere.

- **WildFly** is the open-source upstream for JBoss EAP. The community-driven variety is great for development and testing.

- **IBM WebSphere Application Server** (WAS) is a flexible, security-rich Java server runtime environment for enterprise applications. It focuses on high reliability. WAS supports microservices and standards-based programming models. You can modernize at your own pace, gain greater visibility across workloads, analyze enterprise applications, and advance your journey to Kubernetes.

- **Open Liberty**, following the Java EE, Jakarta-EE, and Microprofile standard, is the community-driven, open-source version of WAS.

- **Oracle GlassFish** is the open-source Java EE reference implementation. As such, it welcomes external contributions. It's the reference implementation of the Java EE standard (which includes Servlet and JSP).

## Other frameworks for microservice-oriented architectures

- **Netty** is a nonblocking I/O (NIO) client/server framework. It enables quick and easy development of network applications such as protocol servers and clients. It greatly simplifies and streamlines network programming such as TCP and UDP socket servers. Netty is an asynchronous, event-driven network application framework for rapid development of maintainable, high-performance protocol servers and clients.

- **Quarkus** is a Kubernetes Native Java stack tailored for OpenJDK HotSpot and GraalVM. It aims to be crafted from the best-of-breed Java libraries and standards. Quarkus is getting more and more momentum. By the way, there are more performance-focused frameworks like this, such as Vert.x, Helidon, Payara Micro, and KumuluzEE.

- **Micronaut** is a modern, JVM-based, full-stack framework for building modular, easily testable microservice and serverless applications. Micronaut features a dependency injection and aspect-oriented programming runtime that uses no reflection. That makes it easier for Micronaut applications to run on GraalVM.
