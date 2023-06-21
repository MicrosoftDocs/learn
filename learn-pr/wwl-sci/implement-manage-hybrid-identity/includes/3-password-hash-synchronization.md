## How password hash synchronization works

Password hash synchronization is one of the sign-in methods used to accomplish hybrid identity. Azure AD Connect synchronizes a hash, of the hash, of a user's password from an on-premises Active Directory instance to a cloud-based Azure AD instance.

:::image type="content" source="../media/password-hash-sync-architecture-1-e3833a51.png" alt-text="Diagram of how Azure AD Connect passes a password hash for a user between on-premises and in the cloud.":::


Active Directory Domain Services stores passwords in the form of a hash value representation of the actual user password. A hash value is a result of a one-way mathematical function (the hashing algorithm). There is no method to revert the result of a one-way function to the plain text version of a password. To synchronize your password, Azure AD Connect sync extracts your password hash from the on-premises Active Directory instance. Extra security processing is applied to the password hash before it is synchronized to the Azure Active Directory authentication service. Passwords are synchronized on a per-user basis and in chronological order.

The actual data flow of the password hash synchronization process is similar to the synchronization of user data. However, passwords are synchronized more frequently than the standard directory synchronization window for other attributes. The password hash synchronization process runs every 2 minutes. You cannot modify the frequency of this process. When you synchronize a password, it overwrites the existing cloud password.

The first time you enable the password hash synchronization feature, it performs an initial synchronization of the passwords of all in-scope users. You cannot explicitly define a subset of user passwords that you want to synchronize during the first synchronization. Once the initial synchronization completes, you can set up a **selective password hash synch** for future synchronizations.

If there are multiple connectors, it is possible to disable password hash sync for some connectors but not others. When you change an on-premises password, the updated password is synchronized, most often in a matter of minutes. The password hash synchronization feature automatically retries failed synchronization attempts. If an error occurs during an attempt to synchronize a password, an error is logged in your event viewer.

## Enable password hash synchronization

When you install Azure AD Connect by using the **Express Settings** option, password hash synchronization is automatically enabled. If you use custom settings when you install Azure AD Connect, password hash synchronization is available on the user sign-in page.

:::image type="content" source="../media/password-hash-connect-setting-ef874d71.png" alt-text="Screenshot of Azure AD Connect with the Password Hash Synchronization option selected.":::


## Password hash synchronization and Federal Information Processing standard<br>

If your server has been locked down according to Federal Information Processing Standard (FIPS), then MD5 is disabled.

**To enable MD5 for password hash synchronization, perform the following steps:**

1.  Go to `%programfiles%\Azure AD Sync\Bin`.
2.  Open miiserver.exe.config.
3.  Go to the configuration/runtime node at the end of the file.
4.  Add the following node: `<enforceFIPSPolicy enabled="false"/>`
5.  Save your changes.

For reference, this snippet is what it should look like:

```
    <configuration>
        <runtime>
            <enforceFIPSPolicy enabled="false"/>
        </runtime>
    </configuration>


```

## Using PingFederate

Configure PingFederate with Azure AD Connect to set up federation with the domain you want connected. The following prerequisites are required:

 -  PingFederate 8.4 or later.
 -  A TLS/SSL certificate for the federation service name that you intend to use (for example, sts.contoso.com).

After you choose to set up federation by using PingFederate in AD Connect, you're asked to verify the domain you want to federate. Select the domain from the drop-down menu.

:::image type="content" source="../media/pingfederate-domain-2e41c11d.png" alt-text="Screenshot of Azure AD Connect interface showing the domain you want to create a federation with.":::


Configure PingFederate as the federation server for each federated Azure domain. Then select Export Settings to share this information with your PingFederate administrator. The federation server administrator updates the configuration and provides the PingFederate server URL and port number so that Azure AD Connect can verify the metadata settings.
