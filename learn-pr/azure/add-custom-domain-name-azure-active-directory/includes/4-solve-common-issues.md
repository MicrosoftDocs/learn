Although the process of adding a custom domain name is simple, you might face a few issues.

Unknown to you, some members of your sales department have started using Power BI, signing up with their @*proseware.com* work email addresses. This action has created an unmanaged tenant with users in that team.

In this unit, you'll resolve the unmanaged tenant issue, explore other problems, and see how to resolve them.

## Custom domain name is under an unmanaged tenant

Staff who sign up for Microsoft services as a self-service user might cause this issue. If people sign up for OneDrive or Power BI, their email domain is used to create an unmanaged Azure AD directory. This unmanaged tenant, or directory, can only be used for that service, and can't be added as a custom domain in Azure AD.

You have two options to resolve this problem, depending on the service they signed up for:

1. **Internal admin takeover**: You add yourself as the global administrator for the unmanaged tenant.
1. **External admin takeover**: You add the DNS domain name to your managed Azure AD tenant.

The best solution is external admin takeover, unfortunately that isn't an option for some services. The table below lists your options.

|Service  |Solution  |
|----|----|
|SharePoint              | Internal admin takeover |
|OneDrive                | Internal admin takeover |
|Office 365              | Internal admin takeover |
|Power BI                | External admin takeover |
|Azure Rights Management | External admin takeover |
|Exchange Online        | External admin takeover |
|Dynamics 365           | External admin takeover |

In this scenario, the sales team signed up for Power BI, so you can do an external admin takeover. The steps are the same as for adding a custom domain. The unmanaged tenant won't stop you from completing those steps. What happens is that all the domain name users, subscriptions, and license assignments are moved into your directory.

Internal admin takeovers are more complex, and involve signing up for a Power BI account for the unmanaged tenant. Then using Office 365 to verify the domain name. No users, or service plans will be migrated during an internal takeover.

## Domain name verification isn't working

When you verify your domain, you update the DNS records with your domain name registrar. There's a period that's required for the change to propagate through the world's DNS servers. The time taken can be an hour or more. During this period, Azure can't read the record or verify the domain name.

If you've waited for more than an hour, and the domain is still unverified, check that you've entered the correct details. You can check them directly with your registrar, or using the `Resolve-DnsName` PowerShell command:

```PowerShell
Resolve-DnsName -Name proseware.com -Type TXT
```

You should see something like:

```PowerShell
Name                                     Type   TTL   Section    Strings
----                                     ----   ---   -------    -------
proseware.com                  TXT    3600  Answer     {MS=ms94126796}
```

## Domain name is already in use

A domain name created in one directory means it won't be verified in a new directory. Hopefully, as the owner of the tenant, you'll delete the custom domain name from the old directory. You'll also have to delete any created users, or apps, that use the domain name in their app ID URI. After deleting these resources, and the domain name, you can then add it to the new directory correctly.