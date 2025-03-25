## Security Control: Data protection

Data Protection covers control of data protection at rest, in transit, and via authorized access mechanisms, including discover, classify, protect, and monitor sensitive data assets using access control, encryption, key management and certificate management.

### DP-3: Encrypt sensitive data in transit

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 3.10                      | SC-8                        | 3.5, 3.6, 4.1            |

Security principle: Protect the data in transit against 'out of band' attacks (such as traffic capture) using encryption to ensure that attackers can't easily read or modify the data.

Set the network boundary and service scope where data in transit encryption is mandatory inside and outside of the network. While this is optional for traffic on private networks, this is critical for traffic on external and public networks.

Azure guidance: Enforce secure transfer in services such as Azure Storage, where a native data in transit encryption feature is built in.

Enforce HTTPS for web application workloads and services by ensuring that any clients connecting to your Azure resources use transport layer security (TLS) v1.2 or later. For remote management of VMs, use SSH (for Linux) or RDP/TLS (for Windows) instead of an unencrypted protocol.

For remote management of Azure virtual machines, use SSH (for Linux) or RDP/TLS (for Windows) instead of an unencrypted protocol. For secure file transfer, use the SFTP/FTPS service in Azure Storage Blob, App Service apps, and Function apps, instead of using the regular FTP service.

> [!NOTE]
> Data in transit encryption is enabled for all Azure traffic traveling between Azure datacenters. TLS v1.2 or later is enabled on most Azure services by default. And some services such as Azure Storage and Application Gateway can enforce TLS v1.2 or later on the server side.

Azure implementation and additional context:

 -  [Double encryption for Azure data in transit](/azure/security/fundamentals/double-encryption#data-in-transit)
 -  [Understand encryption in transit with Azure](/azure/security/fundamentals/encryption-overview#encryption-of-data-in-transit)
 -  [Information on TLS Security](/security/engineering/solving-tls1-problem)
 -  [Enforce secure transfer in Azure storage](/azure/storage/common/storage-require-secure-transfer?toc=/azure/storage/blobs/toc.json#require-secure-transfer-for-a-new-storage-account)

AWS guidance: Enforce secure transfer in services such as Amazon S3, RDS and CloudFront, where a native data in transit encryption feature is built in.

Enforce HTTPS (such as in AWS Elastic Load Balancer) for workload web application and services (either on the server side or client side, or on both) by ensuring that any clients connecting to your AWS resources use TLS v1.2 or later.

For remote management of EC2 instances, use SSH (for Linux) or RDP/TLS (for Windows) instead of an unencrypted protocol. For secure file transfer, use AWS Transfer SFTP or FTPS service instead of a regular FTP service.

> [!NOTE]
> All network traffic between AWS data centers is transparently encrypted at the physical layer. All traffic within a VPC and between peered VPCs across regions is transparently encrypted at the network layer when using supported Amazon EC2 instance types. TLS v1.2 or later is enabled on most AWS services by default. And some services such as AWS Load Balancer can enforce TLS v1.2 or later on the server side.

AWS implementation and additional context:

 -  [TLS security policies in Elastic Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#tls-security-policies)
 -  [AWS Transfer SFTP and FTPS](https://aws.amazon.com/aws-transfer-family/getting-started/?pg=ln&cp=bn)

GCP guidance: Enforce secure transfer in services such as Google Cloud Storage, where a native data in transit encryption feature is built in.

Enforce HTTPS for web application workloads and services ensuring that any clients connecting to your GCP resources use transport layer security (TLS) v1.2 or later.

For remote management Google Cloud Compute Engine use SSH (for Linux) or RDP/TLS (for Windows) instead of an unencrypted protocol. For secure file transfer, use the SFTP/FTPS service in services such as Google Cloud Big Query or Cloud App Engine instead of a regular FTP service.

GCP implementation and additional context:

 -  [Encryption in transit](https://cloud.google.com/docs/security/encryption-in-transit)
 -  [Encryption in Transit in Google Cloud](https://cloud.google.com/static/docs/security/encryption-in-transit/resources/encryption-in-transit-whitepaper.pdf)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Infrastructure and endpoint security](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint)
 -  [Application Security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Data Security](/azure/cloud-adoption-framework/organize/cloud-security-data-security)

## Security Control: Logging and threat detection

Logging and Threat Detection covers controls for detecting threats on cloud, and enabling, collecting, and storing audit logs for cloud services, including enabling detection, investigation, and remediation processes with controls to generate high-quality alerts with native threat detection in cloud services; it also includes collecting logs with a cloud monitoring service, centralizing security analysis with a SIEM, time synchronization, and log retention.

### LT-4: Enable network logging for security investigation

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 8.2, 8.5, 8.6, 8.7, 13.6  | AU-3, AU-6, AU-12, SI-4     | 10.8                     |

Security principle: Enable logging for your network services to support network-related incident investigations, threat hunting, and security alert generation. The network logs may include logs from network services such as IP filtering, network and application firewall, DNS, flow monitoring and so on.

Azure guidance: Enable and collect network security group (NSG) resource logs, NSG flow logs, Azure Firewall logs, and Web Application Firewall (WAF) logs, and logs from virtual machines via the network traffic data collection agent for security analysis to support incident investigations, and security alert generation. You can send the flow logs to an Azure Monitor Log Analytics workspace and then use Traffic Analytics to provide insights.

Collect DNS query logs to assist in correlating other network data.

Azure implementation and additional context:

 -  [How to enable network security group flow logs](/azure/network-watcher/network-watcher-nsg-flow-logging-portal)
 -  [Azure Firewall logs and metrics](/azure/firewall/logs-and-metrics)
 -  [Azure networking monitoring solutions in Azure Monitor](/azure/azure-monitor/insights/azure-networking-analytics)
 -  [Gather insights about your DNS infrastructure with the DNS Analytics solution](/azure/azure-monitor/insights/dns-analytics)

AWS guidance: Enable and collect network logs such as VPC Flow Logs, WAF Logs, and Route53 Resolver query logs for security analysis to support incident investigations, and security alert generation. The logs can be exported to CloudWatch for monitoring or an S3 storage bucket for ingesting into the Microsoft Sentinel solution for centralized analytics.

AWS implementation and additional context:

 -  [Enabling logging from certain AWS services](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html)

GCP guidance: Most of the network activities logs are available through the VPC Flow Logs which records a sample of network flows send from and received by resources, including instances used as Google Compute VMs, Kubernetes Engine nodes. These logs can be used for network monitoring, forensics, real-time security analysis, and expense optimization.

You can view flow logs in Cloud Logging, and export logs to the destination that Cloud Logging export supports. Flow logs are aggregated by connection from Compute Engine VMs and exported in real time. By subscribing to Pub/Sub, you can analyze flow logs using real-time streaming APIs.

> [!NOTE]
> You can also use Packet Mirroring clones the traffic of specified instances in your Virtual Private Cloud (VPC) network and forwards it for examination. Packet Mirroring captures all traffic and packet data, including payloads and headers.

GCP implementation and additional context:

 -  [Use VPC Flow Logs](https://cloud.google.com/vpc/docs/using-flow-logs)
 -  [VPC audit logging information](https://cloud.google.com/vpc/docs/audit-logging)
 -  [Packet Mirroring](https://cloud.google.com/vpc/docs/packet-mirroring)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security operations](/azure/cloud-adoption-framework/organize/cloud-security-operations-center)
 -  [Infrastructure and endpoint security](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint)
 -  [Application security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
 -  [Threat intelligence](/azure/cloud-adoption-framework/organize/cloud-security-threat-intelligence)

## Security Control: Network security

Network Security covers controls to secure and protect networks, including securing virtual networks, establishing private connections, preventing, and mitigating external attacks, and securing DNS.

### NS-1: Establish network segmentation boundaries

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 3.12, 13.4, 4.4           | AC-4, SC-2, SC-7            | 1.1, 1.2, 1.3            |

Security principle: Ensure that your virtual network deployment aligns to your enterprise segmentation strategy defined in the GS-2 security control. Any workload that could incur higher risk for the organization should be in isolated virtual networks.

Examples of high-risk workload include:

 -  An application storing or processing highly sensitive data.
 -  An external network-facing application accessible by the public or users outside of your organization.
 -  An application using insecure architecture or containing vulnerabilities that can't be easily remediated.

To enhance your enterprise segmentation strategy, restrict or monitor traffic between internal resources using network controls. For specific, well-defined applications (such as a 3-tier app), this can be a highly secure "deny by default, permit by exception" approach by restricting the ports, protocols, source, and destination IPs of the network traffic. If you have many applications and endpoints interacting with each other, blocking traffic may not scale well, and you may only be able to monitor traffic.

Azure guidance: Create a virtual network (VNet) as a fundamental segmentation approach in your Azure network, so resources such as VMs can be deployed into the VNet within a network boundary. To further segment the network, you can create subnets inside VNet for smaller sub-networks.

Use network security groups (NSG) as a network layer control to restrict or monitor traffic by port, protocol, source IP address, or destination IP address. Refer to [NS-7: Simplify network security configuration](/security/benchmark/azure/mcsb-network-security#ns-7-simplify-network-security-configuration) to use Adaptive Network Hardening to recommend NSG hardening rules based on threat intelligence and traffic analysis result.

You can also use application security groups (ASGs) to simplify complex configuration. Instead of defining policy based on explicit IP addresses in network security groups, ASGs enable you to configure network security as a natural extension of an application's structure, allowing you to group virtual machines and define network security policies based on those groups.

Azure implementation and additional context:

 -  [Azure Virtual Network concepts and best practices](/azure/virtual-network/concepts-and-best-practices)
 -  [Add, change, or delete a virtual network subnet](/azure/virtual-network/virtual-network-manage-subnet)
 -  [How to create a network security group with security rules](/azure/virtual-network/tutorial-filter-network-traffic)
 -  [Understand and use application security groups](/azure/virtual-network/network-security-groups-overview#application-security-groups)

AWS guidance: Create a Virtual Private Cloud (VPC) as a fundamental segmentation approach in your AWS network, so resources such as EC2 instances can be deployed into the VPC within a network boundary. To further segment the network, you can create subnets inside VPC for smaller sub-networks.

For EC2 instances, use Security Groups as a stateful firewall to restrict traffic by port, protocol, source IP address, or destination IP address. At the VPC subnet level, use Network Access Control List (NACL) as a stateless firewall to have explicit rules for ingress and egress traffic to the subnet.

> [!NOTE]
> To control VPC traffic, Internet and NAT Gateway should be configured to ensure the traffic from/to the internet are restricted.

AWS implementation and additional context:

 -  [Control traffic to EC2 instances with security groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)
 -  [Compare security groups and network ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Security.html#VPC_Security_Comparison)
 -  [Internet Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)
 -  [NAT Gateway](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)

GCP guidance: Create a virtual private cloud (VPC) network as a fundamental segmentation approach in your GCP network, so resources such as compute engine virtual machine instances (VMs) can be deployed into the VPC network within a network boundary. To further segment the network, you can create subnets inside the VPC for smaller sub-networks.

Use VPC firewall rules as a distributed network layer control to allow or deny connections to or from your targeted instances in the VPC network, which include VMs, Google Kubernetes Engine (GKE) clusters, and App Engine flexible environment instances.

You can also configure VPC firewall rules to target all instances in the VPC network, instances with a matching network tag, or instances that use a specific service account, allowing you to group instances and define network security policies based on those groups.

GCP implementation and additional context:

 -  [Create and manage VPC networks](https://cloud.google.com/vpc/docs/create-modify-vpc-networks)
 -  [Google Cloud VPC Subnets](https://cloud.google.com/vpc/docs/subnets)
 -  [Use VPC firewall rules](https://cloud.google.com/vpc/docs/using-firewalls)
 -  [Add network tags](https://cloud.google.com/vpc/docs/add-remove-network-tags)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Application Security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### NS-2: Secure cloud native services with network controls

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 3.12, 4.4                 | AC-4, SC-2, SC-7            | 1.1, 1.2, 1.3            |

Security principle: Secure cloud services by establishing a private access point for resources. You should also disable or restrict access from public networks when possible.

Azure guidance: Deploy private endpoints for all Azure resources that support the Private Link feature to establish a private access point for the resources. Using Private Link keeps the private connection from routing through the public network.

> [!NOTE]
> Certain Azure services may also allow private communication through the service endpoint feature, though it's recommended to use Azure Private Link for secure and private access to services hosted on Azure platform.

For certain services, you can choose to deploy VNet integration for the service where you can restrict the VNET to establish a private access point for the service.

You also have the option to configure the service native network ACL rules or simply disable public network access to block access from public networks.

For Azure VMs, unless there's a strong use case, you should avoid assigning public IPs/subnet directly to the VM interface and instead use gateway or load balancer services as the front-end for access by the public network.

Azure implementation and additional context:

 -  [Understand Azure Private Link](/azure/private-link/private-link-overview)
 -  [Integrate Azure services with virtual networks for network isolation](/azure/virtual-network/vnet-integration-for-azure-services)

AWS guidance: Deploy VPC PrivateLink for all AWS resources that support the PrivateLink feature, to allow private connection to the supported AWS services or services hosted by other AWS accounts (VPC endpoint services). Using PrivateLink keeps the private connection from routing through the public network.

For certain services, you can choose to deploy the service instance into your own VPC to isolate the traffic.

You also have the option to configure the service native ACL rules to block access from the public network. For example, Amazon S3 allows you to block public access at the bucket or account level.

When assigning IPs to your service resources in your VPC, unless there's a strong use case, you should avoid assigning public IPs/subnet directly to your resources and instead use private IPs/subnet.

AWS implementation and additional context:

 -  [AWS PrivateLink](https://docs.aws.amazon.com/vpc/latest/privatelink/endpoint-service.html)
 -  [Blocking public access to your Amazon S3 storage](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html)

GCP guidance: Deploy VPC Private Google Access implementations for all GCP resources that support it to establish a private access point for the resources. These private access options keep the private connection from routing through the public network. Private Google Access has VM instances that only have internal IP addresses (no external IP addresses)

For certain services, you can choose to deploy the service instance into your own VPC to isolate the traffic. You also have the option to configure the service native ACL rules to block access from the public network. For example, the App Engine firewall allows you to control which network traffic is allowed or rejected when communicating with the App Engine resource. Cloud Storage is another resource where you can enforce public access prevention on individual buckets or at the organization level.

For GCP Compute Engine VMs, unless there's a strong use case, you should avoid assigning public IPs/subnets directly to the VM interface and instead use gateway or load balancer services as the front-end for access by the public network.

GCP implementation and additional context:

 -  [Private Google Access](https://cloud.google.com/vpc/docs/private-google-access)
 -  [Private access options for services](https://cloud.google.com/vpc/docs/private-access-options)
 -  [Understanding the App Engine firewall](https://cloud.google.com/appengine/docs/legacy/standard/java/understanding-firewalls)
 -  [Cloud Storage - use public access prevention](https://cloud.google.com/storage/docs/using-public-access-prevention)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Application Security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### NS-3: Deploy firewall at the edge of enterprise network

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 4.4, 4.8, 13.10           | AC-4, SC-7, CM-7            | 1.1, 1.2, 1.3            |

Security principle: Deploy a firewall to perform advanced filtering on network traffic to and from external networks. You can also use firewalls between internal segments to support a segmentation strategy. If required, use custom routes for your subnet to override the system route when you need to force the network traffic to go through a network appliance for security control purposes.

At a minimum, block known bad IP addresses and high-risk protocols, such as remote management (for example, RDP and SSH) and intranet protocols (for example, SMB and Kerberos).<br>Azure guidance: Use Azure Firewall to provide fully stateful application layer traffic restriction (such as URL filtering) and/or central management over a large number of enterprise segments or spokes (in a hub/spoke topology).

If you have a complex network topology, such as a hub/spoke setup, you may need to create user-defined routes (UDR) to ensure the traffic goes through the desired route. For example, you have the option to use an UDR to redirect egress internet traffic through a specific Azure Firewall or a network virtual appliance.

Azure implementation and additional context:

 -  [How to deploy Azure Firewall](/azure/firewall/tutorial-firewall-deploy-portal)
 -  [Virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview)

AWS guidance: Use AWS Network Firewall to provide fully stateful application layer traffic restriction (such as URL filtering) and/or central management over a large number of enterprise segments or spokes (in a hub/spoke topology).

If you have a complex network topology, such as a hub/spoke setup, you may need to create custom VPC route tables to ensure the traffic goes through the desired route. For example, you have the option to use a custom route to redirect egress internet traffic through a specific AWS Firewall or a network virtual appliance.

AWS implementation and additional context:

 -  [AWS Network Firewall](https://docs.aws.amazon.com/network-firewall/latest/developerguide/what-is-aws-network-firewall.html)
 -  [AWS VPC configure custom route tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html)

GCP guidance: Use Google Cloud Armor security policies to provide Layer 7 filtering and protection of common web attacks. Additionally, use VPC firewall rules to provide distributed, fully stateful network layer traffic restriction, and firewall policies for central management over a large number of enterprise segments or spokes (in a hub/spoke topology).

If you have a complex network topology, such as a hub/spoke setup, create firewall policies that group firewall rules and to be hierarchical so that they may be applied to multiple VPC networks.

GCP implementation and additional context:

 -  [Use VPC firewall rules](https://cloud.google.com/vpc/docs/using-firewalls)
 -  [Firewall policies](https://cloud.google.com/vpc/docs/firewall-policies-overview)
 -  [Google Cloud Armor best practices](https://cloud.google.com/armor/docs/best-practices)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Application Security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### NS-5: Deploy DDOS protection

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 13.10                     | SC-5, SC-7                  | 1.1, 1.2, 1.3, 6.6       |

Security principle: Deploy distributed denial of service (DDoS) protection to protect your network and applications from attacks.

Azure guidance: DDoS Protection Basic is automatically enabled to protect the Azure underlying platform infrastructure (e.g. Azure DNS) and requires no configuration from the users.

For higher levels of protection of your application layer (Layer 7) attacks such as HTTP floods and DNS floods, enable the DDoS standard protection plan on your VNet to protect resources that are exposed to the public networks.

Azure implementation and additional context:

 -  [Manage Azure DDoS Protection Standard using the Azure portal](/azure/virtual-network/manage-ddos-protection)

AWS guidance: AWS Shield Standard is automatically enabled with standard mitigations to protect your workload from common network and transport layer (Layer 3 and 4) DDoS attacks

For higher levels of protection of your applications against application layer (Layer 7) attack such as HTTPS floods and DNS floods, enable AWS Shield Advanced protection on Amazon EC2, Elastic Load Balancing (ELB), Amazon CloudFront, AWS Global Accelerator, and Amazon Route 53.

AWS implementation and additional context:

 -  [AWS Shield Features](https://docs.aws.amazon.com/waf/latest/developerguide/ddos-overview.html)

GCP guidance: Google Cloud Armor offers the following options to help protect systems against DDoS attacks:

 -  Standard network DDoS protection: basic always-on protection for network load balancers, protocol forwarding, or VMs with public IP addresses.
 -  Advanced network DDoS protection: additional protections for Managed Protection Plus subscribers who use network load balancers, protocol forwarding, or VMs with public IP addresses.
 -  Standard network DDoS protection is always enabled. You configure advanced network DDoS protection on a per-region basis.

GCP implementation and additional context:

 -  [Configure advanced network DDoS protection](https://cloud.google.com/armor/docs/advanced-network-ddos)
 -  [Google Cloud Armor overview](https://cloud.google.com/armor/docs/cloud-armor-overview)
 -  [Google Cloud Armor Security policy overview](https://cloud.google.com/armor/docs/security-policy-overview)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Application Security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### NS-6: Deploy web application firewall

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 13.10                     | SC-7                        | 1.1, 1.2, 1.3            |

Security principle: Deploy a web application firewall (WAF) and configure the appropriate rules to protect your web applications and APIs from application-specific attacks.

Azure guidance: Use web application firewall (WAF) capabilities in Azure Application Gateway, Azure Front Door, and Azure Content Delivery Network (CDN) to protect your applications, services and APIs against application layer attacks at the edge of your network.

Set your WAF in "detection" or "prevention mode", depending on your needs and threat landscape.

Choose a built-in ruleset, such as OWASP Top 10 vulnerabilities, and tune it to your application needs.

Azure implementation and additional context:

 -  [How to deploy Azure WAF](/azure/web-application-firewall/overview)

AWS guidance: Use AWS Web Application Firewall (WAF) in Amazon CloudFront distribution, Amazon API Gateway, Application Load Balancer, or AWS AppSync to protect your applications, services and APIs against application layer attacks at the edge of your network.

Use AWS Managed Rules for WAF to deploy built-in baseline groups and customize it to your application needs for the user-case rule groups.

To simplify the WAF rules deployment, you can also use the AWS WAF Security Automations solution to automatically deploy pre-defined AWS WAF rules that filter web-based attacks on your web ACL.

AWS implementation and additional context:

 -  [How AWS WAF works](https://docs.aws.amazon.com/waf/latest/developerguide/how-aws-waf-works.html)
 -  [AWS WAF Security Automations](https://docs.aws.amazon.com/solutions/latest/security-automations-for-aws-waf/solution-overview.html)
 -  [AWS Managed Rules for AWS WAF](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups.html)

GCP guidance: Use Google Cloud Armor to help protect your applications and websites against denial of service and web attacks.

Use Google Cloud Armor out-of-the-box rules based on industry standards to mitigate common web-application vulnerabilities and help provide protection from OWASP Top 10.

Setup your preconfigured WAF rules, each consisting of multiple signatures sourced from ModSecurity Core Rules (CRS). Each signature corresponds to an attack detection rule in the ruleset.

Cloud Armor works in conjunction with external load balancers and protects from distributed denial-of-service (DDoS) and other web-based attacks, whether the applications are deployed on Google Cloud, in a hybrid deployment, or in a multicloud architecture. Security policies can be configured manually, with configurable match conditions, and actions in a security policy. Cloud Armor also features preconfigured security policies, which cover a variety of use cases.

Adaptive Protection in Cloud Armor helps you prevent, detect and protect your application and services from L7 distributed attacks by analyzing patterns of traffic to your backend services, detecting and alerting suspected attacks, and generating suggested WAF rules to mitigate such attacks. These rules can be fine-tuned to meet your needs.

GCP implementation and additional context:

 -  [Google Cloud Armor](https://cloud.google.com/armor)
 -  [Apigee documentation](https://cloud.google.com/apigee/docs)
 -  [Integrating Google Cloud Armor with other Google products](https://cloud.google.com/armor/docs/integrating-cloud-armor)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Application Security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### NS-8: Detect and disable insecure services and protocols

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 4.4, 4.8                  | CM-2, CM-6, CM-7            | 4.1, A2.1, A2.2, A2.3    |

Security principle: Detect and disable insecure services and protocols at the OS, application, or software package layer. Deploy compensating controls if disabling insecure services and protocols aren't possible.

Azure guidance: Use Microsoft Sentinel’s built-in Insecure Protocol Workbook to discover the use of insecure services and protocols such as SSL/TLSv1, SSHv1, SMBv1, LM/NTLMv1, wDigest, weak ciphers in Kerberos, and Unsigned LDAP Binds. Disable insecure services and protocols that don't meet the appropriate security standard.

> [!NOTE]
> If disabling insecure services or protocols isn't possible, use compensating controls such as blocking access to the resources through network security group, Azure Firewall, or Azure Web Application Firewall to reduce the attack surface.

Azure implementation and additional context:

 -  [Azure Sentinel insecure protocols workbook](/azure/sentinel/quickstart-get-visibility#use-built-in-workbooks)

AWS guidance: Enable VPC Flow Logs and use GuardDuty to analyze the VPC Flow Logs to identify the possible insecure services and protocols that don't meet the appropriate security standard.

If the logs in the AWS environment can be forwarded to Microsoft Sentinel, you can also use Microsoft Sentinel's built-in Insecure Protocol Workbook to discover the use of insecure services and protocols

> [!NOTE]
> If disabling insecure services or protocols isn't possible, use compensating controls such as blocking access to the resources through security groups, AWS Network Firewall, AWS Web Application Firewall to reduce the attack surface.

AWS implementation and additional context:

 -  [Use GuardDuty with VPC Flow Logs as the data source](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_data-sources.html#guardduty_vpc)

GCP guidance: Enable VPC Flow Logs and use BigQuery or Security Command Center to analyze the VPC Flow Logs to identify the possible insecure services and protocols that don't meet the appropriate security standard.

If the logs in the GCP environment can be forwarded to Microsoft Sentinel, you can also use the Microsoft Sentinel’s built-in Insecure Protocol Workbook to discover the use of insecure services and protocols. Additional you can forward logs to Google Cloud Chronicle SIEM and SOAR and build custom rules for the same purpose.

> [!NOTE]
> If disabling insecure services or protocols isn't possible, use compensating controls such as blocking access to the resources through VPC Firewall rules and policies, or Cloud Armor to reduce the attack surface.

GCP implementation and additional context:

 -  [Use VPC Flow Logs](https://cloud.google.com/vpc/docs/using-flow-logs)
 -  [Security log analytics in Google Cloud](https://cloud.google.com/architecture/security-log-analytics)
 -  [BigQuery overview](https://cloud.google.com/bigquery/docs/introduction) \- [Security Command Center overview](https://cloud.google.com/security-command-center/docs/concepts-security-command-center-overview)
 -  [Microsoft Sentinel for GCP workloads](/azure/sentinel/connect-google-cloud-platform)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Application Security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)

### NS-9: Connect on-premises or cloud network privately

| **CIS Controls v8 ID(s)** | **NIST SP 800-53 r4 ID(s)** | **PCI-DSS ID(s) v3.2.1** |
| ------------------------- | --------------------------- | ------------------------ |
| 12.7                      | CA-3, AC-17, AC-4           | N/A                      |

Security principle: Use private connections for secure communication between different networks, such as cloud service provider datacenters and on-premises infrastructure in a colocation environment.

Azure guidance: For lightweight site-to-site or point-to-site connectivity, use Azure virtual private network (VPN) to create a secure connection between your on-premises site or end-user device and the Azure virtual network.

For enterprise-level high performance connections, use Azure ExpressRoute (or Virtual WAN) to connect Azure datacenters and on-premises infrastructure in a co-location environment.

When connecting two or more Azure virtual networks together, use virtual network peering. Network traffic between peered virtual networks is private and is kept on the Azure backbone network.

Azure implementation and additional context:

 -  [Azure VPN overview](/azure/vpn-gateway/vpn-gateway-about-vpngateways)
 -  [What are the ExpressRoute connectivity models](/azure/expressroute/expressroute-connectivity-models)
 -  [Virtual network peering](/azure/virtual-network/virtual-network-peering-overview)

AWS guidance: For site-to-site or point-to-site connectivity, use AWS VPN to create a secure connection (when IPsec overhead isn't a concern) between your on-premises site or end-user device to the AWS network.

For enterprise-level high performance connections, use AWS Direct Connect to connect AWS VPCs and resources with your on-premises infrastructure in a co-location environment.

You have the option to use VPC Peering or Transit Gateway to establish connectivity between two or more VPCs within or across regions. Network traffic between peered VPC is private and is kept on the AWS backbone network. When you need to join multiple VPCs to create a large flat subnet, you also have the option to use VPC Sharing.

AWS implementation and additional context:

 -  [AWS Direct Connect introduction](https://docs.aws.amazon.com/directconnect/latest/UserGuide/Welcome.html)
 -  [AWS VPN introduction](https://docs.aws.amazon.com/vpn/)
 -  [Transit Gateway](https://docs.aws.amazon.com/vpc/latest/tgw/what-is-transit-gateway.html)
 -  [Create and accept VPC peering connections](https://docs.aws.amazon.com/vpc/latest/peering/create-vpc-peering-connection.html)
 -  [VPC Sharing](https://docs.aws.amazon.com/whitepapers/latest/building-scalable-secure-multi-vpc-network-infrastructure/amazon-vpc-sharing.html)

GCP guidance: For lightweight site-to-site or point-to-site connectivity use Google Cloud VPN.

For enterprise-level high performance connections, use Google Cloud Interconnect or Partner Interconnect, to connect to Google Cloud VPCs and resources with your on-premises infrastructure in a colocation environment.

You have the option to use VPC Network Peering or Network Connectivity Center to establish connectivity between two or more VPCs within or across regions. Network traffic between peered VPCs is private and is kept on the GCP backbone network. When you need to join multiple VPCs to create a large flat subnet, you also have the option to use Shared VPC

GCP implementation and additional context:

 -  [Cloud VPN overview](https://cloud.google.com/network-connectivity/docs/vpn/concepts/overview)
 -  [Cloud Interconnect, Dedicated Interconnect and Partner Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect#docs)
 -  [Network Connectivity Center overview](https://cloud.google.com/network-connectivity/docs/network-connectivity-center/concepts/overview)
 -  [Private Service Connect](https://cloud.google.com/vpc/docs/private-service-connect)

Customer security stakeholders ([Learn more](/azure/cloud-adoption-framework/organize/cloud-security#security-functions)):

 -  [Security architecture](/azure/cloud-adoption-framework/organize/cloud-security-architecture)
 -  [Posture management](/azure/cloud-adoption-framework/organize/cloud-security-posture-management)
 -  [Application Security and DevOps](/azure/cloud-adoption-framework/organize/cloud-security-application-security-devsecops)
