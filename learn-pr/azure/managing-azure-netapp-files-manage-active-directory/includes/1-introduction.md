Several features of Azure NetApp Files require an Active Directory connection. You need to have an Active Directory connection before you can create an SMB volume, a NFSv4.1 Kerberos volume, or a dual-protocol volume.

An Azure NetApp Files account must be created in the region where the Azure NetApp Files volumes are to be deployed. By default, Azure NetApp Files allows only one Active Directory (AD) connection per subscription. You can also create one Active Directory connection per NetApp account.

> [!NOTE]
> Azure NetApp Files supports only one Active Directory connection within the same region and the same subscription.

### NetApp accounts and Active Directory type

There are three values for Active Directory account type:

- **NA**: Existing NetApp account which supports only one AD configuration per subscription and region. The AD configuration is not shared with other NetApp accounts in the subscription.
- **Multi AD**: NetApp account supports one AD configuration in each NetApp account in the subscription. This allows for more than one AD connection per subscription when using multiple NetApp accounts.
- **Shared AD**: NetApp account supports only one AD configuration per subscription and region, but the configuration is shared across NetApp accounts in the subscription and region.
