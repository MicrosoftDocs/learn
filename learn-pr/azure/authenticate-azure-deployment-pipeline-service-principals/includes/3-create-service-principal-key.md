Now that you understand the concept of a service principal, you might wonder how it proves its identity to Microsoft Entra ID. In this unit, you'll learn about the authentication process and credentials for service principals. You'll also learn how to create a service principal and give it a key.

## Understand how service principals are authenticated

When a service principal needs to communicate with Azure, it signs in to Microsoft Entra ID. After Microsoft Entra ID verifies the service principal's identity, it issues a _token_ that the client application stores and uses when it makes any requests to Azure. 

Broadly speaking, this process is similar to how things work when you sign in to Azure yourself as a user. However, compared to users, service principals have a slightly different type of credential to prove their identity. Service principals use two main credentials: keys and certificates.

> [!NOTE]
> Remember that managed identities are special service principals that work within Azure. They have a different type of authentication process that doesn't require that you know or handle credentials at all.

### Keys

Keys are similar to passwords. However, keys are much longer and more complex. In fact, for most situations, Microsoft Entra ID generates keys itself to ensure that:

- The keys are _cryptographically random_. That is, they're extremely hard to guess.
- Humans don't accidentally use weak passwords as keys. 

Service principals often have highly privileged permissions, so it's essential that they're secure. Typically, you only need to handle the key briefly when first configuring the service principal and your pipeline. So the key doesn't need to be memorable or easy to type. 

A single service principal can have multiple keys at the same time, but users can't have multiple passwords. Like passwords, keys have an expiration date. You'll learn more about that soon.

> [!NOTE]
> Think of keys like very important passwords, similar to storage account keys. You should treat them with the same level of security and care.

### Certificates

Certificates are another way to authenticate service principals. They're very secure but can be hard to manage. Some organizations require the use of certificates for certain types of service principals. 

We won't discuss certificates in this module. However, if you work with a service principal that uses certificate authentication, it basically works the same way as any other service principal in terms of managing it and granting it permission for your pipeline.

> [!NOTE]
> Certificates are a good option when you can use them. They're harder for attackers to steal. It's also harder to intercept and modify requests that use certificates. However, certificates require more infrastructure and have some ongoing maintenance overhead.

## Work with keys for service principals

When you create a service principal, you generally ask Azure to create a key at the same time. Azure typically generates a random key for you.

> [!NOTE]
> Remember our earlier discussion about how service principals work? Keys are stored as part of the application registration object. If you open the Azure portal, look within the Microsoft Entra configuration, and then go to the application registrations, you can create and delete keys there too.

Azure shows you the key when you create the service principal. This is the only time that Azure will ever show you the key. After that, you can't retrieve it anymore. It's important that you securely copy the key so you can use it when you configure your pipeline. Don't share the key by email or another non-secure means. If you lose a key, you must delete it and create a new one.

## Manage service principals for Azure Pipelines

When you create a key for a pipeline's service principal, it's a good idea to immediately copy the key into the pipeline's configuration. That way, you avoid storing or transmitting the key unnecessarily. 

Pipeline tools include secure ways to specify your service principal's application ID and key. Never store credentials of any kind in source control. Instead, use *service connections* when you work with Azure Pipelines. In this module, we only discuss how to create a service principal and key. You'll learn how to configure your pipeline with the key in a later module.

> [!TIP]
> Azure Pipelines can create service principals for you automatically. In this module, you'll manually create and manage your service principals to gain a better understanding of what's happening. In other modules, you'll use the automatic creation method for simplicity.

## Create a service principal and key

::: zone pivot="cli"

You can use the Azure CLI to create and manage service principals.

> [!NOTE]
> Creating and modifying service principals requires that you have the related permissions in Microsoft Entra ID. In some organizations, you might need an administrator to perform these steps for you.

To create a service principal and a key, use the `az ad sp create-for-rbac` command. This command accepts several arguments and can optionally assign roles to the service principal. You'll learn about this subject later in this module. For now, here's an example that illustrates how to create a service principal without any Azure role assignments:

```azurecli
az ad sp create-for-rbac --name MyPipeline
```

When you run this command, the Azure CLI returns a JSON response with a `password` property. This property is the service principal's key. You can't get this key again, so be sure to use it immediately or save it somewhere securely.

> [!NOTE]
> The `az ad sp create-for-rbac` command creates an application registration in Microsoft Entra ID, adds a service principal to your Microsoft Entra tenant, and creates a key for the application registration. Another command, `az ad sp create`, only creates the service principal in your tenant (not the application registration). When you create service principals for pipelines, `az ad sp create-for-rbac` is usually the best command to use.

::: zone-end

::: zone pivot="powershell"

You can use the Azure PowerShell cmdlets to create and manage service principals.

> [!NOTE]
> Creating and modifying service principals requires that you have the related permissions in Microsoft Entra ID. In some organizations, you might need an administrator to perform these steps for you.

To create a service principal and a key, use the `New-AzADServicePrincipal` cmdlet. This cmdlet accepts several arguments and can optionally assign roles to the service principal. You'll learn about this subject later in this module. For now, here's an example that illustrates how to create a service principal without any Azure role assignments:

```azurepowershell
$servicePrincipal = New-AzADServicePrincipal -DisplayName MyPipeline
```

When you run this command, Azure PowerShell populates the `servicePrincipal` variable with information about the service principal, including the key:

```azurepowershell
$servicePrincipalKey = $servicePrincipal.PasswordCredentials.SecretText
```

You can't get this key again, so be sure to use it immediately or save it somewhere secure.

> [!NOTE]
> The `New-AzADServicePrincipal` cmdlet creates an application registration in Microsoft Entra ID, adds a service principal to your Microsoft Entra tenant, and creates a key for the application registration.

::: zone-end

## Identify a service principal

Service principals have several identifiers and names that you use to identify and work with them. The identifiers that you use the most are:

- **Application ID**: The application registration has a unique identifier, often called an _application ID_ or sometimes a _client ID_. You typically use it as the username when the service principal signs in to Azure.
- **Object ID**: The application registration and the service principal have their own separate object IDs, which are unique identifiers assigned by Microsoft Entra ID. Occasionally, you'll need to use these object IDs when you manage a service principal.
- **Display name**: This is a human-readable name that describes the service principal.

> [!TIP]
> Use a clear, descriptive display name for your service principal. It's important to help your team understand what the service principal is for, so that nobody accidentally deletes it or changes its permissions.

> [!CAUTION]
> A display name isn't unique. Multiple service principals might share the same display name. Be careful when you grant permissions to a service principal by using its display name to identify it. You might accidentally give permissions to the wrong service principal. It's a good practice to use the application ID instead.

When you create a service principal, you typically only set the display name. Azure assigns the other names and identifiers automatically.

## Handle expired keys

Service principals don't expire, but their keys do. When you create a key, you can configure its expiration time. By default, the expiration time is set to one year. After this expiration time, the key no longer works and the pipeline can't sign in to Microsoft Entra ID. You need to renew or _rotate_ keys regularly.

> [!CAUTION]
> It might be tempting to set long expiration times for your keys, but you shouldn't do so. Service principals are only protected by their credentials. If an attacker obtains a service principal's key, they can do a great deal of damage. The best approach to minimize the period that an attack can last is to regularly change your keys. You should also delete and re-create keys if you ever suspect they've been leaked.

::: zone pivot="cli"

To reset a key for a service principal, use the `az ad sp` command with the application ID, as in this example:

```azurecli
az ad sp credential reset --id "b585b740-942d-44e9-9126-f1181c95d497"
```

You can also remove and re-create the service principal's key in two separate steps by using the `az ad sp credential delete` and then the `az ad sp credential reset --append` commands.

::: zone-end

::: zone pivot="powershell"

To reset a key for a service principal, first use the `Remove-AzADServicePrincipalCredential` cmdlet to remove the existing credential. Then use the `New-AzADServicePrincipalCredential` cmdlet to add a new credential. These cmdlets both use the service principal's object ID to identify it. Before you use the cmdlets, you need to obtain this ID from the application ID:

```azurepowershell
$applicationId = APPLICATION_ID
$servicePrincipalObjectId = (Get-AzADServicePrincipal -ApplicationId $applicationId).Id

Remove-AzADServicePrincipalCredential -ObjectId $servicePrincipalObjectId

$newCredential = New-AzADServicePrincipalCredential -ObjectId $servicePrincipalObjectId
$newKey = $newCredential.SecretText
```

::: zone-end

> [!TIP]
> A single service principal can have multiple keys. You can safely update your application to use a new key while the old key is still valid, and then delete the old key when it's no longer in use. This technique avoids downtime from key expiration.

## Manage the lifecycle of your service principal

It's important to consider the whole lifecycle of each service principal that you create. When you build a service principal for a pipeline, what will happen if the pipeline is eventually deleted or is no longer used? 

Service principals aren't removed automatically, so you need to audit and remove old service principals. It's important to remove old service principals for the same reason that you delete old user accounts: attackers might gain access to their keys. It's best not to have credentials that aren't actively used.

It's a good practice to document your service principals in a place that you and your team can easily access. You should include the following information for each service principal:

> [!div class="checklist"]
> * Essential identifying information, including its name and application ID.
> * The purpose of the service principal.
> * Who created it, who's responsible for managing it and its keys, and who might have answers if there's a problem.
> * The permissions that it needs, and a clear justification for why it needs them.
> * What its expected lifetime is.

You should regularly audit your service principals to ensure that they're still being used and that the permissions they've been assigned are still correct.
