Data encryption forms the foundation of database security, protecting sensitive information from unauthorized access even if attackers gain access to the underlying storage. In Microsoft's SQL platforms, you have multiple encryption options designed for different scenarios, from encrypting data at rest to protecting data in use during query processing.

Understanding when to use each encryption method helps you design security solutions that balance protection requirements with application performance. This unit explores the encryption technologies available in SQL Server, Azure SQL, and SQL databases in Microsoft Fabric.

## Understand encryption layers

Database encryption operates at different layers, each addressing specific security concerns. Transparent Data Encryption (TDE) encrypts data at rest, protecting the physical database files. Column-level encryption targets specific sensitive columns, while Always Encrypted protects data throughout its lifecycle, including during query processing.

:::image type="content" source="../media/encryption.png" alt-text="Diagram comparing three encryption layers: TDE at the database file level, column-level encryption at specific columns, and Always Encrypted with encryption keys held outside the database at the client application level.":::

With TDE enabled, SQL Server automatically encrypts the database files, transaction logs, and backups. The encryption happens transparently to applications, requiring no code changes. TDE uses a database encryption key protected by a certificate stored in the `master` database.

Unlike TDE, column-level encryption requires you to explicitly encrypt and decrypt data in your T-SQL code or application. This approach gives you granular control over which columns contain sensitive data and who can decrypt them.

Always Encrypted takes a different approach by keeping encryption keys outside the database engine. The database never sees plaintext data, providing protection even from database administrators with high-level access.

## Configure Always Encrypted

Always Encrypted protects sensitive data by ensuring the database engine never processes plaintext values. Client applications hold the encryption keys and perform all encryption and decryption operations. This separation means that even users with administrative access to the database can't view the protected data.

:::image type="content" source="../media/sql-data-flow.png" alt-text="Diagram showing the data flow for Always Encrypted, where client applications encrypt and decrypt data while the database engine only processes ciphertext.":::

To implement Always Encrypted, you first create a column master key (CMK) that protects the column encryption keys. Store the CMK in a secure key store such as Azure Key Vault, Windows Certificate Store, or a hardware security module.

```sql
CREATE COLUMN MASTER KEY MyCMK
WITH (
    KEY_STORE_PROVIDER_NAME = 'AZURE_KEY_VAULT',
    KEY_PATH = 'https://mykeyvault.vault.azure.net/keys/MyCMK/abc123'
);
```

This statement creates a metadata entry pointing to your key in Azure Key Vault. The actual key material remains in the vault, never stored in the database.

Next, create a column encryption key (CEK) protected by the column master key:

```sql
CREATE COLUMN ENCRYPTION KEY MyCEK
WITH VALUES (
    COLUMN_MASTER_KEY = MyCMK,
    ALGORITHM = 'RSA_OAEP',
    ENCRYPTED_VALUE = 0x01700000016C006F00...
);
```

The encrypted value contains the CEK encrypted with your CMK. Applications retrieve this encrypted value and use the CMK to decrypt it locally.

When creating or altering tables, specify the encryption type for sensitive columns:

```sql
CREATE TABLE Employees (
    EmployeeID int PRIMARY KEY,
    SSN char(11) COLLATE Latin1_General_BIN2
        ENCRYPTED WITH (
            ENCRYPTION_TYPE = DETERMINISTIC,
            ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256',
            COLUMN_ENCRYPTION_KEY = MyCEK
        ),
    Salary money
        ENCRYPTED WITH (
            ENCRYPTION_TYPE = RANDOMIZED,
            ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256',
            COLUMN_ENCRYPTION_KEY = MyCEK
        )
);
```

Choose deterministic encryption when you need to perform equality comparisons, joins, or use the column in `WHERE` clauses. Randomized encryption provides stronger security but limits query operations on the encrypted column.

## Implement column-level encryption

Column-level encryption using T-SQL functions provides an alternative when you need more control over the encryption process or when Always Encrypted isn't suitable for your scenario. This approach uses symmetric or asymmetric keys stored within the database.

First, create a database master key and certificate:

```sql
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongPassword123!';

CREATE CERTIFICATE SensitiveDataCert
WITH SUBJECT = 'Certificate for sensitive data encryption';
```

Create a symmetric key protected by the certificate:

```sql
CREATE SYMMETRIC KEY SensitiveDataKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE SensitiveDataCert;
```

To encrypt data, open the symmetric key and use the `ENCRYPTBYKEY` function:

```sql
OPEN SYMMETRIC KEY SensitiveDataKey
DECRYPTION BY CERTIFICATE SensitiveDataCert;

INSERT INTO CustomerData (CustomerID, CreditCardNumber)
VALUES (1, ENCRYPTBYKEY(KEY_GUID('SensitiveDataKey'), '4111-1111-1111-1111'));

CLOSE SYMMETRIC KEY SensitiveDataKey;
```

Decryption follows a similar pattern using `DECRYPTBYKEY`:

```sql
OPEN SYMMETRIC KEY SensitiveDataKey
DECRYPTION BY CERTIFICATE SensitiveDataCert;

SELECT CustomerID, 
       CONVERT(varchar(20), DECRYPTBYKEY(CreditCardNumber)) AS CardNumber
FROM CustomerData;

CLOSE SYMMETRIC KEY SensitiveDataKey;
```

This approach requires explicit key management in your code, which adds complexity but also flexibility. You can grant or deny permissions to the symmetric key, controlling exactly which users can decrypt the data.

## Choose the right encryption approach

Selecting the appropriate encryption method depends on your security requirements and application constraints. Consider these factors when making your decision.

Use TDE when you need to protect data at rest without application changes. TDE works well for compliance requirements that mandate encryption of database files and backups. However, TDE doesn't protect data from users who can connect to the database with appropriate permissions.

Choose Always Encrypted when you need to protect data from database administrators or when sensitive data must remain encrypted during query processing. This approach requires client driver support and impacts which operations you can perform on encrypted columns.

Implement column-level encryption when you need granular control over encryption and decryption, or when you must encrypt only specific columns without the overhead of Always Encrypted infrastructure. This method requires more development effort but offers flexibility in key management.

> [!TIP]
> You can combine encryption methods. For example, enable TDE for baseline protection of data at rest, then add Always Encrypted for your most sensitive columns.

For SQL databases in Microsoft Fabric, TDE is enabled by default and managed automatically. Focus your encryption design decisions on column-level protection using Always Encrypted or symmetric key encryption based on your application requirements.
