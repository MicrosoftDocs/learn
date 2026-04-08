## Learning objectives

By the end of this unit, learners will be able to:

- Explain how custom connectors extend Copilot capabilities in Dynamics 365 Sales
- Describe the process of creating, authenticating, and testing a custom connector
- Understand how to create and publish connector actions in Copilot Studio
- Evaluate considerations regarding environments, authentication, security, and certification
- Apply best practices when designing connectors for customer experience scenarios

## Introduction

Copilot in Dynamics 365 Sales becomes more powerful when connected to external data sources.

Custom connectors allow organizations to extend Sales workflows using **their own APIs**, enabling richer insights and automation.

Microsoft provides a "production ready preview" feature that allows developers and solution architects to:

- Build custom connectors using Power Apps or Power Automate

- Use Microsoft Entra ID (OAuth 2.0) for secure authentication

- Create Copilot actions that consume the connector

- Publish and enable these actions for Sales users

Custom connectors allow Copilot to retrieve insights from **third party systems**, improving customer experience and agent productivity.

## Core concepts for connector design

### Connector purpose

A custom connector acts as a bridge between:

- **External APIs / business systems**

- **Dynamics 365 Sales**

- **Copilot Studio actions**

The connector becomes a reusable component for extending the Sales experience with data driven insights.

## Creating a custom connector

### Environment requirements

You must create the connector in an **environment with Dynamics 365 apps enabled**.

Environments without Dynamics 365 (ex: default environment) **are not supported**.

### Steps to create a connector

- Build connector from **Power Apps** or **Power Automate**.

- Provide API host, base URL, and security model.

- Upload OpenAPI definition (Microsoft provides templates).

## Authentication & security

**Microsoft Entra ID (OAuth 2.0)**

When setting up authentication:

- Use **OAuth 2.0**

- Use **Microsoft Entra ID** as identity provider

- The backend service receives Entra ID tokens

- The connector and backend depend on **two app registrations** for secure token exchange

> [!IMPORTANT]
> To enable automated authentication (OBO tokens) for plugins, set: Enable onbehalfoflogin = true.

## Publishing connector actions in Copilot Studio

After creating your connector:

- Create a **Copilot action** using the connector

- Configure what data the action retrieves

- Publish the action

- Request an admin to enable it for Sales users

**Actions determine what operations Copilot can perform** with the connector (ex: retrieving insight from external sources).

> [!IMPORTANT]
> - Actions may take up to **7 days** to appear in the Sales experience.
> - Users can sign out/in to accelerate ingestion.

## Governance, compliance & certification

### Admin responsibilities

Admins must ensure connector actions comply with organizational policy:

- External data sources may contain **third-party terms & privacy policies**

- Data from connectors becomes accessible inside Microsoft 365 experiences

### Optional certification

To make the connector available organization-wide, certify the connector and the plugin.

## Chart: Connector design overview

| **Area** | **Key Considerations** |
|---|---|
| **Environment** | Must include Dynamics 365 Sales |
| **Authentication** | OAuth 2.0 + Microsoft Entra ID |
| **Security** | Two app registrations; optional OBO login |
| **Connector Actions** | Created & managed in Copilot Studio |
| **Admin Enablement** | Required for visibility in Sales |
| **Compliance** | Third-party data usage review |
| **Certification** | Optional for broad tenant availability |

## References

- [Create a custom connector and connector action (preview)](/microsoft-sales-copilot/custom-connector-action)
