In this exercise, you configure group policy items related to password policies. This includes configuring the domain password policy, creating a stricter password policy for the Domain Admins group, and enabling the Active Directory Recycle Bin.

## Configure Domain Password Policy

In this task, you configure the domain password policy. To complete this task, perform the following steps:

1.  In TAILWIND-DC1, from the Tools menu of the Server Manager console, open the Group Policy Management Console.
2.  In the Group Policy Management Console, expand the tailwindtraders.internal domain.
3.  Right-click **Default Domain Policy** and click **Edit**.
4.  In the Group Policy Management Editor, navigate to Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Account Policies\\Password Policy.
5.  Double click the **Minimum password length** policy item.
6.  Change the minimum number of characters to 14.
7.  Click **Ok**, and then close the Group Policy Management Editor window.

## Configure Fine-Grained Password Policy<br>

In this task, you configure a fine-grained password policy and apply it to the Domain Admins group. To complete this task, perform the following steps in TAILWIND-DC1:

1.  From the Tools menu of the Server Manager console, open Active Directory Administrative Center.
2.  Under Overview, Click **Tailwindtraders (local)**.
3.  In the tailwindtraders (local) pane, open the System container.
4.  In the System container, open the Password Settings Container.
5.  Right-click the Password Settings Container, click **New,** and then click **Password Settings**.
6.  In the Name field, type **Domain Admins Password Policy**.
7.  Set the Precedence field to 1.
8.  Set minimum password length to 16
9.  Click **OK**.
10. Open the new policy **Domain Admins Password Policy**.
11. In the Directly Applies to section, click **Add,** then type Domain Admins and click **OK**.
12. Click **OK**.

## Enable Active Directory Recycle Bin<br>

In this task, you enable the Active Directory Recycle Bin. To complete this task, perform the following steps in TAILWIND-DC1:

1.  From the Tools menu of the Server Manager console, open Active Directory Administrative Center.
2.  Click **Tailwindtraders (local)** in the left pane.
3.  In the right pane, select **Enable Recycle Bin**.
4.  Click **OK** to dismiss the warning.
5.  Click **OK** to dismiss the warning about replication latency.
