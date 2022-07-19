
## How does it help me?

Common scenarios for using workbooks include:

- Get shareable, at-a-glance summary reports about your Azure AD tenant, and build your own custom reports.

- Find and diagnose sign-in failures, and get a trending view of your organization's sign-in health.

- Monitor Azure AD logs for sign-ins, tenant administrator actions, provisioning, and risk together in a flexible, customizable format.

- Watch trends in your tenant’s usage of Azure AD features such as conditional access, self-service password reset, and more.

- Know who's using legacy authentications to sign in to your environment.

- Understand the effect of your conditional access policies on your users' sign-in experience.

## Who should use it?

Typical personas for workbooks are:

- Reporting admin - Someone who is responsible for creating reports on top of the available data and workbook templates

- Tenant admins - People who use the available reports to get insight and take action.

Workbook template builder - Someone who “graduates” from the role of reporting admin by turning a workbook into a template for others with similar needs to use as a basis for creating their own workbooks.

## How to use it

When working with workbooks, you can either start with an empty workbook, or use an existing template. Workbook templates enable you to quickly get started using workbooks without needing to build from scratch.

There are:

- **Public templates** published to a gallery that serve as a good starting point when you're just getting started with workbooks.
Private templates when you start building your own workbooks and want to save one as a template to serve as the foundation for multiple workbooks in your tenant.

- **Private templates** when you start building your own workbooks and want to save one as a template to serve as the foundation for multiple workbooks in your tenant.


## Prerequisites

To use Monitor workbooks, you need:

- An Azure Active Directory tenant with a premium (P1 or P2) license. Learn how to get a premium license.

- A Log Analytics workspace.

- Access to the log analytics workspace

- Following roles in Azure Active Directory (if you're accessing Log Analytics through Azure Active Directory portal)
   - Security administrator
   - Security reader
   - Report reader 
   - Global administrator
   


## Roles

To access workbooks in Azure Active Directory, you must have access to the underlying Log Analytics workspace and be assigned to one of the following roles:

- Global Reader

- Reports Reader

- Security Reader

- Application Administrator

- Cloud Application Administrator

- Company Administrator

- Security Administrator

## Workbook access

To access workbooks:

1. Sign in to the Azure portal.

2. Navigate to **Azure Active Directory > Monitoring > Workbooks**.

3. Select a report or template, or on the toolbar select **Open**.

:::image type="content" source="../media/azure-monitor-workbooks-in-azure-ad.png" alt-text="Schematic diagram that shows a query as a funnel." border="false"::: 