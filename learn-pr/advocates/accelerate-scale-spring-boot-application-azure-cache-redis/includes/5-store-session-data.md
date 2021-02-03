Now that we have Azure Cache for Redis configured and working, let's use it to store HTTP session data through Spring Session.

## What are HTTP sessions?

HTTP sessions store user data between requests. They typically store security information. But they can go further and store an application's state, or serve as a cache for frequently accessed user data. Because those sessions are stored on the server side, they cause scalability issues: you need to replicate them when your application scales out to multiple nodes.

In Java, HTTP sessions have been available since the early days of servlets. They're heavily used in technologies like JavaServer Faces (JSF). Scaling them has been an issue from the beginning, and session replication mechanisms exist in all major Java application servers.

## What is Spring Session?

One of the problems with mechanisms for HTTP session replication is that they aren't standardized. They rely on APIs, which are specific to each application server. This setup causes some portability problems, so the Spring team created [Spring Session](https://spring.io/projects/spring-session) to have a generic solution.

Spring Session is a Spring subproject that aims to simplify the configuration of HTTP session replication. It supports several back-end mechanisms, including Redis as a popular option. Spring Session will replicate all session data inside Redis so that when the application scales out, each node will have access to those user sessions.

This configuration is similar to the one we did before with Spring Data, and is another recommended usage scenario for Redis.

## How to use Spring Session with Redis

Some of this configuration is the same as the one we did for using Spring Data Redis. You need to do this configuration only once for both solutions.

Using Spring Boot, typically with [Spring Initializr](https://start.spring.io/), you'll have three main tasks:

- Add the Spring Session Data Redis library to your application.
- Configure your `application.yml` file to connect to your Azure Cache for Redis instance.
- Use Java's HTTP Session mechanism to store or retrieve data.

Those tasks are what we're going to achieve in the next section's exercise.
