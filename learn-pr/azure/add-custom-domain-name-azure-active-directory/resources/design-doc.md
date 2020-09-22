# Module design

## Title

Add custom domain name to Azure Active Directory

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Azure Active Directory

## Prerequisites

- Familiarity with identity and access management concepts in Azure Active Directory
- Basic knowledge of networking concepts like DNS

## Summary

Add your custom domain to Azure Active Directory. Add DNS information to the domain registrar. Verify your custom domain name in the Azure portal and set it as the primary.


## Learning objectives

1. Add a custom domain name in Azure Active Directory
1. Identify the common issues when verifying the custom domain name

## Chunk your content into subtasks

Identify the subtasks of *Add custom domain name to Azure Active Directory*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand custom domain names | before you create the user accounts, you want to add your organization's domain name to Azure AD | knowledge check | Enabling objective for # 1 | Yes |
| Add a custom domain name | before you create the user accounts, you want to add your organization's domain name to Azure AD | knowledge check | 1 | Yes |
| Common issues | before you create the user accounts, you want to add your organization's domain name to Azure AD | knowledge check | 2 | Yes |

## Outline the units


1. **Introduction**

    Your organization used Azure to develop and test a pilot project and has now decided to make Azure broadly available to the entire organization. As your organization's Global Administrator in Azure Active Directory (Azure AD), you need to create accounts to onboard your organization. You want to create user names that are familiar to your users. Their Azure sign-in name is memorable and it's clear that their Azure AD account is associated with your organization. You have a new custom domain name that your organization bought from a third-party domain name registrar. So before you create the user accounts, you want to add your organization's custom domain name to Azure AD.

1. **What are domain names in Azure Active Directory?**

    - What are Custom Domain Names?
        - Initial onmicrosoft.com domain name
            - Custom domain will give access to resources secured with onmicrosoft.com domain as well as any resources accessed with registered custom domain name
        - Add a familiar domain name not already created by service such as Microsoft 365
        - Domain must already be registered (you can buy a domain name by using App Service domains or a third-party domain name registrar)
        - Add a subdomain
            - Subdomains are automatically verified
   
    **Knowledge check**

    - What types of custom domain names are supported?
        - A. Any registered domain name that not already being used.
    - Which resources can a custom domain account access?
        - A. Both internal and external


1. **Add a custom domain name in Azure Active Directory**

  
    - Create a new tenant
        - Create tenant with onmicrosoft.com address
    - Set the primary domain name
        - Add custom domains
        - Add DNS information to the domain registrar
        - Add subdomains
    - Add a custom domain name using PowerShell
        - New-MsolDomain cmdlet 
    - Take over management of unmanaged Power BI tenants
        - Power BI users can create unmanaged tenants with self-service sign-up
    - Microsoft 365
        - It is not necessary to create a custom domain if one has already been created by Microsoft 365 (see note)
   - Mention scenario where after adding the domain name, you'd create user accounts. Users would sign in by using account name that has custom domain. Provide example of what the sign-in name would look like with custom domain.
     
    **Knowledge check**

    - How do the global DNS servers point to the Azure resources?
        - Copy info from Azure and update domain registrar
    - What is the default domain name before a custom domain is created?
        - A: userdomainname.onmicrosoft.com


1. **Solve common issues when adding custom domain name**

    - Federate an on-premises Windows Server AD with Azure AD
    - Verify that the domain registrar information is correct
        - Wait for an hour
        - Check the entry at the domain registrar site
    - Ensure that the domain name isn't used by another directory


    **Knowledge check**

    - What should you do if domain registrar verification fails?
        - Wait for an hour and then check domain registrar site
    - How many tenants can use a single domain name?
        - A: 1



1. **Summary**

    Theory of custom domains, steps to create custom domain, and common issues discussed.

## Notes

- Couple of things a bit off topic but should maybe be mentioned briefly:

   Microsoft 365-related
  - If they have Microsoft 365 and have a custom domain added there, they don't need add the domain in Azure AD unless Microsoft 365 is set up in a different tenant/directory as their Azure subscription or they want to use a different domain.
  - If they plan to later add Microsoft 365 and use Exchange Online for email with the same domain they've already added to Azure AD, they'd need to add an MX record to Azure AD.

  Other services to mention very briefly:
  - Customers can use whatever DNS service they want to. If they want to centralize DNS services on Azure, they can use Azure DNS. There's a module planned for that service.
  - Domain Services is for Hybrid environments.
- Creating a demonstration custom domain not possible and so there is no exercise.
 
## Resources

- [Add your custom domain name using the Azure Active Directory portal](https://docs.microsoft.com/azure/active-directory/fundamentals/add-custom-domain)
- [Managing custom domain names in your Azure Active Directory](https://docs.microsoft.com/azure/active-directory/users-groups-roles/domains-manage)
- [What is Azure Active Directory](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-whatis)
