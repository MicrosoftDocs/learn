Azure Storage provides a layered security model. Use this model to secure your storage accounts to a specific set of supported networks. When you set up network rules, only applications that request data over the specified networks can access your storage account. 

Authorization is supported by a public preview of Azure Active Directory credentials (for blobs and queues), a valid account access key, or a shared access signature (SAS) token. Data encryption is enabled by default, and you can proactively monitor systems by using Advanced Threat Protection.


---

##Check your knowledge



You are working on a project with a 3rd party vendor to build a website for a customer. The image assets that will be used on the website are stored in an Azure Storage account that is held in your subscription. You want to give read access to this data for a limited period of time. What security option would be the best option to use?

( ) CORS Support{{CORS uses HTTP headers so that a web application at one domain can access resources from a server at a different domain.}} 

( ) Storage Account{{In Azure Storage accounts, shared keys are called storage account keys. Azure creates two of these keys (primary and secondary) for each storage account you create. The keys give access to everything in the account.}} 

(X) Shared Access Signatures{{Correct.  A shared access signature is a string that contains a security token that can be attached to a URI. Use a shared access signature to delegate access to storage objects and specify constraints, such as the permissions and the time range of access.}}



When configuring network access to your Azure Storage Account, what is the default network rule?

(X) To allow all connections from all networks{{Correct. The default network rule is to allow all connections from all networks.}} 

( ) To allow all connection from a private IP address range{{Incorrect. The default network rule is to allow all connections from all networks.}} 

( ) To deny all connections from all networks{{Incorrect. The default network rule is to allow all connections from all networks.}} 



Which Azure service detects anomalies in account activities and notifies you of potential harmful attempts to access your account?

(X) Azure Defender for Storage{{Microsoft Defender for Storage detects anomalies in account activity. It then notifies you of potentially harmful attempts to access your account.}} 

( ) Azure Storage Account Security Feature{{Incorrect. Azure Storage Account Security Feature does not exist. Microsoft Defender for Storage detects anomalies in account activity. It then notifies you of potentially harmful attempts to access your account.}} 

( ) Encryption in transit{{Incorrect. Encryption in transit uses security algorithms to protect data on the network. Microsoft Defender for Storage detects anomalies in account activity. It then notifies you of potentially harmful attempts to access your account.}} 