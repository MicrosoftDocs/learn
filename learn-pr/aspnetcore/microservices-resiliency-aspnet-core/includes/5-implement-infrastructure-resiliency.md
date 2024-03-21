To implement infrastructure-based resiliency, you can use a *service mesh*. Aside from resiliency without changing code, a service mesh provides traffic management, policy, security, strong identity, and observability. Your app is decoupled from these operational capabilities, which are moved to the infrastructure layer. Architecturally speaking, a service mesh is composed of two components: a control plane and a data plane.

:::image type="content" source="../media/5-service-mesh-architecture.png" alt-text="Diagram of a typical service mesh architecture." border="false" lightbox="../media/5-service-mesh-architecture.png":::

The *control plane* component has many components that support managing the service mesh. The components inventory typically includes:

* A management interface, which could be a UI or an API.
* Rules and policy definitions that define how the service mesh should implement specific capabilities.
* Security management for things like strong identity and certificates for mTLS.
* Metrics or observability to collect and aggregate metrics and telemetry from the apps.

The *data plane* component consists of proxies that are transparently injected alongside each service; this is known as the Sidecar pattern. Each proxy is configured to control the network traffic in and out of the pod that contains your service. This configuration allows each proxy to be configured to:

* Secure traffic via mTLS.
* Dynamically route traffic.
* Apply policies to traffic.
* Collect metrics and tracing information.

Some popular service mesh options for Kubernetes clusters include Linkerd, Istio, and Consul. This module focuses on Linkerd. The following diagram shows interactions between components within the data and control planes:

:::image type="content" source="../media/5-linkerd-architecture.png" alt-text="Diagram of a Linkerd service mesh architecture." border="true" lightbox="../media/5-linkerd-architecture.png":::

#### Comparison to code-based approaches

Linkerd's principal fault-handling strategy comprises [retries and timeouts](https://linkerd.io/2/features/retries-and-timeouts). Because Linkerd has a systemic view of the entire cluster, it can employ resiliency strategies in novel ways. An example is retrying in such a way as to add a maximum of 20 percent additional load on the target service. Linkerd's metrics-based view allows it to adapt dynamically to cluster conditions in real time. This approach adds another dimension to managing the cluster, but doesn't add any code.

With a code-based approach, such as with Polly, you:

* Are required to guess which retry and timeout parameters are appropriate.
* Focus on a specific HTTP request.

There's no reasonable way to respond to an infrastructure failure in your app's code. Consider the hundreds or thousands of requests that are being processed simultaneously. Even a retry with exponential back-off (times request count) can flood a service.

In contrast, infrastructure-based approaches like Linkerd are unaware of app internals. For example, complex database transactions are invisible to Linkerd. Such transactions can be protected from failure with Polly.

In upcoming units, you'll implement resilience for the coupon service by using Polly and Linkerd.
