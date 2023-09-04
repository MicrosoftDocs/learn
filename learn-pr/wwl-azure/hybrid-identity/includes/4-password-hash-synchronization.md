Password hash synchronization is one of the sign-in methods used to accomplish hybrid identity. Azure AD Connect synchronizes a hash of a user's password from an on-premises Active Directory instance to a cloud-based Azure AD instance.

Password hash synchronization is an extension to the directory synchronization feature implemented by Azure AD Connect sync. You can use this feature to sign in to Azure AD services like Microsoft 365. You sign in to the service by using the same password you use to sign in to your on-premises Active Directory instance.

:::image type="content" source="../media/password-hash-synchronization-with-azure-active-directory-b8d84e4d.png" alt-text="Image showing how passoword hash synchronization works with Azure Active Directory.":::
<br>

Password hash synchronization helps by reducing the number of passwords your users need to maintain to just one. Password hash synchronization can:

 -  Improve the productivity of your users.
 -  Reduce your helpdesk costs.

Password Hash Sync also enables leaked credentials detection for your hybrid accounts. Microsoft works alongside dark web researchers and law enforcement agencies to find publicly available username/password pairs. If any of these pairs match those of our users, the associated account is moved to high risk.

> [!NOTE]
> Only new leaked credentials found after you enable password hash synchronization (PHS) will be processed against your tenant. Verifying against previously found credential pairs is not performed.

Optionally, you can set up password hash synchronization as a backup if you use Federation with Active Directory Federation Services (AD FS) as your sign-in method.

To use password hash synchronization in your environment, you need to:

 -  Install Azure AD Connect.
 -  Configure directory synchronization between your on-premises Active Directory instance and your Azure Active Directory instance.
 -  Enable password hash synchronization.

## How password hash synchronization works

The Active Directory domain service stores passwords in the form of a hash value representation of the actual user password. A hash value results from a one-way mathematical function (the *hashing algorithm*). There is no method to revert the result of a one-way function to the plain text version of a password.

To synchronize your password, Azure AD Connect sync extracts your password hash from the on-premises Active Directory instance. Extra security processing is applied to the password hash before synchronizing to the Azure Active Directory authentication service. Passwords are synchronized on a per-user basis and in chronological order.

The data flow of the password hash synchronization process is similar to the synchronization of user data. However, passwords are synchronized more frequently than the standard directory synchronization window for other attributes. The password hash synchronization process runs every 2 minutes. You cannot modify the frequency of this process. When you synchronize a password, it overwrites the existing cloud password.

The first time you enable the password hash synchronization feature, it performs an initial synchronization of the passwords of all in-scope users. You cannot explicitly define a subset of user passwords you want to synchronize. However, if multiple connectors exist, it is possible to disable password hash sync for some connectors but not others using the **Set-ADSyncAADPasswordSyncConfiguration** cmdlet.

When you change an on-premises password, the updated password is synchronized, most often in a matter of minutes. The password hash synchronization feature automatically retries failed synchronization attempts. If an error occurs during an attempt to synchronize a password, an error is logged in your event viewer.

The synchronization of a password has no impact on the user who is currently signed in. Your current cloud service session is not immediately affected by a synchronized password change that occurs while you are signed in to a cloud service. However, when the cloud service requires you to authenticate again, you must provide your new password.

A user must enter their corporate credentials a second time to authenticate to Azure AD, regardless of whether they're signed in to their corporate network. This pattern can be minimized, however, if the user selects the Keep me signed in (KMSI) check box at sign-in. This selection sets a session cookie that bypasses authentication for 180 days. KMSI behavior can be enabled or disabled by the Azure AD administrator. In addition, you can reduce password prompts by turning on Seamless SSO, which automatically signs users in when they are on their corporate devices connected to your corporate network.

> [!NOTE]
> Password sync is only supported for the object type user in Active Directory. It is not supported for the iNetOrgPerson object type.

### Detailed description of how password hash synchronization works

The following section describes, in-depth, how password hash synchronization works between Active Directory and Azure AD.

:::image type="content" source="../media/how-password-hash-synchronization-works-af7ba7dd.png" alt-text="Image showing how password hash synchronization works.":::


1.  Every two minutes, the password hash synchronization agent on the AD Connect server requests stored password hashes (the unicodePwd attribute) from a domain controller (DC). This request is via the standard Microsoft Directory Replication Service (MS-DRSR) replication protocol used to synchronize data between DCs. The service account must have Replicate Directory Changes and Replicate Directory Changes All AD permissions (granted by default on installation) to obtain the password hashes.
2.  Before sending, the domain controller (DC encrypts the MD4 password hash by using a key that is an MD5 hash of the Remote Procedure Call (RPC) session key and a salt. It then sends the result to the password hash synchronization agent over RPC. The DC also passes the salt to the synchronization agent by using the DC replication protocol, so the agent can decrypt the envelope.
3.  After the password hash synchronization agent has the encrypted envelope, it uses message-digest algorithm 5 (MD5) **CryptoServiceProvider** and the salt to generate a key to decrypt the received data back to its original MD4 format. The password hash synchronization agent never has access to the clear text password. The password hash synchronization agent’s use of MD5 is strictly for replication protocol compatibility with the DC, and it is only used on-premises between the DC and the password hash synchronization agent.
4.  The password hash synchronization agent expands the 16-byte binary password hash to 64 bytes by first converting the hash to a 32-byte hexadecimal string, then converting this string back into binary with Unicode Transformation Format-16 (UTF-16) encoding.
5.  The password hash synchronization agent adds a per-user salt, consisting of a 10-byte length salt, to the 64-byte binary to further protect the original hash.
6.  The password hash synchronization agent then combines the message-digest algorithm 4 (MD4) hash plus the per-user salt and inputs it into the Password-Based Key Derivation Function 2 (PBKDF2) function. 1000 iterations of the Hash-based Message Authentication Code-Secure Hash Algorithm 256 (HMAC-SHA256) keyed hashing algorithm are used.
7.  The password hash synchronization agent takes the resulting 32-byte hash, concatenates both the per-user salt and the number of Secure Hash Algorithm 256 (SHA256) iterations to it (for use by Azure AD), then transmits the string from Azure AD Connect to Azure AD over transport layer security (TLS).<br>
8.  When a user attempts to sign in to Azure AD and enters their password, the password is run through the same MD4+salt+PBKDF2+HMAC-SHA256 process. If the resulting hash matches the hash stored in Azure AD, the user has entered the correct password and is authenticated.

> [!NOTE]
> The original MD4 hash is not transmitted to Azure AD. Instead, the SHA256 hash of the original MD4 hash is transmitted. As a result, if the hash stored in Azure AD is obtained, it cannot be used in an on-premises pass-the-hash attack.

## Security considerations

When synchronizing passwords, the plain-text version of your password is not exposed to the password hash synchronization feature, to Azure AD, or any of the associated services.

User authentication takes place against Azure AD rather than against the organization's own Active Directory instance. The SHA256 password data stored in Azure AD--a hash of the original MD4 hash--is more secure than what is stored in Active Directory. Further, because this SHA256 hash cannot be decrypted, it cannot be brought back to the organization's Active Directory environment and presented as a valid user password in a pass-the-hash attack.

### Password policy considerations

There are two types of password policies that are affected by enabling password hash synchronization:

1.  Password complexity policy
2.  Password expiration policy

### Password complexity policy

When password hash synchronization is enabled, the password complexity policies in your on-premises Active Directory instance override complexity policies in the cloud for synchronized users. You can use all of the valid passwords from your on-premises Active Directory instance to access Azure AD services.

> [!NOTE]
> Passwords for users that are created directly in the cloud are still subject to password policies as defined in the cloud.

### Password expiration policy

If a user is in the scope of password hash synchronization, by default, the cloud account password is set to **Never to Expire**.

You can continue to sign in to your cloud services by using a synchronized password that is expired in your on-premises environment. Your cloud password is updated the next time you change the password in the on-premises environment.

> [!IMPORTANT]
> It is important to understand that this is the **same sign-in**, not single sign-on. The user still authenticates against two separate directory services, albeit with the same username and password. This solution provides a simple alternative to an AD FS implementation.
