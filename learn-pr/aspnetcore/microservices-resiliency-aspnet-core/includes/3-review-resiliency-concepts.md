Resiliency is the ability to recover from transient failures and continue to function as completely as possible. It isn't about avoiding failures but accepting the fact that failures will happen and responding to them in a way that avoids downtime or data loss.

The goal of resiliency is to return the application to a fully functioning state after a failure. If possible, even without the user being aware of the failure.

It's challenging enough to design and deploy a microservices-based application. But you also need to keep your application running in an environment where some sort of failure is certain. Therefore, your application should be resilient. It should be designed to cope with partial failures, like network outages or nodes or VMs crashing in the cloud. Even microservices (containers) being moved to a different node within a cluster can cause intermittent short failures within the application.

Handling partial failures in distributed systems, like a microservices-based applications, is probably one of the most complex endeavors of working in the cloud.There's an ever-present risk of partial failure. For instance, a single microservice/container can fail or might not be available to respond for a short time, or a single VM or server can crash. Since clients and services are separate processes, a service might not be able to respond in a timely way to a client's request. The service might be overloaded and responding very slowly to requests or might simply not be accessible for a short time because of network issues.

Ensuring a resilient deployment also requires the use of health checks. Health checks won't be covered in this module, but the key idea here is that applications and services provide some [liveness, readiness and startup probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) that inform about the service state, so Kubernetes knows when it's ready to accept traffic or it's time to replace a failing pod.

## Resiliency approaches

There are two fundamental approaches to resiliency, you can:

- Add failure handling code in your application
- Add infrastructure to handle communication failures

As usual there are pros and cons on both sides and you may actually use them both, depending on the situation. As usual too, there are plenty of solutions for both approaches.

For the first approach we'll introduce the use of [Polly](https://github.com/App-vNext/Polly), and [Linkerd](https://linkerd.io/) for the second.

## Polly

Polly is a .NET resilience and transient-failures-handling library, that allows the developer to include failure-handling code with fluent and easy-to-understand syntax.

There are several strategies ([Polly's policies](https://github.com/App-vNext/Polly#resilience-policies)) for handling failures, and the strategies can be applied for HTTP(gRPC) requests and even database transactions, but for this module we'll focus on **Retries (with exponential back-off)** and **Circuit Breaker** on HTTP calls using [IHttpClientFactory](https://docs.microsoft.com/aspnet/core/fundamentals/http-requests).

Resiliency with Polly has to be hard-coded, although you can use startup-time configuration for some parameters.

### Retry policy

The Retry policy is just what the name implies, the request is retried if an error response is received, after a short waiting time. The waiting time can be configured to whatever you want, can be a constant waiting time for a certain retry count, or an exponentially increasing time (2, 4, 8, 16 seconds), or even a specific time list (100ms, 100ms, 100ms, 2s, 4s, 8s...).

The retry policy always has a maximum retry count and it gives up at that point, finally sending the error message back. The user experience for this policy is usually that the application takes longer to complete some operations or it takes some time before informing the user that it couldn't complete the operation.

For an in-depth explanation of the Retry policy, see [Polly's wiki page on Retry policy](https://github.com/App-vNext/Polly/wiki/Retry).

### Circuit Breaker Policy

The Circuit Breaker policy kind of "gives the target service a break", after a certain number of failures, when it looks like the service is having some serious problem and it's not going to respond for a while.

The concept is quite simple too, after a certain number of consecutive failures (more options with the advanced Circuit Breaker policy) the connection is open for some waiting time.

During the waiting time the operation is just failed immediately, without even "bothering" the service. After the waiting time is over the operation is tried once. If the operation succeeds, the circuit is closed again and the system goes back to normal. If the operation fails, the circuit is opened and the waiting time begins again.

For an in-depth explanation of the Circuit Breaker policy, see [Polly's wiki page on Circuit Breaker policy](https://github.com/App-vNext/Polly/wiki/Circuit-Breaker).

## Linkerd

[Linkerd](https://linkerd.io/2/overview/) is completely different from Polly. Linkerd is a service mesh, it's infrastructure for Kubernetes clusters. One of the nice features is that it can handle resiliency without changing your application code.

A [service mesh](https://servicemesh.io/) is basically a set of proxies that stand right besides each of your  pods and handle all communication-related tasks. For example Linkerd can be configured to ensure reliable and secure communications and getting operational metrics.

Each "meshed" service doesn't really now it's being supported by a proxy right besides it. The proxies are "transparent" and light. The proxy handles both incoming and outgoing connections.

In this module we'll focus on the resiliency aspect of Linkerd and skip the observability and security aspects.

Linkerd includes a dashboard, that you can [explore when running from a local machine](https://linkerd.io/2/features/dashboard/), but not from Azure's Cloud Shell.

### Resiliency strategies

Linkerd's resiliency strategies are completely different from the ones mentioned for Polly.

Basically you have [Retries and Timeouts](https://linkerd.io/2/features/retries-and-timeouts/). However, since Linkerd has a systemic view of the cluster, it can do some interesting "tricks" like, for example, retrying in such a way as to add a maximum of 20% additional load on the target service.

It might look like Linkerd is more limited than Polly in this sense. However, keep in mind that the systemic, metrics-based view, allows Linkerd to adapt dynamically to cluster condition in real-time. This just adds another dimension to managing the cluster.

When you implement resiliency in your application code, as when using Polly, you're basically guessing which retry or timeout parameters might be reasonable. With a Polly-like solution you're focusing on a specific request. There's no (reasonable) way that you can respond, in your application code, considering the hundreds or thousands of requests that are being processed simultaneously. So it's not difficult to imagine a situation where even a retry with exponential back-off (times request count) can flood a service.

On the other hand, there are other "tricks" that's just impossible for Linkerd to handle, because it doesn't know anything about the application internals. For example, you can protect a complex database transaction with a Polly strategy, so it's automatically retried if it fails.

In the next two exercises you'll implement resilience for the coupon service going through the application gateway. Using Polly for the first exercise and using Linkerd for the second.
