Infrastructure as Code is an integral component of modern software development and operations practices. It involves the use of programming methods to provision and manage infrastructure services. IaC is beneficial in cloud-based environments, such as the one described in the sample scenario. However, any organization that relies on computing assets for its revenue can take advantage of its capabilities. In this unit, you'll learn about the main principles of IaC and the most common techniques of implementing these principles.

## What are the main principles of IaC?

While individual implementations of IaC may differ significantly, they all tend to follow a set of common principles, including:

- **Version control**: IaC defines infrastructure components, including compute, storage, and network resources by using code. Such code typically resides in a VCS, which facilitates tracking changes to infrastructure in the same manner as tracking software versions.
- **Declarative syntax**: IaC relies on *declarative* syntax in order to describe the desired state of the infrastructure. This contrasts with a more traditional *imperative* syntax, which involves writing code that defines a step-by-step procedure leading to that state. The declarative approach tends to be more efficient for many reasons. For one, it relies on the intelligence of the platform hosting the infrastructure components, minimizing the possibility of programming errors or inefficiencies. In addition, it ensures idempotence.
- **Idempotence**: This term designates the characteristic of an action where the outcome is always the same, regardless of the number of times the action is performed. Since the declarative syntax describes the end state only, using it guarantees that each code execution will always yield the same result. This ensures the consistency of the target environment and precludes the possibility of unintended side effects of intermediary changes.
- **Automation**: The use of code facilitates automated provisioning and configuration, enhancing efficiency, consistency, and scalability. This also eliminates the potential impact of manual errors.
- **CI/CD integration**: IaC can be (and frequently is) integrated with CI/CD, yielding a comprehensive software delivery strategy by combining  infrastructure provisioning, with application build, test, and deployment into one continuous, fully automated sequence.
- **Reusability**: IaC promotes the use of reusable code modules, in accordance with the best programming practices. This facilitates development of software libraries consisting of standardized infrastructure building blocks that can be shared across projects. As a result, organizations benefit from increased consistency, simplified maintenance, and minimized duplication of efforts.

## How to implement IaC?

Implementing IaC starts with identifying infrastructure requirements, including compute, storage, and networking components. Details depend largely on the platform hosting that infrastructure and could differ significantly depending, for example, on the use of public or private cloud environments.

:::image type="content" source="../media/3-infrastructure-as-code.png" alt-text="Diagram of the infrastructure as code flow.":::

The choice of the platform will also have an impact on the choice of the IaC technology and tools. For example, each public cloud provider offers its own set of IaC capabilities. In the case of Microsoft Azure, these capabilities are based on Azure Resource Manager (ARM) and Bicep templates. There are also solutions that offer multicloud support, such as Terraform.
The choice of tool determines the type of files and the corresponding directory structure of your projects. This should allow you to set up repositories in the version control system of your choice. VCS repos facilitate tracking infrastructure changes, intra and cross-team collaboration, automation for deployments and rollbacks, as well as integration with CI/CD workflows.

With the repository in place, you should start building an IaC code library, consisting of modules representing building blocks of your future infrastructure deployments. Such blocks could, for example, represent individual serves, networks, or data stores, which you can mix and match in an arbitrary manner to construct multi-resource solutions.

The next step would typically involve integrating your IaC environment with CI/CD workflows. Commonly, this would involve using the same set of repositories, facilitating combining deployment of infrastructure with building, testing, and delivery of the software hosted on that infrastructure. However, the integration should extend to applying CI/CD practices to your IaC deployments. In particular, you should ensure that, as with CI/CD, you utilize development and staging environments, automate testing, implement monitoring and feedback loops, and properly secure your infrastructure code and the IaC processes.
