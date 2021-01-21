Now that we have Azure Cache Redis configured and working, let's use it to store HTTP session data using Spring Session.

## What are HTTP Sessions

HTTP sessions store user data between requests. Typically they store security information, and they can go further and store an application's state, or serve as a cache for frequently accessed user data. As those sessions are stored on the server side, they cause scalability issues as you need to replicate them when your application scales out to multiple nodes.

In Java, HTTP sessions are available since the early of Servlets, and are heavily used in technologies like JavaServer Faces (JSF). Scaling them has been an issue from the beginning, and session replication mechanisms exist in all major Java application servers.

## What is Spring Session

One of the issues with HTTP session replication mechanisms, is that they aren't standardized: they rely on APIs, which are specific to each application servers. This setup causes some portability issues, and so the Spring team created [Spring Session](https://spring.io/projects/spring-session) to have a generic solution.

Spring Session is a Spring subproject that aims to simplify HTTP session replication configuration. It supports several backend mechanisms, Redis being a popular option here: it will replicate all session data inside Redis, so that when the application scales out, each node will have access to those user sessions.

This configuration is similar to the one we've done before with Spring Data, and is another recommended usage scenario for Redis.

## How to use Spring Session with Redis

Some of this configuration is the same as the one we did for using Spring Data Redis, so you need both solutions you only need to this once.

Using Spring Boot, typically with [https://start.spring.io/](https://start.spring.io/), you'll have three main tasks to achieve:

- Add the Spring Session Data Redis library to your application.
- Configure your `application.yml` file to connect to your Azure Cache for Redis instance.
- Use Java's HTTP Session mechanism to store or retrieve data.

Those tasks are what we're going to achieve in the next section's exercise.
