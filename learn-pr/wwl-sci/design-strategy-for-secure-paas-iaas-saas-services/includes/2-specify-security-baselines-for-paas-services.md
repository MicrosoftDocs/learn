
Let's look at the security advantages of an Azure PaaS deployment versus
on-premises.

Microsoft mitigates common risks and responsibilities starting at the bottom of the stack: the physical infrastructure. Because the Microsoft cloud is continually monitored by Microsoft, it's hard to
attack. It doesn't make sense for an attacker to pursue the Microsoft cloud as a target. Unless the attacker has lots of money and resources, the attacker is likely to move on to another target.

In the middle of the stack, there's no difference between a PaaS
deployment and on-premises. At the application layer and the account and
access management layer, you have similar risks. In the next steps
section of this article, we will guide you to best practices for
eliminating or minimizing these risks.

At the top of the stack, data governance and rights management, you take
on one risk that can be mitigated by key management. (Key management is
covered in best practices.) While key management is an additional
responsibility, you have areas in a PaaS deployment that you no longer
have to manage so you can shift resources to key management.

The Azure platform also provides you strong DDoS protection by using
various network-based technologies. However, all types of network-based
DDoS protection methods have their limits on a per-link and
per-datacenter basis. To help avoid the impact of large DDoS attacks,
you can take advantage of Azure's core cloud capability of enabling you
to quickly and automatically scale out to defend against DDoS attacks.

With PaaS deployments come a shift in your overall approach to security.
You shift from needing to control everything yourself to sharing
responsibility with Microsoft. Another significant difference between
PaaS and traditional on-premises deployments is a new view of what
defines the primary security perimeter. Historically, the primary
on-premises security perimeter was your network, and most on-premises
security designs use the network as its primary security pivot. For PaaS
deployments, you're better served by considering identity to be the
primary security perimeter.

Microsoft Defender for Cloud has security recommendations that are based
on Azure Security Benchmark for all supported PaaS services. The list of
supported PaaS services can be found below:

| Service                                            | Recommendations (Free) | Security alerts | Vulnerability assessment |
|----------------------------------------------------|------------------------|-----------------|--------------------------|
| Azure App Service                                  | X                      | X               | -                        |
| Azure Automation account                           | X                      | -               | -                        |
| Azure Batch account                                | X                      | -               | -                        |
| Azure Blob Storage                                 | X                      | X               | -                        |
| Azure Cache for Redis                              | X                      | -               | -                        |
| Azure Cloud Services                               | X                      | -               | -                        |
| Azure Cognitive Search                             | X                      | -               | -                        |
| Azure Container Registry                           | X                      | X               | X                        |
| Azure Cosmos DB                                    | X                      | X               | -                        |
| Azure Data Lake Analytics                          | X                      | -               | -                        |
| Azure Data Lake Storage                            | X                      | X               | -                        |
| Azure Database for MySQL                           | -                      | X               | -                        |
| Azure Database for PostgreSQL                      | -                      | X               | -                        |
| Azure Event Hubs namespace                         | X                      | -               | -                        |
| Azure Functions app                                | X                      | -               | -                        |
| Azure Key Vault                                    | X                      | X               | -                        |
| Azure Kubernetes Service                           | X                      | X               | -                        |
| Azure Load Balancer                                | X                      | -               | -                        |
| Azure Logic Apps                                   | X                      | -               | -                        |
| Azure SQL Database                                 | X                      | X               | X                        |
| Azure SQL Managed Instance                         | X                      | X               | X                        |
| Azure Service Bus namespace                        | X                      | -               | -                        |
| Azure Service Fabric account                       | X                      | -               | -                        |
| Azure Storage accounts                             | X                      | X               | -                        |
| Azure Stream Analytics                             | X                      | -               | -                        |
| Azure Subscription                                 | X                      | X               | -                        |
| Azure Virtual Network                              | X                      | -               | -                        |
| (incl. subnets, NICs, and network security groups) |                        |                 |                          |

The recommendations column represents the security recommendations that are coming from Azure Security Benchmark and are part of the Defender for Cloud free tier. The security alerts column represents the alerts that are coming from each individual threat detection plan. The vulnerability assessment column represents the services that have this capability available. 

## Security baseline for PaaS

Security baselines for Azure PaaS help you strengthen security through
improved tooling, tracking, and security features. They also provide you
with consistent experience when securing your environment. Security
baselines for Azure focus on cloud-centric control areas. These controls
are consistent with well-known security benchmarks, such as those
described by the Center for Internet Security (CIS). These baselines
provide guidance for the control areas listed in the Azure Security
Benchmark.

Each recommendation includes the following information:

-   **Azure ID**: The Azure Security Benchmark ID that corresponds to the recommendation.
-   **Recommendation**: Following directly after the Azure ID, the recommendation provides a high-level description of the control.
-   **Guidance**: The rationale for the recommendation and links to guidance on how to implement it. If the recommendation is supported by Microsoft Defender for Cloud, that information will also be listed.
-   **Responsibility**: Who is responsible for implementing the control. Possible scenarios are customer responsibility, Microsoft responsibility, or shared responsibility.
-   **Microsoft Defender for Cloud monitoring**: Whether the control is monitored by Microsoft Defender for Cloud, with link to reference.

All recommendations, including recommendations that are not applicable
to this specific service, are included in the baseline to provide you a
complete picture of how the Azure Security Benchmark relates to each
service. There may occasionally be controls that are not applicable for
various reasons---for example, IaaS/compute-centric controls (such as
controls specific to OS configuration management) may not be applicable
to PaaS services.

The PaaS baseline will vary according to the service, so it's important
for you to familiarize yourself with the PaaS service that you want to
protect, and then apply the appropriate baseline. For example, for App
Service, the security baseline establishes security recommendations in
the following areas:

-   Network security
-   Logging and Monitoring
-   Identity and Access Control
-   Data Protection
-   Vulnerability Management
-   Inventory and Asset Management
-   Secure Configuration
-   Data Recovery
-   Incident Response

For more information about App Service security baseline, visit [Azure security baseline for App Service](/security/benchmark/azure/baselines/app-service-security-baseline).

One strategy to The Inventory dashboard in Defender for Cloud allows you to identify all your PaaS resources and verify the open issues. You can create a filter by resource type and see only the PaaS resources that you want to evaluate. 

Once you identify the resource, you can click on it and see open security recommendations.

This list provides the list of recommendations, which are derived from Azure Security Benchmark, organized by priority and showing the current status (healthy or unhealthy).

