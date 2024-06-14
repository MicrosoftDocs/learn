In this exercise, you will configure settings related to security including disabling NTLM authentication for domain accounts, auditing account management activity and denying log on as a service for members of a security group.

## Restrict NTLM Authentication

In this task, you will restrict NTLM authentication. To complete this task, perform the following steps in TAILWIND-DC1:

1.  From the Tools menu of the Server Manager console, open the Group Policy Management console.
2.  Expand the Tailwindtraders.internal domain and then expand Group Policy Objects.
3.  Right-click **Default Domain Controller Policy** and click **Edit**.
4.  Navigate to Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Local Policies\\Security Options.
5.  Select and double-click **Network security: Restrict NTLM: NTLM authentication in this domain**.
6.  Click the **Define this policy setting** check box.
7.  Select the value **Deny all accounts** and click **OK**.
8.  Click **Yes** in the Confirm Setting Change dialog box.

## Audit User Account Management in Sydney<br>

In this task, you will enable auditing of User Account Management in the Sydney OU. To complete this task, perform the following steps in TAILWIND-DC1:

1.  From the Tools menu of the Server Manager console, choose Group Policy Management Console.
2.  In the Group Policy Management Console, expand the Tailwindtraders.internal domain.
3.  Navigate to the Sydney OU, right-click and select **Create new GPO and link here**.
4.  Name the new GPO **SydneyOUPolicy**.
5.  Right-click SydneyOUPolicy and select **Edit**.
6.  Browse to Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Advanced Audit Policy Configuration\\Audit Policies\\Account Management.
7.  Select and double-click **Audit User account management**.
8.  Click the **Configure the following audit events** check box.
9.  Select the **Success** and **Failure** values and click **OK**.

## Deny Log On As a Service<br>

In this task, you will configure the Deny Log On As A Service security option. To complete this task, perform the following steps in TAILWIND-DC1:

1.  From the Tools menu of the Server Manager console, open the Group Policy Management console.
2.  Expand Tailwindtraders.internal domain.
3.  Browse to the Sydney OU and right-click SydneyOUPolicy. Select **Edit**.
4.  Browse to Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment.
5.  Select and double-click the **Deny Log on as a service** policy.
6.  Select the **Define this policy** setting.
7.  Click **Add User or Group**.
8.  Click **Browse**, click **Advanced**, and then click **Find now**.
9.  Select **Sydney Administrators** group.
10. Click **OK**, then click **OK** again to close the remaining open dialog boxes.
