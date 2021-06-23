Now that you understand the concept of a service principal, you might wonder how it proves its identity to Azure AD. In this unit, you'll learn about the authentication process and credentials for service principals. You'll also learn how to create a service principal and give it a key.

## How are service principals authenticated?

When a service principal needs to communicate with Azure, it signs into Azure AD. Once Azure AD verifies the service principal's identity, it issues a _token_ that the client application stores and uses when it makes any requests to Azure. Broadly speaking, this process is similar to how things work when you sign into Azure yourself as a user. However, compared to users, service principals have a slightly different type of credential to prove their identity. There are two main credentials that service principals use: keys and certificates.

> [!NOTE]
> Managed identities are special service principals that work within Azure. They have a different type of authentication process that doesn't require that you know or handle credentials at all.

### Keys

Keys are similar to passwords. However, keys are much longer and more complex. In fact, for most situations, Azure AD generates keys itself to ensure they are _cryptographically random_ - that is, extremely difficult to guess - and to ensure humans don't accidentally use weak passwords as keys. Service principals often have quite highly privileged permissions, so it's essential that they are secure. Typically you only need to handle the key very briefly when first configuring the service principal and your pipeline, so it doesn't need to be memorable or easy to type. Also, a single service principal can have multiple keys at the same time, but users can't have multiple passwords. Like passwords, keys have an expiry date - you'll learn more about this soon.

### Certificates

Certificates are another way to authenticate service principals. They are very secure, but also can be difficult to manage. Some organizations require the use of certificates for certain types of service principals. We won't discuss certificates in this module. However, if you work with a service principal that uses certificate authentication, it basically works the same way as any other service principal when it comes time to manage it and grant it permission for your pipeline.

## Work with keys for service principals

When you create a service principal, you generally ask Azure to create a key at the same time. Azure typically generates a random key for you.

> [!NOTE]
> Remember our early discussion on how service principals work under the covers? Keys are stored as part of the application registration object. If you open up the Azure portal, look within the Azure AD configuration, and then navigate to the application registrations, you can create and delete keys there too.

Azure provides the key to you when you create the service principal. This is the only time it will ever show you that key. After that, you can't get it anymore. It's important that you securely copy the key so you can use it when you configure your pipeline. If you lose the key, you must delete it and create a new one.

> [!TIP]
> When you create a key for a pipeline's service principal, it's a good idea to immediately copy the key into the pipeline's configuration. That way, you avoid storing the key unnecessarily. In this module we only discuss how to create a service principal and key, but you'll learn how to update your pipeline with the key in a later module.

## Create a service principal and key

::: zone pivot="cli"

To create a service principal and a key, use the `az az sp create-for-rbac` command. The command accepts several arguments, and can optionally assign roles to the service principal. You'll learn about this later in this module, so for now here's an example illustrating how to create a service principal without any Azure role assignments:

```azurecli
az ad sp create-for-rbac \
  --name MyPipeline \
  --skip-assignment
```

When you run this command, the Azure CLI returns a JSON response with a `password` property. This is the service principal's key. You can't get this again, so make sure you use it immediately or save it somewhere securely.

> [!NOTE]
> Under the covers, the `az ad sp create-for-rbac` command creates an application registration in Azure AD, adds a service principal to your Azure AD tenant, and creates a key for the application registration. There's also another command, `az ad sp create`, which only creates the service principal in your tenant - not the application registration. When you create service principals for pipelines, `az ad sp create-for-rbac` is usually the best command to use.

::: zone-end

::: zone pivot="powershell"

To create a service principal and a key, use the `New-AzADServicePrincipal` cmdlet. The command accepts several arguments, and can optionally assign roles to the service principal. You'll learn about this later in this module, so for now here's an example illustrating how to create a service principal without any Azure role assignments:

```azurepowershell
$servicePrincipal = New-AzADServicePrincipal `
  -DisplayName MyPipeline `
  -SkipAssignment
```

When you run this command, Azure PowerShell populates the `servicePrincipal` variable with information about the service principal, including the key. The key is in a secure format and you have to convert it to a string to read it, as in this example:

```azurepowershell
$plaintextSecret = [System.Net.NetworkCredential]::new('', $servicePrincipal.Secret).Password
```

The `plaintextSecret` variable contains the service principal's key. You can't get this again, so make sure you use it immediately or save it somewhere secure.

> [!NOTE]
> Under the covers, the `New-AzADServicePrincipal` cmdlet creates an application registration in Azure AD, adds a service principal to your Azure AD tenant, and creates a key for the application registration.

::: zone-end

## Identify a service principal

Service principals have several identifiers and names that you use to identify and work with them. The two you mostly use are:

- **Application ID:** The application registration has a unique identifier, often called an _application ID_ or sometimes a _client ID_. You typically use this as the username when the service principal signs into Azure.
- **Display name:** This is a human-readable name that describes the service principal.

> [!TIP]
> Use a clear, descriptive display name for your service principal. It's important to help your team understand what the service principal is for, so that nobody accidentally deletes it or changes its permissions.

> [!CAUTION]
> A display name isn't unique. Multiple service principals might share the same display name. Be careful when you grant permissions to a service principal by using its display name to identity it - you might accidentally give permissions to the wrong service principal. It's a good practice to use the application ID instead.

When you create a service principal, you typically only set the display name, and Azure assigns the other names and identifiers automatically.

## Handle expired keys

Service principals don't expire, but their keys do. When you create a key you can configure its expiry time. By default the expiry time is set to one year. After this expiry time, the key no longer works and the pipeline can't sign into Azure AD. You need to renew or _rotate_ keys regularly.

> [!CAUTION]
> It might be tempting to set long expiry times for your keys, but you shouldn't do so. Service principals are only protected by their credentials, so if an attacker obtains a service principal's key they can do a great deal of damage. The best approach to minimize the period that an attack can last is to regularly change your keys. You should also delete and recreate keys if you ever suspect they've been leaked.

::: zone pivot="cli"

To reset a key for a service principal, use the `az ad sp` command, as in this example:

```azurecli
az ad sp credential reset --name MyPipeline
```

::: zone-end

::: zone pivot="powershell"

To reset a key for a service principal, first use the `New-AzADSpCredential` to add a new credential, then use the `Remove-AzADSpCredential` cmdlet to remove the old credential, as in this example:

```azurepowershell
New-AzADSpCredential -ServicePrincipalName MyPipeline
Remove-AzADSpCredential -DisplayName MyPipeline
```

::: zone-end

> [!TIP]
> A single service principal can have multiple keys. You can use this to safely update your application to use a new key while the old key is still valid, and then delete the old key when it's no longer in use. This avoids downtime due to key expiry.
