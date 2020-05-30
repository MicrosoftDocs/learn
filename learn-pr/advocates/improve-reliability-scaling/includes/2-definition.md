In the business world, growth is good. However, when growth happens too
fast, and when you haven’t adequately prepared for it, growth can bring
problems. One of those is the impact on the reliability of applications and
services that weren’t designed to handle a large increase in traffic.

To your customers and end users, an outage is an outage. They don’t know or
care whether they’re unable to access your site because of buggy code or
because too many other people are trying to use your perfectly coded site
at the same time.

_Scalability_ is the ability to adapt to increased demands or changing
needs. Your applications and services must be able to handle a larger
amount of workload to accommodate growth. Scalable applications are able to
handle an expanding number of requests over time without a negative effect
on availability or performance.

In this unit, you’ll learn about the relationship between scalability and
reliability, the importance of capacity planning in achieving scalability,
and briefly review some basic concepts and terms related to scaling.

## The scalability/reliability relationship

The good news is that making your app more scalable may also make it more
reliable. For example, if your system auto scales, then given a component
failure on a single virtual machine, the autoscaling service will provision
another instance to meet your minimum VM count requirements. This means
your system is more reliable. In another example, if you’re leveraging
higher-level services such as Azure Storage that are inherently scalable,
these have been built to be reliable, so your data will be replicated.

Here's an analogy: Think of the accessibility ramps that you often see
outside buildings that were initially designed to accommodate people in
wheelchairs. They serve that purpose, but they’re also used by parents with
babies in strollers or carriages, or by small children for whom the stair
steps are too deep or high. This is a _secondary benefit._

Reliability is often a secondary benefit of scalability. If you design your
systems to be scalable, they are likely to be more reliable, too.

## Scalability and capacity planning

_Capacity planning_ involves determining the resources you need to meet
both present and future demands. You do this by analyzing your current
resource usage and then projecting for future growth.

To estimate capacity needs in the future, you should consider such factors
as:

-   Expected business growth
-   Periodic fluctuations (seasonal, etc.)
-   Application constraints
-   Identification of bottlenecks and limiting factors

You’ll also need to set service level objectives so you can create a
capacity management plan that will reliably meet or exceed those objectives
as the workload and environment change.

Capacity planning is an iterative process. As we go through this module,
you will learn how to map out resource requirements for application
components.

## Concepts and terminology

Before you can fully understand the concepts and strategies you’ll
encounter in this module, you need some prerequisite knowledge of a few
basic concepts and fundamental terms related to scaling.

-   Scaling up: making a component bigger so as to handle an increased
    workload. This is also referred to as vertical scaling.

-   Scaling out: adding more components or resources to spread out the load
    over a distributed architecture. For example, using a simple
    architecture that has multiple backends behind a set of frontends. As
    load increases, we add more backend (and frontend) servers to handle
    it. This is also referred to as horizontal scaling.

-   Manually scaling: human action is necessary to increase the amount of
    resources.

-   Auto scaling: the amount of resources is automatically adjusted by the
    system based on the load. And just to be clear, because this is often
    left out of our thinking, the amount is adjusted both up and down based
    on either an increased or decreased load.

-   DIY scale: do-it-yourself scaling whereby you have to configure the
    autoscaling.

-   Inherent scale: services that were built to be scalable and handle this
    scaling for you behind the scenes without any intervention on your
    part. From your perspective, they look almost infinitely scalable
    because you can just consume more resources without needing to manually
    provision them.

## Tailwind Traders architecture

In this module we are going to use an example architecture from a fictional
hardware company called Tailwind Traders. Their e-commerce platform looks
like this:

:::image type="content" source="../media/application-diagram.png" alt-text="Full architecture diagram of applications with frontend, backend and other components.":::

This is pretty complex on first glance, so let's walk our way through it.
The website has a frontend, that’s what you’ll be talking to if you go to
tailwindtraders.com.

:::image type="content" source="../media/application-diagram-frontend.png" alt-text="Full architecture diagram of application with frontend component highlighted":::

The frontend talks to a set of backend services. These backend services
include a coupon service, a shopping cart service, and inventory service,
the usual stuff. They are all running in Azure Kubernetes Service. There
are other parts and technologies at play with this application. But really,
all you need to focus on is the frontend and the backend services running
on Kubernetes.

:::image type="content" source="../media/application-diagram-backend.png" alt-text="Full architecture diagram of application with backend component highlighted":::

### Single points of failure

Now that you have seen the whole architecture, let's take a moment to
examine the single points of failure and the places we might put our
attention when thinking about scaling.

:::image type="content" source="../media/application-diagram-failure-points.png" alt-text="Full architecture diagram of application with backend components and SQL DB highlighted":::

All of these services are a single point of failure, they’re not built for
resiliency, or for scale. If one of them gets overloaded, it’s likely to
crash, and there is no easy way to resolve that in the moment.

Later in this module we will look at other ways to design theses service to
be more scalable and reliable.

### Pre-provisioned capacity

Lets take a look at another issue that could come and bite us. Here are the
services/components that require us to pre-provisioned capacity:

:::image type="content" source="../media/application-diagram-provisioned.png" alt-text="Full architecture diagram of application with Azure Cognitive Services, Cosmos DB, and SQL DB highlighted":::

For example, with Cosmos DB we pre-provision the throughput. If we exceed
those limits, we’re going to start returning error messages to our
customers. With Cognitive services, we select the tier and that tier has a
maximum number of requests per second. Once we hit either of these, clients
are going to be throttled.

Will a big spike in traffic, perhaps due to a product launch, make us hit
these limits? Right now we don’t know. This is another matter we will
discuss later in this module.

### Costs

Even when we do things right, we still need to plan for growth. Here are
the pay-per-use services:

:::image type="content" source="../media/application-diagram-costs.png" alt-text="Full architecture diagram of application with Azure Logic Apps and Azure Functions highlighted":::

Here we’re using Azure Logic Apps and Azure Functions, which are both
examples of serverless technology. This means these services scale
automatically and we pay per request. Your bill grows as your customer base
does. We should at least be aware of the impact upcoming events like a
product launch may have on our cloud spend. We will work on understanding
and predicting our cloud spend later in this module as well.
