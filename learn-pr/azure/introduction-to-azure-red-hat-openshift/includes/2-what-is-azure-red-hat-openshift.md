Azure Red Hat OpenShift is a fully managed container platform combining the power of Red Hat OpenShift with the robust infrastructure of Azure. Built on Kubernetes, Azure Red Hat OpenShift provides an enterprise-ready solution for deploying and managing containerized applications, simplifying the complexities associated with container orchestration and management. Unlike native Kubernetes services that require users to handle the entire stack, Azure Red Hat OpenShift automates the underlying infrastructure, enabling developers to focus on writing code and delivering business value. This managed approach eliminates the need to configure various components, such as runtimes, CI/CD pipelines, monitoring, and security measures, which can be overwhelming in traditional setups.

<!--The platform is constructed from dozens of upstream open-source projects from the Cloud Native Computing Foundation (CNCF), ensuring enterprise-class support through careful curation and engineering. Azure Red Hat OpenShift offers a seamless experience for deploying applications, making it easier to use containers and Kubernetes without delving into the intricacies of those technologies. This ease of use translates to reduced operational overhead, quicker deployments, and improved collaboration among development teams. -->

## Continuous Integration and Continuous Deployment

Azure Red Hat OpenShift includes robust support for Continuous Integration and Continuous Deployment (CI/CD), letting  you automate your software delivery processes. CI/CD pipelines streamline the process of building, testing, and deploying applications, enabling teams to deliver new features rapidly while maintaining high quality. Azure Red Hat OpenShift enhances collaboration among teams, reducing development cycles and improving overall application quality. The platform integrates well with popular CI/CD tools, allowing organizations to tailor their workflows according to their specific needs.

<!-- It utilizes Tekton building blocks to automate deployments across various platforms, abstracting the underlying implementation details. Tekton provides several standard custom resource definitions (CRDs) to define CI/CD pipelines that are portable across different Kubernetes distributions. -->

## GitOps support and Operators

Azure Red Hat OpenShift supports GitOps, a modern approach that applies Git repositories for infrastructure and application management. OpenShift GitOps promotes collaboration and ensures consistency across environments by allowing teams to define their desired state in Git and automatically synchronize their deployments. The use of Helm further simplifies application deployment by providing a package manager that streamlines the process of installing and managing Kubernetes applications. Helm charts allow teams to define, install, and upgrade even the most complex applications with ease.

Azure Red Hat OpenShift also utilizes Operators, which are custom controllers that automate the management of complex applications on Kubernetes. Operators help teams handle the entire application lifecycle, from installation to scaling and upgrades, thus reducing manual intervention and operational overhead. 

<!-- Additionally, Azure Red Hat OpenShift features Source-to-Image (S2I), which streamlines the process of building container images directly from source code. S2I enables developers to create reproducible images by embedding the source code and necessary build instructions into a container, ensuring consistent deployments across different environments. -->

## Security features

For enhanced security and isolation, Azure Red Hat OpenShift features:

- Support for sand-boxed containers for developers to run untrusted code securely within isolated environments

- Support for serverless architectures, allowing you to build and deploy applications without managing the underlying infrastructure <!-- providing essential flexibility for businesses seeking to innovate quickly and respond to market demands -->

- Service mesh capabilities to facilitate microservices communication, providing a dedicated infrastructure layer that manages service-to-service interactions, enhances observability, and improves resilience

- Fully managed cluster updates that can be triggered from inside the OpenShift Console, to start immediately or scheduled in advance <!-- by utilizing the Managed Upgrade Operator -->

<!--The Managed Upgrade Operator starts the cluster upgrade, but it doesn't perform any activities of the cluster upgrade process itself. The OpenShift Container Platform (OCP) is responsible for upgrading the clusters. The goal of the operator is to satisfy the operating conditions that a managed cluster must hold, both before and after starting the cluster upgrade.

Minor versions are released approximately every three months and patch releases are more frequent, typically weekly. You can see more about the support lifecycle here. -->

## Multi-cluster management

Azure Red Hat OpenShift's multi-cluster management capabilities let you manage multiple clusters from a single control plane. This capability is crucial for organizations that require high availability, disaster recovery, or compliance across different environments. Moreover, Azure Red Hat OpenShift's integration with various Azure services, such as Azure Cosmos DB, Azure SQL Database, and Azure Machine Learning, lets you create complex, integrated solutions that utilize cloud power.

<!-- It's an open-source project created and maintained by Microsoft, available also through OperatorHub.io, a repository of operators launched by Red Hat, Microsoft, AWS, and Google, which we integrated into OpenShift 4. -->

The Azure Service Operator further simplifies resource management by streamlining infrastructure operations. It allows users to easily spin up and manage Azure resources, enabling developers to self-provision infrastructure or even include Azure Service Operator in deployment pipelines. <!-- This way, Azure-specific knowledge is abstracted, allowing deployments in a Kubernetes-native way. -->

<!--Azure Red Hat OpenShift is adaptable to various business needs, whether organizations aim to develop new products or modernize existing applications. This managed approach, combined with the powerful Azure infrastructure, positions Azure Red Hat OpenShift as a preferred choice for organizations striving to transform their IT operations and accelerate their digital transformation journey. By alleviating the burden of infrastructure management, Azure Red Hat OpenShift empowers teams to invest their time and resources in delivering new features and optimizing applications, ultimately driving significant business value.-->

## Additional features

- **Managed version of OpenShift:** Azure Red Hat OpenShift is a managed version of OpenShift where the setup of the cluster is automatically handled by Azure, allowing teams to focus on applications rather than infrastructure. It means a native service, with a managed approach, from infrastructure to daily operations.

- **Self-service capabilities:** Quickly and easily deploy OpenShift clusters through the Azure portal or using CLI (command line interface) within minutes.

- **Fully managed clusters:** Control and application nodes are taken care of by Microsoft and Red Hat, removing the need for users to manage VMs or patches. The OpenShift API offers a Service Level Agreement (SLA) of 99.95%.

- **Integrated experience:** Azure Red Hat OpenShift is part of Azure APIs, meaning seamless onboarding, service management, and technical support as a native Azure service.

- **Azure compliance:** Leverage Azure's compliance certifications, scalable on-demand capabilities, and robust support.

## Benefits of Azure Red Hat OpenShift

- **Simplified management:** Azure Red Hat OpenShift handles installation, configuration, and ongoing maintenance, enabling users to focus on applications rather than managing infrastructure components. Microsoft and Red Hat manage not only the Kubernetes control plane, but also the worker nodes and the integrated tools.  They also manage the configuration of Azure Red Hat OpenShift networking, while the customer is responsible for the underlying network (subnets, virtual networks, etc.), usually an initial setup before cluster creation. Customers bring the virtual network, install the control plane on subnet X, data plane on subnet Y, then hook up the overlay pod networking using OVN (Open Virtual Network). However, customers still need to configure cluster network policies, etc.

- **Collaborative SRE model:** SRE teams prioritize resolving issues proactively, maintaining communication, and auditing access to ensure smooth operations. The Site Reliability Engineering team comprises developers with a systems mindset and system engineers with a development mindset responsible for Azure Red Hat OpenShift environments. They handle from building and installing to upgrading and maintaining every cluster. They fully automate installation and initial configuration for "Day One" operations and automate remaining cluster lifecycle operations for "Day Two" operations.

- **Unified billing:** Azure Red Hat OpenShift allows for a single bill within your Azure subscription for both Red Hat and Azure solutions, leveraging Azure monetary commitments. You can also use Azure Reservations and Azure Spot instances to get fine control of costs.

## Azure Red Hat OpenShift reference architecture

:::image type="content" source="../media/aro-reference-architecture.png" alt-text="Diagram showing basic reference architecture of Azure Red Hat OpenShift." lightbox="../media/aro-reference-architecture.png":::
