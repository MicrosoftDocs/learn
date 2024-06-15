What if you wanted to have different password policies for different people? The domain password policy sets the password policy for the entire domain. What if your organization wanted to have different password policies for different groups of people? Maybe vendors passwords need to require more frequent updates, domain admins need a more secure password, and other groups also need different password configurations.

A fine-grained password policy (FGPP) enables active directory to enforce different password policies for different groups.

## Configure an FGPP

1.  Open **Active Directory Administrative Center** (ADAC).
2.  Expand the domain and click on the **System** container.
3.  Locate the **Password Settings** Container.
4.  Right-click on the Password Settings Container.
5.  Select **New** and then **Password Settings**.
6.  Configure the password requirements.
7.  Select **OK**.

The FGPP is now created, and the procedure can be completed multiple times to create different variations or versions of a FGPP. Once the password settings object (PSO) is created, it needs to be associated with users or groups to be enforced.

## Apply an FGPP

1.  Still in the **Password Settings Container**, select the newly created PSO.
2.  In the Extended view, under **Direct Applies To**, select **Add**.
3.  Enter the name of the user or group and select **OK**.

This process can be repeated multiple times to create a more secure, customized domain that restricts access to maximize security and reduce the risk of compromised passwords.
