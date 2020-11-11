Although the process of adding a custom domain name is simple, you might face a few problems.

Unknown to you, some members of your sales department have started using Power BI. They signed up with their @proseware.com work email addresses. This action created an unmanaged Azure Active Directory (Azure AD) organization with users in that team.

In this unit, you'll resolve the unmanaged Azure AD organization problem, explore other problems, and see how to resolve them.

## A custom domain name is under an unmanaged organization

If members of your organization sign up for another Microsoft service like OneDrive or Power BI, their email domain is used to create an unmanaged Azure AD organization. This organization or directory is useable for only that service. You can't add it as a custom domain in Azure AD.

You have two options to resolve this problem. Which you use depends on the service they signed up for.

- **Internal admin takeover**: Add yourself as the global administrator for the unmanaged organization.
- **External admin takeover**: Add the Domain Name System (DNS) domain name to your managed Azure AD organization.

The best solution is external admin takeover. Unfortunately, that's not an option for some services. The following table lists your option for each service.

|Service  |Solution  |
|----|----|
|SharePoint              | Internal admin takeover |
|OneDrive                | Internal admin takeover |
|Microsoft 365              | Internal admin takeover |
|Power BI                | External admin takeover |
|Azure Rights Management | External admin takeover |
|Exchange Online         | External admin takeover |
|Dynamics 365            | External admin takeover |

Because the sales team signed up for Power BI in this scenario, you can do an external admin takeover. The steps are the same as for adding a custom domain. The unmanaged organization won't stop you from completing those steps.

After you add your custom domain to your managed organization, all the following items are moved into your Azure AD organization:

- Domain name users
- Subscriptions
- License assignments

Internal admin takeovers are more complex and involve signing up for a Power BI account for the unmanaged organization. After you sign up, use Microsoft 365 to verify the domain name. No users or service plans migrate during an internal takeover.

## Domain name verification isn't working

When you verify your domain, you update the DNS records with your domain name registrar. A period of time is required for the change to propagate through the world's DNS servers. The time taken can be an hour or more. During this period, Azure can't read the record or verify the domain name.

If the domain is still unverified after an hour, check that you've entered the correct details. You can check them directly with your registrar or by using the `Resolve-DnsName` PowerShell command.

```PowerShell
Resolve-DnsName -Name proseware.com -Type TXT
```

You should see something like this:

```PowerShell
Name                                     Type   TTL   Section    Strings
----                                     ----   ---   -------    -------
proseware.com                            TXT    3600  Answer     {MS=ms94126796}
```

## A domain name is already in use

A domain name created in one Azure AD organization won't be verified in a new organization. Delete the custom domain name from the old Azure AD organization. Also delete any created users or apps that use the domain name in their app ID URI. After you delete these resources and the domain name, you can then add the custom domain name to the new Azure AD organization.
