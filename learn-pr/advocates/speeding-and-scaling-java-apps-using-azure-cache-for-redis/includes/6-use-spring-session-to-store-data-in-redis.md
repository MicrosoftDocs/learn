Now that we have Azure Cache Redis configured and working, let's use it to store HTTP session data using Spring Session.

## What is Spring Session

HTTP sessions store user data between requests. Typically they store security information (like security tokens), and they can go further and store an application's state, or serve as a cache for frequently-accessed user data. As those sessions are stored on the server side, they cause scalability issues as you need to replicate them when your application scales out to multiple nodes.

This is where Spring Session comes into play. [Spring Session](https://spring.io/projects/spring-session) is a Spring sub-project that aims to simplify HTTP session replication configuration. It supports several backend mechanisms, Redis being a popular option for this: it'll replicate all session data inside Redis, so that when the application scales out, each node will have access to those user sessions.

## Spring Session configuration

To add Spring Session support inside your application, add the following dependency in the `pom.xml` file, in the `<dependencies>` section:

```xml
<dependency>
    <groupId>org.springframework.session</groupId>
    <artifactId>spring-session-data-redis</artifactId>
</dependency>
```

And to configure Spring Session to use Redis for session replication, add this line to the `src/main/resources/application.properties` file:

```properties
spring.session.store-type=redis
```

## Add a new controller to test session replication

Now let's add a new Spring MVC REST controller to test session replication.

Create a new controller called `SessionReplicationController`, next to the `TodoController`:

```java
package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/")
public class SessionReplicationController {

    @GetMapping("/session")
    public int session(HttpSession session) {
        Integer test = (Integer) session.getAttribute("test");
        if (test == null) {
            test = 0;
        } else {
            test++;
        }
        session.setAttribute("test", test);
        return test;
    }
}
```

You can now restart your application

## Testing Spring Session
