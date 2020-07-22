Resiliency is the ability to recover from transient failures and restore normal function with minimal user impact. Failures are unavoidable and your app must respond in a way that minimizes downtime and data loss. This should ideally be done gracefully without any user impact.

Microservice environments are volatile. Consequently, microservice apps should be designed to handle partial failures, such as code exceptions, network outages, unresponsive server processes, and hardware failures. Even normal activities, such as moving containers to a different node within a Kubernetes cluster, can cause transient failures.

Ensuring a resilient deployment also requires the use of health checks. Microservices provide [liveness, readiness, and startup probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes). The probes provide the service state. Kubernetes uses that state to determine whether to accept traffic or replace a failing pod.

## Resiliency approaches

There are two fundamental approaches to resiliency. You can add:

- Failure handling code in your app.
- Infrastructure to handle communication failures.

There are pros and cons on both sides. You may use both approaches, depending on the situation. Plenty of solutions exist for both approaches.

You'll start with adding Polly to the app. Once you understand how Polly works, you'll replace it with Linkerd.

## Polly

[Polly](https://github.com/App-vNext/Polly) is a .NET resilience and transient-failures-handling library. It allows the developer to include failure-handling code with a fluent, easy-to-understand syntax.

There are several strategies ([Polly's policies](https://github.com/App-vNext/Polly#resilience-policies)) for handling failures. The strategies can be applied for HTTP (gRPC) requests and even database transactions. This module focuses on **Retries (with exponential back-off)** and **Circuit Breaker** on HTTP calls using [IHttpClientFactory](/aspnet/core/fundamentals/http-requests).

Resiliency with Polly must be hard-coded, although you can use startup-time configuration for some parameters.

### Retry policy

The *Retry policy* is exactly what the name implies. The request is retried if an error response is received, after a short waiting time. The waiting time is configurable and may be:

- A constant waiting time for a certain retry count.
- An exponentially increasing time. For example, 2, 4, 8, 16 seconds.
- A specific time list. For example, 100 ms, 100 ms, 100 ms, 2 s, 4 s, 8 s, and so on.

The Retry policy always has a maximum retry count. Once that number of retries has been satisfied, the policy gives up and returns the error message. The user experience for this policy is usually that the app takes longer to complete some operations. The app may also take some time before informing the user that it couldn't complete the operation.

For an in-depth explanation of the Retry policy, see [Polly's wiki page on Retry policy](https://github.com/App-vNext/Polly/wiki/Retry).

### Circuit Breaker policy

The *Circuit Breaker policy* "gives the target service a break", after a certain number of failures, when it looks like the service is having some serious problem and it's not going to respond for a while.

The concept is simple too. After a certain number of consecutive failures (more options with the advanced Circuit Breaker policy), the connection is open for some waiting time.

During the waiting time, the operation is failed immediately, without "bothering" the service. After the waiting time has elapsed, the operation is tried once. If the operation succeeds, the circuit is closed again and the system goes back to normal. If the operation fails, the circuit is opened and the waiting time begins again.

For an in-depth explanation of the Circuit Breaker policy, see [Polly's wiki page on Circuit Breaker policy](https://github.com/App-vNext/Polly/wiki/Circuit-Breaker).

## Linkerd

[Linkerd](https://linkerd.io/2/overview) takes a different approach than Polly. Linkerd is service mesh infrastructure for Kubernetes clusters. It can handle resiliency without changing your app's code.

A [service mesh](https://servicemesh.io) is a set of proxies that stand beside each pod and handle all communication-related tasks. For example, Linkerd can be configured to ensure reliable and secure communications and to get operational metrics.

Each "meshed" service doesn't really know it's being supported by a proxy beside it. A proxy is "transparent", light, and handles incoming and outgoing connections.

This module focuses on the resiliency aspect of Linkerd and skips the observability and security aspects.

Linkerd includes a dashboard, that you can [explore when running from a local machine](https://linkerd.io/2/features/dashboard), but not from Azure's Cloud Shell.

### Resiliency strategies

Linkerd's resiliency strategies differ from those mentioned for Polly. Linkerd has [Retries and Timeouts](https://linkerd.io/2/features/retries-and-timeouts). Since Linkerd has a systemic view of the cluster, it can do some interesting "tricks". For example, retrying in such a way as to add a maximum of 20 percent additional load on the target service.

It may appear that Linkerd is more limited than Polly in this sense. Keep in mind that the systemic, metrics-based view allows Linkerd to adapt dynamically to cluster conditions in real time. This just adds another dimension to managing the cluster.

When you implement resiliency in your app's code, as when using Polly, you're guessing which retry or timeout parameters are reasonable. With a Polly-like solution, you're focusing on a specific request. There's no reasonable way that you can respond in your app's code. Consider the hundreds or thousands of requests that are being processed simultaneously. It's not difficult to imagine a situation in which even a retry with exponential back-off (times request count) can flood a service.

There are other "tricks" that are impossible for Linkerd to handle. Linkerd doesn't know anything about the app internals. For example, you can protect a complex database transaction with a Polly strategy, so it's automatically retried if it fails.

In the next two units, you'll implement resilience for the coupon service going through the app gateway. Polly and Linkerd are used for the first and second units, respectively.
