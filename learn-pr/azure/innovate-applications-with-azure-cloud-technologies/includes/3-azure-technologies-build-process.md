In this unit, you learn the relationship between the innovation process and some of the technologies in the industry that can help you to build new functionality into applications.

## DevOps

After you've started the build phase to validate your innovation hypothesis, the required development, integration, and deployment cycles should be as streamlined as possible. This phase is where DevOps comes in. You can define DevOps as "processes and tools to deliver software features quickly and reliably." Here are details about this definition:

- **Processes and tools**: DevOps, and the innovation process as a whole, is based on culture patterns that encourage change. Azure and GitHub offer great tooling around DevOps, but purchasing a license isn't enough. Your processes and organizational culture need to evolve to embrace change and innovation.
- **Quick delivery of software features**: DevOps processes and tools embrace the concept of failing fast. Building MVPs or prototypes to quickly validate whether the feature on which you're working goes in the right direction is core to the concept of DevOps.
- **Reliable delivery of software features**: Change-averse organizations often associate quick changes with downtime. However, DevOps promises exactly the opposite: a quick change rate and a high level of reliability. This reliability is made possible by integrating testing in early stages of the development cycle, in a process called "shift to the left."

  If the development of a feature across time is seen as a line from left to right, then a legacy development process would perform user validation and quality control at the end of the development cycle. This is at the "right" end of that line. DevOps advises you to test and validate as early as possible, at the "left" of that time line.

DevOps embodies the same core concepts of a healthy innovation culture. Adopting its methodology is key to get to an agile innovation cycle.

## Microservices architectures

Modularity is a well-known technique to reduce complexity in architecting complex systems. If a system is a complex interaction of many pieces that can't be taken apart (often called a "monolith"), tight component interdependencies make system improvements difficult. Every change needs to be validated with the rest of the system, so the test process is complex.

If the system is modular, you can separate it into smaller subsystems that interact with each other via well-defined interfaces. Introducing changes in one of these subsystems is easier, because as long as its interface with the other modules stays constant, the overall system continues working.

Microservices architectures are application patterns that exploit modularity. Applications are subdivided into separate, small components that can be developed independently from each other, potentially even using different programming languages. Each component, or microservice, can operate on its own. You can scale it as required, you can troubleshoot it as a single unit, and you can modify it independently from the other microservices.

A question that organizations often ask is what to do if an application is monolithic. Should the organization redesign the application into a microservices architecture before introducing innovation, or can the innovation and redesign processes run in parallel? There's no single answer to this question. It depends on the complexity and business relevance of the application under consideration.

Tailwind Traders confronted this question when looking at introducing innovation in its e-commerce platform. The company decided to start a project to redesign the e-commerce application into a microservices architecture, because the application's business criticality justified this effort. Not having a modular application would severely impair Tailwind Traders' ability to react to changing trends in the online market.

However, Tailwind Traders made the decision to tackle some of the major gaps in its platform at the same time. Waiting for the application redesign project to finish would mean losing significant market share to the new startups that are disrupting the ecommerce market right now.

The projects are to interact with each other, guided by the business value of innovations. The redesign efforts are to focus on the most critical application areas, where the need for modification to improve customer experience is highest.

## Containers

The technology of containerization isn't exclusive to microservices architectures, but the concepts work together. Containers are a way to encapsulate application code and its dependencies so that they can be deployed effortlessly in any platform.

Traditional application deployments require the organization to install software first, such as the application runtime, programming libraries, or external components. This approach often results in the "it works on my machine" problem since it's difficult to replicate the same environment across development, test, staging, and production. Small differences in the way that the application dependencies are installed can cause the application to work fine while being tested but fail when it's deployed into production.

Containers change the rules of the game. The application dependencies are packed along with the application code in an autonomous deployment unit called the container image. Whether the application container is deployed on a developer's laptop or in a production cluster with hundreds of nodes, the dependency handling is the same. The container works exactly the same way, so application testing is more reliable and trustworthy.

Containers have come a long way since Docker released their code as open source in 2013. Containers now support both Linux and Windows, and different CPU architectures. There are many offers in Azure that allow container-based workloads to run. In this unit, you learn about some of them.

## Kubernetes and Red Hat OpenShift

A container runtime is the technology that starts containers on a computer, but more logic is required in a production environment. Who deploys more containers if more performance is required? Who restarts the containers if they have a problem? If multiple computers are available, who decides on which of them a certain container should be started? These and other tasks are the responsibility of a container orchestration platform.

The first version of Kubernetes was released in 2015, and it soon became the *de facto* standard for container orchestration. Kubernetes clusters consist of several worker nodes. Each worker node has a container runtime, so it can run containers where the Kubernetes control plane schedules the deployment of containerized applications. This control plane typically runs in a set of core nodes. It's responsible for keeping the application running correctly, scaling the application up or down, and carrying out any required updates.

One of the main reasons for Kubernetes' popularity is the hardware independence that containers provide. Because container-based applications can be reliably deployed to any container runtime, you can run Kubernetes in clouds that use various hypervisors. The deployed applications should behave in a similar way (assuming that the underlying hardware resources are similar too). Many organizations have adopted Kubernetes as an abstraction layer that allows consistent application deployment processes both on-premises and in public clouds.

Running Kubernetes in Azure is easy. [Azure Kubernetes Service](/azure/aks/intro-kubernetes?azure-portal=true) is simple to deploy and cost efficient, because the customer is only charged for the cost of the worker nodes. Microsoft carries the cost and operation of the control plane that contains the core components. Microsoft patches and updates the operating system of the worker nodes, further reducing the operational complexity of managing a Kubernetes cluster to run Linux and Windows containers.

[OpenShift](https://www.openshift.com?azure-portal=true) is an application-deployment platform based on Kubernetes, developed and supported by [Red Hat](https://www.redhat.com?azure-portal=true). It incorporates many other functionalities. Some of the organizations that choose to run their applications on OpenShift do so because of these extra features and the support that Red Hat provides. Running OpenShift on Azure is again simple. [Azure Red Hat OpenShift](/azure/openshift/intro-openshift?azure-portal=true) consists of an OpenShift cluster where Microsoft manages many of its aspects, including the whole lifecycle of the cluster.

## Azure App Service

[Azure App Service](/azure/app-service/overview?azure-portal=true) is a platform where organizations can run their web-based workloads without having to manage any orchestrator or underlying operating system. The only requirement is uploading the application code to the service through one of many available deployment methods. Azure does the rest to include scaling the application in and out, patching and maintaining the underlying virtual machines, and much more. All this without requiring the learning curve of Kubernetes.

Azure App Service supports container-based workloads, so you can upload your container image instead of the application code. It also supports Linux and Windows workloads and many different application runtimes.

Azure App Service supports various pricing models, including a serverless option called [Azure Functions](/azure/azure-functions/functions-overview?azure-portal=true). In Azure Functions, only application usage is charged. There are no fixed costs.

The serverless model is interesting for innovating, because it lets you deploy new microservices without incurring high monthly bills if the market doesn't accept them. This model is another example of the fail-fast strategy, where innovation doesn't necessarily mean high expenses.

Azure App Service also offers features that support DevOps-oriented deployments, such as web app slots. Slots are staging areas where you can deploy new features without affecting the production environment. Slots are great from an innovation perspective, because you can redirect a small selection of your customers to this new version of the application. Then, you can validate whether your innovation hypothesis is correct. Eventually, if you want to promote the new code to production, you can "swap" slots so that the staging environment becomes the production version.

## Summary

In this unit, you learned how technology can support innovation:

- DevOps processes and tools give your development and operations teams the superpower of delivering new features quickly and reliably.
- You can rearchitect applications into microservices to allow innovation on their components individually, without affecting the rest.
- Containers enable reliable application deployment across multiple platforms and environments.
- Kubernetes is a cloud-agnostic orchestration platform to run containerized applications.
- Azure App Service can run web-based workloads with minimum management overhead. It offers many features, like serverless or application slots, to speed up the innovation cycle.

Tailwind Traders has decided to start the redesign of its e-commerce application into a microservices architecture. The first application subsystem that it separates from the "monolith" is the payment service, because you've identified it as a critical area where the competition is offering better value to customers.

After the payment subsystem, more application components will be converted into independent microservices. The microservices can communicate through REST APIs. The application code for each microservice is to be containerized, and the development and operations organizations are to adopt DevOps best practices.

Because Tailwind Traders doesn't want to be dependent on any specific public cloud, it's decided to build Kubernetes expertise in-house and deploy the application on Azure Kubernetes Service clusters. If new microservices need to be developed, the company has opted to consider Azure Functions as a platform for MVP deployment to reduce development costs.

## Where to look next

Many of the concepts in this unit are further articulated in the Cloud Adoption Framework articles [Empower adoption with digital invention](/azure/cloud-adoption-framework/innovate/considerations/ci-cd?azure-portal=true) and [Kubernetes in the Cloud Adoption Framework](/azure/cloud-adoption-framework/innovate/kubernetes?azure-portal=true).