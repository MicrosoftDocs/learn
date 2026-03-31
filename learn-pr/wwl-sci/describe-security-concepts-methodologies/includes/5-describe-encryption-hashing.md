
One way to mitigate against common cybersecurity threats is to encrypt sensitive or valuable data. *Encryption* is the process of making data unreadable and unusable to unauthorized viewers. To use or read encrypted data, it must be *decrypted*, which requires the use of a secret key. Even if an attacker intercepts or gains access to encrypted data, it remains useless to them without the corresponding key.

## Types of encryption

There are two primary types of encryption: symmetric and asymmetric.

:::image type="content" source="../media/6-encryption.png" alt-text="Diagram showing symmetric encryption using a single shared key for both encryption and decryption, and asymmetric encryption using a public key to encrypt and a private key to decrypt." lightbox="../media/6-encryption.png":::

### Symmetric encryption

Symmetric encryption uses the **same key** to both encrypt and decrypt data. Because only one key is involved, symmetric encryption is computationally fast and well-suited for encrypting large amounts of data—for example, files stored on a hard drive or records in a database.

The main challenge with symmetric encryption is key distribution: both parties need access to the same secret key, and securely sharing that key—especially over a network—can be difficult.

### Asymmetric encryption

Asymmetric encryption uses a **key pair**: a public key and a private key. These keys are mathematically related, but you can't derive the private key from the public key.

- Data encrypted with the **public key** can only be decrypted with the corresponding **private key**.
- Data signed with the **private key** can be verified with the corresponding **public key**.

Because the public key can be freely shared, asymmetric encryption solves the key distribution problem of symmetric encryption. Anyone can encrypt data using your public key, but only you—holding the private key—can decrypt it. Asymmetric encryption is used in many security protocols you interact with daily, including HTTPS, which secures websites, and email encryption.

### Digital signatures

Asymmetric encryption also enables *digital signatures*, which verify both the authenticity and integrity of data. When a sender signs data with their private key, anyone with the sender's public key can verify that:

1. The data came from the expected sender (authenticity).
2. The data wasn't modified after it was signed (integrity).

Digital signatures are used to verify software downloads, authenticate email messages, and secure electronic documents and transactions.

## Encryption by data state

### Encryption for data at rest

Data at rest is data stored on a physical device, such as a server hard drive, a database, or a cloud storage account. Encryption of data at rest ensures the data is unreadable without the keys needed to decrypt it.

If an attacker obtained a hard drive with encrypted data and didn't have access to the encryption keys, they would be unable to read the data. This protection remains even if the physical storage media is stolen or the storage account is accessed without authorization.

### Encryption for data in transit

Data in transit is data moving from one location to another, such as across the internet, between services, or over a private network. Data in transit is vulnerable to interception by anyone who can observe the network traffic.

Encrypting data in transit protects it from eavesdropping and interception. HTTPS is the most familiar example: when you access a website over HTTPS, the connection is secured using Transport Layer Security (TLS), which ensures that data exchanged between your browser and the server can't be read by third parties. The same principle applies to data moving between cloud services and to VPN connections that protect traffic over public networks.

### Encryption for data in use

Data in use refers to data actively being processed—for example, data loaded into a computer's memory (RAM) or being worked on by a CPU. Traditional encryption protects data at rest and in transit, but data is typically decrypted when loaded into memory for processing, creating a window of potential exposure.

Encryption of data in use is achieved through *confidential computing* technologies that create protected execution environments, sometimes called *secure enclaves*, where data can be processed without being exposed even to the operating system or hypervisor. This is especially important in multitenant environments where different customers may share the same physical hardware.

## Key management

Encryption is only as secure as the keys used to encrypt data. An encryption key that is stolen or exposed makes encrypted data accessible to attackers, defeating the purpose of encryption. Key management covers how encryption keys are generated, stored, protected, rotated, and eventually retired.

Key management best practices include:

- **Storing keys separately from the data they protect**: If keys are stored alongside encrypted data, an attacker who gains access to one automatically has both.
- **Using dedicated hardware for key storage**: Hardware security modules (HSMs) are specialized, tamper-resistant devices designed specifically to store and protect cryptographic keys.
- **Rotating keys regularly**: Changing encryption keys periodically limits the amount of data exposed if a key is ever compromised.
- **Controlling access to keys tightly**: Only authorized users and systems should be able to access decryption keys, enforced through strong authentication and least-privilege access principles.

Cloud key management services—such as Azure Key Vault—provide a centralized, managed service for storing and managing encryption keys, certificates, and secrets. These services reduce the risk of key exposure, support key rotation workflows, and integrate with other cloud services to provide encryption without exposing key material to application code or administrators.


## Hashing

Hashing uses an algorithm to convert any input into a fixed-length string of characters called a *hash* (or *digest*). Unlike encryption, hashing is a one-way process: you can't reverse a hash to recover the original input. Each time the same input is hashed using the same algorithm, the same hash value is produced, making the hash a reliable unique fingerprint for that data.

Hashing is different from encryption in that it doesn't use keys, and the hashed value can't be reversed back to the original data. This makes hashing useful for scenarios where you need to verify data without ever needing to store or read the original value.

:::image type="content" source="../media/6-hashing-3-inline.png" alt-text="Diagram showing original text passing through a hashing algorithm to produce a fixed-length hash value." lightbox="../media/6-hashing-3-inline.png":::

### How hashing protects passwords

Hashing is widely used to protect stored passwords. Instead of storing a user's actual password, a system stores only the hash of that password. When a user signs in, the system hashes the password they enter and compares it to the stored hash. If the hashes match, the authentication succeeds—without the system ever storing or transmitting the actual password in plain text.

This is more secure than storing plain-text passwords because even if the password database is stolen, the attacker gets only hashes. However, basic hashing has a known vulnerability: because hash functions are deterministic, attackers can precompute hashes for millions of common passwords and look them up in tables—called *rainbow tables* or *dictionary attacks*—to find matches.

### Salting

To defend against precomputed attacks, passwords are typically *salted* before hashing. A *salt* is a unique, randomly generated value created for each individual password and added to it before hashing. Because every password gets a different salt, two users with the same password produce different hashes in the database. This makes precomputed rainbow tables ineffective, because the attacker would need a separate lookup table for every possible salt value.

Salting is a standard best practice in secure password storage and is required for any properly implemented authentication system.
