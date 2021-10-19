As you discovered in the previous unit, cryptography is the art of obscuring the meaning of a message to everyone but the intended recipient. This requires the plaintext message to be transformed into ciphertext. The mechanism that enables that is called encryption.

The methods used to encrypt a message have evolved over thousands of years, from swapping one letter for another to more elaborate mechanical devices like the Enigma machine used throughout the second world war.

Encryption now takes place in the digital world and uses computers and mathematics to combine large random prime numbers to create keys that are used in both symmetric and asymmetric encryption today.

## What is encryption

Encryption is the mechanism by which plaintext messages are turned into unreadable ciphertext. The use of encryption enhances the *confidentiality* of data being shared with your recipient, whether they're a friend, a work colleague, or another business.

Decryption is the mechanism by which the recipient of a ciphertext message can turn it back into readable plaintext.

To facilitate the encryption and decryption process requires the use of a secret encryption key. This key is much like the one you’d use to open your car or the door to your house. Encryption keys come in two flavors:

- Symmetric keys
- Asymmetric keys

### Symmetric keys

Symmetric key encryption is based around the idea that the same **cryptographic key** is used for both the *encryption* of the plaintext message and the *decryption* of the ciphertext message. Which makes this encryption method very quick and provides a degree of confidentiality about the security of the ciphertext.

With this encryption method, the cryptographic key is treated as a *shared secret* between two or more parties that must be carefully guarded to avoid it falling into the hands of a bad actor. All parties must be in possession of the same cryptographic key before secure messages can be sent, so distribution of the key, represents one of the challenges associated with symmetric encryption.

Consider a group or organization where each individual needs the capability to communicate securely with every other individual. If the group consists of three individuals, you need only three keys.

:::image type="content" source="../media/symmetric-encryption.png" alt-text="This diagram shows how a cryptographic key is needed by all recipients for the symmetric key encryption to work":::

Now let’s consider an organization with only 100 employees where each person needs to communicate with every other person in a secure manner. In this case, 4950 keys need to be created and securely shared and managed. Lastly, imagine a government-based organization with 1000 employees where each individual need to communicate securely. The number of keys required is 450,000. This growth can be expressed with a formula: p x (p-1) /2, where p is the number of people that need to communicate.

As the number of people in the organization grows the number of keys required grows significantly, making the secure management and distribution of the secret keys, used in symmetric encryption, difficult and costly.

## Asymmetric or public-key encryption

In the 1970s, asymmetric encryption was developed, which addresses the secure distribution of and the proliferation of keys, that are associated with symmetric encryption.  

Asymmetric encryption changed the way cryptographic keys were shared. Rather than one encryption key, an asymmetric key is composed of two elements, a **private key** and a **public key**, which form a **key pair**. The public key, as the name suggests, can be shared with anyone, so individuals and organizations don’t need to worry about secure distribution of this key. The private key has to be kept safe, but that key is kept only by the person who generated the key pair and is not shared with anyone, hence the name, private key.  A user that needs to encrypt a message would use the public key and only the person holding the private key can decrypt the message. You will see this in more detail below.

:::image type="content" source="../media/key-pair-generation.png" alt-text="This diagram shows the creation of a key pair and how you can share the public key, but need to keep the private key safe.":::

Asymmetric encryption, with its use of a public key and private key removes the burden of secure distribution of keys. This concept also addresses the proliferation of keys we saw in symmetric encryption. Consider the example of the government-based organization with 1000 employees where each individual must be able to communicate securely. With asymmetric encryption, each individual will generate a key pair, resulting in 2,000 keys. In symmetric encryption this would have required 450,000 keys.

### How does asymmetric encryption work

While the algorithms and mathematics that underpin asymmetric encryption are complex, the principle of how it works is relatively easy.

Let's assume that we have two people, Quincy and Monica, who need to communicate securely and privately.

Using readily available software tools, Quincy creates his own key pair, and Monica also creates a key pair.

The first thing that Quincy and Monica will need to do is share their **public keys** with each other. Since public keys are not secret, they can exchange them via email.

:::image type="content" source="../media/asymmetric-public-key-sharing.png" alt-text="This diagram shows how Quincy must share his public key with Monica so she can send him ciphertext. It also slows Monica sharing her public key with Quincy.":::

When Quincy wants to send a secured message to Monica, he uses Monica's **public key** to encrypt the plaintext and create the ciphertext. Quincy then sends the ciphertext to Monica using whatever means he wants, for example, email. When Monica receives the ciphertext, she uses her **private key** to decrypt it, turning it back to plaintext.

:::image type="content" source="../media/asymmetric-encryption-process.png" alt-text="This diagram shows the process of encrypting a message using Monica’s public key, and Monica decrypting the ciphertext using her private key.":::

When Monica wants to respond, she uses Quincy's **public key** to encrypt the message before sending it, and Quincy uses his **private key** to decrypt it.

Let's assume that Eve is interested in what Quincy and Monica are saying. Eve intercepts a ciphertext message sent from Quincy to Monica. Additionally, Eve knows Monica's public key.

Because Eve doesn’t know Monica’s private key, she has no way of decrypting the ciphertext. If Eve tries to decrypt the ciphertext with Monica’s public key all she will get is gibberish.

Given the nature of asymmetric encryption, even if you know the public key, it's impossible to discover the private key.

### VIDEO showing how asymmetric keys work

In this short 2-minute video, we'll demonstrate how symmetric and asymmetric encryption work and how they protect your documents from being read by unauthorized people.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWNyAM]

### Different types of encryptions

There are several different types of symmetric and asymmetric encryption, and new versions are being invented all the time. Here are some of that you may encounter:

- **Data Encryption Standard (DES)** & **Triple-DES** - This was one of the first symmetric encryption standards used.
- **Advanced encryption standard (AES)** - AES replaced DES and Triple DES and is still widely used today.
- **RSA** - This was one of the first asymmetric encryption standards, and variations are still being used today.

## Where is encryption used?

Encryption is used worldwide in almost every facet of our lives, from making a call on your smartphone to using your credit card to make a purchase in a shop, and even more so when you browse the web.

*Web browsing* - You may not realize it, but every time you go to website where the address starts with HTTPS or there is an icon showing a padlock, encryption is being used. Notice the address bar for this web page and you will notice the address starts with https://. Similarly, anytime you connect to your bank through the web or make an online purchase where you're providing sensitive information such as a credit card number, you should make sure you see https:// in the address bar.

*Device encryption* – many operating systems provide tools to enable encryption of hard drives and portable devices. Windows Bit Locker, a feature of the Windows operating system, for example, provides encryption for your PC hard drive as well as portable drives that may connect via a USB device.

*Messaging applications* – Some commonly known and available messaging applications encrypt messages.

*Mobile communications* - Whether you're using a smartphone or other mobile communications device, encryption is used by your phone to securely register your mobile device to the nearest communications mast or cell tower, ensuring you always have the best signal strength to make a call.
