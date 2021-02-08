You'll now add Spring Session to your existing Spring Boot application, to store HTTP session data inside Azure Cache for Redis.

## Configure Spring Session

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

Create a new controller called `SessionReplicationController`, next to `TodoController`:

```java
package com.example.demo;

import org.springframework.context.annotation.Bean;
import org.springframework.session.data.redis.config.ConfigureRedisAction;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/")
public class SessionReplicationController {

    @Bean
    public static ConfigureRedisAction configureRedisAction() {
        return ConfigureRedisAction.NO_OP;
    }

    @GetMapping("/session")
    public String session(HttpSession session) {
        Integer test = (Integer) session.getAttribute("test");
        if (test == null) {
            test = 0;
        } else {
            test++;
        }
        session.setAttribute("test", test);
        return "[" + session.getId() + "]-" + test;
    }
}
```

> [!NOTE]
> We configure a specific `ConfigureRedisAction.NO_OP` Spring bean because by default, Spring Session will try to set up [Redis keyspace notifications](https://redis.io/topics/notifications). This setup won't work on a secured Redis instance like the one that Azure Cache for Redis provides. It has to be applied manually (through the Redis CLI) if needed.
> 
> Those keyspace notifications shouldn't be enabled for our current scenario anyway. They're useful for people who use WebSockets (which isn't our case), and they consume more resources.

You can now restart your application, and you'll benefit from HTTP session replication.

## Test Spring Session

Sessions are specific to each user and are maintained through a cookie.

There are two ways to test that sessions are working correctly here. You can point your browser to `http://localhost:8080/session` and reload your page several times, or you can use the following command line:

```bash
curl -b cookie.txt -c cookie.txt http://127.0.0.1:8080/session
```

This command should display your HTTP session ID, with a number that's incremented after each request. Here's an example of this output:

![Screenshot that shows example output for session replication.](../media/6-http-session.png)

> [!NOTE]
> This command line will save your cookie in a file called `cookie.txt`.

To check if sessions are correctly persisted, you can restart your server and verify that your session data wasn't lost.

In the next unit, we'll go further and cluster HTTP sessions between your local machine and a cloud service.
