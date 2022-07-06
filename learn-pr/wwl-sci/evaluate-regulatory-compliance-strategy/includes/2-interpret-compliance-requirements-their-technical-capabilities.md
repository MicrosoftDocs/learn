
Cloud governance is the product of an ongoing adoption effort over time, as a true lasting transformation doesn't happen overnight. It becomes critical to evaluate risk tolerance to inform minimally invasive policies that govern cloud adoption and manage risks. In some industries, third-party compliance affects initial policy creation.

Regulatory organizations frequently publish standards and updates to help define good security practices so that organizations can avoid negligence. The purpose and scope of these standards, and regulations vary. The security requirements, however, can influence the design for data protection and retention, network access, and system security.

## Establish a compliance strategy

Once the business risks are mapped and converted into decisions to policy statements, the cybersecurity architect will be able to establish the regulatory compliance strategy. This strategy also takes into consideration the industry in which the organization belongs or the type of transactions that the organization performs. A good compliance strategy needs to ensure that security controls are implemented to directly map regulatory compliance requirements, that's why is important to have full visibility of the type of business, transactions, and overall business requirements before establishing a regulatory compliance strategy. 

Noncompliance can lead to fines or other business impact. Work with your regulators and carefully review the standard to understand both the intent and the literal wording of each requirement. Here are some questions that may help you understand each requirement.

- How is compliance measured?
- Who approves if the workload meets the requirements?
- Are there processes for obtaining attestations?
- What are the documentation requirements?

In traditional governance and incremental governance, corporate policy creates the working definition of governance. Most IT governance actions seek to implement technology to monitor, enforce, operate, and automate those corporate policies. Cloud governance is built on similar concepts.

:::image type="content" source="../media/define-corporate-policy.png" alt-text="Diagram showing corporate governance and governance disciplines.":::

The image above demonstrates the interactions between business risk, policy and compliance, and monitoring and enforcement to create a governance strategy. During the corporate policy definition you'll need to first evaluate the business risk, which includes the investigation of current cloud adoption plans and data classification. In this phase you'll work with the business to balance risk tolerance and mitigation costs.

Once you establish the business risk, you'll evaluate risk tolerance to inform minimally invasive policies that govern cloud adoption and manage risks. Keep in mind that in some industries, third-party compliance affects initial policy creation. The final stage is comprised by the pace of adoption and innovation activities that will naturally create policy violations. Executing relevant processes will aid in monitoring and enforcing adherence to policies.

After defining your corporate policy strategy, which includes regulatory compliance requirements, you'll need to ensure that you have proper governance in place to stay compliant over time as new workloads are provisioned. You can use the five disciplines of cloud governance shown in the diagram as the main pillars for your cloud governance strategy.

## Compliance considerations

Organizations may need to be compliant with one or more industry standards. Compliance is based on various types of assurances, including formal certifications, attestations, validations, authorizations, and assessments produced by independent third-party auditing firms, as well as contractual amendments, self-assessments, and customer guidance documents.

Compliance can also be distinguished according to the type of risk, regulatory or operational. According to Federal US regulators, **operational risk** is the failure to establish a system of internal controls and an independent assurance function and exposes the organization to the risk of signification fraud, defalcation, and other operational losses. While **compliance risk** is the risk of legal or regulatory sanctions, financial loss, or damage to reputation resulting from failure to comply with laws, regulations, rules, other regulatory requirements, or codes of conduct. When planning your compliance strategy, you should take into consideration operational compliance that will support your regulatory compliance.

If your organization uses vendors or other trusted business partners, one of the biggest business risks to consider may be a lack of adherence to **regulatory compliance** by these external organizations. This risk often can't be remediated, and instead may require a strict adherence to requirements by all parties. Make sure you've identified and understand any third-party compliance requirements before beginning a policy review.

Improving **operational compliance** reduces the likelihood of an outage related to configuration drift or vulnerabilities related to systems being improperly patched. The following table gives some examples of operational compliance processes along with the tools that can perform them and their purpose.

| Process         | Tool     | Purpose |
|--------------|-----------|------------|
| Patch Management | Azure Automation Update Management      | Management and scheduling of updates         |
| Policy enforcement       | Azure Policy   | Policy enforcement to ensure environment and guest compliance       |
| Environment configuration  | Azure Blueprints       | Automated compliance for core services         |
| Resource configuration        | Desired State Configuration    | Automated configuration on guest OS and some aspects of the environment       |

The compliance requirements that an organization must follow will vary according to the organization's industry and type of service. Consider a health organization, which could be a doctors' offices, hospitals, health insurers, and other healthcare companies - that create, receive, maintain, transmit, or access protected health information (PHI) - this organization will need to be compliant with the Health Insurance Portability and Accountability Act of 1996 (HIPAA). The regulations issued under HIPAA are a set of US healthcare laws that, among other provisions, establish requirements for the use, disclosure, and safeguarding of PHI. Azure Policy Regulatory Compliance built-in initiative definition maps to compliance domains and controls in HIPAA HITRUST 9.2.

Azure Policy Regulatory Compliance built-in initiative definition maps to compliance domains and controls in Azure Security Benchmark. Each control is associated with one or more Azure Policy definitions. These policies may help you assess compliance with the control; however, there often isn't a one-to-one or complete match between a control and one or more policies. As such, Compliant in Azure Policy refers only to the policy definitions themselves; this doesn't ensure you're fully compliant with all requirements of a control. In addition, the compliance standard includes controls that aren't addressed by any Azure Policy definitions at this time. Therefore, compliance in Azure Policy is only a partial view of your overall compliance status. The associations between compliance domains, controls, and Azure Policy definitions for this compliance standard may change over time.

By default, every subscription has the Azure Security Benchmark assigned. This is the Microsoft-authored, Azure-specific guidelines for security and compliance best practices based on common compliance frameworks. Learn more about Azure Security Benchmark. Available regulatory standards:

- PCI-DSS v3.2.1:2018
- SOC TSP
- NIST SP 800-53 R4
- NIST SP 800 171 R2
- UK OFFICIAL and UK NHS
- Canada Federal PBMM
- Azure CIS 1.1.0
- HIPAA/HITRUST
- SWIFT CSP CSCF v2020
- ISO 27001:2013
- New Zealand ISM Restricted
- CMMC Level 3
- Azure CIS 1.3.0
- NIST SP 800-53 R5
- FedRAMP H
- FedRAMP M
