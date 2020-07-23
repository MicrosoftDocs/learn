Resiliency is the ability to recover from transient failures and restore normal function with minimal user impact. Failures are unavoidable and your app must respond in a way that minimizes downtime and data loss. You should strive to handle failures gracefully without any user impact.

Microservice environments are volatile. Consequently, microservice apps should be designed to handle partial failures, such as code exceptions, network outages, unresponsive server processes, and hardware failures. Even normal activities, such as moving containers to a different node within a Kubernetes cluster, can cause transient failures.

Ensuring a resilient deployment requires the use of health checks. Microservices implement [liveness, readiness, and startup probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes) that expose the state of the service. Kubernetes uses that state to determine whether to accept traffic or replace a failing pod.

## Resiliency approaches

There are two fundamental approaches to resiliency: code and infrastructure. Each approach has benefits and drawbacks. Both approaches can be appropriate depending on the situation. In this module, you'll implement code-based resiliency using Polly. Then you'll implement infrastructure-based resiliency with Linkerd.

## Polly

[Polly](https://github.com/App-vNext/Polly) is a .NET library for resilience and transient failure handling. It is used to build failure-handling code with a fluent, easy-to-understand syntax. There are several ([resilience policies](https://github.com/App-vNext/Polly#resilience-policies)) that define failure-handling behavior. In this module, you'll apply the *Retry* and *Circuit-breaker* policies to HTTP client operations.

Resiliency with Polly is usually defined in code, but startup-time configuration for some parameters is supported.

### Retry policy

The *Retry* policy is exactly what the name implies. The request is retried after a short wait if an error response is received. The wait time is configurable and may be:

* A constant value, such as every 2 s.
* An exponentially increasing value, such as 2 s, 4 s, 8 s, 16 s, etc.
* A specific list of values, such as 100 ms, 100 ms, 100 ms, 2 s, 4 s, 8 s, etc.

The Retry policy always has a maximum retry count. Once that number of retries has been satisfied, the policy gives up and throws an exception. The user experience for this policy is usually that the app takes longer to complete some operations. The app may also take some time before informing the user that it couldn't complete the operation.

For an in-depth explanation of the Retry policy, see [Polly's wiki page on Retry policy](https://github.com/App-vNext/Polly/wiki/Retry).

### Circuit-breaker policy

The *Circuit-breaker* policy gives the target service a break after a repeated number of failures. Such a state might indicate that the service is having a serious problem and will be temporarily unable to respond. After a number of consecutive failures, the connection attempts are paused temporarily, "opening" the circuit. During this wait, additional operations on the target service fail immediately without "bothering" the service. After the wait time has elapsed, the operation is tried again. If the operation succeeds, the circuit is "closed" and the system goes back to normal.

For an in-depth explanation of the Circuit-breaker policy, see [Polly's wiki page on Circuit-breaker policy](https://github.com/App-vNext/Polly/wiki/Circuit-Breaker).

## Linkerd

[Linkerd](https://linkerd.io/2/overview) is service mesh infrastructure for Kubernetes clusters. It provides resiliency without changing code.

A [service mesh](https://servicemesh.io) is a set of proxies that stand beside each pod and handle all communication-related tasks. Each service in the mesh isn't aware it's being supported by a proxy beside it. The proxy is transparent, lightweight, and handles incoming and outgoing connections.

Linkerd and skips the observability and security aspects.

Linkerd includes a dashboard, that you can [explore when running from a local machine](https://linkerd.io/2/features/dashboard), but not from Azure's Cloud Shell.

### Resiliency strategies

Linkerd's resiliency strategies differ from those mentioned for Polly. Linkerd has [Retries and Timeouts](https://linkerd.io/2/features/retries-and-timeouts). Since Linkerd has a systemic view of the cluster, it can do some interesting "tricks". For example, retrying in such a way as to add a maximum of 20 percent additional load on the target service.

It may appear that Linkerd is more limited than Polly in this sense. Keep in mind that the systemic, metrics-based view allows Linkerd to adapt dynamically to cluster conditions in real time. This just adds another dimension to managing the cluster.

When you implement resiliency in your app's code, as when using Polly, you're guessing which retry or timeout parameters are reasonable. With a Polly-like solution, you're focusing on a specific request. There's no reasonable way that you can respond in your app's code. Consider the hundreds or thousands of requests that are being processed simultaneously. It's not difficult to imagine a situation in which even a retry with exponential back-off (times request count) can flood a service.

There are other "tricks" that are impossible for Linkerd to handle. Linkerd doesn't know anything about the app internals. For example, you can protect a complex database transaction with a Polly strategy, so it's automatically retried if it fails.

In the next two units, you'll implement resilience for the coupon service going through the app gateway. Polly and Linkerd are used for the first and second units, respectively.
