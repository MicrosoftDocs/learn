
Cryptographic failures are failures related to cryptography (or lack thereof) that often leads to sensitive data exposure or system compromise.

Implementation mistakes leading to unexpected cryptographic errors. Firstly, let's being with distinguishing between encoding, encryption and hashing in general programming terms.

**Encoding** a value helps transmit data in a channel, such as base 64 encoding over HTTP, but doesn't provide security. It changes the format of a value so that it obstructs but not protects the value.
**Encryption** is a reversible operation that translates text into what may seem a random and meaningless cypher. To decrypt the value an encryption *key* is needed.
**Hashing** is a one-way operation of mapping input data into fixed-size values (value hash). There's no way to reverse hash a value.

> [!WARNING]
> Avoid writing your own cryptographic algorithms. Instead, use the strong cryptographic algorithms provided by .NET.

.NET framework provided you with all the tools one may require, that is, encryption, hashing and random number generation, out of the box.

Your web applications deal with user data and their accounts. How to ensure you securely encrypt a secret, generate a password hash, or create a temporary password in your app? To figure this out, let's explore a couple of examples of what ``System.Security.Cryptography`` namespace has to offer.

### Encryption

To securely encrypt a value like a string or integer, symmetric or asymmetric encryption can be used. To encrypt data with symmetric-key algorithm, we can use Advanced Encryption Standard (AES). In next example, a new instance of the AES class is created and used it to generate a new key and initialization vector (IV).​ The Advanced Encryption Standard is used to encrypt any type of managed stream, then the stream is wrapped with CryptoStream.

 ```csharp
Aes aes = Aes.Create();​
CryptoStream cryptStream = new CryptoStream(fileStream,
                                            ​aes.CreateEncryptor(aes.Key, aes.VI),​
                                            CryptoStreamMode. Write);
 ```

### Hashing

Hashing is a one way operation. When using a hashing function to hash nonunique inputs such as passwords, use a *salt value* added to the original value before hashing.

```csharp
public static byte[] HashPassword256(string password)​
{​
    System.Security.Cryptography.SHA256 mySHA256 = System.Security.Cryptography.SHA256.Create();​
    var encoding = new System.Text.UnicodeEncoding();​
    return mySHA256.ComputeHash(encoding.GetBytes(password));​
}        
```

### Random numbers

Temporary password or access codes are intended to be unique per user. The uniqueness can be achieved by introducing random character generation. You may be familiar with System.Random class. It's worth noting how the *randomness* is achieved. `System.Random` is a deterministic pseudo-random sequence generator. It’s predictable and seeded only from the system clock, which means it's guessable. In matter of fact, Microsoft Learn documentation explicitly states it shouldn't be used for generating passwords.
To generate a cryptographically secure random number, such as one that's suitable for creating a random password `RandomNumberGenerator` instance should be used.

```csharp
var randomNumberGenerator = System.Security.Cryptography.RandomNumberGenerator.Create();​
```

By using `RandomNumberGenerator` you can eliminate the changes of two or more users ending up with the same, what should be unique, token or password.

### Code review notes

You don't want to unnecessarily store any sensitive data in your system. If you do, make sure you encrypt all data in transit and at rest with the use of HTTPS and SSL.
After studying your teams codebase, you can now make the distinction between encryption, encoding, and hashing. No crypto keys were checked into the source code repository. You're planning to research security scanning tools to run as part of the CI/CD process to prevent sensitive data and secrets from getting into the repository.
Your app has a built-in mechanism for resetting user passwords. You noticed `System.Security Cryptography.RandomNumberGenerator` being used in favor of `System.Random`.
