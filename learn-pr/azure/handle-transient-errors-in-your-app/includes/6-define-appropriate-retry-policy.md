Your chat app needs to respond appropriately to errors it detects. If it's a transient error, trying the operation again is a sensible approach.

However, retrying an operation when the service is busy only makes the situation worse. Likewise, if the service is unavailable and the service has notified the client that it should try again in 10 minutes, there's no point retrying instantly. Knowledge of the service being called enables you to decide on the key properties of a retry strategy. The first decision needs to be how many times the app is going to retry calling the service. If this number is larger than one, how long should the interval be between retries?

The following table lists common retry interval strategies to try when a transient error occurs.

| Interval      | Description   |
|---------------|---------------|
| Instant retry | If packets are corrupted because of networking issues, trying again straight away is a good option. |
| Regular       | Instant retry, then try again every 5 seconds. |
| Incremental   | Instant retry, then increase the wait period by fixed amounts, 2 seconds, 4 seconds, 6 seconds. |
| Exponential   | Instant retry, then increase the wait period exponentially, 1 second, 8 seconds, 20 seconds. |
| Random        | Can be used with any of the other retry intervals. The aim is to reduce the chance that clients of a service retry at the same time. |

A good practice for usability is to use an exponential interval for background operations that an end user may not notice. For interactive operations, like user interface updates, regular retries is a better choice. The users are waiting the least amount of time as possible. In other cases, you may have a Service Level Agreement (SLA) with end users, or one with the service. The SLA sets a hard limit on the number of times the app can spend trying to get a response.

As stated previously, apps should ensure they're using idempotent operations. Instead of sending delta operations, for example increase or decreasing values, send absolute values, by setting values rather than adjusting them.

Let's look at the example of when a service you're using returns an HTTP 503 Service Unavailable exception. The service can return a *Retry-After* header in the response. The response from the service gives your app the best chance to get a successful response. Many services have a built-in ability to retry operations, so in some cases this feature might provide enough functionality to serve as your app's retry strategy.

Once you've defined a strategy, a good approach is to have a central process or object that handles retries. This process can allow parameters such as max retry count and retry intervals to be changed via configuration. Then, your system administrators have the flexibility to adjust the apps performance when deployed into production, without the need for any code changes.

Eventually, if the service still hasn't responded, your app needs to make the decision to give up.

### External libraries

Although it's possible to write your own retry logic in code, there are some open-source projects that have already codified the good practices we outline here.

::: zone pivot="csharp"
For C# there's [Polly](https://old.dotnetfoundation.org/projects/polly), it supports defining a retry policy, including random and exponential intervals. It allows for the reties to be stopped after a specified number or by using a circuit breaker. Finally for more permanent errors, fallback and caching can be used.
::: zone-end
::: zone pivot="java"
For Java there's [Resilience4j](https://github.com/resilience4j/resilience4j), it supports defining a retry policy, including random and exponential intervals. It allows for the reties to be stopped after a specified number or by using a circuit breaker. Finally for more permanent errors, fallback and caching can be used.
::: zone-end
::: zone pivot="node"
For Node there's [Polly.js](https://github.com/mauricedb/polly-js), Which is based on the .NET Polly project. It doesn't have as many features as the C# library, but does implement retry and circuit breaker logic.
::: zone-end
