Password hash synchronization is one of the sign-in methods used to accomplish hybrid identity. Microsoft Entra Connect synchronizes a hash of a user's password from an on-premises Active Directory instance to a cloud-based Microsoft Entra instance.

Password hash synchronization is an extension to the directory synchronization feature implemented by Microsoft Entra Connect Sync. You can use this feature to sign in to Microsoft Entra services like Microsoft 365. You sign in to the service by using the same password you use to sign in to your on-premises Active Directory instance.

:::image type="content" source="../media/password-hash-synchronization-architecture-d8637c23.png" alt-text="Diagram showing an example of password hash synchronization functionality.":::


Password hash synchronization helps by reducing the number of passwords, your users need to maintain to just one. Password hash synchronization can:

 -  Improve the productivity of your users.
 -  Reduce your helpdesk costs.

Password Hash Sync also enables leaked credential detection for your hybrid accounts. Microsoft works alongside dark web researchers and law enforcement agencies to find publicly available username/password pairs. If any of these pairs match those of our users, the associated account is moved to high risk.

> [!NOTE]
> Only new leaked credentials found after you enable PHS will be processed against your tenant. Verifying against previously found credential pairs is not performed.

Optionally, you can set up password hash synchronization as a backup if you decide to use Federation with Active Directory Federation Services (AD FS) as your sign-in method.

To use password hash synchronization in your environment, you need to:

 -  Install Microsoft Entra Connect.
 -  Configure directory synchronization between your on-premises Active Directory instance and your Microsoft Entra instance.
 -  Enable password hash synchronization.
