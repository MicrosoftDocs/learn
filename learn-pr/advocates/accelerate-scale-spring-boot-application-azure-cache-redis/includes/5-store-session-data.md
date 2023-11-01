In this unit, learn how to use Azure Cache for Redis to store HTTP session data through Spring Session.

## HTTP sessions

HTTP sessions store user data, typically security information, between requests. HTTP sessions can also store application state, or cache frequently accessed user data. Because HTTP sessions are stored on the server, they can present a scalability issue. You need to replicate the sessions when your application scales out to more nodes.

HTTP sessions have been available in Java since the early days of servlets, and technologies like JavaServer Faces (JSF) use them heavily. Scaling HTTP sessions has always been an issue, and session replication mechanisms exist in all major Java application servers.

One problem is that HTTP session replication mechanisms aren't standardized, but rely on APIs that are specific to each application server. This setup can cause portability problems.

## Spring Session

[Spring Session](https://spring.io/projects/spring-session) is a Spring subproject that provides a generic solution for configuring HTTP session replication. Spring Session supports Redis as one of several backend options. Spring Session replicates all session data within Redis, so when the application scales out, each node has access to the user sessions.

Spring Session configuration is similar to the previous Spring Data configuration, and illustrates another recommended Redis usage scenario.

## Use Spring Session with Redis

Some of the configuration is the same as for Spring Data Redis, and you need to do it only once for both solutions. As in the Spring Data configuration, you typically use [Spring Initializr](https://start.spring.io/) and do the following main tasks:

1. Add the Spring Session Redis library to your application.
1. Configure your *application.yml* file to connect to your Azure Cache for Redis instance.
1. Use Java's HTTP session mechanism to store and retrieve data.

Proceed to the next unit to implement this configuration.
