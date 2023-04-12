
Cryptographic failures focuses on failures related to cryptography (or lack thereof) that often leads to sensitive data exposure or system compromise.

To better understand how where implementation mistakes leading to cryptographic failures are made let's being with distinguish between encoding, encryption and hashing in general, programming sense.

**Encoding** a value provides no security, it helps transmit data in a channel (for example base 64 encoding over HTTP). It changes the format of a value, obstructs but not protects the value.
**Encryption** is a reversible operation that translates text into what may seem a random and meaningless cypher. To decrypt the value an encryption *key* is needed.
**Hashing** is a one-way operation of mapping input date into fixed-size values (value hash). There's no way to reverse hash a value.

> [!WARNING]
> Avoid writing your own cryptographic algorithms. Use strong cryptographic algorithms provided by .NET.

For .NET developers, framework provides us with all the tools one may require, i.e. encryption, hashing and random number generation, out of the box.

Suppose your web applications deals with user data and their accounts. But how do you securely encrypt a secret, generate a password hash or create a temporary password in .NET? To answers lets explore a couple of examples of what ``System.Security.Cryptography`` namespace and it's contained functionality has to offer.

### Encryption

To securely encrypt a value (string, integer etc.) we can useAdvanced Encryption Standard (AES). In the example below a new instance of the AES class is created and used it to generate new key and initialization vector (IV).​ This illustrates how to use the Advanced Encryption Standard to be used to perform encryption on any type of managed stream, then the stream is wrapped with CryptoStream.

 ```csharp
Aes aes = Aes.Create();​
CryptoStream cryptStream = new CryptoStream(fileStream,
                                            ​aes.CreateEncryptor(aes.Key, aes.VI),​
                                            CryptoStreamMode. Write);
 ```

### Hashing

Hashing is a one way operation. When using a hashing function to hash non-unique inputs such as passwords, use a *salt value* added to the original value before hashing.

```csharp
public static byte[] HashPassword256(string password)​
{​
    System.Security.Cryptography.SHA256 mySHA256 = System.Security.Cryptography.SHA256.Create();​
    var encoding = new System.Text.UnicodeEncoding();​
    return mySHA256.ComputeHash(encoding.GetBytes(password));​
}        
```

### Random numbers

System.Random isn't a random number generator. It's a deterministic pseudo-random sequence generator which mean it can be guessed by the attacker. Microsoft Learn documentation explicitly states it shouldn't be used for generating passwords. It’s predictable and seeded only from the system clock.
To generate a cryptographically secure random number, such as one that's suitable for creating a random password `RandomNumberGenerator` instance should be used.

```csharp
var randomNumberGenerator = System.Security.Cryptography.RandomNumberGenerator.Create();​
```

### Code Review Notes

You don't want to be unnecessarily storing any sensitive data in your system. If you do, make sure you encrypt all data in transit and at rest with use of HTTPS and SSL.
After studying your teams codebase you can now make the distinction between encryption, encoding and hashing. No crypto keys were checked into source code repository. You're planning to research security scanning tools to run as part of the CI/CD process to prevent sensitive data and secrets from getting in to the repository.
Your app has build in mechanism for resetting user passwords, this is where you noticed `System.Security Cryptography.RandomNumberGenerator` being used in favor of `System.Random`.
