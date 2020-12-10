## What is the benefit of Java EE (Jakarta EE)

At first, let's look back at the history of Java EE (Jakarta EE).  
In 1999, the Java 2 Platform, Enterprise Edition (J2EE) was released with the aim of providing a standard library for developing Java applications for the enterprise. This allows enterprises to build stable and robust enterprise services with standard Java technology. J2EE includes technologies such as JSP, Servlet, JDBC, JMS, JTA, and EJB. The JSP and Servlet were especially popular technologies at that time.

Up to J2EE 1.4, it also supported XML technologies such as SOAP to meet all the needs of enterprise enterprise application development. In the opposite side, while the specifications have expanded, the development of enterprise Java applications has had to write the settings in XML, and the ease of development has also been compromised.

Therefore, the specification creator has made improvements to improve the ease of development so that XML is not required from version 5 and development can be performed using Java annotations. It also renamed from J2EE to Java EE. Improvements that enhance ease of development have also been made in Java EE 6 and Java EE 7, and also incorporate technologies such as WebSocket and RESTful Web services, which were modern technologies, and Java EE standard technology makes it easy for enterprise applications to develop.  

After the release of Java EE 7, the acquisition of Sun Microsystems by Oracle stagnated the development process for the next version of Java EE, but Thanks to the efforts of the communities and companies that underpin the enterprise Java industry (IBM, Red Hat, Payara, Tomitribe, Fujitsu and Oracle), Java EE is now being renamed to Jakarta EE under the Eclipse Foundation. Even after becoming Jakarta EE, Jakarta EE 8 and 9 were released, and many applications conforming to the Jakarta EE specifications were provided, and it is still provided as a Java framework for developing important enterprise applications. Thus in this module, we will deploy a Java EE (Jakarta EE) Application to `Red Hat JBoss Enterprise Application Platform (JBoss EAPs)` as one of Java EE Compatible Application Server.

|  Version  |  Description  |  Date  |
| ---- | ---- | ---- |
|  JPE Project  |  Initial Version  | May 1998|
|  J2EE 1.2  |  JSP, Servlet, EJB, JMS, Java Mail, JDBC, JNDI, JAF |Dec 12, 1999|
|  J2EE 1.3  |  JSTL、JAXP, J2CA , JAAS  |Sep 24, 2001|
|  J2EE 1.4  |  JAXP, JAXR, JAX-RPC, Async Connector  |Nov 11, 2003|
|  Java EE 5  |  Easy of Development by Annotation, EJB 3.0, JPA, JSF, JAXB|May 11 2006|
|  Java EE 6 |  Web Profile, EJB Lite, JAX-RS, CDI, Bean Validation  |Dec 20, 2009|
|  Java EE 7 |  WebSocket,Java Batch, JSON-P, JMS 2.0 |May 28, 2013|
|  Jakarta EE 8 |  JSON-B, HTTP/2, Security   |Sep 21, 2017|
|  Jakarta EE 9 |  Namespace change to jakarta, Enhancement of EJB, Activation, Moved from Java SE to Jakarta EE of JAXB, JAX-WS, SOAP as optional |December 8, 2020|

## What is JBoss Enterprise Application Platform

`Red Hat JBoss Enterprise Application Platform 7` is listed on one of the `Jakarta EE 8 Platform Compatible Products`.

And it has many functionalities like below.

- Optimized for Cloud and Containers
- Lightweight, Flexible Architecture
- More Productive Developers
- Flexible Management, Configuration, and Administration
- Flexible, Future-Friendly Subscription Model
- Support and standardize microservices development

JBoss EAP is based on the Open Source Application Server which is called as `WildFly Application Server`. It also provides commercial support.

HTTP request is handled by a module called `Undertow`, which supports HTTP/2 and WebSocket, and is implemented by using Non-Blocking IO, so it is highly scalable and has high performance. In addition, it can run various Java web applications such as HTML5, mobile applications, microservice applications, and enterprise applications that require transactions using Java EE. 

![JBoss Web Admin Console](../media/jboss-admin-console2.png)

For Management, Both Command Line Interface (CLI) and a Graphical User Interface (GUI) are provided, and by using these, various configurations of the application server can be managed quickly and centrally.

As a result, the JBoss EAP making it ideal for companies that demand high development productivity and reliability.




