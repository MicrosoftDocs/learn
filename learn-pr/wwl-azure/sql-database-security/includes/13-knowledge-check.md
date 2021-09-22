
Answer these review questions to test your knowledge of securing databases in Azure.
### Answer the questions

## Multiple choice 
Your SQL database administrator has recently read about SQL injection attacks. They ask you what can be done to minimize the risk of this type of attack. You suggest implementing which of the following features? 
(x) Advanced Threat Protection {{Advanced Threat Protection. Advanced Threat Protection is an Advanced Data Security feature for databases. The feature provides alerts when a potential attack, like SQL injection, occurs.}}
() Data Discovery and Classification {{Discovering and classification will not minimize the risk of attack.}} 
() Dynamic Data Masking {{Data masking is not helpful in the situation.}} 



## Multiple Choice 
Your organization provides a Help Desk for its customers. Service representatives need to identify callers using the last four numbers of their credit card. You need to ensure the complete credit card number is not fully exposed to the service representatives. Which of the following features do you implement? 
() Always Encrypted {{Encryption makes sure the data is unreadable while stored, not masking phone numbers.}}
() Data Classification{{Data classifcation will not help mask off personally identifiable phone number information.}}
(x) Dynamic Data Masking{{Dynamic Data Masking. Dynamic data masking limits sensitive data exposure by masking it to non-privileged users. This feature enables customers to designate how much of the sensitive data to reveal.}}


## Multiple Choice 
Your organization auditors need to be assured that sensitive database data always remains encrypted at rest, in transit, and in use. You assure the auditors this is being done because you have configured which feature? 
(x) Always Encrypted {{Always Encrypted. Always Encrypted helps protect sensitive data at rest on the server, during movement between client and server, and while the data is in use. Always Encrypted ensures that sensitive data never appears as plaintext inside the database system. After you configure data encryption, only client applications or app servers that have access to the keys can access plaintext data. Always Encrypted uses the AEAD_AES_256_CBC_HMAC_SHA_256 algorithm to encrypt data in the database.}}
() Disk Encryption {{Disk encryption on helps when data is a rest.}}
() Dynamic Data Masking {{Data masking only blocks seeing all the data values of certain data types, not encrypt data.}} 


## Multiple Choice 
You have an App Service web application uses a SQL database. Users need to authenticate to the database with their Azure AD credentials. You perform all the following tasks, except? Select one. 
() Create a SQL Database Administrator {{The SQL Database Admin account would offer too much access to your users.}}
() Create an Azure AD Database Administrator {{An Azure AD Database admin could only configure and manage the database.}}
(x) Create users in the Master db {{Create users in the Master db. You could not create users in the Master db. Instead, contained users should be created on each database.}}

 

## Multiple Choice
What type of firewall rules can you configure for an Azure SQL database?  
() Datacenter-level firewall rules {{Datacenter-level rules would not be available inside of a SQL database.}}
(x) Server-level firewall rules {{Server-level firewall rules, and Database-level firewall rules can be created. Server-level IP firewall rules enable clients to access your entire Azure SQL Database—that is, all the databases within the same SQL Database server. These rules are stored in the master database. Database-level IP firewall rules enable clients to access certain secure databases within the same SQL Database server. You can create these rules for each database (including the master database), and they are stored in the individual databases.}}
() Table-level firewall rules {{There are no table-level firewall rules.}}

 