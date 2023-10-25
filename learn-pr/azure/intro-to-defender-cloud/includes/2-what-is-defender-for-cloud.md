Cybersecurity is a growing concern for businesses with an online presence. Taking advantage of multicloud environments and the benefits they offer opens your business, data, and customers to cyber threats. Every business with an online presence needs to ensure it has the proper security in place and protect its workloads running in Azure and hybrid environments.

Let's start with a few definitions and a quick tour of the core features of Microsoft Defender for Cloud. This overview should help you see whether Defender for Cloud might be a good fit for you.

## Protect your environments with Defender for Cloud

Defender for Cloud is a security software product that protects and secures your hybrid cloud environments in Azure, AWS, GCP, on-premises.

Defender for Cloud provides you with recommendations on how to improve your security posture via a Secure Score.

The Secure Score is a percentage-based KPI that informs you of your environment's security posture. Your environment is more secure the higher your Secure Score is. The Secure Score is made up of several controls that contain recommendations. You can increase your Secure Score by remediating all of the recommendations in the controls associated with your environments.

When you remediate recommendations, your environments are hardened, which in turn improves your security posture across Azure, AWS and GCP.  

Defender for Cloud allows you to secure your resources in your cloud environments through the many Defender plans.

| Plan name | Description |
|--|--|
| Defender for Servers | Provides threat detection and advanced defenses to your Windows and Linux machines whether they're running in Azure, AWS, GCP, and on-premises environment. |
| Defender for Storage | Detects unusual and potentially harmful attempts to access or exploit your storage accounts. |
| Defender for SQL | Discovers and mitigates potential database vulnerabilities. It also detects anomalous activities that might be an indication of a threat to your databases. |
| Defender for Containers | Continuously assesses clusters and provides visibility into misconfigurations and guidelines to help mitigate identified threats. It also provides vulnerability assessment and management tools for images stored in ACR registries. It generates security alerts for suspicious activities for clusters and Linux nodes. |
| Defender for App Service | Identifies attacks that target applications running over App Service. |
| Defender for Key Vault | Detects unusual and potentially harmful attempts to access or exploit Key Vault data. |
| Defender for Resource Manager |  Monitors the resource management operations in your organization, whether they're performed through the Azure portal, Azure REST APIs, Azure CLI, or other Azure programmatic clients. |
| Defender for DNS | Detects suspicious and anomalous activities such as data exfiltration, malware, DNS attacks and communication with domains that are used for malicious activities (for example phishing and crypto mining).  |
| Defender for open-source relational databases | Provides threat protections for the following open-source relational databases: <br> - Azure Database for PostgreSQL <br> - Azure Database for MySQL <br> - Azure Database for MariaDB |
| Defender for Azure Cosmos DB | Detects potential SQL injections, known bad actors based on Microsoft Threat Intelligence, suspicious access patterns, and potential exploitation of your database through compromised identities or malicious insiders. |

All of these plans are integrated into the Defender for Cloud service and each provides their own levels of protection to your multicloud environment.

## How to protect Contoso's new e-commerce website

When Contoso develops its e-commerce website in order to sell clothes, it needs to provide protection for its SQL databases and servers, among the other components. When you enable both the Defender for SQL plan and the Defender for Servers plan, Contoso can use the Defender for Cloud dashboard, to monitor and configure protections and their workloads.

Defender for Cloud uses threat detection to determine if there are any suspicious activities that have occurred on your resources. Based on the results, Defender for Cloud creates alerts and recommendations.

Alerts contain metadata that tell you which resources were affected and what occurred. Each alert also contains a Take Action section, which guides you with remediation steps for the alert.

The Servers plan also provides protections with alerts that are meant to protect your environments from threats, such as brute-force attacks. Brute-force attacks attempt to gain access to your servers by guessing usernames and passwords in rapid succession until a combination works.  

## Key terms

Some key terms you should know include:

- **SOC** - Security Operations Center - Is an individual or team that deals with security issues on an organizational and technical level.
- **Secure Score** - Is a percentage-based KPI that informs you of your environment's security posture. Your environment is more secure the higher your Secure Score is. 
- **Hybrid workloads** - Includes workloads that are contained in a cloud environment and on-premises.
- **Regulatory compliance standards** - government regulations that different industries are required to meet. For example, NIST, PCI-DSS, ISO, HIPAA.
- **CSPM** - Cloud Security Posture Management - a system by which organizations can identify and remediate misconfigurations, threats, misuse and compliance violations across an organization's infrastructure.
- **CWP** - Cloud Workload Protection - The process by which cloud based workloads are kept secure.
- **Security posture** - Is a combination of your visibility into your asset environment and attack surface, along with your ability to detect, contain, mitigate, protect and react to security threats.
