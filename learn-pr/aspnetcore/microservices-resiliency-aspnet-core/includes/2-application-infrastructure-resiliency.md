Resiliency is the ability to recover from transient failures. The app's recovery strategy restores normal function with minimal user impact. Failures can happen in cloud environments, and your app should respond in a way that minimizes downtime and data loss. In an ideal situation, your app handles failures gracefully without the user ever knowing there was a problem.

Because microservice environments can be volatile, design your apps to expect and handle partial failures. A partial failure, for example,  can include code exceptions, network outages, unresponsive server processes, or hardware failures. Even planned activities, such as moving containers to a different node within a Kubernetes cluster, can cause a transient failure.

## Resiliency approaches

In designing resilient applications, you often have to choose between failing fast and graceful degradation. Failing fast means the application will immediately throw an error or exception when something goes wrong, rather than try to recover or work around the problem. This allows issues to be identified and fixed quickly. Graceful degradation means the application will try to keep operating in a limited capacity even when some component fails.

In cloud-native applications it's important for services to handle failures gracefully rather than fail fast. Since microservices are decentralized and independently deployable, partial failures are expected. Failing fast would allow a failure in one service to quickly take down dependent services, which reduce overall system resiliency. Instead, microservices should be coded to anticipate and tolerate both internal and external service failures. This graceful degradation allows the overall system to continue operating even if some services are disrupted. Critical user-facing functions can be sustained, avoiding a complete outage. Graceful failure also allows disturbed services time to recover or self-heal before impacting the rest of the system. So for microservices-based applications, graceful degradation better aligns with resiliency best practices like fault isolation and rapid recovery. It prevents local incidents from cascading across the system.

There are two fundamental approaches to support a graceful degradation with resiliency: application and infrastructure. Each approach has benefits and drawbacks. Both approaches can be appropriate depending on the situation. This module explains how to implement both *code-based* and *infrastructure-based* resiliency.

### Code-based resiliency

To implement code-based resiliency, .NET has an extension library for resilience and transient failure handling, `Microsoft.Extensions.Http.Resilience`.

It uses a fluent, easy-to-understand syntax to build failure-handling code in a thread-safe manner. There are several resilience policies that define failure-handling behavior. In this module, you apply the Retry and Circuit Breaker strategies to HTTP client operations.

#### Retry strategy

A *Retry* strategy is exactly what the name implies. The request is retried after a short wait if an error response is received. The wait time increases with each retry. The increase can be linear or exponential.

After the maximum number of retries is reached, the strategy gives up and throws an exception. From the user's perspective, the app usually takes longer to complete some operations. The app might also take some time before informing the user that it couldn't complete the operation.

#### Circuit Breaker strategy

A *Circuit Breaker* strategy gives a target service a break after a repeated number of failures by pausing trying to communicate with it. The service could be experiencing a serious problem and be temporarily unable to respond. After a defined number of consecutive failures, the connection attempts are paused, *opening* the circuit. During this wait, additional operations on the target service fail immediately without even trying to connect the service. After the wait time has elapsed, the operation is attempted again. If the service successfully responds, the circuit is *closed* and the system goes back to normal.

### Infrastructure-based resiliency

To implement infrastructure-based resiliency, you can use a *service mesh*. Aside from resiliency without changing code, a service mesh provides traffic management, policy, security, strong identity, and observability. Your app is decoupled from these operational capabilities, which are moved to the infrastructure layer. 

#### Comparison to code-based approaches

An infrastructure-based resiliency approach can use a metrics-based view that allows it to adapt dynamically to cluster conditions in real time. This approach adds another dimension to managing the cluster, but doesn't add any code.

With a code-based approach you:

* Are required to guess which retry and timeout parameters are appropriate.
* Focus on a specific HTTP request.

There's no reasonable way to respond to an infrastructure failure in your app's code. Consider the hundreds or thousands of requests that are being processed simultaneously. Even a retry with exponential back-off (times request count) can flood a service.

In contrast, infrastructure-based approaches are unaware of app internals. For example, complex database transactions are invisible to service meshes. Such transactions can only be protected from failure with a code based approach.

In upcoming units, you'll implement resilience for a microservice based app  using .NET HTTP resiliency in code and a Linkerd service mesh.