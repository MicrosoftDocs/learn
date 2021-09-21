Check your knowledge and comprehension with this questions.
### Knowledge check


## Multiple Choice 
What method does Microsoft Azure App Service use to obtain credentials for users attempting to access an app? Select one. 
() Credentials that are stored in the browser{{You would never want to use browser stored credentials for secure access to an application.}}
() Pass-through authentication{{Pass-throuh authentication is for Azure AD Connect.}}
(x) Redirection to a provider endpoint{{Redirection to a provider endpoint. Microsoft Azure App Service apps redirect requests to an endpoint that signs in users for that provider. The App Service can automatically direct all unauthenticated users to the endpoint that signs in users.}}



## Multiple Choice
What type of Managed Service Identities can you create?  
() Application-assigned and VM-assigned{{Application-signed and VM-signed are not managed service identities.}}
() Database-assigned and unsigned{{Managed service identities do not include database-signed and unsigned identities.}}
(x) System-assigned and User-assigned{{System-assigned, user assigned. There are two types of managed identities: A system-assigned managed identity is enabled directly on an Azure service instance. When the identity is enabled, Azure creates an identity for the instance in the Azure AD tenant that's trusted by the subscription of the instance. Creating an app with a user-assigned identity requires that you create the identity and then add its resource identifier to your app config.}}



## Multiple Choice 
Your App Service application stores page graphics in an Azure storage account. The app needs to authenticate programmatically to the storage account. What should you do? Select one.  
() Create an Azure AD system user{{A system user is not a secure way to authenticate programmatically.}}
(x) Create a managed identity{{Create a managed identity. A managed identity is an Azure AD security principal that represents the resource (app). Managed identities can be user or system managed.}}
() Create a RBAC role assignment{{RBAC would not work in this situation.}}


## Multiple Choice 
How does using managed identities for Azure resources change the way an app authenticates to Azure Key Vault? Select one. 
(x) The app gets tokens from a token service instead of Azure Active Directory.{{The app gets tokens from a token service instead of Azure Active Directory. When you enable managed identity on your web app, Azure activates a separate token-granting REST service specifically for use by your app. Your app will request tokens from this service instead of Azure Active Directory.}}
() The app uses a certificate to authenticate instead of a secret.{{Application could use either item to authenticate.}}
() Managed identities are automatically recognized by Azure Key Vault and authenticated automatically.{{Key Vault does not automatically authenticate any identity.}}


 