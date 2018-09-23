Azure Active Directory (Azure AD) is not just a domain controller in the cloud. Azure AD is a multi-tenant, cloud-based directory and identity management service. It combines core directory services, application access management, and identity protection into a single solution. Azure AD can work in concert with an existing Windows Server Active Directory environment by way of Azure AD Connect, which allows you to utilize existing on-premises identity investments.

Azure AD comes in four editions. For this exercise, we will only focus on features in the Azure AD Premium P1 and P2 editions.

In this module, we will create an Azure AD directory where all of our users and groups will live, similar to an on-premises directory.

When we create the directory, our account will automatically be made a global administrator. Accounts with global administrator rights should be regulated, as they have full access to all Azure AD administrative features. You can have more than one global administrator, but only global administrators can assign any of the other administrator roles to users.

## How can Azure AD help you protect access to applications?

Azure AD Premium includes features like Multi-Factor Authentication and conditional access policies. When these features are used together, they provide the most granularity when protecting access to applications.

A conditional access policy consists of:

- Users or groups
- Applications they're attempting to access
- Controls to be fulfilled, such as Multi-Factor Authentication

In this unit, you learned the basics of what Azure AD is and what features are available to secure access to applications.