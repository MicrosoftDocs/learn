## What is the benefit of Java EE (Jakarta EE)

At first, let's look back at the history of Java EE (Jakarta EE).  
In 1999, the Java 2 Platform, Enterprise Edition (J2EE) was released with the aim of providing a standard library for developing Java applications for the enterprise. This allows enterprises to build stable and robust enterprise services with standard Java technology. J2EE includes technologies such as JSP, Servlet, JDBC, JMS, JTA, and EJB. The JSP and Servlet were especially popular technologies at that time.

Up to J2EE 1.4, it also supported XML technologies such as SOAP to meet all the needs of enterprise enterprise application development. In the opposite side, while the specifications have expanded, the development of enterprise Java applications has had to write the settings in XML, and the ease of development has also been compromised.

Therefore, the specification creator has made improvements to improve the ease of development so that XML is not required from version 5 and development can be performed using Java annotations. It also renamed from J2EE to Java EE. Improvements that enhance ease of development have also been made in Java EE 6 and Java EE 7, and also incorporate technologies such as WebSocket and RESTful Web services, which were modern technologies, and Java EE standard technology makes it easy for enterprise applications to develop.  

After the release of Java EE 7, the acquisition of Sun Microsystems by Oracle stagnated the development process for the next version of Java EE, but Thanks to the efforts of the communities and companies that underpin the enterprise Java industry (IBM, Red Hat, Payara, Tomitribe, Fujitsu and Oracle), Java EE is now being renamed to Jakarta EE under the Eclipse Foundation. Even after becoming Jakarta EE, Jakarta EE 8 and 9 were released, and many applications conforming to the Jakarta EE specifications were provided, and it is still provided as a Java framework for developing important enterprise applications.

|  Version  |  Description  |  Date  |
| ---- | ---- | ---- |
|  JPE Project  |  Initial Version  | May 1998|
|  J2EE 1.2  |  Servlet,JSP,EJB,JMS,RMI,IIOP  |Dec 12, 1999|
|  J2EE 1.3  |  CMP, Connector Architecture  |Sep 24, 2001|
|  J2EE 1.4  |  Web Services, Management, Deployment, Async Connector  |Nov 11, 2003|
|  Java EE 5  |  Easy of Development by Annotation, EJB 3.0, JPA, JSF, JAXB, JAX-WS, Stax, SAAJ  |May 11 2006|
|  Java EE 6 |  Web Profile, EJB Lite, JAX-RS, CDI  |Dec 20, 2009|
|  Java EE 7 |  WebSocket, JSON-P, JMS 2.0  |May 28, 2013|
|  Jakarta EE 8 |  JSON-B,   |Sep 21, 2017|
|  Jakarta EE 9 |  TD  |December 8, 2020|
## What is JBoss Enterprise Application Platform

`Red Hat JBoss Enterprise Application Platform` is listed on one of the `Jakarta EE 8 Platform Compatible Products`. And it has many functionalities like below.

- Optimized for cloud and containers
- Lightweight, flexible architecture
- More productive developers
- Flexible management, configuration, and administration
- Flexible, future-friendly subscription model
- Support and standardize microservices development
