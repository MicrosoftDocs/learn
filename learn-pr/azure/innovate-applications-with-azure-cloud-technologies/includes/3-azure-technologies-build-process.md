
In this unit you will learn the relationship between the innovation process and some of the technologies in the industry.

## DevOps

Once you have embarked in the build process to validate your innovation hypothesis, the required development, integration and deployment process should be as streamlined as possible. This is where DevOps comes into the picture: DevOps can be defined as "processes and tools to deliver software features quickly and reliably". There are three important concepts in this definition that are worthy to be highlighted:

- It is about **processes and tools**: DevOps, as the innovation process as a whole, is based on culture patterns encouraging change. Azure and Github offer great tooling around DevOps, but it is not enough with purchasing a license: your processes and organization culture need to evolve to embrace change and innovation.
- Deliver software features **quickly**: DevOps processes and tools embody the concept of failing fast. Bulding MVPs or prototypes to quickly validate whether the feature being worked on goes in the right direction is core to the concept of DevOps.
- Deliver software features **reliably**: change-averse organizations often identify quick changes with downtime. However, DevOps promises exactly the opposite: a quick change rate and a high level of reliability. This is possible by integrating testing in early stages of the development cycle, a process known as "shift to the left". If the development of a feature across time is seen as a line from left to right, legacy development process would perform user validation and quality control at the end of the development cycle, at the "right" end of that line. However, DevOps advises to test and validate as early as possible, at the "left" of the line.

As you can see DevOps embodies the core concepts of a healthy innovation culture, and adopting its methodology is key to get to an agile innovation cycle.

## Microservices architectures

The concept of modularity is a well-known technique used to reduce complexity when architecting complex systems: If a system is a complex interaction of many pieces that cannot be taken apart from each other (often called a "monolith"), tight component interdependencies will make system improvements very difficult: every single change needs to be validated with the rest of the system, making the test process extremely complex.

However, if the system is modular, it means that it can be decomposed in different smaller subsystems that interact with each other via well-defined interfaces. Introducing changes in one of these subsystem is easier, because as long as its interface stays constant, the overall system will continue working.

Microservices architectures are application patterns that exploit modularity: applications are subdivided into separate, small components that can be developed completely independently from each other, potentially even using different programming languages. Each of the components, or microservice, can operate on its own: it can scale as required, it can be troubleshooted independently, and it can be modified as long as its interface to the other microservices is kept consistent.

A question often asked by organizations is what to do if an application is monolithic: should the application be redesigned into a microservices architecture before introducing innovation? Or can the innovation and redesign processes run in parallel? There is not a single answer to this question, but it will depend on the complexity and business relevance of the application.

Tailwind Traders is confronted with this question when looking at introducing innovation in their ecommerce platform. The decision was taken to start a project to redesign the ecommerce application into a microservices architecture, because its business criticality justifies this effort. Not having a modular application would severely impair Tailwind Traders' ability to react to ever changing trends in the online market in the future.

However, Tailwind Traders has decided to tackle some of the major gaps of their platform at the same time, because waiting for the application redesign project to finish would mean losing significant market share to the new startups disrupting the ecommerce market right now. Both projects will interact with each other, guided by the business value of innovations: the redesign efforts will focus on the most critical application areas, where the need of being modified to improve customer experience is highest.

## Containers

The technology of containerization is not exclusive of microservices architectures, but both play really well together. Containers are a way of encapsulating application code and its dependencies, so that it can be deployed effortlessly in any platform. Traditional application deployments require installing some software required by an application before being able to run it, such as the application runtime, programming libraries or external components. This often derives in the "it works on my machine" problem: it is very difficult replicating the same environment across development, test, staging and production. Small differences in the way that the application dependencies are installed can cause that the application works fine in the test environments, but fails when deployed into production.

Containers change the game rules, because the application dependencies are packed along the application code in an autonomous deployment unit, the container image. Whether the application container is deployed on a developer's laptop or in a production cluster with hundreds of nodes, the dependency handling is exactly the same, and the container will work exactly the same way. Hence application testing is much more reliable and trustworthy.

Containers have come a long way since Docker released their code as open source in 2013. Containers support now both Linux and Windows, as well as different CPU architectures such as ARM. There are many offers in Azure that allow to run container-based workloads, in this section you will learn some of them.

## Kubernetes and Red Hat OpenShift

A container runtime is the technology that starts containers on a computer, but additional logic is required in a production environment: who will deploy more containers, if more performance is required? Who will restart the containers, in case they experience any problem? If multiple computers are available, who will decide on which of them a certain container should be started? These and other tasks are the responsibility of a container orchestration platform.

The first version Kubernetes was released in 2015, and it soon became the *de facto* standard for container orchestration. Kubernetes clusters consist of several worker nodes, each with a container runtime and hence able to run containers, where the Kubernetes control plane will schedule the deployment of containerized applications. This control plane will typically run in a set of master nodes, and it will be responsible to keep the application running correctly, to scale it up or down, and to carry out any required updates.

One of the main reasons of the popularity of Kubernetes is the hardware independence that containers provide. Since container-based applications can be reliably deployed to any container runtime, you can run Kubernetes in different clouds, on different hypervisors, but the deployed applications should behave in a similar way (assuming the underlying hardware resources are similar too). Hence, many organizations have adopted Kubernetes as an abstraction layer that allows for consistent application deployment processes both on-premises and in different public clouds.

Running Kubernetes in Azure is extremely easy: [Azure Kubernetes Service](https://docs.microsoft.com/azure/aks/intro-kubernetes) is extremely simple to deploy, as well as very cost efficient, since only the cost for the worker nodes is charged. The cost and operation of the master nodes is carried by Microsoft, so the customer only needs to consider the worker nodes. Additionally, Microsoft will patch and update the underlying Operating System of the worker nodes, reducing even more the operational complexity of manage a Kubernetes cluster to run Linux and Windows containers.

[Openshift](https://www.openshift.com/) is an application deployment platform based on Kubernetes, that incorporates many additional functionalities and is developed and supported by [Red Hat](https://www.redhat.com). Some of the organizations that choose to run their applications on OpenShift do so because of these extra features, as well as the support provided by Red Hat. Running OpenShift on Azure is again very simple, where [Azure Red Hat OpenShift](https://docs.microsoft.com/azure/openshift/intro-openshift) makes it extremely easy.

## Azure Application Service

[Azure App Service](https://docs.microsoft.com/azure/app-service/overview) is a platform where organizations can run their web-based workloads without having to manage any orchestrator or underlying operating system. The only requirement is uploading the application code to the service through one of many available deployment methods, and Azure will do the rest: scaling the application up and down, patching and maintaining the underlying virtual machines, and much more, without going through the learning curve of Kubernetes.

Azure App Services support as well container-based workloads, so you can upload your container image instead of the application code. It supports as well Linux and Windows workloads, and many different application runtimes.

Additionally, Azure App Services support different pricing models including a serverless option called [Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-overview), where only application usage is charged without any fixed costs. The serverless model is extremely interesting for innovating, because it allows to deploy new microservices without incurring in high monthly bills in case they are not accepted by the market. This is another example of the fail-fast strategy, where innovation does not necessarily mean high expenses.

Azure App Service offers as well many features that are targeted at supporting DevOps-oriented deployments, such as web app slots. Slots are staging areas where you can deploy new features without impacting the actual production environment. This is great from an innovation perspective, because you can then redirect a small selection of your customers to this new version of the application, and validate whether your innovation hypothesis is true. Eventually, if you wish to promote the new code to production, you can "swap" slots so that the staging environment becomes now the production version.

## Summary

In this unit you have learnt how technology can support innovation:

- DevOps processes and tools will give your development and operations teams the superpower of delivering new features quickly and reliably.
- Applications can be rearchitected into microservices to allow innovating on one of their components without affecting the rest.
- Containers allow reliable application deployments across multiple environments
- Kubernetes is a cloud-agnostic platform to run containerized applications
- Azure Application Services is an Azure offering that can run web-based workloads with a minimum management overhead, and offers many features like serverless or application slots specifically targeted to speed up the innovation cycle.

Tailwind Traders has decided to start the redesign of their ecommerce application into a microservices architecture. The first application subsystem they will separate from the main "monolith" is the payment service, since this has been identified as a critical area where their competition is better than them. After the payment subsystem, additional application components will be converted into independent microservices. The microservices will talk to each other using REST APIs.

The application code for each microservice will be containerized, and the development and operations organizations will adopt DevOps best practices. Since Tailwind Traders does not want to be dependent on any specific public cloud, they have decided to build Kubernetes expertise in house, and deploy the application on Azure Kubernetes Service clusters. If new microservices need to be developed, Azure Functions will be considered as a platform for Minimum Viable Product deployment to reduce development costs.

## Where to look next

Many of the concepts exposed in this unit are further articulated in the Cloud Adoption Framework sections [Empower adoption with digital invention](https://docs.microsoft.com/azure/cloud-adoption-framework/innovate/considerations/ci-cd) and [Kubernetes in the Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/innovate/kubernetes/)
