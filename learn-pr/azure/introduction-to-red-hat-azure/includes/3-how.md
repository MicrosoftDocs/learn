Here, we discuss how the different deployment options for Red Hat on Azure work behind the scenes. You learn about the benefits of using each option and see how they can work together to help you build and support nearly any kind of application or workload. This knowledge helps you decide which Red Hat on Azure deployment option can best suit your Red Hat workload.

:::image type="content" source="../media/logo-collage.png" alt-text="A collage of logos of Red Hat services and related Azure infrastructure.":::

## How Red Hat Enterprise Linux (RHEL) on Azure works

Red Hat Enterprise Linux provides a tested, secure, and supportable base for enterprise class applications and services to be built on. It combines the Linux kernel along with hundreds of industry-leading open-source projects into a distribution with a 10-year support lifecycle. Red Hat works with Azure and others in its extensive partner network to ensure compatibility across multiple architectures and deployment platforms. So, regardless of whether you deploy a workload at the edge, in on-premises datacenters, or on Azure, RHEL is available.

## How Azure Red Hat OpenShift (ARO) works

Azure Red Hat OpenShift is OpenShift that Red Hat and Microsoft jointly engineer, operate, and support. They work together to provide an integrated support experience. There are no virtual machines to operate and no patching is required. Red Hat and Microsoft, patch, update, and monitor your master, infrastructure, and application nodes. Your Azure Red Hat OpenShift clusters are deployed into your Azure subscription and are included on your Azure bill.

### OpenShift background

Running containers in production with Kubernetes requires extra tools and resources. Cluster management includes juggling image registries, storage management, networking solutions, and logging and monitoring tools - all of which must be versioned and tested together. Building container-based applications requires even more integration work with middleware, frameworks, databases, and CI/CD tools. OpenShift combines these capabilities into a single platform, bringing ease of operations to IT teams while giving application teams what they need to execute.

OpenShift at its core is a fully compliant instance of upstream Kubernetes that has been hardened with hundreds of fixes that address defect, security, and performance issues in every release. It's integrated with, and tested against, with dozens of technologies and is a robust, tightly integrated platform.

### How ARO differs from OpenShift

OpenShift is the platform that runs your applications. To provide that platform, OpenShift relies on infrastructure components like virtual machines, storage, load balancers, and other network components. The difference between an OpenShift subscription directly from Red Hat and one provided by Azure Red Hat OpenShift is that ARO also includes the underpinning components and the management of them.

You don't need to know how to install or provision OpenShift and all its prerequisites to gets it benefits from day one. And in addition, Microsoft and Red Hat jointly manage all on-going day two operations including server maintenance, updates, and security patches.

## How JBoss EAP in Azure works

JBoss EAP helps you upgrade from proprietary or outdated middleware to an open-source platform and increase your runtimes through Red Hat’s application modernization and migration solution. The JBoss approach minimizes your effort, time, and risk. By helping to reduce app costs, improve operational efficiency, and boost developer productivity for faster software delivery cycles.

JBoss EAP is part of the Red Hat Application Services portfolio of middleware products, it gives developers, architects, and IT leaders the ability to create, integrate, and automate applications. The portfolio has been engineered together to help develop, implement and run business applications cost-effectively at scale. Red Hat Application Services supports your hybrid cloud journey by being able to run the same workloads on-site, in the cloud, or within a container platform, like Red Hat OpenShift.

Regardless of whether you already have existing licenses JBoss subscriptions on-premises or are starting fresh with new subscriptions on Azure, the Red Hat Cloud Access program allows you to use any JBoss EAP subscription. You can use a subscription to install JBoss EAP on your own Azure virtual machine or one of the on-demand operating systems from the Microsoft Azure Marketplace. Virtual machine operating system subscriptions are separate from a JBoss EAP subscription.
