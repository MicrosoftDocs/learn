Cryptographic failures are failures related to cryptography, or the lack thereof, that often leads to exposing sensitive data or compromising your system. Implementation mistakes often cause unexpected cryptographic errors.

First, let's begin by distinguishing between encoding, encryption, and hashing in general programming terms.

- **Encoding** a value converts the data to a different format for storage, transmission, compression, or decompression. Encoding helps transmit data in a channel, such as base 64 encoding over HTTP, but it doesn't provide security. It changes a value's format, but it doesn't protect the value from detection.
- **Encryption** is a reversible operation that translates text into what might seem like a random and meaningless cypher. To decrypt the value, an encryption *key* is needed.
- **Hashing** is a one-way operation of mapping input data into fixed-size values (value hash). There's no way to reverse hash a value.

> [!WARNING]
> Avoid writing your own cryptographic algorithms. Instead, use the strong cryptographic algorithms .NET provides.

The .NET framework provides you with all the tools you need out of the box, including encryption, hashing, and random-number generation.

Your web applications deal with user accounts and data, but how do you securely encrypt a secret, generate a password hash, or create a temporary password in your app? To answer this question, let's explore a couple of examples of what the ``System.Security.Cryptography`` namespace has to offer.

### Encryption

To securely encrypt a value like a string or integer, you can use symmetric or asymmetric encryption. To encrypt data with a symmetric-key algorithm, you can use the Advanced Encryption Standard (AES). In the next example, we create new instance of the `Aes` class and use it to generate a new key and initialization vector (IV).​ We use the AES to encrypt any type of managed stream. The stream is then wrapped with `CryptoStream`.

 ```csharp
Aes aes = Aes.Create();​
CryptoStream cryptStream = new CryptoStream(fileStream,
                                            ​aes.CreateEncryptor(aes.Key, aes.VI),​
                                            CryptoStreamMode. Write);
 ```

### Hashing

Hashing is a one-way operation. When you're using a hashing function to hash nonunique inputs such as passwords, use a *salt value* added to the original value before hashing.

```csharp
public static byte[] HashPassword256(string password)​
{​
    System.Security.Cryptography.SHA256 mySHA256 = System.Security.Cryptography.SHA256.Create();​
    var encoding = new System.Text.UnicodeEncoding();​
    return mySHA256.ComputeHash(encoding.GetBytes(password));​
}        
```

### Random numbers

Temporary password or access codes are intended to be unique per user. You can achieve this uniqueness by introducing random-character generation, and it's worth noting how the *randomness* is achieved. You might be familiar with the `System.Random` class. `System.Random` is a deterministic pseudo-random sequence generator. It’s predictable and seeded only from the system clock, which means it's guessable. As a matter of fact, Microsoft Learn documentation explicitly states that you shouldn't use it for generating passwords. To generate a cryptographically secure random number that's suitable for creating a random password, you should use a `RandomNumberGenerator` instance.

```csharp
var randomNumberGenerator = System.Security.Cryptography.RandomNumberGenerator.Create();​
```

By using `RandomNumberGenerator`, you can eliminate the chances of two or more users ending up with the same token or password when they must be unique.

### Code review notes

You don't want to unnecessarily store any sensitive data in your system. If you do, make sure you encrypt all data in transit and at rest with the use of HTTPS and TLS/SSL. After studying your team's codebase, you can now make the distinction between encryption, encoding, and hashing. No crypto keys were checked into the source code repository. You're planning to research security-scanning tools to run as part of the CI/CD process to prevent sensitive data and secrets from getting into the repository.

Your app has a built-in mechanism for resetting user passwords. You noticed `System.Security Cryptography.RandomNumberGenerator` being used in favor of `System.Random`.
