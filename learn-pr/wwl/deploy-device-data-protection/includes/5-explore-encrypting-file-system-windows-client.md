
EFS is a built-in file encryption tool for Windows-based systems. EFS is a component of the NTFS file system, and it uses advanced, standard cryptographic algorithms to allow transparent file encryption and decryption. Through the Windows Information Protection functionality of Windows, EFS functionality is also simulated on volumes that use the FAT32 file system. Any individual or app that doesn't have access to a certificate store that holds an appropriate cryptographic key cannot read encrypted data. You can protect encrypted files even from those who gain physical possession of a computer on which files are stored. Even people who have the authorization to access a computer and its file system cannot view the encrypted data.

Encryption is a powerful addition to any defensive plan. However, you must use additional defensive strategies, because encryption isn’t the correct countermeasure for every threat. Furthermore, every defensive weapon has the potential to harm your data, if you use it incorrectly. When you implement EFS, the most important task is to properly manage EFS certificates for users. Encryption provided by EFS is based on user certificates, and their public and private keys. Without proper certificate management, you can easily get into a situation where encrypted data isn't accessible.

#### Manage EFS certificates

EFS uses public key cryptography to encrypt files. EFS obtains the keys from a user’s EFS certificate, which also might contain private key information. Therefore, you must manage them correctly.

Users need asymmetric key pairs to encrypt data, and they can obtain these keys:

 -  **From a certification authority (CA)**. An internal or third-party CA can issue EFS certificates. This method provides central management and backup of keys. This is recommended way to issue and manage EFS certificates as it allows you to restore user certificate if it's lost.
 -  **By generating them**. If a CA is unavailable, Windows will generate a key pair. These keys have a lifespan of 100 years. This method is more difficult than using a CA because there's no centralized management, and users become responsible for managing their own keys. Additionally, recovery is more difficult to manage. However, it’s still a popular method because it requires no setup.

Users can make encrypted files accessible to other users’ EFS certificates. If you grant access to another user’s EFS certificate, that user may make those files available to yet another user’s EFS certificates.

#### Issue a certificate for a DRA

Before starting to use EFS in your organization, it’s very important to issue a certificate for a Data Recovery Agent (DRA). This certificate is used in scenarios where a user who encrypted the file can't or does not want to decrypt it. A user that has a DRA certificate can decrypt any encrypted file in the organization. This applies to all files encrypted after a DRA certificate is issued.

You can issue EFS certificates only to individual users. You cannot issue EFS certificates to groups.

#### CAs can archive and recover CA-issued EFS certificates

If you use CA to issue EFS certificates, you can configure archiving of user’s private key. You should configure this before you start to issue EFS certificates for users. If you don’t use this functionality, users must backup their self-generated EFS certificates and private keys manually. To do this, they can export the certificate and private key to a Personal Exchange File (.pfx), which is password-protected during the export process. This password is required to import the certificate into a user’s certificate store. In Windows, you can also use built-in tool to manage and backup user certificates used for EFS. It is recommended that each user that uses EFS, use this tool to backup his or her certificate, with a private key, to external protected location.

#### Export the client EFS certificate without the private key

If you need to distribute only your public key, you can export the client EFS certificate without the private key to Canonical Encoding Rules (.cer) files. A user’s private key is stored in the user’s profile in the RSA folder, which you can access by expanding **AppData** > **Roaming** > **Microsoft** > **Crypto**. However, please note that because there is only one instance of the key, it is vulnerable to hard-disk failure or data corruption.

#### Export certificates with the MMC Certificates snap-in

The Microsoft Management Console (MMC) Certificates snap-in exports certificates and private keys. The Personal Certificates store contains the EFS certificates. When users encrypt files in remote shared folders, their keys are stored on the file server.

#### How EFS works

The basic EFS encryption functionality works as follows:

 -  When a user who possesses the necessary key opens a file, the file opens. If a user does not possess the key, the user receives an access-denied message.
 -  File encryption uses a symmetric key that it encrypts with a user’s public key, which is stored in the file header. Additionally, it stores a certificate with the user’s public and private keys, or asymmetric keys, in the user’s profile. The user’s private key must be available for decryption of the file.
 -  If a private key incurs damage or is lost, the file cannot be decrypted. If a data recovery agent exists, the file is recoverable. If you implement key archival, you can recover the key and decrypt the file. Otherwise, the file might be lost. The certificate system, which the encryption is based on, is referred to as public key infrastructure (PKI).
 -  You can archive a user’s certificate that contains his or her public and private keys. For example, you can export it to a USB flash drive, and then keep the USB flash drive in a safe place for recovery if the keys incur damage or are lost.
 -  A user’s password protects the public and private keys. Any user who can obtain the user ID and password can sign in as that user and decrypt that user’s files. Therefore, an organization’s security practices should include a strong password policy and user education to protect EFS-encrypted files.
 -  EFS-encrypted files do not remain encrypted when crossing the network, such as when you work with the files on a shared folder. The file is decrypted, and it then traverses the network in an unencrypted state. EFS encrypts it locally if you save it to a folder on the local drive that is configured for encryption. EFS-encrypted files can remain encrypted while traversing a network if you save them to a web folder by using the World Wide Web Distributed Authoring and Versioning (WebDAV) protocol. They can also remain encrypted if you configure the network traffic to be encrypted by using Internet Protocol Security (IPSec).
 -  EFS supports industry-standard encryption algorithms, including Advanced Encryption Standard (AES). AES uses a 256-bit symmetric encryption key and is the default EFS algorithm.

#### EFS features in Windows 10

Additionally, be aware of the following features when implementing EFS on Windows:

 -  **Support for storing private keys on smart cards**. Windows includes full support for storing users’ private keys on smart cards. If a user signs in to Windows with a smart card, EFS also can use the smart card for file encryption. Administrators can store their domain’s recovery keys on a smart card. Recovering files is then as simple as signing in to the affected machine, either locally or by using Remote Desktop, and using the recovery smart card to access the files.
 -  **The Encrypting File System Rekeying Wizard**. The Encrypting File System Rekeying Wizard allows users to choose an EFS certificate, then select and migrate the existing files that will use the newly chosen EFS certificate. Administrators can use the wizard to migrate users in existing installations from software certificates to smart cards. The wizard also is helpful in recovery situations because it’s more efficient than decrypting and re-encrypting files.
 -  **Group Policy settings for EFS**. You can use Group Policy to control and configure EFS protection policies centrally for an entire enterprise. For example, Windows allows page file encryption through the local security policy or Group Policy.
 -  **Per-user encryption of Offline Files**. You can use EFS to encrypt offline copies of files from remote servers. When you enable this option, each file in the offline cache is encrypted with a public key from the user who cached the file. Thus, only that user has access to the file, and even local administrators cannot read the file without access to the user's private keys.
 -  **Selective Wipe**. A feature of Windows in a corporate environment is Selective Wipe. If a device is lost or stolen, an administrator can revoke the EFS key that was used to protect the files on the device. Revoking a key prevents all access to data files that are stored on a user’s device.
