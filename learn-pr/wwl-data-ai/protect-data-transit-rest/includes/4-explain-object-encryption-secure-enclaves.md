In addition to supporting encryption at rest, SQL Server supports encrypting data within columns using Always Encrypted. Once data is encrypted, the application accessing the database must have the correct certificate in order to view the plain text values of the data.

## Always Encrypted

Always Encrypted allows for the encryption of data within the client application, protecting sensitive data from malware and high-privileged users, such as  Database Administrators (DBAs), server admins, cloud admins, or those who manage the data but should have no access. This encryption happens automatically based on the settings within the Microsoft SQL Server database, which tell the application what the encryption settings on the database column are.

The following table provides some scenarios for Always Encrypted usage:

| Scenario | Definition |
|------------|-------------|
|**Client and data on-premises** | For scenarios where you need to protect your on-premises database from high-privileged users, for example, external vendors managing SQL Server. |
|**Client on-premises with data in Azure** | In this scenario, to ensure Microsoft cloud administrators have no access to the data, Always Encrypted keys are stored in key store hosted on-premises, for SQL Database or SQL Server running in a virtual machine on Microsoft Azure. |
|**Client and Data in Azure** | In this scenario, the environment is fully hosted on Azure. While Always Encrypted doesn't completely isolate data from cloud administrators, the customer still benefits from the fact that the data is encrypted in the database. |

Always Encrypted is based on a master encryption key and a column encryption key. Having both keys allows each column to be encrypted using a different encryption key for maximum data protection. Always Encrypted has various key stores that can store the certificate used by encryption.

Here’s an example of enabling Always Encrypted. As shown below, you can see that *NationalIDNumber* and *BirthDate* columns are both in plain text.

 :::image type="content" source="../media/module-33-security-final-06.png" alt-text="Query from Unencrypted table for Always Encrypted.":::

The next few images will show you how we can encrypt both of these columns using Always Encrypted. The encryption could be done using T-SQL, but in this example, you'll see the wizard from SQL Server Management Studio. You can reach the wizard by right-clicking on the table name in Object Explorer as shown below.

:::image type="content" source="../media/module-33-security-final-07.png" alt-text="Launching the Encryption Wizard in SQL Server Management Studio.":::

When you select **Encrypt Columns...**, the wizard will launch.

:::image type="content" source="../media/module-33-security-final-08.png" alt-text="Always Encrypted Wizard launch screen from SSMS.":::

In the image below, you'll see the Always Encrypted launch screen. Select **Next** to choose the columns you want to encrypt.

:::image type="content" source="../media/module-33-security-final-09.png" alt-text="Column selection screen for Always Encrypted Wizard.":::

In the image above, there are two different types of encryption specified. The *NationalIDNumber* column is encrypted with **Deterministic** encryption, and the *BirthDate* column is encrypted using **Randomized** encryption.

Randomized encryption is more secure than Deterministic encryption, but is more limited. The type of encryption can't be changed after the column is created. It's recommended to use Randomized encryption for columns that had a few well-known distinct values that could potentially be guessed by someone with access to the encrypted values. An example of a potentially guessable column would a three-digit credit card verification code.

Using Always Encrypted with Randomized encryption is more limited because the randomization means that the same value isn't always encrypted the same way. The only thing you can do with columns with Randomized encryption is to return them in your results. Deterministic encryption always encodes a value as the same string, which allows us to compare columns to a constant using equality and inequality operators, and to compare columns with each other to perform joins, grouping, and indexing.

Another thing to note is that the wizard is generating a column encryption key, which is the key that actually performs the data encryption. Each column being encrypted may have its own key, or as shown here, you can use the same key to encrypt both columns.

After identifying the columns you're encrypting, you can select **Next** and you'll see the **Master Key Configuration** screen:

:::image type="content" source="../media/module-33-security-final-10.png" alt-text="Master Key Configuration for Always Encrypted Wizard.":::

In this screen, you create the column master key, which is used to encrypt the column encryption keys. You can supply your own key, if you're using T-SQL to encrypt the columns. This key must be stored in a key store such as the Windows Certificate Store, Azure Key Vault, or a hardware security module. The database engine never stores the column master key, and only contains the metadata about where it's stored. Not storing the master key protects data access from users who have full access to the database.

For the highest level of security, the key should be stored within a third party key store such as Azure Key Vault. Never generate the keys on the server hosting your database, as the key could potentially be extracted from memory on that server.

In the example below, the key is being stored in Azure Key Vault. On the next screen, the wizard will provide you the option to either finish the encryption process now, or to generate a PowerShell script. Once you complete the process, the data will appear as encrypted to anyone querying the data without the key.

:::image type="content" source="../media/module-33-security-final-11.png" alt-text="Employees Table with Encrypted Data from SSMS.":::

In order to decrypt data from an Always Encrypted column, your application needs an Always Encrypted driver to connect to the database, followed by the actions below:

1. The application has access to the key store where the Always Encrypted keys are stored
1. The application then retrieves the data
1. Data that is written back to the database is encrypted at the client through the driver

In addition to the driver, the application’s connection string needs to have the setting **Column Encryption Setting=enabled** provided. This setting will cause a metadata lookup to be made for each column that is used by the application.

 > [!NOTE]
 >To minimize metadata lookups, the application needs to update the *SqlCommandColumnEncryptionSetting* on the *SqlConnection* objects within the .NET application. These settings must be set for each database query that the application submits.

### Secure enclaves

Always Encrypted supports a feature called secure enclaves, which allows more robust querying of encrypted data.

A secure enclave is a secured region of memory within the SQL Server process that acts as a trusted execution environment for processing encrypted data. This enclave appears as a black box to SQL Server, and it isn't possible to view any data or code, even with a debugger.

The image below shows the architecture of this process:

:::image type="content" source="../media/module-33-security-final-12.png" alt-text="Secure Enclaves Architecture for Always Encrypted.":::

Always Encrypted with secure enclaves also addresses some of the limitations of Randomized encryption, which enables pattern matching, comparison operations, and indexing on columns using this encryption type.
