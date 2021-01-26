## How password hash synchronization works

Password hash synchronization is one of the sign-in methods used to accomplish hybrid identity. Azure AD Connect synchronizes a hash, of the hash, of a user's password from an on-premises Active Directory instance to a cloud-based Azure AD instance.

> [!div class="mx-imgBorder"]
> ![Graphic showing Azure AD Connect passes a password hash for a user between on-premises and in the cloud.](../media/passwordhashsync-arch1.png)

Active Directory Domain Services stores passwords in the form of a hash value representation of the actual user password. A hash value is a result of a one-way mathematical function (the hashing algorithm). There is no method to revert the result of a one-way function to the plain text version of a password. To synchronize your password, Azure AD Connect sync extracts your password hash from the on-premises Active Directory instance. Extra security processing is applied to the password hash before it is synchronized to the Azure Active Directory authentication service. Passwords are synchronized on a per-user basis and in chronological order.

The actual data flow of the password hash synchronization process is similar to the synchronization of user data. However, passwords are synchronized more frequently than the standard directory synchronization window for other attributes. The password hash synchronization process runs every 2 minutes. You cannot modify the frequency of this process. When you synchronize a password, it overwrites the existing cloud password.

The first time you enable the password hash synchronization feature, it performs an initial synchronization of the passwords of all in-scope users. You cannot explicitly define a subset of user passwords that you want to synchronize. However, if there are multiple connectors, it is possible to disable password hash sync for some connectors but not others. When you change an on-premises password, the updated password is synchronized, most often in a matter of minutes. The password hash synchronization feature automatically retries failed synchronization attempts. If an error occurs during an attempt to synchronize a password, an error is logged in your event viewer.

## Enable password hash synchronization

When you install Azure AD Connect by using the **Express Settings** option, password hash synchronization is automatically enabled. If you use custom settings when you install Azure AD Connect, password hash synchronization is available on the user sign-in page.

> [!div class="mx-imgBorder"]
> ![Enabling password hash synchronization](../media/usersignin2.png)

### Password hash synchronization and FIPS

If your server has been locked down according to Federal Information Processing Standard (FIPS), then MD5 is disabled.

**To enable MD5 for password hash synchronization, perform the following steps:**

1. Go to %programfiles%\Azure AD Sync\Bin.

1. Open miiserver.exe.config.

1. Go to the configuration/runtime node at the end of the file.

1. Add the following node: `<enforceFIPSPolicy enabled="false"/>`

1. Save your changes.

For reference, this snippet is what it should look like:

<configuration>

        <runtime>

            <enforceFIPSPolicy enabled="false"/>

        </runtime>

    </configuration>

