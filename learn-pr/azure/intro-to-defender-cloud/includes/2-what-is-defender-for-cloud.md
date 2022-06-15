Cybersecurity is an ever growing concern for all business with an online presence. Taking advantage of multicloud environments and the benefits they offer will also often open your business, its data and customers to even more risk. Every business with an online presence needs to ensure its security properly enabled and protect its workloads running in Azure and hybrid environments.

Let's start with a few definitions and a quick tour of the core features of Defender for Cloud. This overview should help you see whether Defender for Cloud might be a good fit for you.

## What is Defender for Cloud?

Defender for Cloud is a security software product that protects and secures your hybrid cloud environments in Azure, AWS, GCP, on-premises and other clouds.

Defender for Cloud provides you with recommendations on how to improve your security posture via a Secure Score.

The Secure Score is percentage based score that informs you of your security posture. The higher your Secure Score is, the more secure your environment is. You can increase your Secure Score by remediating recommendations associated with your environments.

When you remediate recommendations, your environments are hardened, which in turn improves your security posture across Azure, AWS and GCP.  

Defender for Cloud allows you to secure your resources in your cloud environments through the many Microsoft defender plan;

| Plan name | Description |
|--|--|
| Defender for Servers | Adds threat detection and advanced defenses to your Windows and Linux machines whether they're running in Azure, AWS, GCP, and on-premises environment. |
| Defender for Storage | Adds an Azure-native layer of security intelligence that detects unusual and potentially harmful attempts to access or exploit your storage accounts. |
| Defender for SQL | Includes functions that can be used to discover and mitigate potential database vulnerabilities. Defender for SQL can also detect anomalous activities that may be an indication of a threat to your databases. |
| Defender for Containers | Cloud-native solution for securing your containers so you can improve, monitor, and maintain the security of your clusters, containers, and their applications. |
| Defender for App Service | Identifies attacks that target applications running over App Service. |
| Defender for Key Vault | Detects unusual and potentially harmful attempts to access or exploit Key Vault accounts. |
| Defender for Resource Manager |  Automatically monitors the resource management operations in your organization, whether they're performed through the Azure portal, Azure REST APIs, Azure CLI, or other Azure programmatic clients. |
| Defender for DNS | Detects suspicious and anomalous activities such as data exfiltration, malware, DNS attacks and communication with domains that are used for malicious activities (for example phishing and crypto mining).  |
| Defender for open-source relational databases | Provides threat protections for the following open-source relational databases: <br> - Azure Database for PostgreSQL <br> - Azure Database for MySQL <br> - Azure Database for MariaDB |
| Defender for Azure Cosmos DB | Detects potential SQL injections, known bad actors based on Microsoft Threat Intelligence, suspicious access patterns, and potential exploitation of your database through compromised identities, or malicious insiders. |

All of these plans are integrated into the Defender for Cloud service and each provide their own levels of protection to your multicloud environment.

## How to protect Contoso's new e-commerce website

When Contoso develops its e-commerce website in order to sell its clothes, it will need to provide protection for its SQL databases and its servers. When you enable both Defender for SQL and Defender for Servers, Microsoft Defender for Cloud will allow Contoso to view its dashboard in the Azure portal to monitor and configure protections and monitor their workloads.

Microsoft Defender for Cloud uses Threat Detections to determine if there are any suspicious activities that have occurred on your resources, and then creates alerts in Microsoft Defender for Cloud.

These alerts contain the metadata of what resources were affected and what occurred. Each alert also contains a Take Action section, which will guide you on how to remediate the alert and to ensure it doesn’t happen again.

The Servers plan will also provide protections through alerts meant to alert or automatically protect from threats, such as brute-force attacks that are attempts to gain access to your servers by guessing usernames passwords in rapid succession until a combination works.  

## Key terms

Some key terms you should know include:

- **SOC** - Security Operations Center - is an individual or team that deals with security issues on an organizational and technical level.
- **Secure Score** - is percentage based score provided by Defender for Cloud that informs you of your security posture. The higher your Secure Score is, the more secure your environment is.
- **Hybrid workloads** - Includes workloads that may be contained on Azure, AWS, GCP or on-premises.
- **Regulatory compliance standards** - For example, NIST, PCI-DSS, ISO, HIPAA – government regulations that different industries are required to meet.
- **CSPM** - Cloud Security Posture Management - a system by which organizations can identify and remediate misconfigurations, threats, misuse and compliance violations across a multicloud infrastructure.
- **CWP** - Cloud Workload Protection - The process by which cloud based workloads are kept secure.
- **Security posture** - Is a combination of your visibility into your asset environment and attack surface, along with your ability to detect, contain, mitigate, protect and react to security threats.
