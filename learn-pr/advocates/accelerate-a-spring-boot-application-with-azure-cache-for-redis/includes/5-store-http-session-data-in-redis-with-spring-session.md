Now that we have Azure Cache Redis configured and working, let's use it to store HTTP session data using Spring Session.

## What is Spring Session

HTTP sessions store user data between requests. Typically they store security information, and they can go further and store an application's state, or serve as a cache for frequently accessed user data. As those sessions are stored on the server side, they cause scalability issues as you need to replicate them when your application scales out to multiple nodes.

Those scalability issues are where Spring Session comes into play. [Spring Session](https://spring.io/projects/spring-session) is a Spring subproject that aims to simplify HTTP session replication configuration. It supports several backend mechanisms, Redis being a popular option here: it will replicate all session data inside Redis, so that when the application scales out, each node will have access to those user sessions.

