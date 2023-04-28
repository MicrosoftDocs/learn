This unit presents an analysis of the scenario and possible answers to the conceptual and technical questions from the case study.

## A summary of the architect's analysis of the background scenario

The current state of the customer's environment reflects its rapid growth, resulting from business-driven changes circumventing existing governance and security controls for the sake of expediency. Many business acquisitions, including the most recent one involving Tailwind Traders, further contributed to the fragmented technology landscape. There are no clearly defined hardware or software standards or existing third-party solutions that would provide a comprehensive, centralized security solution. On-premises servers run a mix of different Windows operating system (OS) versions and a range of more common Linux distributions. The existing cloud presence is limited to a small deployment of compute workloads in the AWS public cloud. Remote users rely on VPN to connect to an on-premises Virtual Desktop Infrastructure (VDI) farm from personal computers running Windows client OS.

The presence of Active Directory Domain Services (AD DS) environment offers the basis for an integration with Microsoft public cloud. This integration would constitute the starting point for incorporating a wide range of Microsoft security-focused products into Contoso's environment, with Defender for Cloud serving the primary role in protecting the current and future infrastructure services.


## A summary of the architect's analysis of the design requirements

### Implement a comprehensive, continuous assessment of the company-wide security posture for on-premises and cloud infrastructure. 

This requirement drives the choice of Microsoft Defender for Cloud as the fundamental component of the proposed solution. Defender for Cloud provides Cloud Security Posture Management (CSPM) as one of its core capabilities. Basic CSPM features are enabled for free within each Azure subscription, yielding an immediate benefit to cloud-based workloads. These benefits can be extended to Tailwind Traders' Amazon Web Services (AWS) account without having to deploy any agents. Enhanced CSPM features further increase a range of security-centered capabilities, including governance and regulatory compliance, cloud security explorer, attack path analysis, and agentless scanning for virtual machines.

### Implement a comprehensive, continuous threat protection of the company's technology environment for on-premises and cloud infrastructure.

This requirement further validates the suitability of Microsoft Defender for Cloud as the fundamental component of the proposed solution. Cloud Workload Protection Platform (CWPP) is one of the two core capabilities of Defender for Cloud. Its scope extends beyond Azure to on-premises and third-party clouds, including integration with AWS compute workloads such as Elastic Kubernetes Service (EKS) clusters and Elastic Compute Cloud (EC2) instances.

### Provide a solution to address the vulnerabilities of client devices used for remote access to the on-premises VDI environment.

This requirement, combined with the lack of an existing mobile device management solution, influences the choice of Microsoft Intune for the management of personal devices. Windows client computers can be Microsoft Azure Active Directory (Azure AD) joined to provide a comprehensive set of security features. These features include passwordless authentication with Windows Hello for Business, single sign-on to both cloud and on-premises resources, support for Azure AD Conditional Access, and enforcement of organization-required configurations, such as disk encryption or software updates.

### Provide a tactical and strategic solution to address the vulnerabilities of the on-premises VDI environment.

This requirement distinguishes between the immediate goal of addressing vulnerabilities of the existing on-premises VDI implementation and a longer-term goal of transitioning to a cloud-based deployment of Azure Virtual Desktop. The former can be addressed by using the capabilities of Microsoft Defender for Endpoint, while the latter delivers a modern solution that not only maximizes security and resiliency but also minimizes the operational overhead.

### Recommend the approach to securing Tailwind Traders' on-premises and cloud computing resources. 

This requirement focuses on the role of Microsoft Defender for Containers, which is part of Defender for Cloud, in securing Kubernetes-based workloads running on-premises and in third-party clouds. Microsoft Defender for Containers enhances the three main aspects of container security:

- Environment hardening protects your Kubernetes clusters running on Azure Kubernetes Service (AKS), on-premises, or on Amazon EKS. Defender for Containers continuously assesses cluster state and operations in order to discover any misconfigurations and provide guidelines that help mitigate potential threats.
- Vulnerability assessment scans images stored in Azure Container Registry (ACR) and AWS Elastic Container Registry (ECR) for any known vulnerabilities.
- Runtime threat protection for nodes and clusters generates security alerts in response to any suspicious activities.

### Recommend a solution for the on-premises SIEM instance that would provide a single-pane of glass for the company's security operations team.

This requirement drives the choice of Microsoft Sentinel as the replacement for the on-premises Security Information and Event Management (SIEM) instance. Traditional on-premises SIEM deployments, unlike Sentinel, have limited scalability and don't provide AI or machine learning capabilities. 

### Identify security-related benefits resulting from the integration of on-premises and third-party cloud resources with Azure.

This requirement suggests the use of Azure Arc as the technology that not only helps streamline the management and operational model but also enhances security. Azure Arc provides a unified view of the entire technology estate, which helps with identifying the security posture of all assets. In addition, Azure Arc delivers such features as Azure Policy-based compliance enforcement and assessment, GitOps-based configuration management for containerized workloads, Azure role-based access control (RBAC) for the control plane operations, and the use of VM extensions for maintaining the desired state configuration of Windows and Linux servers.

## Answers to each conceptual question

### What are the primary Microsoft Defender products and services that offer security solutions for an infrastructure?

Microsoft Defender comprises a suite of security-focused products, including Microsoft 365 Defender, Microsoft Defender for Cloud, Microsoft Defender for IoT, Microsoft Defender Threat Intelligence, and Microsoft Defender capabilities in the Windows operating system. Solutions focusing on infrastructure benefit directly or indirectly from all of them, but the ones of particular importance are Microsoft Defender for Cloud and Microsoft Defender for IoT. 

Microsoft Defender for Cloud provides unified security management and advanced threat protection across hybrid and multicloud workloads. The following Defender for Cloud plans offer comprehensive defenses for the compute, data, and service layers of your environment:

- Defender for Servers
- Defender for Storage
- Defender for SQL
- Defender for Containers
- Defender for App Service
- Defender for Key Vault
- Defender for Resource Manager
- Defender for DNS
- Defender for open-source relational databases
- Defender for Azure Cosmos DB
- Defender for DevOps

### How does Microsoft Defender for Cloud benefit Azure customers?

Defender for Cloud delivers the following three core capabilities: 

- Secure Score provides a continuous assessment of the security posture of your environment, helping you to enhance and keep track of security-focused efforts.
- Recommendations provide step-by-step guidance for workload protection from known security risks.
- Alerts notify you about threats affecting your environment in real-time, facilitating a prompt response that minimizes the associated risk and potential impact.

### How and to what extent can the Microsoft Defender for Cloud benefits be extended to hybrid and multicloud scenarios?

Because Defender for Cloud is an Azure-native service, many Azure services are monitored and protected automatically, without the need for any extra configuration or deployment tasks. You can extend that protection to resources that reside on-premises or in third-party public clouds, such as AWS or Google Cloud Platform (GCP). Implementation details are specific to the type of protected resource and the target environment.

For example, by connecting your AWS account to your Defender for Cloud, you can extend the CSPM features to your AWS resources without having to deploy any agents. This provides a security assessment for your AWS resources according to AWS-specific security recommendations and compliance standards, automatically updating your secure score. You can also use Microsoft Defender for Containers, which applies its threat detection and advanced defenses to Amazon EKS clusters. Microsoft Defender for Servers brings threat detection and advanced defenses to Windows and Linux EC2 instances. 

### What are the integration capabilities of Microsoft Defender for Cloud with other security-focused Microsoft cloud-based services?

With Microsoft Defender for Servers, you benefit from its integration with Microsoft Defender for Endpoint. Microsoft Defender for Endpoint is a holistic, cloud-delivered, endpoint security solution. Microsoft Defender for Cloud also integrates with Microsoft Defender for Cloud Apps. Another important integration point links Defender for Cloud with Microsoft Sentinel and is implemented as one of Sentinel's top connectors. 

### How do the Microsoft Defender for Cloud native and integration capabilities help minimize the impact of cyberthreats?

Microsoft Defender for Endpoint protects Windows and Linux machines whether in Azure, on-premises, and in third-party cloud environments. This protection includes:

- Advanced post-breach detection sensors. Defender for Endpoint's sensors collect a vast array of behavioral signals from your machines.
- Vulnerability assessment from the Microsoft threat and vulnerability management solution. With Microsoft Defender for Endpoint installed, Defender for Cloud can detect vulnerabilities discovered by the threat and vulnerability management module and also offer this module as a supported vulnerability assessment solution. 
- Analytics-based, cloud-powered, post-breach detection. Defender for Endpoint quickly adapts to changing threats. It uses advanced analytics and big data. It's amplified by the power of the Intelligent Security Graph with signals across Windows, Azure, and Office to detect unknown threats. It also provides actionable, real-time alerts.
- Threat intelligence. Defender for Endpoint generates alerts when it identifies attacker tools, techniques, and procedures. It uses data generated by Microsoft threat hunters and security teams, augmented by intelligence provided by partners.

The integration between Defender for Endpoint and Defender for Cloud offers the following capabilities:

- Automated onboarding. Defender for Cloud automatically enables the Defender for Endpoint sensors on all supported machines connected to Defender for Cloud.
- Single-pane of glass. The Defender for Cloud portal pages display Defender for Endpoint alerts. To investigate them further, you can use Microsoft Defender for Endpoint pages in the Microsoft 365 Defender portal, where you find additional information such as the alert process tree and the incident graph. 

The integration between Defender for Endpoint and Defender for Cloud Apps provides you with the ability to perform anomaly detection against the Azure activity logs.

Microsoft Defender for Cloud connector of Microsoft Sentinel allows you to stream security alerts from Defender for Cloud into Microsoft Sentinel. This allows for viewing, analyzing, and responding to Defender alerts, along with the incidents they generate, in a broader organizational threat context.

### What are the considerations and requirements that should be taken into account when onboarding to Microsoft Defender for Cloud resources residing in Azure, on-premises, and in third-party cloud environments?

From the commercial standpoint, Defender for Cloud offers basic and enhanced security features that help protect your organization against threats and attacks. Basic features are enabled for free within each Azure subscription and consist of foundational cloud security and posture management (CSPM) capabilities. These capabilities include secure score, security policy, basic recommendations, and network security assessment for Azure resources. Enhanced features comprise a range of paid-for offerings that deliver unified security management and threat protection across Azure, on-premises, and third-party cloud workloads.

From the planning and implementation standpoint, the full functionality of Defender for Servers depends on log collection, which requires installing either the Log Analytics Agent or the Azure Monitor Agent. As part of the planning stage, ensure that your target servers are running one of the supported operating systems for the agent you choose. Your implementation plan should account for the need to install that agent.

From the functionality standpoint, the range of supported features is determined by the type of target service, the underlying compute platform, and its location. For example, the list of features for servers differs depending on whether they're implemented as Azure VMs or Azure-Arc enabled machines, whether they're running a Windows or Linux operating system, and, whether they reside on-premises or are hosted in third-party clouds. Similar dependencies exist for containerized workloads. In regard to Azure PaaS services, Defender for Cloud offers free recommendations for a large number of them, but security alerts and vulnerability assessments are more limited in scope.

### What security measures provided by Microsoft help secure Azure Virtual Desktop deployments?

Enhanced security features of Defender for Cloud provide protection for Azure Virtual Desktop workloads, including vulnerability management, compliance assessments based on common frameworks like Payment Card Industry (PCI), and overall strengthening of their security posture. For server operating systems functioning as Azure Virtual Desktop hosts, you'll benefit from the integration between Defender for Cloud and Defender for Endpoint. For client operating systems, you can deploy Defender for Endpoint directly.


## Answers to each design question

### How would you use the primary capabilities of Microsoft Defender for Cloud to address the company's needs?

The company's needs can be addressed by using both the CSPM and CWPP capabilities of Microsoft Defender for Cloud. The former implements a comprehensive, continuous assessment of the company-wide security posture for on-premises and cloud infrastructure. The latter implements a comprehensive, continuous threat protection of the company's technology environment for on-premises and cloud infrastructures.

### Which plans and components of Microsoft Defender for Cloud are most significant to consider in the context of the case study?

The most significant plans and components of Microsoft Defender for Cloud include the following:

- Basic and enhanced CSPM features 
- Defender for Servers
- Defender for Containers
- Defender for SQL
- Defender for open-source relational databases
- Defender for Storage
- Defender for App Service

### Which benefits of enhanced security features of Microsoft Defender for Cloud would help the company to optimize its security stance and protect its infrastructure?

Basic CSPM features deliver continuous assessment of the security configuration of your cloud resources, security recommendations to fix misconfigurations and weaknesses, and secure score for cloud-based resources. With enhanced CSPM features, these capabilities extend to on-premises resources and, additionally, include governance and regulatory compliance, cloud security explorer, attack path analysis, as well as agentless scanning for virtual machines.

Defender for Servers extends protection to Windows and Linux machines that run in Azure, AWS, and on-premises. It integrates with Defender for Endpoint to provide endpoint detection and response (EDR) and other threat protection features.

Defender for Containers, which is part of Defender for Cloud, helps with securing Kubernetes-based workloads running on-premises and in third-party clouds. 
Defender for SQL helps discover and mitigate potential database vulnerabilities and alerts about anomalous activities that may indicate an impending threat. 
Defender for open-source relational databases brings a similar set of features to open-source relational databases, including Azure Database for PostgreSQL, Azure Database for MySQL, and Azure Database for MariaDB.
Defender for Storage detects unusual and potentially harmful attempts to access storage accounts. 
Defender for App Service assesses the resources that constitute App Service plan-based workloads and generates security recommendations based on its findings. These resources include the VM instances on which your App Service is running. 

Contoso would also benefit from onboarding its resources to Defender for Key Vault and Defender for Resource Manager.

### What are the main considerations and requirements that you would include in your design of onboarding the company's resources onto Microsoft Defender for Cloud?

Considering that all of the on-premises and cloud-based resources in the scope of the proposed solution are supported by enhanced protection of Microsoft Defender for Cloud, the first step would involve evaluating the commercial implications. The simplest method to estimate the cost of your solution is to use the Price Estimation workbook accessible from the Microsoft Defender for Cloud interface in the Azure portal. Since individual plans are configurable independently, it's possible to roll them out in a gradual manner. The 30-day trial period provides a convenient option to validate the expected functionality by using a small-scale pilot deployment.

From the planning and implementation standpoint, to provide the required Defender for Cloud functionality for the company's on-premises and cloud workloads, you'll need to deploy the Log Analytics Agent or Azure Monitor Agent. The proposed solution takes into account the automated agent deployment options.

### How would you minimize the effort and time involved in implementing your solution?

In general, onboarding Azure resources to Microsoft Defender tends to be straightforward and requires limited administrative effort. Defender for Servers includes the autoprovisioning configuration option, which automatically installs Log Analytics Agent or Azure Monitor Agent, depending on your preferences. The same applies to Defender for Cloud deployments targeting AWS by using the native cloud connector.

For on-premises deployments, you should use the support for bulk, automated deployments of Azure Arc that rely on an installation script you can generate directly from the Azure portal. With Azure Arc in place, you can use the same autoprovisioning option that is applicable to Azure Virtual Machines. 

For multisubscription deployments, you might consider automation. Infrastructure as Code (IaC) is an interesting option since it ties to DevSecOps and allows you to use declarative deployments through Bicep, Azure Resource Manager, or Terraform template. Other benefits of this approach are associated with using version control for tracking changes to the deployment templates and Continuous Integration/Continuous Deployment (CI/CD) pipelines, which facilitate multistaged validations and gated controls. 

### What additional security-focused Microsoft cloud-based services would you consider including in your design?

As part of your solution, consider adding Microsoft Sentinel as the replacement for the on-premises SIEM instance. Traditional on-premises SIEM deployments, unlike Sentinel, have limited scalability and don't provide AI or machine learning capabilities. In addition, Microsoft Sentinel integrates with Microsoft Defender for Cloud by using a dedicated connector. The connector streams security alerts from Defender for Cloud into Microsoft Sentinel. This facilitates viewing, analyzing, and responding to Defender alerts, along with the incidents they generate, in a broader organizational threat context.

Microsoft Intune is another cloud service you should incorporate in your design. While its primary focus is on mobile device and application management, it also allows for the enforcement of security-related features such as disk encryption, installation of software updates, and integration with Azure AD Conditional Access. 

### Which elements of your design should be implemented as soon as possible and which ones are suitable as part of a longer-term solution? 

The first step towards implementing the comprehensive infrastructure security solution for Contoso is to create an Azure AD tenant and integrate it with the on-premises AD DS environment. That integration constitutes the starting point for setting up Azure subscriptions and provisioning Azure services such as Microsoft Defender for Cloud and Microsoft Intune. This is essential for subsequent stages of the transition to the cloud-based security model. This should be followed by remediating security vulnerabilities in the existing environment, including enrolling remote client computers into Intune, integrating on-premises and AWS resources with Microsoft Defender for Cloud through Azure Arc, and protecting the VDI farm. At that point, you should also consider using other Azure services, such as Azure Update Management to address any gaps in patch levels of existing servers. 

The longer-term goals should involve modernizing the existing environment by transitioning on-premises workloads to Azure. This would include migrating the on-premises VDI farm to Azure Virtual Desktop and replacing on-premises SIEM with Microsoft Sentinel.

## Proposed solution architecture

:::image type="content" source="../media/final-architecture.png" alt-text="Diagram showing Contoso's proposed final architecture." lightbox="../media/final-architecture.png":::