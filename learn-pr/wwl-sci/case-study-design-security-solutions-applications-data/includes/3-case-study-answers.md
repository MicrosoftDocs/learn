This unit presents an analysis of the scenario and possible answers to the conceptual and technical questions from the case study.

## A summary of the architect's analysis of the background scenario

The current state of the customer's environment represents a stark contrast between its online business model and full dependency on infrastructure hosted in an on-premises datacenter. That infrastructure includes Azure DevOps Server for version control and application lifecycle management (ALM), a server running Jenkins handling limited task automation, front-end Web servers and back-end SQL Servers, servers hosting Web API components developed in JavaScript, and a Docker Registry server storing container images for backend APIs. Transitioning to a cloud-based model, with all of the existing services and DevOps processes in scope wouldn't only allow elimination of the overhead associated with administering and maintaining the current environment, but would also significantly enhance its security, resiliency, and manageability. 

Another critical part of the transition would involve addressing the absence of proper development and design practices, insufficient oversight of the open-source software (OSS) on which parts of Contoso’s internally developed code are based, absence of configuration management tools, no dedicated staging environment, and lack of automation. Replacing the current DevOps processes with fully automated continuous integration and continuous delivery (CI/CD) workflows that use Microsoft managed DevOps offerings facilitate a full adoption of DevSecOps principles. 

However, there are other aspects of that adoption that will require a more comprehensive approach to various stages of the application lifecycle. In particular, Contoso’s development team needs to incorporate a currently missing threat modeling approach into its code planning and authoring process. Implementing a modern and up-to-date cloud-based toolset will help address the disparity between software versions installed on personal computers used for programming tasks and allow to take advantage of the latest Integrated Development Environment (IDE) security plugins. Attempts to push code changes to a cloud-based Git repository triggers unit, functional, and security tests, with the commit contingent on a successful completion of all of them. 

The operations team needs to implement cloud configuration validation and infrastructure scanning in order to detect any potential vulnerabilities. Penetration tests need to become part of the standard operating procedures. The team should also be able to relatively easily remediate the absence of staging and testing environments by taking advantage of the capabilities of a public cloud. 


## A summary of the architect's analysis of the design requirements – discussing how each requirement influences the final solution

### Ensure that the footprint of the existing on-premises infrastructure is minimized or even replaced by Microsoft cloud-based managed services.

Contoso can replace their on-premises Azure DevOps Server with Git-based repositories hosted in a GitHub account or an Azure DevOps organization. Both options fully support version control and ALM without the overhead of administering and maintaining the underlying infrastructure. GitHub actions and Azure Pipelines deliver enhanced automation capabilities compared with Jenkins. The services delivered by on-premises Web, API, and SQL Server deployments can be migrated to a wide range of Azure managed services that provide the equivalent functionality. Azure Container Registry can be used to store container images for backend APIs. 

### Use the capabilities of GitHub and Microsoft Azure to rapidly build, test, and deploy new and updated applications in an automated manner, following the CI/CD principles.

Contoso should use GitHub Actions to automate its software development and delivery workflows. GitHub Actions provides the ability to implement workflows that fully automate building, testing, packaging, releasing, and deploying GitHub-based projects. Each workflow is made up of individual actions that run in response to a specific event, such as a pull request. GitHub Actions fully integrates with Azure services, including Azure App Service, Azure Container Registry, and Azure Key Vault. GitHub Actions also include support for such utilities as Azure Resource Manager and Bicep templates, Azure CLI, and Azure Policy.

### Implement controls that minimize the risk of unauthorized access to CI/CD workflows.

GitHub Enterprise for Cloud integrates with Azure Active Directory (Azure AD), including its conditional access and multifactor authentication. Users can access a GitHub organization by relying on Security Assertion Markup Language (SAML)-based single sign-on (SSO). SAML SSO supports access controls to such organizational resources as repositories, issues, and pull requests. Organizations can implement System for Cross-domain Identity Management (SCIM) to add, manage, or remove organization member access within GitHub. 

### Standardize the development environment and enhance its security with minimal administrative effort.

Contoso should use GitHub Codespaces for both individual and shared development projects. These prebuilt development environments organized into containers provide correctly configured IDEs equipped with required security scanning extensions. With GitHub Codespaces, the developers can set up projects that build inside a container hosted by GitHub. By using Visual Studio Code's Remote feature, it becomes possible to connect a locally running Visual Studio Code instance to a Codespace and edit, build, deploy, and debug directly from that Codespace. Codespaces accelerate cloud adoption.

### Protect backend APIs from misuse.

Contoso should consider implementing API Management as part of their transition to the cloud-based operational model. Azure API Management is a hybrid, multicloud management platform for APIs hosted in Azure, third-party clouds, and on-premises environments. Azure API Management includes an API gateway component, which serves as an entry point for all incoming requests and forwards them to respective backend services. By configuring policies at the API gateway level, Contoso is able to properly authenticate and authorize access to its APIs.

### Minimize security risks associated with security vulnerabilities introduced into custom code, secrets checked into repositories, and the use of OSS components.

A cloud-based DevSecOps implementation helps Contoso with mitigating risks associated with custom code, secrets checked into repositories, and the use of OSS components. To start, the company should adopt a zero-trust approach as one of the founding principles of its security strategy. This approach includes repetitive and automated validation of the integrity of DevOps processes and artifacts, including applying all relevant bug fixes and updates. 

### Validate that applications deployed into the staging environment comply with the security standards before being deployed into the production environment

This requirement can be addressed by using the native capabilities of Azure services that facilitate implementing staging environment. One of such services is App Service, which supports deployment slots. The equivalent functionality is supported by other services, including Azure Kubernetes Service, Azure Functions, and Azure Spring Apps.

## Answers to each conceptual question

### What are the two primary Microsoft-managed DevOps offerings?

The two primary Microsoft-managed DevOps offerings are Azure DevOps and GitHub. Each of them forms a sound foundation for implementing DevSecOps practices, so the choice is driven primarily by a customer's preference in regard to DevOps-related functionality. 

### Which mechanisms provide support for the CI/CD functionality in the Microsoft-managed DevOps offerings?

The mechanisms that provide support for the CI/CD functionality in the Microsoft-managed DevOps offerings consist of GitHub Actions and Azure Pipelines. Both represent examples of pipelines as code. Pipelines as code facilitate incorporating standard source control practices such as code reviews via pull request and versioning, they're audited by default, and they minimize the possibility of human error. 

### Which Microsoft cloud services contribute to enforcing DevSecOps practices when using GitHub for ALM?

The primary cloud service that helps enforce DevSecOps practices when using GitHub for ALM is Defender for DevOps, which is part of the Microsoft Defender for Cloud offerings. Defender for DevOps provides a unified interface that facilitates protecting applications and resources across multiple environments, including GitHub and Azure DevOps organizations. This simplifies correlation between cloud security-related events in order to prioritize remediation efforts.  

### Which security standards should be considered for onboarding new applications?

Microsoft Azure Well-Architected Framework offers guidance regarding securing code deployments and infrastructure in the areas of code deployment security, credential scanning, accelerated rollback and roll-forward that address critical bugs and code updates outside of the normal deployment lifecycle


To prevent credentials from being stored in the source code or configuration files, integrate code scanning tools within the CI/CD pipeline. This can be implemented throughout the entire application lifecycle. For example, during design, code analyzers can prevent credentials from getting pushed to the source code repository. During build, pipeline add-ons can discover credentials in the source code. During CI process, dependency scanning. Dynamic application security testing (DAST) and static application security testing (SAST) allow for testing applications in use. 

It's essential that any security-sensitive artifacts, such as secrets or private keys, are stored outside of version control systems and pipelines in a managed key store, such as Azure Key Vault. 


### Which DevSecOps activities are most suitable in individual stages of CI/CD workflows?

DevSecOps applies innovation security by integrating security processes and tools into the DevOps development process. Because DevOps itself is an emerging discipline with a high degree of process variations, successful DevSecOps hinges on integrating security into the development process. Adding security should start with low-friction changes to the code, the development processes, and the infrastructure that hosts the workload. Focus first on changes with the highest positive effect on security while placing a low burden on DevOps processes and skills. However, strive to incorporate these into all stages of a CI/CD workflow, including plan and develop, commit the code, build and test, go to production, and operate.

During plan and develop, follow threat modeling to analyze the application with the mindset of a potential attacker. Threat modeling is one of the most important security practices. It promotes documenting security aspects of your application that take into account how attackers can take advantage of the application's design and the way to fix vulnerabilities.

Another security consideration during development is the use of IDE security plug-ins, precommit hooks for lightweight static analysis, and peer reviews. That help incorporate secure coding practices, such as those available from OWASP.
Code commit vulnerabilities can be identified by implementing repository scanning. Repository scanning tools perform static code analysis on source code within repositories. This protects primarily against human error.

Lack of proper dependency management is another common source of security issues. Development teams should only obtain up-to-date dependencies from known sources. The same considerations apply to the configuration of package feeds. 
Static application security testing (SAST) should be an integral part of continuous integration. This testing verifies security as soon as code changes happen. Dynamic application security testing (DAST) should be part of penetration testing, which treats the application from a black-box security perspective, mirroring an attacker mindset. DAST tools are commonly referred to as web application vulnerability scanners.  Since a full-fledged pen test might take up to several weeks, typical DevOps workflows use lighter versions. This helps to uncover issues missed by SAST. DAST should also incorporate infrastructure scanning to ensure that the target environments where the applications are deployed to are also secure.

To ensure the consistency of the target environment, it's recommended to extend the concepts of DevOps to provisioning and maintaining infrastructure by implementing infrastructure as code (IaC). IaC designates the management of infrastructure in a declarative manner. IaC allows for the same versioning model as the one used for application source code. This also brings the same set of principles that apply to application security into the realm of infrastructure security.

Security must be maintained after an application reaches the production stage. When operating in Azure, the platform offers other monitoring and security services such as Microsoft Defender for Cloud and Microsoft Sentinel. One of the benefits of these services is the ability to detect anomalous events or configurations that require investigation and potential remediation. More feedback can be obtained from Azure Policy and Azure Monitor. Commonly, such feedback is integrated into Azure DevOps or GitHub workflows, allowing developers to rapidly respond and resolve any issues application related issues.

### Which Microsoft Cloud services facilitate enhanced protection of Web Services APIs, including those hosted in on-premises and third-party cloud environments?

Azure API Management is a hybrid, multicloud management platform for APIs hosted in Azure, third-party clouds, and on-premises environments. Azure API Management includes an API gateway component, which serves as an entry point for all incoming requests and forwards them to respective backend services. The API gateway allows API providers to abstract API implementations and modify backend components without impacting API consumers. It also helps enhance security of these components through policies that provide support for such features as authentication and authorization, quotas and rate limiting, restricting callers based on the originating IP address, as well as rewriting of HTTP headers and URLs. 


### How would you evaluate and enforce the compliance and security of applications deployed by using CI/CD workflows?

GitHub Marketplace offers many actions that help evaluate and enforce the compliance and security of applications deployed by using CI/CD workflows. For example, GitHub Action for Azure Policy Compliance Scan allows you to trigger an on-demand scan from your GitHub workflow on one or multiple resources, resource groups or subscriptions, and continue or fail the workflow based on the result of the scan. You can also use this GitHub Action to generate a report on the compliance state of scanned resources for further analysis or archiving.


## Answers to each design question

### Which Azure services would you consider as a replacement for the existing on-premises components of Contoso’s infrastructure?

Contoso can replace their on-premises Azure DevOps Server with Git-based repositories hosted in a GitHub account or an Azure DevOps organization. Both options fully support version control and ALM without the overhead of administering and maintaining the underlying infrastructure. GitHub actions and Azure Pipelines deliver enhanced automation capabilities compared with Jenkins. The services delivered by on-premises Web, API, and SQL Server deployments can be migrated to a wide range of Azure-managed services that provide the equivalent functionality. For example, both web apps and API apps, including the containerized instances, are suitable for deployment to Azure App Service. Azure Container Registry can serve as a replacement for the Docker Registry server to store container images for backend APIs. This, effectively, would allow Contoso to fully transition to the cloud-only model and eliminate its dependency on the leased datacenter space.

### Which GitHub features would you use to implement CI/CD functionality for Contoso?

GitHub simplifies development of collaborative projects through features such as issues, discussions, pull requests, notifications, labels, actions, forks, and projects. While Contoso benefits from all of these features, GitHub Actions is of particular importance in the context of the CI/CD functionality. GitHub actions streamline the software development lifecycle and implement CI/CD workflows. 

Contoso should also consider purchasing GitHub Enterprise Cloud with GitHub Advanced Security and taking advantage of Dependabot functionality. This allows for incorporating code scanning into CI/CD workflows and automatic pull request generation that, once merged into the main branch, automatically upgrade third-party and open-source dependencies to their nonvulnerable versions. 

### How would you minimize the risk of unauthorized use of CI/CD workflows for Contoso?

In order to transition to GitHub-based CI/CID workflows in the most secure manner, Contoso should create an Azure AD tenant and enable multifactor authentication. GitHub Enterprise Cloud supports modern authentication and integrates with Azure AD, including its conditional access and multifactor authentication capabilities. This won't only enhance authentication security but also centralize identity management and resource authorization. Users are able to access GitHub resources such as repositories, issues, and pull requests by using SAML-based single sign-on. With GitHub Enterprise Cloud, Contoso could also implement System for Cross-domain Identity Management (SCIM) to facilitate user provisioning.

In addition, Contoso should make sure that the credentials being used within workflows have the least privileges required and protect access to GitHub repositories. In addition, any security sensitive-artifacts, such as secrets or private keys should be stored outside of version control systems and pipelines in a managed key store, such as Azure Key Vault.

### What managed service could help you standardize the development environment for Contoso's development team?

Contoso should use GitHub Codespaces for both individual and shared development projects. These prebuilt, container-based development environments provide correctly configured IDEs equipped with the latest security scanning extensions. 

### How would you enhance protection of backend APIs that are used by Contoso's web and mobile applications?

Contoso should consider implementing Azure API Management as part of their transition to the cloud-based operational model. With API Management, Contoso is able authenticate incoming requests by relying on such methods as JWT or certificates before authorizing access to their backend APIs. API Management will also allow Contoso to enforce usage quotas and rate limits in order to minimizing the impact of potential DDOS attacks. By creating custom policies, Contoso developers will be able to transform API responses to prevent disclosure of sensitive data.

### What would you recommend to minimize security risks associated with security vulnerabilities introduced into custom code, secrets checked into repositories, and the use of open-source software (OSS) components in Contoso's applications?

A cloud-based DevSecOps implementation helps Contoso with mitigating risks associated with using OSS components. To start, the company should adopt a zero-trust approach to OSS and third-party components. This approach involves repetitive and automated validation of the integrity of these components, including applying all relevant bug fixes and updates. 

Contoso should also use GitHub native code scanning, available by default for all public repositories. By creating a GitHub Enterprise Cloud organization with a GitHub Advanced Security license, Contoso will also be able to extend the scope of code scanning to its private repositories. This allows Contoso developers to automatically detect security vulnerabilities and coding errors in their code, detect secrets such as keys and tokens stored accidentally in public or private repositories, as well as identify any vulnerable dependencies in a pull request before invoking a merge operation.

Contoso will also be able to use the functionality of the Dependabot component of GitHub, which automatically searches for dependencies within repositories and checks them for known vulnerabilities recorded in the GitHub's Advisory Database. In case such dependencies do exist, Dependabot automatically generates pull requests facilitating upgrades to their nonvulnerable versions. 

To enhance these capabilities, Contoso should consider implementing Defender for DevOps, which is part of Microsoft Defender for Cloud. Defender for DevOps offers a centralized console that facilitates protecting applications and resources across multipipeline environments, including GitHub and Azure DevOps. Findings from Defender for DevOps can then be correlated with other contextual cloud security insights to prioritize remediation in code. 

In addition, Contoso would benefit from the functionality offered by Defender for Containers, which provides the ability to scan container images stored in Azure Container Registry, as part of the protections provided within Microsoft Defender for Cloud. Any vulnerabilities detected by the scanner are automatically surfaced by Defender for Cloud. The automatically generated information includes remediation steps, relevant Common Vulnerabilities and Exposures (CVEs) references, and the corresponding Common Vulnerability Scoring System scores (CVSS). 

The scans are triggered automatically whenever an image is pushed to or imported into the registry. In addition, Defender for Containers also scans, on a weekly basis, any image that has been pulled within the last 30 days to identify any newly discovered vulnerabilities. 

Defender for Cloud filters and classifies findings from the scanner. Images without vulnerabilities are marked as healthy and Defender for Cloud doesn't send notifications about healthy images to keep you from getting unwanted informational alerts.


### Which functionality would allow Contoso's developer and operations teams to validate that a new version of an application deployed into the staging environment complies with the security standards, before deploying it into the production environment?

Contoso is able to use a wide range of Azure services that closely integrate with DevOps workflows. That integration is evident when using Azure App Service, which is the most suitable option for Contoso to transition its on-premises web apps to Azure. When deploying web apps and API apps to Azure App Service, Contoso DevOps teams could target a separate deployment slot instead of the default production slot. Deploying applications to a nonproduction slot allows for validating app changes in a staging deployment slot before swapping it with the production slot. In addition, after a swap, the slot with the previously staged app will contain the previous version of the app. This facilitates a rapid failback to address any unexpected functionality, security, or performance-related issues introduced by an app update.

To further enhance this capability, Contoso’s development team should build a workflow that deploys a new version of an application into a staging environment and makes the switch to production contingent on passing a range of validation tasks. To accomplish this, the status of the new version can be evaluated by using tools such as Azure Monitor and Azure Application Insights. It's also possible to make the deployment contingent on complying with an Azure Policy assignment.

## Proposed solution architecture

:::image type="content" source="../media/final-architecture.png" alt-text="Diagram of the initial architecture of Contoso." lightbox="../media/final-architecture.png":::