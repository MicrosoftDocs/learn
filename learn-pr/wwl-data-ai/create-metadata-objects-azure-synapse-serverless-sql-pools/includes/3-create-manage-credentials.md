Azure Synapse serverless SQL pool accesses the storage to read the files using credentials. There are 3 types of credentials that are supported: 
-	Azure Active Directory pass-through 
-	Managed Identity
-	Shared access signature. 

Azure Active Directory pass-through, is a default for Azure Active Directory users. If you login with an Azure Active Directory identity, and you don’t explicitly specify the credential, the identity of the logged in user will be used. To explicitly specify an identity of a logged in user, you need to create a database scoped credential as follows:

```sql
CREATE DATABASE SCOPED CREDENTIAL [sqlondemand] 
WITH IDENTITY='User Identity' 
```

Managed identities is a Azure Active Directory identity that represents the the Azure Synapse workspace in your Azure Active Directory tenant. You can grant access to services to this identity explicitly. To instruct the serverless SQL pool to use a managed identity, create a credential as follows.

```sql
CREATE DATABASE SCOPED CREDENTIAL [sqlondemand] 
WITH IDENTITY='Managed Identity' 
```

A Shared access signature (SAS) is a storage feature, that enables you to give a time bound permissions. To use a SAS credential in serverless SQL pool, , create a credential as follows.

```sql
CREATE DATABASE SCOPED CREDENTIAL [sqlondemand] 
WITH IDENTITY='SHARED ACCESS SIGNATURE',   
SECRET = 'sv=2018-03-28&ss=bf&srt=sco&sp=rl&st=2019-10-14T12%3A10%3A25Z&se=2061-12-31T12%3A10%3A00Z&sig=KlSU2ullCscyTS0An0nozEpo4tO5JAgGBvw%2FJX2lguw%3D' 
```

Whichever credential you choose to use, all credentials can be passed to external data source, defining what authentication method should be used against the storage. 
