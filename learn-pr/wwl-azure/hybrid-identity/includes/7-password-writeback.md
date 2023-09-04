Azure Active Directory (Azure AD) self-service password reset (SSPR) lets users reset their passwords in the cloud, but most companies also have an on-premises Active Directory Domain Services (AD DS) environment for users. Password writeback allows password changes in the cloud to be written back to an on-premises directory in real-time by using either Azure AD Connect or Azure AD Connect cloud sync. When users change or reset their passwords using SSPR in the cloud, the updated passwords are also written back to the on-premises AD DS environment.

:::image type="content" source="../media/az500-password-writeback-7fb0c69a.png" alt-text="Screenshot of Azure AD Connect Optional Features. The Password Writeback checkbox is selected.":::


Password writeback is supported in environments that use the following hybrid identity models:

 -  Password hash synchronization
 -  Pass-through authentication
 -  Active Directory Federation Services

Password writeback provides the following features:

 -  **Enforcement of on-premises Active Directory Domain Services (AD DS) password policies**: When a user resets their password, it's checked to ensure it meets your on-premises AD DS policy before committing it to that directory. This review includes checking the history, complexity, age, password filters, and any other password restrictions that you define in AD DS.
 -  **Zero-delay feedback**: Password writeback is a synchronous operation. Users are notified immediately if their password doesn't meet the policy or can't be reset or changed for any reason.
 -  **Supports password changes from the access panel and Microsoft 365**: When federated or password hash synchronized users come to change their expired or non-expired passwords, those passwords are written back to AD DS.
 -  **Supports password writeback when an admin resets them from the Azure portal**: When an admin resets a user's password in the Azure portal, if that user is federated or password hash synchronized, the password is written back to on-premises. This functionality is currently not supported in the Office admin portal.
 -  **Doesn't require any inbound firewall rules**: Password writeback uses an Azure Service Bus relay as an underlying communication channel. All communication is outbound over port 443.
 -  **Supports side-by-side domain-level deployment** using Azure AD Connect or cloud sync to target different sets of users depending on their needs, including users who are in disconnected domains.

> [!NOTE]
> Administrator accounts within protected groups in on-premises AD can be used with password writeback. Administrators can change their password in the cloud but can't reset a forgotten password.

## How password writeback works

When a user account configured for federation, password hash synchronization (or, in the case of an Azure AD Connect deployment, pass-through authentication) attempts to reset or change a password in the cloud, the following actions occur:

1.  A check is performed to see what type of password the user has. If the password is managed on-premises:
    
    
     -  A check is performed to see if the writeback service is running. If it is, the user can proceed.
     -  If the writeback service is down, the user is informed that their password can't be reset.
2.  Next, the user passes the appropriate authentication gates and reaches the Reset password page.
3.  The user selects a new password and confirms it.
4.  When the user selects Submit, the plaintext password is encrypted with a public key created during the writeback setup process.
5.  The encrypted password is included in a payload that gets sent over an HTTPS channel to your tenant-specific service bus relay (set up for you during the writeback setup process). This relay is protected by a randomly generated password that only your on-premises installation knows.
6.  After the message reaches the service bus, the password-reset endpoint automatically wakes up and sees that it has a reset request pending.
7.  The service then looks for the user by using the cloud anchor attribute. For this lookup to succeed, the following conditions must be met:
    
    
     -  The user object must exist in the AD DS connector space.
     -  The user object must be linked to the corresponding metaverse (MV) object.
     -  The user object must be linked to the corresponding Azure AD connector object.
     -  The link from the AD DS connector object to the MV must have the synchronization rule **Microsoft.InfromADUserAccountEnabled.xxx** on the link.
    
    When the call comes in from the cloud, the synchronization engine uses the cloudAnchor attribute to look up the Azure AD connector space object. It then follows the link back to the MV object and then follows the link back to the AD DS object. Because there can be multiple AD DS objects (multi-forest) for the same user, the sync engine relies on **Microsoft.InfromADUserAccountEnabled.xxx** link to pick the correct one.
8.  After the user account is found, an attempt to reset the password directly in the appropriate AD DS forest is made.
9.  If the password set operation is successful, the user is told their password has been changed.
    
    > [!NOTE]
    > If the user's password hash is synchronized to Azure AD by using password hash synchronization, there's a chance that the on-premises password policy is weaker than the cloud password policy. In this case, the on-premises policy is enforced. This policy ensures that your on-premises policy is enforced in the cloud, no matter if you use password hash synchronization or federation to provide single sign-on.
10. If the password set operation fails, an error prompts the user to try again. The operation might fail because of the following reasons:
    
    
     -  The service was down.
     -  The password they selected doesn't meet the organization's policies.
     -  Unable to find the user in the local AD DS environment.
    
    The error messages provide guidance to users so they can attempt to resolve them without administrator intervention.

## Password writeback security

Password writeback is a highly secure service. To ensure your information is protected, a four-tiered security model is enabled as follows:

 -  **Tenant-specific service-bus relay**
     -  When you set up the service, a tenant-specific service bus relay is set up that's protected by a randomly generated strong password that Microsoft never has access to.
 -  **Locked down, cryptographically strong, password encryption key**
     -  After the service bus relay is created, a strong symmetric key is created that is used to encrypt the password as it comes over the wire. This key only lives in your company's secret store in the cloud, which is heavily locked down and audited, just like any other password in the directory.
 -  **Industry standard Transport Layer Security (TLS)**
    1.  When a password reset or change operation occurs in the cloud, the plaintext password is encrypted with your public key.
    2.  The encrypted password is placed into an HTTPS message that's sent over an encrypted channel by using Microsoft TLS/SSL certs to your service bus relay.
    3.  After the message arrives in the service bus, your on-premises agent wakes up and authenticates to the service bus by using the strong password that was previously generated.
    4.  The on-premises agent picks up the encrypted message and decrypts it using the private key.
    5.  The on-premises agent attempts to set the password through the AD DS SetPassword API. This step is what allows enforcement of your AD DS on-premises password policy (such as the complexity, age, history, and filters) in the cloud.
 -  **Message expiration policies**
     -  If the message sits in the service bus because your on-premises service is down, it times out and is removed after several minutes. The time-out and removal of the message increases security even further.

## Password writeback encryption details

After a user submits a password reset, the reset request goes through several encryption steps before it arrives in your on-premises environment. These encryption steps ensure maximum service reliability and security. They are described as follows:

1.  **Password encryption with 2048-bit Rivest–Shamir–Adleman (RSA) Key**: After a user submits a password to be written back to on-premises, the submitted password itself is encrypted with a 2048-bit RSA key.
2.  **Package-level encryption with 256-bit Advanced Encryption Standard (AES) Galois Counter Mode (GCM)**: The entire package, the password plus the required metadata, is encrypted by using AES-GCM (with a key size of 256 bits). This encryption prevents anyone directly accessing the underlying Service Bus channel from viewing or tampering with the contents.
3.  **All communication occurs over TLS/SSL**: All the communication with Service Bus happens in an SSL/TLS channel. This encryption secures the contents from unauthorized third parties.
4.  **Automatic key rollover every six months**: All keys roll over every six months or every time password writeback is disabled and re-enabled on Azure AD Connect to ensure maximum service security and safety.

> [!IMPORTANT]
> To use **self-service password reset (SSPR)** you must have already configured Azure AD Connect in your environment.
