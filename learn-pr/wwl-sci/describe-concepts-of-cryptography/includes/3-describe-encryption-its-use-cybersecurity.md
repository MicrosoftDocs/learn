As you discovered in the previous unit, cryptography is the art of obscuring the meaning of a message to everyone but the intended recipient. This requires the plaintext message to be transformed into ciphertext. The mechanism that enables this is called encryption.

The methods used to encrypt a message have evolved over thousands of years, from swapping one letter for another to more elaborate mechanical devices like the Enigma machine.

Encryption now takes place in the digital world. It uses computers and mathematics to combine large random prime numbers to create keys that are used in both symmetric and asymmetric encryption.

## What is encryption?

Encryption is the mechanism by which plaintext messages are turned into unreadable ciphertext. The use of encryption enhances the *confidentiality* of data being shared with your recipient, whether they're a friend, a work colleague, or another business.

Decryption is the mechanism by which the recipient of a ciphertext message can turn it back into readable plaintext.

To facilitate the encryption and decryption process, you need to use a secret encryption key. This key is much like the one you’d use to open your car, or the door to your house. Encryption keys come in two flavors:

- Symmetric keys
- Asymmetric keys

### Symmetric keys

Symmetric key encryption is based around the idea that the same **cryptographic key** is used for both the *encryption* of the plaintext message and the *decryption* of the ciphertext message. This makes the encryption method quick and provides a degree of confidentiality about the security of the ciphertext.

With this encryption method, the cryptographic key is treated as a *shared secret* between two or more parties. The secret must be carefully guarded to avoid it being found by a bad actor. All parties must have the same cryptographic key before secure messages can be sent. Distribution of the key represents one of the challenges associated with symmetric encryption.

Consider a group or organization where each individual needs the capability to communicate securely with every other person. If the group consists of three individuals, you need only three keys.

:::image type="content" source="../media/symmetric-encryption.png" alt-text="This diagram shows how a cryptographic key is needed by all recipients for the symmetric key encryption to work":::

Now let’s consider an organization with only 100 employees, where each person needs to communicate securely with everyone else. In this case, 4,950 keys need to be created, and securely shared and managed. Lastly, imagine a government-based organization with 1,000 employees where each individual needs to communicate securely. The number of keys required is 499500. This growth can be expressed with a formula: p x (p-1) /2, where p is the number of people who need to communicate.

As the number of people in the organization grows, the number of keys increases significantly. This makes the secure management and distribution of secret keys, which are used in symmetric encryption, difficult and costly.

## Asymmetric or public-key encryption

Asymmetric encryption was developed in the 1970s. It addresses the secure distribution and proliferation of keys that are associated with symmetric encryption.  

Asymmetric encryption changed the way cryptographic keys were shared. Rather than one encryption key, an asymmetric key is composed of two elements, a **private key** and a **public key**, which form a **key pair**. The public key, as the name suggests, can be shared with anyone, so individuals and organizations don’t need to worry about its secure distribution.

The private key must be kept safe. It's looked after only by the person who generated the key pair and isn't shared with anyone.  A user who needs to encrypt a message would use the public key, and only the person holding the private key could decrypt it.

:::image type="content" source="../media/key-pair-generation.png" alt-text="This diagram shows the creation of a key pair and how you can share the public key, but need to keep the private key safe.":::

Asymmetric encryption, with its use of public and private keys, removes the burden of secure distribution of keys. This concept also addresses the proliferation of keys we saw in symmetric encryption. Consider the example of the government-based organization with 1,000 employees, where each individual must be able to communicate securely. With asymmetric encryption, every person will generate a key pair, resulting in 2,000 keys. With symmetric encryption, this would have required 450,000 keys.

### How does asymmetric encryption work

While the algorithms and mathematics that underpin asymmetric encryption are complex, the principle of how it works is relatively easy.

Let's assume that we have two people, Quincy and Monica, who need to communicate securely and privately. Using readily available software tools, Quincy and Monica each create their own key pair.

The first thing that Quincy and Monica will do is share their **public keys** with each other. Because public keys aren't secret, they can exchange them via email.

:::image type="content" source="../media/asymmetric-public-key-sharing.png" alt-text="This diagram shows how Quincy must share his public key with Monica so she can send him ciphertext. It also slows Monica sharing her public key with Quincy.":::

When Quincy wants to send a secured message to Monica, he uses her **public key** to encrypt the plaintext and create the ciphertext. Quincy then sends the ciphertext to Monica using whatever means he wants, such as email. When Monica receives the ciphertext, she uses her **private key** to decrypt it, turning it back to plaintext.

:::image type="content" source="../media/asymmetric-encryption-process.png" alt-text="This diagram shows the process of encrypting a message using Monica’s public key, and Monica decrypting the ciphertext using her private key.":::

When Monica wants to respond, she uses Quincy's **public key** to encrypt the message before sending it. Quincy then uses his **private key** to decrypt it.

Let's assume that Eve is interested in what Quincy and Monica are saying. Eve intercepts a ciphertext message sent from Quincy to Monica. Additionally, Eve knows Monica's public key.

Because Eve doesn’t know Monica’s private key, she has no way of decrypting the ciphertext. If Eve tries to decrypt the ciphertext with Monica’s public key, she will see gibberish.

Given the nature of asymmetric encryption, even if you know the public key, it's impossible to discover the private key.

In this two-minute video, we'll demonstrate how symmetric and asymmetric encryption work, and how they protect your documents from being read by unauthorized people.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWNyAM]

### Different types of encryptions

There are several different types of symmetric and asymmetric encryption, and new versions are being invented all the time. Here are some that you may encounter:

- **Data Encryption Standard (DES)** and **Triple-DES**. This was one of the first symmetric encryption standards used.
- **Advanced encryption standard (AES)**. AES replaced DES and Triple DES, and is still widely used today.
- **RSA**. This was one of the first asymmetric encryption standards, and variations are still being used today.

## Where is encryption used?

Encryption is used worldwide in almost every facet of our lives, from making a call on your smartphone to using your credit card for a purchase in a shop. Encryption is used even more when you browse the web.

*Web browsing* - you may not realize it, but every time you go to a website where the address starts with HTTPS, or there is a padlock icon, encryption is being used. In the address bar for this web page, you will notice it starts with https://. Similarly, when you connect to your bank through the web or make an online purchase where you provide sensitive information, such as a credit card number, you should make sure you see https:// in the address bar.

*Device encryption* – many operating systems provide tools to enable encryption of hard drives and portable devices. For example, Windows BitLocker, a feature of the Windows operating system, provides encryption for your PC hard drive or portable drives that may connect via USB.

*Messaging applications* – some commonly known and available messaging applications encrypt messages.

*Mobile communications* - whether you're using a smartphone or other mobile communications device, encryption is used to securely register it with the nearest mast or cell tower. This ensures you always have the best signal strength.
