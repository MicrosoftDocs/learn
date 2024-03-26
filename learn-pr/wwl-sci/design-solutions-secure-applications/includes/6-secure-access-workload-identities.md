A workload identity is an identity used by a software workload (such as an application, service, script, or container) to authenticate and access other services and resources. The terminology is inconsistent across the industry, but generally a workload identity is something you need for your software entity to authenticate with some system. For example, a workload identity could be a user account that your client authenticates as to access a MongoDB database. A workload identity could also be an AWS service role attached to an EC2 instance with read-only access to an Amazon S3 bucket.

In Microsoft Entra ID, workload identities are applications, service principals, and managed identities.

An [application](/azure/active-directory/develop/app-objects-and-service-principals#application-object) is an abstract entity, or template, defined by its application object. The application object is the _global_ representation of your application for use across all tenants. The application object describes how tokens are issued, the resources the application needs to access, and the actions that the application can take.

A [service principal](/azure/active-directory/develop/app-objects-and-service-principals#service-principal-object) is the _local_ representation, or application instance, of a global application object in a specific tenant. An application object is used as a template to create a service principal object in every tenant where the application is used. The service principal object defines what the app can actually do in a specific tenant, who can access the app, and what resources the app can access.

A [managed identity](/azure/active-directory/managed-identities-azure-resources/overview) is a special type of service principal that eliminates the need for developers to manage credentials.

Here are some ways that workload identities in Microsoft Entra ID are used:

-   An app that enables a web app to access Microsoft Graph based on admin or user consent. This access could be either on behalf of the user or on behalf of the application.
-   A managed identity used by a developer to provision their service with access to an Azure resource such as Azure Key Vault or Azure Storage.
-   A service principal used by a developer to enable a CI/CD pipeline to deploy a web app from GitHub to Azure App Service.


<!--
[](/azure/active-directory/develop/workload-identities-overview#workload-identities-other-machine-identities-and-human-identities)
-->
## Workload identities, other machine identities, and human identities

At a high level, there are two types of identities: human and machine/non-human identities. Workload identities and device identities together make up a group called machine (or non-human) identities. Workload identities represent software workloads while device identities represent devices such as desktop computers, mobile, IoT sensors, and IoT managed devices. Machine identities are distinct from human identities, which represent people such as employees (internal workers and front line workers) and external users (customers, consultants, vendors, and partners).

:::image type="content" source="../media/identity-types.svg" alt-text="Diagram that shows different types of machine and human identities." border="true" lightbox="../media/identity-types.svg":::

<!--
[](/azure/active-directory/develop/workload-identities-overview#supported-scenarios)
-->

## Supported scenarios

Here are some ways you can use workload identities:

-   Access Microsoft Entra ID protected resources without needing to manage secrets for workloads that run on Azure using [managed identity](/azure/active-directory/managed-identities-azure-resources/overview).
-   Access Microsoft Entra ID protected resources without needing to manage secrets for supported scenarios such as GitHub Actions, workloads running on Kubernetes, or workloads running in compute platforms outside of Azure using [workload identity federation](/azure/active-directory/develop/workload-identity-federation).
-   Review service principals and applications that are assigned to privileged directory roles in Microsoft Entra ID using [access reviews for service principals](/azure/active-directory/privileged-identity-management/pim-create-azure-ad-roles-and-resource-roles-review).
-   Apply Conditional Access policies to service principals owned by your organization using [Conditional Access for workload identities](/azure/active-directory/conditional-access/workload-identity), and [Continuous access evaluation for workload identities](/azure/active-directory/conditional-access/concept-continuous-access-evaluation-workload).
-   Secure workload identities with [Identity Protection](/azure/active-directory/identity-protection/concept-workload-identity-risk).
