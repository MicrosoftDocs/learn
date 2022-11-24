## A02- Broken Access Control

Failures related to cryptography that often leads to sensitive data exposure or system compromise.
.NET provides us with all the tools we need, encryption, hashing and random number generation out of the box

> [!CAUTION]
> Avoid writing your own cryptographic libraries.

Good practices would include

- Classify the data​
- Protection data in transit and at rest and in use (Azure confidential computing) ​
- Use strong cryptographic algorithms like AES

## Encroption
Let's explore a couple of examples of what ``System.Security.Cryptography`` has to offer.
We'll start with Advanced Encryption Standard (AES), in the example below we create a new instance of the Aes (Strong) class. This generates a new key and initialization vector (IV).​
The following example illustrates how to use the Advanced Encryption Standard to used to perform encryption on any type of managed stream, then the steam is wrapped with CryptoStream.

 ```csharp
Aes aes = Aes.Create();​
CryptoStream cryptStream = new CryptoStream(fileStream,
                                            ​aes.CreateEncryptor(aes.Key, aes.VI),​
                                            CryptoStreamMode. Write);
 ```

## Hashing

Hashing is a one way
When using a hashing function to hash non-unique inputs such as passwords, use a salt value added to the original value before hashing.

```csharp
public static byte[] HashPassword256(string password)​
{​
    System.Security.Cryptography.SHA256 mySHA256 = System.Security.Cryptography.SHA256.Create();​
    var encoding = new System.Text.UnicodeEncoding();​
    return mySHA256.ComputeHash(encoding.GetBytes(password));​
}        
```

## Random numbers

System.Random is not a random number generator, it is a deterministic pseudo-random sequence generator, docs explicitly says it should not be used for generating passwords. It’s predictable and seeded only from the system clock. To generate a cryptographically secure random number, such as one that's suitable for creating a random password.

```csharp
var randomNumberGenerator = System.Security.Cryptography.RandomNumberGenerator.Create();​
```

> [!TIP]
> Make sure you know when to use System.Random versus System.Security Cryptography.RandomNumberGenerator as your choice can lead to security vulnerability
