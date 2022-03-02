In this unit, we’ll talk about modernizing your applications by refactoring with container technology, rearchitecting with microservices, and Cloud native – rebuilding the application in the cloud. Let’s dive into refactoring first.

## Refactoring with container technology

Containers are a packaging mechanism in which applications are abstracted from the environment in which they run, allowing your applications to be more portable.

:::row:::
![Icon indicating play video](../media/video-icon.png)

:::column:::
Watch this video to learn about refactoring your applications with container technology.

:::column-end:::
:::row-end:::

</br>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWr240]

:::row:::
![Icon of lightbulb](../media/lightbulb.png)

:::column:::
*Here’s one way to think about containers. Say you are packing up your kitchen. You put all the appliances and furniture, along with pots and pans into a moving van. This is the container. Wherever you decide to move, you take the container with you and it will be the same kitchen. With container technology, applications can be built to run in any environment. Additional tools, such as Kubernetes, help orchestrate the containers, so you can deploy and scale with confidence.*

---
:::column-end:::
:::row-end:::



Let’s look at how Xerox uses Azure containers.

## Customer scenario: Xerox

When Xerox chose to refactor their applications with containers in Azure, they were able to access a faster demo environment for new releases. They also found several other benefits of refactoring with container technology.

- Onboarding customers faster
- Enabling self-service environments
- Reducing administrative overhead
- No code modification required

--------------
![image of quotes](../media/quote.png)*Thanks to Azure Kubernetes Service, we can now spin up customer environments in 10 minutes instead of 24 hours. Moving DocuShare Flex from virtual machines to containers in Azure allows us to provision environments faster, empowering our sales and partner network.* 

⸺Robert Bingham, Director of DocuShare Cloud Operations, Xerox

--------------

Now that you’ve learned about the success Xerox had refactoring with container technology in Azure, let’s take a look at rearchitecting.

## Rearchitecting with microservices

In a microservices architecture, the application is composed of small, independent services. Here are some of the defining characteristics of microservices:

- Each microservice executes a single business capability.
- A microservice is small enough that a single small team of developers can write and maintain it.
- Microservices run in separate processes, communicating through well-defined APIs or messaging patterns.
- Microservices do not share data stores or data schemas. Each microservice is responsible for managing its own data.
- Microservices have separate code bases, and do not share source code. They may use common utility libraries, however.
- Each microservice can be deployed and updated independently of other services.

Done correctly, microservices can provide several benefits:

|   | Advantages |
| - | - |
| **Agility** | Microservices are deployed independently, it's easier to manage bug fixes and feature releases. You can update a service without redeploying the entire application and roll back an update if something goes wrong. |
| **Small code, small teams** | A microservice should be small enough that a single feature team can build, test, and deploy it. Small code bases are easier to understand. |
| **Mix of technologies** | Teams can pick the technology that best fits their service, using a mix of technology stacks as appropriate. |
| **Resiliency** | If an individual microservice becomes unavailable, it won't disrupt the entire application, as long as any upstream microservices are designed to handle faults correctly (for example, by implementing circuit breaking). |
| **Scalability** | Microservices architecture allows each microservice to be scaled independently of the others. That lets you scale out subsystems that require more resources, without scaling out the entire application. |
| **Data isolation** | It is much easier to perform schema updates, because only a single microservice is impacted. |

---
:::row:::
![Icon indicating play video](../media/video-icon.png)

:::column:::
Watch this video to learn about rearchitecting with microservices.

:::column-end:::
:::row-end:::

</br>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWroKB]

As you saw in the video, with microservices, each service is independent. Each service is a new project that can be developed on its own schedule, using any language or stack that best fits current requirements. Scaling up is easier than with VMs or containers, it just requires deploying additional services as needed. 

Now that we’ve discovered rearchitecting with microservices, let’s focus on building cloud native apps. 

### Build for the cloud with applications with serverless

Serverless computing is a cloud-computing execution model in which the cloud provider dynamically manages the allocation of machine resources. With Azure, you can build applications without provisioning and managing infrastructure, using a fully-managed platform. 

:::row:::
![Icon indicating play video](../media/video-icon.png)

:::column:::
Watch the video to learn about cloud native capabilities.

:::column-end:::
:::row-end:::

</br>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWqP1K] 

Now that you’ve learned about modernizing your apps by refactoring, rearchitecting, and building cloud native, let’s learn how to build, develop, deploy, and manage in a modern way with DevOps.
