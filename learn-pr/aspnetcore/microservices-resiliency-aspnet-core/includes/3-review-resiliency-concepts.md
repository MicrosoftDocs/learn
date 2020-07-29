Resiliency is the ability to recover from transient failures and restore normal function with minimal user impact. Failures are unavoidable, and your app must respond in a way that minimizes downtime and data loss. You should handle failures gracefully without impacting the user.

Microservice environments are volatile. Consequently, microservice apps should be designed to handle partial failures, such as code exceptions, network outages, unresponsive server processes, and hardware failures. Even normal activities, such as moving containers to a different node within a Kubernetes cluster, can cause transient failures.

Ensuring a resilient deployment requires the use of health checks. Microservices implement [liveness, readiness, and startup probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes) that expose the state of the service. Kubernetes uses that state to determine whether to accept traffic or replace a failing pod.

## Resiliency approaches

There are two fundamental approaches to resiliency: code and infrastructure. Each approach has benefits and drawbacks. Both approaches can be appropriate depending on the situation. In this module, you'll implement code-based resiliency using Polly. Then you'll implement infrastructure-based resiliency with Linkerd.

## Polly

[Polly](https://github.com/App-vNext/Polly) is a .NET library for resilience and transient failure handling. It is used to build failure-handling code with a fluent, easy-to-understand syntax. There are several [resilience policies](https://github.com/App-vNext/Polly#resilience-policies) that define failure-handling behavior. In this module, you'll apply the *Retry* and *Circuit-breaker* policies to HTTP client operations.

Resiliency with Polly is defined in code, but startup-time configuration for some parameters is supported.

### Retry policy

The *Retry* policy is exactly what the name implies. The request is retried after a short wait if an error response is received. The wait time is configurable as shown in the following table:

| Wait time value          | Example sequence   |
|--------------------------|--------------------|
| Constant                 | 2 s, 2 s, 2 s, 2 s... |
| Exponentially increasing | 2 s, 4 s, 8 s, 16 s... |
| Specified list           | 100 ms, 100 ms, 100 ms, 2 s, 4 s, 8 s... |

The Retry policy always has a maximum retry count. Once that number of retries has been satisfied, the policy gives up and throws an exception. The user experience for this policy is usually that the app takes longer to complete some operations. The app may also take some time before informing the user that it couldn't complete the operation.

For an in-depth explanation of the Retry policy, see [Polly's wiki page on Retry policy](https://github.com/App-vNext/Polly/wiki/Retry).

### Circuit-breaker policy

The *Circuit-breaker* policy gives the target service a break after a repeated number of failures. Such a state might indicate that the service is having a serious problem and will be temporarily unable to respond. After a number of consecutive failures, the connection attempts are paused temporarily, "opening" the circuit. During this wait, additional operations on the target service fail immediately without "bothering" the service. After the wait time has elapsed, the operation is tried again. If the operation succeeds, the circuit is "closed" and the system goes back to normal.

For an in-depth explanation of the Circuit-breaker policy, see [Polly's wiki page on Circuit-breaker policy](https://github.com/App-vNext/Polly/wiki/Circuit-Breaker).

## Linkerd

[Linkerd](https://linkerd.io/2/overview) is service mesh infrastructure for Kubernetes clusters. It provides resiliency without changing code. A [service mesh](https://servicemesh.io) is a set of proxies that stand beside each pod and handle all communication-related tasks. Each service in the mesh isn't aware it's behind a proxy. The proxy is transparent, lightweight, and handles incoming and outgoing connections.

### Comparison to code-based approaches

Linkerd's principal strategy is [Retries and Timeouts](https://linkerd.io/2/features/retries-and-timeouts). Since Linkerd has a systemic view of the entire cluster, it has the ability employ resiliency strategies in novel ways. An example of this is retrying in such a way as to add a maximum of 20 percent additional load on the target service. Linkerd's metrics-based view allows it to adapt dynamically to cluster conditions in real time. This adds another dimension to managing the cluster, but doesn't add any code.

With a code-based approach, such as with Polly, you:

* Are required to guess which retry and timeout parameters are appropriate.
* Focus on a specific HTTP request.

There's no reasonable way to respond to an infrastructure failure in your app's code. Consider the hundreds or thousands of requests that are being processed simultaneously. It's not difficult to imagine a situation in which even a retry with exponential back-off (times request count) can flood a service.

Infrastructure-based approaches like Linkerd don't know anything about app internals. For example, complex database transactions are not visible to Linkerd. Such transactions can be protected from failure with Polly.

In upcoming units, you'll implement resilience for the coupon service with Polly and Linkerd.
