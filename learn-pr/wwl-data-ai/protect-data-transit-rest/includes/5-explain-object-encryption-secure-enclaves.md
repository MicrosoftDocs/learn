In addition to supporting encryption at rest through transparent data encryption, SQL Server supports encrypting data within columns using Always Encrypted. Once data is encrypted, the application accessing the database must have the correct certificate in order to view the plain text values of the data.

Always Encrypted allows for the encryption of data within the client application. This encryption happens automatically based on the settings within the Microsoft SQL Server database, which tell the application what the encryption settings on the database column are. Always Encrypted is based on a master encryption key as well as a column encryption key. Having both keys allows each column to be encrypted using a different encryption key for maximum data protection. Always Encrypted has a variety of key stores that can store the certificate used by encryption. Here’s an example of enabling Always Encrypted. As shown below, you can see that *NationalIDNumber* and *BirthDate* are both in plain text.

 :::image type="content" source="../media/module-33-security-final-06.png" alt-text="Query from Unencrypted table":::

The next few images will show you how we can encrypt both of these columns using Always Encrypted. The encryption could be done using T-SQL, but in this example, you will see the wizard from SQL Server Management Studio. You can reach the wizard by right-clicking on the table name in Object Explorer as shown below.

:::image type="content" source="../media/module-33-security-final-07.png" alt-text="Launching the Encryption Wizard in SQL Server Management Studio":::

When you click on Encrypt Columns, the wizard will launch.

:::image type="content" source="../media/module-33-security-final-08.png" alt-text="Always Encrypted Wizard launch screen":::

In the image below, you will see the Always Encrypted launch screen. Click next to choose the columns you want to encrypt.

:::image type="content" source="../media/module-33-security-final-09.png" alt-text="Always Encrypted Column selection":::

In the image above, there are two different types of encryption specified. The *NationalIDNumber* column is encrypted with Deterministic encryption, and the *BirthDate* column is encrypted using Randomized encryption. Randomized encryption is more secure than Deterministic encryption, but is more limited. The type of encryption cannot be changed after the column is created. You would use Randomized encryption for columns that had a small number of well-known distinct values that could potentially be guessed by someone with access to the encrypted values. An example of a potentially guessable column would a three-digit credit card verification code.

Using Always Encrypted with Randomized encryption is more limited because the randomization means that the same value is not always encrypted the same way. The only thing you can do with columns with Randomized encryption is to return them in your results. With Deterministic encryption, a given value always is encrypted to the same string so we can compare columns to a constant using equality and inequality operators, and we can compare columns with other columns to do joins, grouping, and indexing.

Always Encrypted with secure enclaves (supported in SQL Server 2019) addresses these limitations and enables pattern matching, comparison operations, and indexing on columns using Randomized encryption.

Another thing to note is that the wizard is generating a column encryption key, which is the key that actually performs the data encryption. Each column being encrypted may have its own key, or as shown here, you can use the same key to encrypt both columns.

After identifying the columns you are encrypting, you can click next and you will see the Master Key Configuration screen:

:::image type="content" source="../media/module-33-security-final-10.png" alt-text="Master Key Configuration":::

In this screen, you create the column master key, which is used to encrypt the column encryption keys. You can supply your own key, if you are using T-SQL to encrypt the columns. This key must be stored in a key store such as the Windows Certificate Store, Azure Key Vault, or a hardware security module. The database engine never stores the column master key, and only contains the metadata about where it is stored. Not storing the master key protects data access from users who have full access to the database.

For the highest level of security, the key should be stored within a third party key store such as Azure Key Vault. Never generate the keys on the server hosting your database, as the key could potentially be extracted from memory on that server. In the example below, the key is being stored in Azure Key Vault. After clicking next, the wizard provides you the option to either finish the encryption process now, or to generate a PowerShell script. Once you complete the process, the data will appear as encrypted ciphertext to anyone querying the data without the key.

:::image type="content" source="../media/module-33-security-final-11.png" alt-text="Employees Table with Encrypted Data":::

In order to decrypt data from an Always Encrypted column, your application needs an Always Encrypted driver to connect to the database. The application has access to the key store where the Always Encrypted keys are stored, and the application can then retrieve the data. Data that is written back to the database is encrypted at the client through the driver.

In addition to the driver, the application’s connection string needs to have the setting “Column Encryption Setting=enabled” placed within it. This setting will cause a metadata lookup to be made for each column that is used by the application. To minimize these metadata lookups, the application needs to be modified by updating the *SqlCommandColumnEncryptionSetting* on the *SqlConnection* objects within the .NET application. Values of either Disabled, Enabled or *ResultSet* can be specified. These settings must be set for each database query that the application submits.

The Disabled setting will prevent the application from executing any metadata queries against the database for that query.

The Enabled setting will cause the application to execute the metadata queries for all columns in the SELECT clause of the T-SQL statement as well as the WHERE clause of the T-SQL statement.

The *ResultSet* setting will cause the metadata queries to be executed for only the values within the SELECT statement.

So to determine which setting of the *SqlCommandColumnEncryptionSetting* should be used, you need to know where in the statement the encrypted columns occur.

## Secure enclaves

Starting with SQL Server 2019, Always Encrypted supports a feature called secure enclaves, which allows more robust querying of encrypted data. A secure enclave is a secured region of memory within the SQL Server process that acts as a trusted execution environment for processing encrypted data. This enclave appears as a black box to SQL Server, and it is not possible to view any data or code, even with a debugger. The image below shows the architecture of this process:

:::image type="content" source="../media/module-33-security-final-12.png" alt-text="Secure Enclaves Architecture":::

Secure enclaves allow pattern matching and range comparison on data that is stored in columns using Randomized encryption.
