Security monitoring and governance form the foundation of secure DevOps practices, ensuring that development pipelines, cloud resources, and identity systems remain protected against evolving threats. As organizations adopt DevOps methodologies and migrate workloads to Azure, comprehensive security visibility and governance enforcement become critical for maintaining compliance, detecting threats, and preventing security incidents.

Modern DevSecOps requires integrating security throughout the development lifecycle rather than treating it as a final gate. **Microsoft Defender for Cloud** provides unified security management and advanced threat protection across Azure resources, hybrid environments, and multicloud deployments. **Azure Policy** enables governance at scale through policy-as-code, ensuring consistent compliance across subscriptions and resource groups. **Microsoft Defender for Identity** detects identity-based threats and suspicious activities targeting user accounts and privileged access. **GitHub Advanced Security** extends security capabilities directly into the development workflow with code scanning, secret detection, and dependency vulnerability management.

This module explores the tools, techniques, and best practices for implementing comprehensive security monitoring and governance in Azure DevOps environments.

## Example scenario

Contoso Financial Services operates a cloud-native banking platform built on Azure with development teams using Azure DevOps and GitHub for version control and CI/CD automation. The organization faces several security challenges:

**Pipeline security gaps:** Development teams deploy code through Azure Pipelines, but lack consistent security scanning, secrets management, and access controls across pipeline definitions.

**Cloud security posture:** With hundreds of Azure resources across multiple subscriptions, the security team struggles to maintain visibility into misconfigurations, vulnerabilities, and compliance violations. Resources are deployed without consistent security baselines, creating compliance risks.

**Governance enforcement:** Different teams apply inconsistent security configurations, use prohibited resource types, and deploy resources to non-compliant regions. Manual governance processes cannot scale with the rapid pace of cloud resource provisioning.

**Identity threats:** The organization has experienced several phishing attempts and suspicious login activities but lacks automated detection capabilities for identity-based attacks. Privileged accounts require additional monitoring and protection.

**Development workflow security:** Developers occasionally commit secrets and API keys to repositories, and vulnerable dependencies make it into production code. Security reviews happen too late in the development lifecycle, creating friction and delays.

Contoso needs a comprehensive security monitoring and governance solution that:

- **Secures pipelines:** Implements consistent security controls across all CI/CD pipelines.
- **Monitors cloud posture:** Provides continuous security assessment and threat detection for Azure resources.
- **Enforces governance:** Automates compliance enforcement through policy-as-code.
- **Protects identities:** Detects and responds to identity-based threats targeting user accounts.
- **Shifts security left:** Integrates security scanning directly into development workflows.

## What you'll learn

This module provides comprehensive coverage of security monitoring and governance tools and practices for Azure DevOps environments.

**Pipeline security fundamentals:** Learn essential security practices for Azure Pipelines including secrets management with Azure Key Vault, service connection security, pipeline permissions, secure variables, and agent security. Understand how to implement least-privilege access, audit logging, and branch protection policies.

**Microsoft Defender for Cloud:** Explore Azure's unified security management platform providing security posture management, threat protection, and compliance monitoring. Learn to configure Defender for Cloud, interpret security recommendations, remediate vulnerabilities, and respond to security alerts across Azure, hybrid, and multicloud environments.

**Microsoft Defender for Cloud use cases:** Examine real-world scenarios including regulatory compliance monitoring, threat detection and response, secure score improvement, workload protection for VMs, containers, databases, and storage, vulnerability assessment, and integration with Azure DevOps for DevSecOps workflows.

**Azure Policy foundations:** Understand Azure Policy's role in governance enforcement through policy-as-code. Learn policy structure, effects (deny, audit, modify, deployIfNotExists), evaluation flow, and assignment scopes. Explore how policies enforce security baselines, compliance requirements, and organizational standards.

**Policy authoring and management:** Learn to create custom policies for organization-specific requirements, test policies in audit mode, assign policies at management group, subscription, and resource group scopes, configure policy parameters, and manage policy exemptions. Understand policy inheritance and precedence rules.

**Policy initiatives (definitions):** Explore how initiatives bundle multiple policies into logical compliance frameworks. Learn to create custom initiatives, assign built-in initiatives like Azure Security Benchmark, and monitor compliance across large Azure estates through initiative assignment and reporting.

**Resource locks:** Understand how resource locks prevent accidental deletion or modification of critical Azure resources. Learn to implement CanNotDelete and ReadOnly locks, manage lock inheritance, and balance governance with operational flexibility.

**Microsoft Defender for Identity:** Learn to deploy and configure Defender for Identity for identity threat detection. Understand suspicious activity detection including credential theft, lateral movement, domain dominance attacks, and compromised user investigation. Explore integration with Microsoft Defender XDR for unified security operations.

**GitHub Advanced Security and Microsoft Defender integration:** Learn to integrate GitHub Advanced Security with Microsoft Defender for Cloud, enabling unified security visibility across development and cloud operations. Understand how code scanning, secret scanning, and dependency scanning findings surface in Defender for Cloud dashboards.

**Configuring GitHub Advanced Security:** Explore detailed configuration of GitHub Advanced Security features including enabling code scanning with CodeQL, configuring secret scanning patterns, implementing dependency scanning with Dependabot, managing security policies, and integrating security checks into pull request workflows.

## Learning objectives

After completing this module, you'll be able to:

- **Implement pipeline security best practices:** Secure Azure Pipelines with secrets management, service connection security, least-privilege access, and audit logging.
- **Configure Microsoft Defender for Cloud:** Enable threat protection, configure security policies, interpret security recommendations, and respond to security alerts.
- **Create and manage Azure policies:** Author custom policies, assign policies at appropriate scopes, configure policy parameters, and monitor compliance.
- **Understand policy initiatives and resource locks:** Implement policy initiatives for compliance frameworks and protect critical resources with locks.
- **Deploy Microsoft Defender for Identity:** Configure identity threat detection, investigate suspicious activities, and integrate with Microsoft Defender XDR.
- **Integrate GitHub Advanced Security with Microsoft Defender:** Connect GitHub security findings to Defender for Cloud for unified security visibility.
- **Configure GitHub Advanced Security:** Enable and configure code scanning, secret scanning, dependency scanning, and security policy enforcement.

## Prerequisites

To get the most from this module, you should have:

- **DevOps fundamentals:** Understanding of DevOps principles, CI/CD concepts, and software development lifecycle practices.
- **Azure experience:** Familiarity with Azure portal navigation, resource groups, subscriptions, and basic Azure resource management.
- **Azure DevOps knowledge:** Experience creating and running Azure Pipelines, managing repositories, and using service connections.
- **Security awareness:** Basic understanding of security concepts including authentication, authorization, encryption, and security best practices.
- **GitHub familiarity:** Experience with GitHub repositories, pull requests, and GitHub Actions workflows is beneficial for GitHub Advanced Security content.
- **Identity concepts:** Understanding of Active Directory, Microsoft Entra ID (formerly Azure AD), user accounts, groups, and role-based access control.

Organizations implementing comprehensive security monitoring and governance establish foundations for secure, compliant, and resilient DevOps practices that protect development pipelines, cloud resources, and identity systems against evolving threats.
