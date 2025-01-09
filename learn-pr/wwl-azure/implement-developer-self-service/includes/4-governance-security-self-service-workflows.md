In any platform engineering strategy, it’s essential to implement self-service workflows that balance speed and autonomy with security and compliance. While empowering developers to manage their resources independently is key to boosting efficiency, governance and security must be tightly integrated to prevent potential issues such as unauthorized access or policy violations.

Governance frameworks ensure developers can operate within predefined boundaries, while security measures protect against vulnerabilities and unauthorized activities. Developers need the autonomy to innovate and provision resources as needed, but organizations also need to maintain control to prevent security risks, avoid misconfigurations, and ensure compliance with regulatory standards. The key to achieving this balance lies in well-designed governance models, the effective use of security measures, and a robust auditing and compliance strategy that can track activities within the self-service workflows.

### Cloud Service Selection

In public clouds, you can choose from SaaS, PaaS, or IaaS, each offering different levels of control and ease of use. PaaS services provide streamlined development experiences but are more prescriptive, requiring a trade-off between ease of use and flexibility. When designing your platform, it's essential to evaluate your organization's service needs, such as whether to use Azure Kubernetes Service (AKS) for more control or Azure Container Apps (ACA) for simplicity. Emerging app models like the OSS Radius incubation project aim to strike a balance between the two but are less mature than established cloud services. The right choice depends on your service requirements and your team's existing skill set.

### Standardization

Infrastructure as Code (IaC) and automation tools can be combined with templates to streamline and standardize infrastructure and application deployment. By abstracting platform-specific details into relatable categories (for example, sizes such as small, medium, and large), templates can simplify the process for development teams, allowing them to get started quickly with minimal configuration. However, there may be situations where custom configurations are needed, in which case platform or operations teams can create one-off configurations and decide whether to integrate them into the template.

Tools like Terraform and cloud-native IaC solutions (for example, Cluster API, Crossplane) can track changes through drift detection, with the ability to automatically remediate drift. Additionally, cloud configuration tools, such as Azure Resource Graph, can help monitor and review changes to resources. To ensure flexibility, tolerances can be set within deployments to allow for predefined limits, such as using Azure Policy to control the number of Kubernetes nodes in a deployment.

### Resource Sharing

Within an organization, sharing resources like Kubernetes clusters across multiple applications can improve utilization and cost-effectiveness, but requires careful consideration. Key factors include:

- **Organization Alignment**: Sharing resources within organizational boundaries ensures better alignment with direction, priorities, and requirements.
- **Application Tenancy**: Applications have different isolation needs (for example, security, compliance). For example, Kubernetes uses namespace isolation, but mixing environments like production and test on the same cluster can lead to risks. Consistency in approach is essential.
- **Resource Consumption**: Each application's resource usage and capacity projections should be evaluated to avoid overloading shared resources. Monitoring and testing help ensure that applications don't exceed available capacity and cause service disruptions.
- **Optimizing Shared Configurations**: Shared resources require detailed configuration, including cross-charging, resource allocation, permissions, workload management, and upgrade coordination.

### Governance Models

One of the most efficient ways to implement governance is through **policy-driven management**, where platform policies are automated using tools like and Azure Policy. These tools enable organizations to enforce policies consistently across the platform, ensuring that every resource provisioning action taken by developers aligns with predefined organizational rules.

Establishing **guardrails and constraints** is another critical aspect of governance. These safeguards—such as resource quotas, geographical restrictions, or tagging requirements—help developers provision resources within acceptable parameters. Guardrails provide boundaries that help protect against security vulnerabilities, compliance violations, or unnecessary costs, while still maintaining the agility required for innovation.

Organizations also need to consider the choice between **centralized vs. decentralized governance** models. Centralized governance ensures tighter control and consistency by allowing a dedicated team, such as platform engineering or IT security, to manage policies and workflows. A decentralized approach delegates decision-making to individual teams, promoting flexibility and autonomy. The optimal model depends on factors such as the organization's size, complexity, and compliance requirements.

### Governance Strategies

From the strategy standpoint, governance can be divided into two stages:

1. **Initial Deployment Compliance (Start Right)**: This is achieved through standardized IaC templates, catalogs, and permission management policies to ensure that only authorized resources and configurations are deployed.
1. **Maintaining Compliance (Stay Right)**: Policy-based tools help monitor and prevent unauthorized resource changes. These tools extend beyond core infrastructure, supporting compliance within resources like Kubernetes, containers or VMs, and a range of security tools.

The tools to maintain compliance should provide auditing, reporting, and remediation capabilities. Azure Policy, for instance, offers this support through various modes such as Audit, Deny, and DeployIfNotExists. However, these policies can sometimes inadvertently disrupt applications, making the transition to Policy as Code (PaC) beneficial, especially for large-scale environments. PaC enables centrally managed standards, version control for policies, automated testing and validation, and faster rollout with continuous deployment, ensuring a more streamlined and reliable approach to managing compliance.

### Security

Ensuring security in developer self-service for platform engineering requires a multi-layered approach, covering code, containers, clusters, and cloud infrastructure. Key recommendations include adhering to the principle of least privilege, unifying DevOps security management across pipelines, enabling contextual insights for critical risk identification, and maintaining runtime detection and response to modern threats across cloud workloads. Tools like Microsoft Defender for Cloud can aid in evaluating and addressing these security challenges across engineering systems, applications, and resources.

In the context of developer self-service, enforcing least-privilege access means ensuring that developers can access the resources they need to complete their tasks without granting excessive permissions. For example, a developer may have full access to a development environment but only read-only access to the production environment. This helps prevent accidental or malicious modifications to production systems.

In addition to enforcing least privilege, organizations must also focus on separation of duties, which ensures that no single individual or role has unchecked power over critical processes. This practice helps mitigate risks such as fraud, errors, and security breaches by ensuring that tasks requiring different sets of expertise are divided among different roles. For instance, developers might be responsible for writing code, but deployment to production may require approval from a separate operations or security team. By using RBAC, organizations can enforce these boundaries restricting access to sensitive environments (for example, production) while still providing developers the freedom to work autonomously in non-sensitive environments (for example, development or staging). Separating duties also supports compliance with security frameworks and regulatory standards, such as SOX (Sarbanes-Oxley) or PCI DSS, which often requires clear roles and responsibilities for system access and data management.

Beyond application security, organizations should focus on several critical areas: managing external attack surfaces (for example, Microsoft Defender EASM), employing intelligent security analytics (for example, Microsoft Sentinel), and securely governing and managing data assets (for example, Microsoft Purview). Additionally, code scanning for vulnerabilities and dependency reviews with tools like GitHub Advanced Security are essential, as is managing the software supply chain with frameworks like the Microsoft Containers Secure Supply Chain Framework.

Applications also require secure identity management to access cloud resources. For instance, AKS workloads can use workload identities that federate with Microsoft Entra ID, allowing containerized applications to authenticate securely without embedding secrets in the application code. This approach enhances security while simplifying resource access for cloud-native applications.

However, proper **secret management** is still vital in securing self-service workflows. Developers often handle sensitive data such as API keys or credentials, which must be securely stored and accessed. Microsoft tools like **Azure Key Vault** provide a centralized solution for securely storing and rotating secrets. These tools ensure secrets are encrypted and only accessible to authorized individuals or services.

#### Authorization

Managing authorization requires defining clear roles and policies that align with the principle of least privilege. Properly implemented access control policies, such as RBAC, allow organizations to assign appropriate permissions to developers based on their job functions, roles, and responsibilities. Additionally, dynamic access control mechanisms such as temporary access or time-based controls further enhance flexibility without compromising security.

Once roles are defined, the next step is to create and enforce role policies that specify what each role can and can't do. For example, roles might grant permission to provision cloud resources, deploy code to a CI/CD pipeline, or modify configuration settings. By assigning specific permissions to these roles, organizations can control the level of access that developers have to various resources. RBAC also helps reduce the risk of privilege creep, where users accumulate excessive permissions over time. By clearly defining roles and regularly reviewing permissions, organizations can ensure that developers have only the access they need to perform their tasks.

#### Governance and Security in Azure Deployment Environments (ADE)

Azure Deployment Environments (ADE) enhances self-service governance by providing pre-configured environments aligned with organizational standards. Governance is achieved by using **templates** that standardize deployments, ensuring resources are provisioned securely and in compliance with policies.

In ADE, RBAC policies control who can provision environments and what configurations they can use, providing well-defined boundaries. Security features such as **Microsoft Entra ID integration** and **Managed Identities** enable secure access to resources without requiring explicit credential management.

With ADE, organizations can define access control policies that enforce RBAC principles at the environment level. For example, a developer may be granted access to deploy code to a development or test environment but may require other permissions or approval to deploy to production. RBAC can be applied to various elements of ADE, including environment templates, resources, and configurations, ensuring that security policies are consistently enforced.

Additionally, ADE supports monitoring and logging through **Azure Monitor**, helping track provisioning activities and resource usage. Organizations can use this data to enforce governance and detect any violations of compliance policies.

#### Governance and Security in Azure Dev Box

Azure Dev Box provides built-in controls for setting up RBAC, enforcing resource limits, and applying cost-management policies, which align with the principles of secure self-service. Security provisions include integration with tools like **Microsoft Entra ID** to manage user authentication and authorization. Microsoft Entra ID ensures only approved individuals can access and provision Dev Boxes, and RBAC policies limit users' capabilities based on their roles. Additionally, integration with **Microsoft Sentinel** helps enhance monitoring and auditing of Dev Box provisioning and usage to detect anomalies and enforce compliance.

Dev Box environments are highly customizable, and RBAC can ensure that only authorized developers can create or modify their own workstations. For example, a developer in a junior role may only have the ability to provision a Dev Box with limited resources, while a senior developer might have broader permissions to adjust configurations or install other software.

Azure Dev Box supports tagging strategies and cost management to track and optimize resource usage. Organizations can implement **Azure Policy** to enforce governance standards, such as requiring certain configurations for Dev Boxes, ensuring consistency and security across environments.
