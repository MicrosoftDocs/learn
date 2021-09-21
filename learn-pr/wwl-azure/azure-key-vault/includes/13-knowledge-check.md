Complete the following question to test your knowledge.

## Multiple Choice 
Which one of the following should not be stored in Azure Key Vault? What are the differences between these items? Select one.  
() Secret management{{Secrets can be stored in your key vault.}}
() Certificate management{{It is always a great idea to store your certificates in the key vault.}}
(x) Identity management{{Identity management. Azure Key Vault can be used for keys, secrets, and certificates. Keys are cryptographic objects. The key vault supports multiple key types and algorithms and enables the use of Hardware Security Modules (HSM) for high value keys. Secrets provide secure storage of passwords and database connection strings. Certificates are built on top of keys and secrets and add an automated renewal feature.}} 



## Multiple Choice 
A select group of users must be able to create and delete keys in the key vault.  You are authenticating to the data plane using Azure AD.  What security tool should you use the authorize access at a role level to these users? 
() Key vault access policies{{Using Access Policies would not give you role level control, and does not follow least privilege rules.}} 
(x) Role-based Access Control{{Role-based Access Control. To create and delete key vaults the data plane you should grant access with RBAC. For example, Key Vault Contributor.  Using Access Policies would not give you role level control, and does not follow least privilege rules.}}
() Azure AD authentication{{AD authentication is not the right way to grant your access.}}



## Multiple Choice 
Which of these statements best describes Azure Key Vault's authentication and authorization process? Select one.  
() Applications authenticate to a vault with the username and password of the lead developer and have full access to all secrets in the vault.{{You do not access the key vault as a developer.}}
(x) Applications and users authenticate to a vault with their Azure Active Directory identities and are authorized to perform actions on all secrets in the vault.{{Authentication to Key Vault uses Azure Active Directory identities. Access policies are used to provide authorization for actions that apply to every secret in the vault.}}
() Applications and users authenticate to a vault with a Microsoft account and are authorized to access specific secrets.{{You need to authentication with Azure AD.}}



## Multiple Choice 
How does Azure Key Vault help protect your secrets after they have been loaded by your app? Select one. 
() Azure Key Vault automatically generates a new secret after every use.{{Key vault does not generate secrets on demand, it provides them via an API.}}
() Azure Key Vault double-encrypts secrets, requiring your app to decrypt them locally every time they're used.{{You application would need to protect your secrets, key vault does not encrypt secrets in applications.}}
(x) It doesn't protect your secrets. Secrets are unprotected once they're loaded by your application.{{It doesn't protect your secrets. Once secrets have been loaded by an app, they are unprotected. Make sure to not log them, store them, or return them in client responses.}} 


## Multiple Choice
Your manager wants to know more about software-protected keys and hardware-protected keys. Pick the correct topic you could explain to your manager? 
() Only hardware-protected keys are encrypted at rest.{{You can encyrpt keys at rest in any system.}}
() Software-protected keys are not isolated from the application.{{This is not a topic that varies between software and hardware protected keys.}}
(x) Software-protected cryptographic operations are performed in software and Hardware-protected cryptographic operations are performed within the HSM.{{Cryptographic operations are performed within each module. HSM keys offer FIPS 140-2 Level 2 assurance. The primary difference (besides price) with a software-protected key is when cryptographic operations are performed, they are done in software using Azure compute services while for HSM-protected keys the cryptographic operations are performed within the HSM.}}
 
