Organizations today operate infrastructure across on-premises datacenters, multiple public clouds, and edge locations. This distributed architecture creates a complex security challenge: how do you maintain consistent visibility into security risks and enforce unified security policies when your workloads span Azure, AWS, Google Cloud, and private infrastructure?

Security posture management addresses this challenge by providing continuous assessment of your security configuration, identification of vulnerabilities, and prioritized recommendations for improvement. As a security architect, you need to design solutions that deliver unified posture management across your entire digital estate, regardless of where workloads run.

## The challenge of hybrid and multicloud security

Traditional security approaches treat each environment as a separate domain with its own tools and processes. This fragmented approach creates several problems:

- **Visibility gaps** - Security teams can't see the complete picture when data is scattered across multiple dashboards and tools.
- **Inconsistent policies** - Different security standards in each environment create compliance risks and operational complexity.
- **Slow response times** - Without unified visibility, identifying and remediating risks takes longer.
- **Increased attack surface** - Misconfigurations in any environment can expose the entire organization.

Microsoft addresses these challenges through an integrated set of security posture management capabilities centered on Microsoft Defender for Cloud, Azure Arc, and Microsoft Security Exposure Management.

## What you'll learn in this module

This module guides you through designing security posture management solutions for hybrid and multicloud environments. You'll explore:

- **Security benchmarks and standards** - How to evaluate your security posture against Microsoft Cloud Security Benchmark (MCSB) and map controls to regulatory requirements.
- **Integrated posture management** - How to design solutions that combine Cloud Security Posture Management (CSPM) and Cloud Workload Protection (CWP) capabilities.
- **Defender for Cloud evaluation** - How to assess security posture using Defender for Cloud's secure score and security recommendations.
- **Workload protection design** - How to design protection for specific workload types including servers, containers, databases, and storage.
- **Hybrid and multicloud integration** - How to extend security posture management to non-Azure environments using Azure Arc.
- **External attack surface management** - How to design solutions that discover and monitor your internet-exposed assets using Defender EASM.
- **Exposure management and prioritization** - How to specify requirements for attack path analysis, security initiatives, and risk prioritization using Microsoft Security Exposure Management.

## Example scenario

Consider Contoso, a financial services organization with the following infrastructure:

- Production workloads running in Azure
- Legacy applications in on-premises datacenters
- A recent acquisition that uses AWS for its core systems
- Customer-facing web applications across multiple hosting providers

Contoso's security team needs to answer questions like: What's our overall security posture? Where are our most critical vulnerabilities? Which misconfigurations could an attacker exploit to reach sensitive data? How do we prioritize remediation across 10,000+ resources?

Throughout this module, you'll learn how to design solutions that answer these questions using Microsoft's security posture management capabilities.

## Learning objectives

By the end of this module, you're able to:

- Evaluate security posture by using Microsoft Cloud Security Benchmark, Microsoft Defender for Cloud, and secure scores
- Design integrated security posture management and workload protection solutions in hybrid and multicloud environments
- Design cloud workload protection solutions that use Microsoft Defender for Cloud

## Prerequisites

- Advanced experience and knowledge in identity and access, platform protection, security operations, securing data, and securing applications
- Experience with hybrid and cloud implementations
