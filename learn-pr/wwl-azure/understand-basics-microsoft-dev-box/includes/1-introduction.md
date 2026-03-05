
In this module you will explore how Platform Engineering empowers development teams through the creation and operation of Internal Developer Platforms (IDP). You'll learn how Microsoft Dev Box fits into this ecosystem providing a scalable, self-service developer workstation environment that's aligned with Platform Engineering principles.

## What is Platform Engineering

Platform engineering is a discipline that focuses on building and maintaining the foundational systems and services that development teams use to deliver software. It emphasizes security, consistency, reusability, and self-service, creating a high-velocity environment where developers can focus on understanding business requirements and writing code rather than deploying, managing, and maintaining infrastructure. In most organizations, currently the IT team is playing the dual role of both an IT admin and Platform Engineering team, if the platform engineering team or related roles don't exist.<br><br>A Platform Engineering team builds a "platform" can be a hybrid of both internal and external products that integrates tooling, services, and workflows into a cohesive user experience. This platform abstracts away repetitive and low-level configuration tasks while providing standardized, secure environments for building, testing, and deploying applications.<br><br>The benefits of platform engineering include:

- Empowering developers with tools and environments they can control independently.
- Reducing cognitive load by standardizing and automating manual and operational tasks.
- Improving consistency and compliance across teams and projects.

## Introduction to Internal Developer Platforms

An Internal Developer Platform (IDP) is the result of a Platform Engineering effort. It's not a single tool or system, but rather a curated suite of tools, services, and workflows made available to developers.<br><br>Think of an IDP as a self-service interface that developers use to provision resources, deploy code, monitor applications, and manage configurations all within approved boundaries.<br><br>Key components typically include:

- Standardized infrastructure and templates
- Infrastructure as Code (IaC) to define and deploy cloud infrastructure consistently.
- Runtime and deployment environment
- Self-service interfaces such as a developer portal and CLI or APIs
- CI/CD pipelines to automate builds, tests, and deployments.
- Security and compliance tooling (Identity management, Secrets management, and policies) 
- Roles-based access and governance 
- Observability and monitoring tools for logs, metrics, and traces.

The majority of these are components of Microsoft Dev Box, which makes it a premium choice as an IDP for an organization.

## Microsoft Dev Box as part of your IDP

Microsoft Dev Box is a managed service that delivers secure, cloud-hosted workstations that are fully configured and ready for development. These virtual machines (VMs) are designed to fit seamlessly into IDP workflows.<br><br>Here's how Dev Box aligns with Platform Engineering goals:

- Self-service provisioning: Developers can deploy their own Dev Boxes from a portal without waiting for IT on standardized infrastructure
- Project-scoped customizable environments for different projects and teams 
- Preconfigured and standardized environments: Teams can create and manage base images with SDKs, dependencies, and pre-installed tools.
- Security and governance: Dev Box integrates with Microsoft Entra ID (formerly Azure AD), Microsoft Intune, and role-based access control to ensure compliance.
- CLI and API support: Dev Boxes machines can be deployed and managed via APIs, making them scriptable and automatable ideal for platform teams embedding Dev Box into larger workflows.

## Strategic benefits of using Dev Box in a Platform Engineering model

Integrating Dev Box into your platform strategy provides several benefits:

- Accelerated onboarding: New hires can get a development-ready environment in minutes, reducing setup delays.
-  Standardized environments: Developers work in consistent environments, minimizing "works on my machine" issues.
- Secure access and control: Dev Boxes can be tightly controlled by using Azure and Microsoft 365 controls.
- Cost efficiency: Dev Boxes can be shut down or deleted when not in use, optimizing cloud spending.

| **Benefit** | **Description** |
|---|---|
| **Faster Onboarding** | New developers can spin up fully loaded dev environments in minutes. |
| **Security & Governance** | Centralized identity management, role-based access, and policies ensure Dev Box machines meet compliance standards. |
| **Consistency** | All team members use standardized tools and environments. |
| **Integration** | Dev Box integrates with IDP workflows (CI/CD, Git, monitoring). |
| **Developer Experience** | Devs get flexibility with multimonitor support, remote access, Do It Yourself (DIY) troubleshooting, and full admin rights (if enabled). |