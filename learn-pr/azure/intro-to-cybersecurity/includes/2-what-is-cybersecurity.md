Cybersecurity consists of the technologies, processes, and training that help protect systems, networks, programs, and data from cyberattacks, damage, and unauthorized access. It’s also called *information technology security* or *infosec*. Cyberattacks continuously evolve, and in a world where companies are racing to move and maintain their businesses online, cybersecurity is an important, large, and growing field.

Securing a company's intellectual property (IP) and data has become increasingly more complex. Contoso has their data residing in multiple locations, i.e., in Azure, on-premises, laptops, personnel cell phones, and backup drives.

You decide to start the training lesson by defining vocabulary used to discuss cybersecurity. Although you could include many more terms, you decide to focus on the following primary terms.

- _Firewall_: The first line of defense between untrusted network application traffic and your trusted device or your company’s trusted network.
- _Authentication_: validating that the user is who they claim to be.
- _Malware_: Defined as *mal*icious soft*ware* that disrupts the normal operations of a computer. Malware is classified as an *advanced persistent threat* (APT). This means that after it’s successfully deployed, it remains undetected until activated.
- _Ransomware_: a form of malware that exploits the vulnerability of a system to encrypt files and demand payment to unencrypt the files. Typical introduced from email.
- _Trojan Horse_: Named after the Greeks hollow horse to gain entrance into the city of Troy and win the war. A form of malware software that appears to be something it isn’t. Functions as a hacker’s back door into an organization’s system.
- _Phishing_: An attempt to trick someone into sharing personal information or sending money to them. The most common method is using email messages that appear to be legitimate.
- _Spear-Phishing_: A targeted phishing attack. It targets specific organizations, businesses, or individuals.
- _Data Breach_: Successful illegal access of data stored on an internal company system. Usually accomplished by using stolen credentials, customer's personal information, credit card numbers, bank account numbers, and more.
- _Kill chain_: Framework for a cyberattack. Typically, it consists of:
1. Reconnaissance of target.
1. Determination of the best attack methods.
1. Delivery of the malware.
1. The exploitation of malware on the target.
1. Attacker gaining persistence access to the target.
1. The intruder initiating the end goal of intrusion.

- _Botnet_: A collection of compromised internet devices under third-party control. Each device is known as a bot. A botnet distributes malware or perform other functions decided by the third party.
- _Zero-day vulnerability_: A software or hardware flaw for which there is no existing patch. Named after the medical term Patient Zero. When a zero-day vulnerability is discovered, the software or hardware vendor has no days to fix the flaw. Zero-days are a hacker’s most dangerous exploit.
- _Computer worm_: A harmful software code that can replicate and search for new hosts to infect. Once infected, it can destroy data and/or corrupt the system.
- _Computer virus_: This is a type of malware that can replicate itself by modifying other computer applications. It’s malicious software that interferes with a computer’s operations.
- _Cryptography_: A field of mathematics that is used to protect data with encryption. The unencrypted data is *plaintext,* and the encrypted information is a *cipher*. A cryptographic key is often a large number and is "seeded" into the encryption algorithm to scramble the data.
- _Encryption_: is the process of encoding data to keep the contents secret.
  - _Public key encryption_: This method of encryption uses a private key and a public key. These two different keys are a *keypair* and they mathematically relate to each other. Data encryption uses different keys or *asymmetric encryption*.

Now that we have a shared vocabulary, lets investigate an example illustrating the use of the encryption process for sending an encrypted message.

The following is an illustration of sending an encrypted message using Public Key encryption.

:::image type="content" source="../media/public-key-encryption.png" alt-text="A diagram of a secure exchange of a message using a public key encryption process. ":::

#### The process includes the following procedures

1. Public and private keys are generated.
1. The public keys are exchanged or placed in a publicly accessible database.
1. Each party keeps their private key private.
1. User A wants to send an encrypted message to User B.
1. User A encrypts the message using User B’s public key and sends the message to User B.
1. User A also signed the message with User A’s private key.
1. User B uses User A's public key to decrypt the signature, confirming the message came from User A.
1. User B is the only one that can decrypt the message because it requires Users B’s private key.
1. Public Key encryption works with SSL/TLS protocol for end-to-end encryption connections.

Now that we understand some standard terms let’s examine the threat landscape to sharpen our cybersecurity knowledge.
