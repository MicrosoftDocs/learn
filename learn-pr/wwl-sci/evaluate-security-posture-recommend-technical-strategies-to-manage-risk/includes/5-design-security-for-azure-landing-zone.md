
Azure landing zones are the output of a multi-subscription Azure
environment that accounts for scale, security governance, networking,
and identity. Azure landing zones enable application migration,
modernization, and innovation at enterprise-scale in Azure. These zones
consider all platform resources that are required to support the
customer's application portfolio and don't differentiate between
infrastructure as a service or platform as a service.

![Diagram that shows a landing zone design.](../media/land-zone.png) 

A landing zone is an environment for hosting your workloads,
pre-provisioned through code. Watch the following video to learn more.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4xdvm]

Security, governance, and compliance are key topics when designing and
building an Azure environment. These topics help you start from strong
foundations and ensure that solid ongoing processes and controls are in
place.

The tools and processes you implement for managing environments play an
important role in detecting and responding to issues. These tools work
alongside the controls that help maintain and demonstrate compliance. As
the organization's cloud environment develops, these compliance design
areas will be the focus for iterative refinement. This refinement might
be because of new applications that introduce specific new requirements,
or the business requirements changing. For example, in response to a new
compliance standard.

| Design Area  |      Objective      |  Relevant methodology |
|----------|:-------------:|------:|
| Security |  Implement controls and processes to protect your cloud environments.  | Secure |
| Management |    For stable, ongoing operations in the cloud, a management baseline is required to provide visibility, operations compliance, and protect and recover capabilities.   |   Manage |
| Governance | Automate auditing and enforcement of governance policies.  |    Govern |
| Platform automation and DevOps  | Align the best tools and templates to deploy your landing zones and supporting resources.  |    Ready |

### Design security review

Security is a core consideration for all customers, in every
environment. When designing and implementing an Azure landing zone,
security should be a consideration throughout the process.

The security design area focuses on considerations and recommendations
for landing zone decisions. The Secure methodology in the Cloud Adoption
Framework also provides further in-depth guidance for holistic security
processes and tools. This design area creates a foundation for security
across your Azure, hybrid, and multicloud environments. You can enhance
this foundation later with security guidance outlined in the Cloud
Adoption Framework's Secure methodology.

When it comes to design area review, ensure that you establish the
involved roles and functions, what is in scope and what is out of scope
as per the guidelines below:

-   **Involved roles or functions:** This design area is led by cloud
    security, specifically the security architects within that team. The
    cloud platform and cloud center of excellence are required to review
    networking and identity decisions. The collective roles might be
    required to define and implement the technical requirements coming
    from this exercise. More advanced security guardrails might also
    need support from cloud governance.

-   **Scope:** The goal of this exercise is to understand security
    requirements and implement them consistently across all workloads in
    your cloud platform. The primary scope of this exercise focuses on
    security operations tooling and access control. This scope includes
    zero trust and advanced network security.

-   **Out of scope:** This exercise focuses on the foundation for a
    modern security operations center in the cloud. To streamline the
    conversation, this exercise doesn't address some of the disciplines
    in the CAF Secure methodology. Security operations, asset
    protection, and innovation security will build on your Azure landing
    zone deployment. However, they're out of scope for this design area
    discussion.

### Security design considerations

An organization must have visibility into what's happening within their technical cloud estate. Security monitoring and audit logging of Azure platform services is a key component of a scalable framework. When it comes to security operations design, make sure to review the following guidelines:   

* **Security alerts**:
    - Which teams require notifications for security alerts? 
    - Are there groups of services that alerts require routing to different teams? 
    - Business requirements for real-time monitoring and alerting. 
    - Security information and event management integration with Microsoft Defender for Cloud and Microsoft Sentinel.
* **Security logs**:
    - Data retention periods for audit data. Azure Active Directory (Azure AD) Premium reports have a 30-day retention period. 
    - Long-term archiving of logs like Azure activity logs, virtual machine (VM) logs, and platform as a service (PaaS) logs. 
* **Security controls**:
    - Baseline security configuration via Azure in-guest VM policy. 
    - Consider how your security controls will align with governance guardrails. 
* **Vulnerability management**:
    - Emergency patching for critical vulnerabilities. 
    - Patching for VMs that are offline for extended periods of time. 
    - Vulnerability assessment of VMs. 
* **Shared responsibility**:
    - Where are the handoffs for team responsibilities? These responsibilities need consideration when monitoring or responding to security events. 
    - Consider the guidance in the Secure methodology for security operations. 
* **Encryption and keys**:
    - Who requires access to keys in the environment? 
    - Who will be responsible for managing the keys? 

### Security in the Azure landing zone accelerator

Security is at the core of the Azure landing zone accelerator. As part
of the implementation, many tools and controls are deployed to help
organizations quickly achieve a security baseline.

For example, the following are included:

Tools:

-   Microsoft Defender for Cloud, standard or free tier

-   Microsoft Sentinel

-   Azure DDoS standard protection plan (optional)

-   Azure Firewall

-   Web Application Firewall (WAF)

-   Privileged Identity Management (PIM)

Policies for online and corporate-connected landing zones:

-   Enforce secure access, like HTTPS, to storage accounts

-   Enforce auditing for Azure SQL Database

-   Enforce encryption for Azure SQL Database

-   Prevent IP forwarding

-   Prevent inbound RDP from internet

-   Ensure subnets are associated with NSG

