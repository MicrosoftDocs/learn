Here, you can learn how to decide whether Azure Service Fabric is the right choice for you.

You saw earlier that there are several features that enhance the Azure Service Fabric offering. Each of these features can be a compelling factor in your decision to use Service Fabric.

| Feature | Consideration |
| --- | --- |
| **Support for stateful and stateless microservices** | Does your solution require stateful services? You can use the Service Fabric programming model or run containerized stateful services written in any language. |
| **Identity and security management** | Do you already use existing Azure resources and make use of Microsoft Entra ID? You can configure a Service Fabric cluster to integrate with Microsoft Entra ID and reuse existing identities and group membership. |
| **Integrated logging and monitoring** | Service Fabric can easily integrate with Azure Monitor to monitor the health of both containers and cluster infrastructure. |
| **Automatic cluster node scaling** | Deciding when to scale up or down in large containerization environment is tricky. Service Fabric supports automatic scaling for your services and your clusters. You can scale clusters horizontally (adding or removing nodes) or vertically (assigning more or fewer resources to existing nodes). |
| **Cluster node upgrades** | Do you want to reduce the number of cluster management tasks? Service Fabric offers automatic cluster upgrading and wave deployment to minimize disruption to your services. |
| **Storage volume support** | Is your application stateful, and does it require persisted storage? Service Fabric supports both static and dynamic storage volumes. |
| **Integrated with CI/CD tools** | Do you already use existing Azure resources and make use of Azure Pipelines? You can configure a Service Fabric cluster to integrate with your CI/CD solution. |
| **Azure, on-premises, and public cloud compatibility** | Are you interested in the features of Service Fabric but concerned about migrating your solution to Azure? You can bring Service Fabric on-premises in Windows or Linux. You can also integrate Service Fabric into other cloud platforms, including AWS. |

All the above features are configurable either when you create the cluster or after deployment.
