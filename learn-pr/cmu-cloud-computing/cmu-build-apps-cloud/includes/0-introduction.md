Now that we've learned how a cloud datacenter runs, you may feel that all of the complexity is handled by the cloud service providers (CSPs), and it is trivial to build a cloud application. To truly fulfill the promise of the cloud, developers must design and deploy their applications by following a few best practices.

In this module, we look at how applications are deployed on the cloud to ensure fault tolerance and achieve high performance. The global presence of cloud datacenters simplifies the process of reaching many end users, but deployment patterns must support easy scaling and fault tolerance.

A cloud application must be economical, be reachable with low latency, and support a large number of simultaneous users (high throughput), without any service degradation (fault tolerance and elasticity). Despite the tools that CSPs provide, building such an application requires a lot of planning.

In a later module, we'll look at some common patterns around load balancing and scaling, as well as how robust applications should be built.

Finally, we explore some additional challenges faced by responsive, interactive applications that use a large cluster of cloud computing resources, and we look at some solutions.

## Learning objectives

In this module, you will:

- Evaluate different considerations when programming applications that run on clouds.
- Evaluate different considerations when deploying applications on clouds.
- Compare and contrast proactive and reactive measures for fault tolerance in cloud applications.
- Describe the importance of load balancing in cloud applications and enumerate various methods to achieve it.
- Enumerate the strategies and considerations in scaling cloud applications.
- Motivate the case for minimizing tail latency and discuss the various strategies to reduce tail latency.
- Describe the strategies to optimize total operational cost of using cloud services.

## Prerequisites

- Understand what cloud computing is, including cloud service models, and common cloud providers.
- Know the technologies that enable cloud computing.
- Understand how cloud service providers pay for and bill for the cloud.
- Know what datacenters are and why they exist.
- Know how datacenters are set up, powered, and provisioned.
- Understand how cloud resources are provisioned and metered.
