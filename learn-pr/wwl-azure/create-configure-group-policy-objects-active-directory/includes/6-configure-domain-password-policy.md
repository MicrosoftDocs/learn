Now that you have a better understanding of Group Policy Objects (GPOs) and their application to managing a domain, let’s dive into some practical applications.

One of the most basic and important tasks to keep a domain secure is configuring a domain password policy. The domain password policy sets the minimum requirements for passwords, including things like:

 -  Password length
 -  Special character requirements
 -  Password complexity
 -  Password change frequency
 -  Password memory

Configuring the domain password policy sets the standard and then applies it for all users and computers attached to the domain.

## Configure a domain password policy

> [!NOTE]
> To configure a domain password policy, you’ll need administrative privileges.

1.  Log on to your Domain Controller.
2.  Open the **Group Policy Management Console** (GPMC) (you can enter gpmc.msc in the search box to locate the console).
3.  In the GPMC, navigate to your domain and find the **Default Domain Policy**.
4.  Right-click on the Default Domain Policy and select **Edit**.

Selecting edit should open up the **Group Policy Management Editor**. From this editor you can set the password policy.

### Navigate to the password policy settings

In the Group Policy Management Editor, go to:

1.  Computer Configuration
2.  Policies
3.  Windows Settings
4.  Security Settings
5.  Account Policies
6.  Password Policy

Once in the password policy section, specific settings can be set to apply across the domain.

### Configure the Password Policy Settings

You will see a list of settings such as Enforce password history, Maximum password age, Minimum password length, etc.

To update the password policy settings:

1.  Double-click a setting to enable editing.
2.  Configure the setting.
3.  Select **Apply**.
4.  Select **OK**.

While the new domain password settings are in place, they aren’t in effect yet. To apply the new settings, a group policy update needs to be completed.

From a command prompt with administrative permissions, use the following command:

```




```

The domain password policy is now configured and rolled-out.
