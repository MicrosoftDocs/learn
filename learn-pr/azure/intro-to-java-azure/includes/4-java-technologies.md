It's necessary to distinguish between the different types of Java application before choosing the matching cloud solution.

You can distinguish your type of application specification wise. The most famous ones are:

## MicroProfile and Jakarta EE, the Java for Enterprises

MicroProfile and Jakarta EE can be seen as the open source follow-up of the Java Enterprise Edition.

### MicroProfile

is a set of specifications for Microservice Architectures. They call themselves an _open forum to optimize Enterprise Java for a microservices architecture_. The MicroProfile aims to innovate across multiple implementations and collaborate on common areas of interest. The goal remains standardization.

### Jakarta EE

Jakarta EE aims to be cloud native for Java development. It's a set of specifications to enable java developers world wide to work together on java enterprise applications. The modularized structure enables developers to create straight forward and efficient software solutions. Jakarta EE was donated to the Eclipse Foundation. Jakarta EE applications can be packaged as archives with the .ear extension (EAR files) or as archives with the .war extension (WAR files).

- **WebProfile** is a properly defined subset of Jakarta EE for backend services with Web focus. But no worries! You can add specific APIs of the Enterprise platform on top of it.

## Spring Framework and the Spring Ecosystem

The Spring Framework is an application framework and inversion of control container for the Java platform. The framework's core features can be used by any Java application, but there are extensions for building web applications on top of the Java EE (Enterprise Edition) platform. Although the framework doesn't impose any specific programming model, it has become popular in the Java community as an addition to the Enterprise JavaBeans (EJB) model. The Spring Framework is open source.
The Spring Framework brings the core functionality and supports:

- Dependency Injection
- Aspect-oriented programming
- Business abstraction

### Spring Boot

Spring Boot is by far the most used framework as an alternative to application servers. It's running on top of the Spring Framework and simplifies the life of developers. Spring Boot has become so successful, that more than half of all Java Web applications are already using it. It has become the most popular Java web framework. And it's getting more and more momentum over the last years. Its opinionated autoconfiguration makes it easy to use. Spring boot applications are running stand-alone. As such they can be a perfect fit for Microservices.

### Spring Data

Spring Data simplifies the data access, no matter which technologies: relational and non-relational databases, map-reduce frameworks, and cloud-based data services.

### Spring Security

Spring Security is de-facto standard for securing Spring-based applications. It offers highly authentication and access-control, for instance Spring Security integrates well with Active Directory.

### Spring Cloud

Spring Cloud is the de-facto standard where to deploy your Java services if you have a distributed system. It's the most stable and mature technology for that use case. Spring Cloud comes with Service Discovery, Scalability, Configuration Management, Monitoring, and a good developer experience.

### Spring Batch

Spring Batch is a lightweight framework for robust batch applications vital for daily operations.

## Application Servers

Java EE applications must be deployed onto Java EE-compliant application servers (such as WebLogic, WebSphere, WildFly, GlassFish, Payara, and others).

About 54% of Java applications are running on Tomcat the rest is splitting as the following graphic is illustrating.

- **Apache Tomcat** is the most used HTTP server and a Java Servlet container meaning it's an open-source implementation of the Java Servlet, JavaServer Pages, Java Expression Language, and Java WebSocket technologies. The Java Servlet, JavaServer Pages, Java Expression Language, and Java WebSocket specifications are developed under the Java Community Process. Tomcat is a reference implementation for the Servlet and JSP specification.

- **Oracle Glassfish** is the Open Source Java EE Reference Implementation; as such, they welcome external contributions. It's the reference implementation of the Java EE standard (which includes Servlet and JSP).

- The **Oracle Weblogic Server** is a unified and extensible platform for developing, deploying, and running enterprise applications, such as Java, for on-premises and in the cloud. WebLogic Server offers a robust, mature, and scalable implementation of Java Enterprise Edition (EE) and Jakarta EE.

- **Red Hat JBoss Enterprise Application Platform** delivers enterprise-grade security, performance, and scalability in any environment. Whether on-premise; virtual; or in private, public, or hybrid clouds, JBoss EAP can help you deliver apps faster, everywhere.

- **WildFly** is the open source upstream for JBoss EAP. The community driven flavor is great for development and testing.

- **IBM WebSphere Application Server** (WAS) is a flexible, security-rich Java server runtime environment for enterprise applications. It focuses on high reliability. WAS supports microservices and standards-based programming models. You can modernize at your own pace, gain greater visibility across workloads, analyze enterprise applications, and advance your journey to Kubernetes.

- **Open Liberty**, following Java-/Jakarta-EE, and Microprofile standard, it is the community driven, open-source version of the WAS.

## Other Frameworks for Microservice-oriented Architectures

- **Netty** is a NIO client-server framework, which enables quick and easy development of network applications such as protocol servers and clients. It greatly simplifies and streamlines network programming such as TCP and UDP socket server. Netty is an asynchronous event-driven network application framework for rapid development of maintainable high-performance protocol servers & clients.

- **Quarkus** is a Kubernetes Native Java stack tailored for OpenJDK HotSpot and GraalVM. It aims to be crafted from the best of breed Java libraries and standards. Quarkus is getting more and more momentum.

- **Vert.x** is an event driven and nonblocking tool-kit. You can use Vert.x with multiple languages including Java, Kotlin, JavaScript, Groovy, Ruby, and Scala. It aims to be the most lightweight, fastest framework. It's simple but not simplistic. Eclipse Vert.x is open source and dual-licensed under the Eclipse Public License 2.0 and Apache License 2.0.

- **Micronaut** is a modern, JVM-based, full-stack framework for building modular, easily testable microservice, and serverless applications. Micronaut features a dependency injection and aspect-oriented programming runtime that uses no reflection. That makes it easier for Micronaut applications to run on GraalVM.
