## Azure Key Vault

Azure Key Vault is a cloud service for securely storing and accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, or cryptographic key. Key Vault can save time and resources by not having to provision, configure, patch, and maintain hardware security modules and critical management software. When you create a key vault in an Azure subscription, it's automatically associated with the Azure AD tenant of the subscription, so you keep control over your keys—simply grant permission for your own and partner applications to use them as needed.

The Key Vault can be helpful if you need to share authentication information such as usernames and passwords.

For example, if you connect to an external database with Azure ML in order to query training data, you will need to pass your username and password to the remote run context. Coding such values into training scripts in cleartext is insecure as it would expose the secret. Instead, use Key Vault to pass secrets to remote runs securely through a set of APIs in the Azure Machine Learning Python SDK.

![A generic image of a key vault authenticator.](../media/4-key-vault.png)