
A proper always encrypting implementation is important to a secure database.

### Configuring Always Encrypted

The initial setup of Always Encrypted in a database involves generating Always Encrypted keys, creating key metadata, configuring encryption properties of selected database columns, and/or encrypting data that may already exist in columns that need to be encrypted. Remember that some of these tasks aren't supported in Transact-SQL and require the use of client-side tools. As Always Encrypted keys and protected sensitive data are never revealed in plaintext to the server, the Database Engine can't be involved in key provisioning and perform data encryption or decryption operations. You can use SQL Server Management Studio (SSMS) or PowerShell to accomplish such tasks.

| **Task**                                                                                                                                 | **SSMS** | **PowerShell** | **SQL** |
| ---------------------------------------------------------------------------------------------------------------------------------------- | -------- | -------------- | ------- |
| Provisioning column master keys, column encryption keys and encrypted column encryption keys with their corresponding column master keys | Yes      | Yes            | No      |
| Creating key metadata in the database                                                                                                    | Yes      | Yes            | Yes     |
| Creating new tables with encrypted columns                                                                                               | Yes      | Yes            | Yes     |
| Encrypting existing data in selected database columns                                                                                    | Yes      | Yes            | No      |

:::image type="content" source="../media/az500-always-encrypted-flow-new-ee112bee.png" alt-text="Screenhot of always encrypted wizard.":::


When setting up encryption for a column, you specify the information about the encryption algorithm and cryptographic keys used to protect the data in the column. Always Encrypted uses two types of keys: column encryption keys and column master keys. A column encryption key is used to encrypt data in an encrypted column. A column master key is a key-protecting key that encrypts one or more column encryption keys.

The Database Engine stores encryption configuration for each column in database metadata. Note, however, the Database Engine never stores or uses the keys of either type in plaintext. It only stores encrypted values of column encryption keys and the information about the location of column master keys, which are stored in external trusted key stores, such as Azure Key Vault, Windows Certificate Store on a client machine, or a hardware security module.

To access data stored in an encrypted column in plaintext, an application must use an Always Encrypted enabled client driver. When an application issues a parameterized query, the driver transparently collaborates with the Database Engine to determine which parameters target encrypted columns and, thus, should be encrypted. For each parameter that needs to be encrypted, the driver obtains the information about the encryption algorithm and the encrypted value of the column encryption key for the column, the parameter targets, as well as the location of its corresponding column master key.

Next, the driver contacts the key store, containing the column master key, in order to decrypt the encrypted column encryption key value and then, it uses the plaintext column encryption key to encrypt the parameter. The resultant plaintext column encryption key is cached to reduce the number of round trips to the key store on subsequent uses of the same column encryption key. The driver substitutes the plaintext values of the parameters targeting encrypted columns with their encrypted values, and it sends the query to the server for processing.

The server computes the result set, and for any encrypted columns included in the result set, the driver attaches the encryption metadata for the column, including the information about the encryption algorithm and the corresponding keys. The driver first tries to find the plaintext column encryption key in the local cache, and only makes a round to the column master key if it can't find the key in the cache. Next, the driver decrypts the results and returns plaintext values to the application.

A client driver interacts with a key store, containing a column master key, using a column master key store provider, which is a client-side software component that encapsulates a key store containing the column master key. Providers for common types of key stores are available in client-side driver libraries from Microsoft or as standalone downloads. You can also implement your own provider. Always Encrypted capabilities, including built-in column master key store providers vary by a driver library and its version.
