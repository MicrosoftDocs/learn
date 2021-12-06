For apps and users, the architecture of Azure Stack Hub is described by four layers. Interactions between each of these layers can use different types of authentication.

:::image type="content" source="../media/identity-providers-2-6d9dbbb7.png" alt-text="Image showing interactions between each of the layers using different types of authentication.":::


:::row:::
  :::column:::
    **Layer**
  :::column-end:::
  :::column:::
    **Authentication between layers**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Tools and clients, such as the administrator portal
  :::column-end:::
  :::column:::
    To access or modify a resource in Azure Stack Hub, tools and clients use a JSON Web Token to place a call to Azure Resource Manager. Azure Resource Manager validates the JSON Web Token and peeks at the claims in the issued token to estimate the level of authorization that user or service principal has in Azure Stack Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Resource Manager and its core services
  :::column-end:::
  :::column:::
    Azure Resource Manager communicates with resource providers to transfer communication from users. Transfers use direct imperative calls or declarative calls via Azure Resource Manager templates.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resource providers
  :::column-end:::
  :::column:::
    Calls passed to resource providers are secured with certificate-based authentication. Azure Resource Manager and the resource provider then stay in communication through an API. For every call that's received from Azure Resource Manager, the resource provider validates the call with that certificate.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Infrastructure and business logic
  :::column-end:::
  :::column:::
    Resource providers communicate with business logic and infrastructure by using an authentication mode of their choice. The default resource providers that ship with Azure Stack Hub use Windows Authentication to secure this communication.
  :::column-end:::
:::row-end:::


:::image type="content" source="../media/identity-providers-3-86b7aa14.png" alt-text="Image showing normalized relational tables.":::


### Authenticate to Azure Resource Manager

To authenticate with the identity provider and receive a JSON Web Token, you must have the following information:

 -  **URL for the identity system (Authority)**: The URL at which your identity provider can be reached. For example, `https://login.windows.net`.
 -  **App ID URI for Azure Resource Manager**: The unique identifier for Azure Resource Manager that's registered with your identity provider. It's also unique to each Azure Stack Hub installation.
 -  **Credentials**: The credential you use to authenticate with the identity provider.
 -  **URL for Azure Resource Manager**: The URL is the location of the Azure Resource Manager service. For example, `https://management.azure.com` or `https://management.local.azurestack.external`.

When a principal (a client, apps, or user) makes an authentication request to access a resource, the request must include:

 -  The principal's credentials.
 -  The app ID URI of the resource that the principal wants to access.

The credentials are validated by the identity provider. The identity provider also validates that the app ID URI is for a registered app, and that the principal has the correct privileges to obtain a token for that resource. If the request is valid, a JSON Web Token is granted.

The token must then pass in the header of a request to Azure Resource Manager. Azure Resource Manager does the following, in no specific order:

 -  Validates the *issuer* (iss) claim to confirm that the token is from the correct identity provider.
 -  Validates the *audience* (aud) claim to confirm that the token was issued to Azure Resource Manager.
 -  Validates that the JSON Web Token is signed with a certificate that's configured through OpenID and known to Azure Resource Manager.
 -  Review the *issued at* (iat) and *expiration* (exp) claims to confirm that the token is active and can be accepted.

When all validations are complete, Azure Resource Manager uses the *object id* (oid) and the *groups* claims to make a list of resources that the principal can access.

:::image type="content" source="../media/identity-providers-4-81bd3d9d.png" alt-text="Image showing list of resources that the principal can access.":::
