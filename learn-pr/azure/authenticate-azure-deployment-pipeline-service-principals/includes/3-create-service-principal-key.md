Now that you understand the concept of a service principal, you might wonder how it proves its identity to Azure AD. In this unit, you'll learn about the authentication process and credentials for service principals. You'll also learn how to create a service principal and give it a key.

## How are service principals authenticated?

When a service principal needs to communicate with Azure, it logs into Azure AD. Once Azure AD verifies the service principal's identity, it issues a _token_ that the client stores and uses when it makes any requests to Azure. Broadly speaking, this process is similar to how things work when you log into Azure yourself as a user. However, service principals use a slightly different type of credential to prove their identity.

There are two main credentials that service principals use: keys and certificates.

Keys are similar to passwords. However, keys are much longer and more complex. In fact, for most situations, Azure AD generates keys itself to ensure they are _cryptographically random_ - that is, extremely difficult to guess - and to ensure humans don't accidentally use weak passwords as keys. Service principals often have quite highly privileged permissions, so it's essential that they are secure. It's also typical that you only need to handle the key very briefly when first configuring the service principal and your pipeline, so it doesn't need to be memorable or easy to type. Also, another difference is that a single service principal can have multiple keys at the same time, but users can't have multiple passwords. Siimlarly to passwords, keys have an expiry date - you'll learn more about this soon.

Certificates are another way to authenticate service principals. They are very secure, but also can be difficult to manage. Some organizations require the use of certificates for certain types of service principals. In this module, we won't discuss certificates. However, if you work with a service principal that uses certificate authentication, it basically works the same way as any other service principal when it comes time to manage it and grant it permission for your pipeline.

> [!NOTE]
> Managed identities are special types of service principal that work within Azure. They have a different type of authentication process that doesn't require that you know or handle credentials at all.

## Work with keys for service principals

When you create a service principal, you generally ask Azure to create a key at the same time. You'll see how to do this shortly. Azure generates a random key and stores it with the service principal.

> [!NOTE]
> Remember our early discussion on how service principals work under the covers? Keys are stored as part of the application registration object. If you open up the Azure portal, look within the Azure AD configuration, and then navigate to the application registrations, you can also create and delete keys there too.

Azure provides the key to you when it creates it. This is the only time it will ever show you the key. After that, you won't be able to get it anymore. It's important that you note the key so you can use it when you configure your pipeline. If you lose the key, you can delete it and create a new one instead.

> [!TIP]
> When you create a key for a pipeline's service principal, it's a good idea to immediately copy the key into the pipeline's configuration once it's created. That way, you avoid storing the key unnecessarily. In this module we only discuss how to create a service principal and key, but you'll learn how to update your pipeline with the key in a later module.

### Key expiration

Keys for service principals expire. When you create a key you can configure its expiry time, but by default it's set to one year. After this expiry time, the key no longer works and the pipeline won't be able to log into Azure AD. You

- Expiry and rotation
- TODO

## Create a service principal and key

- How to create service principals using the CLI/PowerShell, and what this actually does behind the scenes
- Maybe how to use the portal too

<!--
az ad sp create-for-rbac vs. az ad sp create
-->

```azurecli
az ad sp create-for-rbac -n "TODO1" --role Contributor --scopes /subscriptions/a6ccc634-0449-4b65-933a-9a79a8df6d4f/resourceGroups/SP1
```