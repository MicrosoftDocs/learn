Resiliency is the ability to recover from transient failures. The app's recovery strategy restores normal function with minimal user impact. Failures are unavoidable in cloud environments, and your app must respond in a way that minimizes downtime and data loss. In an ideal situation, your app handles failures gracefully without affecting the user.

Because microservice environments are volatile, apps should be designed to handle partial failures. Partial failure examples include code exceptions, network outages, unresponsive server processes, and hardware failures. Even planned activities, such as moving containers to a different node within a Kubernetes cluster, can cause transient failures.

Ensuring a resilient deployment requires the use of health checks. Microservices implement [liveness, readiness, and startup probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes) that expose the state of the service. Kubernetes uses that state to determine whether to accept traffic or replace a failing pod.

## Resiliency approaches

There are two fundamental approaches to resiliency: code and infrastructure. Each approach has benefits and drawbacks. Both approaches can be appropriate depending on the situation. This module explains how to implement both *code-based* and *infrastructure-based* resiliency.

### Code-based resiliency

To implement code-based resiliency, this module uses Polly, which is a .NET library for resilience and transient failure handling. It uses a fluent, easy-to-understand syntax to build failure-handling code in a thread-safe manner. There are several resilience policies that define failure-handling behavior. In this module, you'll apply the Retry and Circuit Breaker policies to HTTP client operations.

Resiliency with Polly is defined in code, but startup-time configuration for some parameters is supported.

#### Retry policy

A *Retry* policy is exactly what the name implies. The request is retried after a short wait if an error response is received. The wait time is configurable, as shown in the following table:

| Wait time value          | Example sequence   |
|--------------------------|--------------------|
| Constant                 | 2 s, 2 s, 2 s, 2 s... |
| Exponentially increasing | 2 s, 4 s, 8 s, 16 s... |
| Specified list           | 100 ms, 100 ms, 100 ms, 2 s, 4 s, 8 s... |

The Retry policy always has a maximum retry count. Once that number of retries has been satisfied, the policy gives up and throws an exception. From the user's perspective, the app usually takes longer to complete some operations. The app might also take some time before informing the user that it couldn't complete the operation.

#### Circuit Breaker policy

A *Circuit Breaker* policy gives the target service a break after a repeated number of failures. Such a state might indicate that the service is experiencing a serious problem and is temporarily unable to respond. After a defined number of consecutive failures, the connection attempts are paused temporarily, "opening" the circuit. During this wait, additional operations on the target service fail immediately without "bothering" the service. After the wait time has elapsed, the operation is attempted again. If the operation succeeds, the circuit is "closed" and the system goes back to normal.

### Infrastructure-based resiliency

To implement infrastructure-based resiliency, you can use a *service mesh*. Aside from resiliency without changing code, a service mesh provides traffic management, policy, security, strong identity, and observability. Your app is decoupled from these operational capabilities, which are moved to the infrastructure layer. Architecturally speaking, a service mesh is composed of two components: a control plane and a data plane.

:::image type="content" source="../media/3-review-resiliency-concepts/service-mesh-architecture.png" alt-text="Diagram of a typical service mesh architecture." border="true" lightbox="../media/3-review-resiliency-concepts/service-mesh-architecture.png":::

The *control plane* component has many components that support managing the service mesh. The components inventory typically includes:

* A management interface, which could be a UI or an API.
* Rules and policy definitions that define how the service mesh should implement specific capabilities.
* Security management for things like strong identity and certificates for mTLS.
* Metrics or observability to collect and aggregate metrics and telemetry from the apps.

The *data plane* component consists of proxies that are transparently injected alongside each service, a pattern known as the Sidecar pattern. Each proxy is configured to control the network traffic in and out of the pod containing your service. This configuration allows each proxy to be configured to:

* Secure traffic via mTLS.
* Dynamically route traffic.
* Apply policies to traffic.
* Collect metrics and tracing information.

Some popular service mesh options for Kubernetes clusters include Linkerd, Istio, and Consul. This module focuses on Linkerd. The following diagram shows interactions between components within the data and control planes:

:::image type="content" source="../media/3-review-resiliency-concepts/linkerd-architecture.png" alt-text="Diagram of a Linkerd service mesh architecture." border="true" lightbox="../media/3-review-resiliency-concepts/linkerd-architecture.png":::

#### Comparison to code-based approaches

Linkerd's principal fault-handling strategy is comprised of [retries and timeouts](https://linkerd.io/2/features/retries-and-timeouts). Since Linkerd has a systemic view of the entire cluster, it can employ resiliency strategies in novel ways. An example is retrying in such a way as to add a maximum of 20 percent additional load on the target service. Linkerd's metrics-based view allows it to adapt dynamically to cluster conditions in real time. This approach adds another dimension to managing the cluster, but doesn't add any code.

With a code-based approach, such as with Polly, you:

* Are required to guess which retry and timeout parameters are appropriate.
* Focus on a specific HTTP request.

There's no reasonable way to respond to an infrastructure failure in your app's code. Consider the hundreds or thousands of requests that are being processed simultaneously. Even a retry with exponential back-off (times request count) can flood a service.

In contrast, infrastructure-based approaches like Linkerd are unaware of app internals. For example, complex database transactions are invisible to Linkerd. Such transactions can be protected from failure with Polly.

In upcoming units, you'll implement resilience for the coupon service by using Polly and Linkerd.
