A firm of IT security specialists have been working at Contoso. They've just produced a report for the main board. The report identifies that most security breaches or data loss incidents at Contoso in the recent past were the result of human error, malicious activity, or both.

The report gave a number of examples, including signing in with administrative privilege and performing standard user tasks. In one cited example, a user signed in with Enterprise Admins rights and opened an email attachment that ran malicious code. That code then had full administrative rights across the Contoso enterprise because the user that ran it had full administrative rights.

## Overview

Least privilege is the concept of restricting access rights to only those rights needed to perform a specific task or job role. You can apply this principle to:

- User accounts.
- Service accounts.
- Computing processes.

Although this principle is easy to understand, it can be complex to implement. As a result, in many cases, least privilege is not adhered to.

The principle states that all users should sign in with a user account that has the minimum permissions necessary to complete the current task and nothing more. This principle provides protection against malicious code, among other attacks. It applies to computers and the users of those computers.

The problem, of course, is that administrators typically don't want to sign in with a standard user account for their day-to-day tasks, and then sign out and back in as an administrator when they need to reset a user's password. It's time-consuming and it's a hassle. To solve this problem, you must find a way to identify the typical security risks. You must then plan a less intrusive principle of least privilege.

## Identify security principals

In an on-premises environment, you should determine which security principals (users and groups) belong to administrative groups. In Active Directory Domain Services (AD DS), there are a number of sensitive administrative groups. These are described in the following table.

|Group|Description|
|--|--|
|Enterprise Admins|This universal security group resides in the Users folder of the AD DS forest root domain. Members can perform any administrative task anywhere in the forest. There are few management tasks that require Enterprise Admins membership. By default, only the Administrator user account from the forest root domain belongs to Enterprise Admins.|
|Domain Admins|This global security group resides in the Users folder of every domain in your AD DS forest. Members can perform any administrative task anywhere in the local domain. By default, only the Administrator user account from the local domain belongs to Domain Admins.|
|Schema Admins|This universal security group resides in the Users folder of the forest root domain. Members can modify the properties of the AD DS schema. Schema changes are infrequent, but very significant in their effect. By default, only the Administrator user account from the forest root domain belongs to Schema Admins.|
|Administrators|This domain local security group resides in the Builtin folder in AD DS. The Administrators local group also exists in all computers in your AD DS forest. Administrators have complete and unrestricted access to the domain (or computer). Typically, the Enterprise Admins and Domain Admins groups are added to the Administrators groups on all computers in your forest.|

> [!NOTE]
> The AD DS schema is a collection of objects and their properties, sometimes also called classes and attributes.

Other built-in groups that have security privileges include:

- Account Operators.
- Server Operators.
- Key Admins.
- Enterprise Key Admins.

:::image type="content" source="../media/m1-groups.png" alt-text="A screenshot of the Active Directory Administrative Center. The administrator has selected the Enterprise Admins group in Contoso (local)\Users. Also displayed are other groups in the Users folder.":::

## Modify group memberships

After you've determined which users and groups belong to administrative groups, you can make any necessary changes. You can use Group Policy Objects (GPOs) in an AD DS environment to expedite this process. Use the **Restricted Groups** feature to control the membership of groups on all computers affected by the GPO. Use the following procedure:

1. Open **Group Policy Management**, and then create and link a GPO to the domain object.
2. Open the GPO for editing.
3. Locate **Computer Configuration**, **Policies**, **Windows Settings**,  **Security Settings**, **Restricted Groups**.
4. Right-click or activate the context menu for **Restricted Groups** and select **Add Group**.
5. In the **Add Group** dialog box, add the required group.
6. Add the members to the group or add the group to another group as a member.
7. Select **OK** to complete the process.

:::image type="content" source="../media/m1-group-policy.png" alt-text="A screenshot of the Group Policy Management Editor. The administrator has navigated to Computer Configuration, Policies, Windows Settings, Security Settings, Restricted Groups. The administrator has added a group called Administrators, and added as members Domain Admins, Enterprise Admins, and ContosoAdmin.":::

## Determine currently assigned rights

After you've modified the security principals in your environment, you must determine what rights those principals already have. Clearly, if a user belongs to a sensitive administrative group, such as Administrators, that user can perform any task and exercise any right on the computer or domain where the group exists.

> [!NOTE]
> A right is the ability to perform an administrative task. A permission is the ability to access an object in the file system, in AD DS, or elsewhere.

However, a user might belong to other groups that have been assigned rights or privileges. It might also be the case that a user is directly assigned a right.

You can use the **Local Security Policy** console to determine what rights are assigned. Use the following procedure:

1. Select **Start**, and then select **Windows Administrative Tools**.
2. Select **Local Security Policy**.
3. In **Local Security Policy**, expand **Local Policies**, and then expand **User Rights Assignment**.
4. Review, and if necessary, edit the **Security Setting** value for each **Policy** listed.

:::image type="content" source="../media/m1-local-policy.png" alt-text="A screenshot of the Local Security Policy console. The administrator has selected the User Rights Assignment node, and displayed in the details pane are policies and security settings.":::

> [!TIP]
> Always assign a policy to a group, and not directly to a user. This helps with ongoing management. When someone's job role changes, you need only change their group memberships rather than revisit all the user rights assignments you assigned to their user account.

## Implement User Account Control

User Account Control (UAC) is a security feature that provides a way for users to limit the status of their administrative account to that of a standard user account. However, when the user wants to perform a task that requires administrative capability, referred to as *elevation*, the user is prompted to confirm that elevation. By default, UAC prompts the user when they attempt elevation, as follows:

- If the user is an administrator, they are prompted to confirm the elevation.
- If the user is a standard user, they are prompted for administrative credentials.

You can control UAC prompts and behavior by using GPOs.

1. Open an appropriately linked GPO for editing, and navigate to **Computer Configuration**, **Policies**, **Windows Settings**,  **Security Settings**, **Local Policies**, **Security Options**.
2. For administrative accounts, open the **User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode** setting, select **Define this policy setting**, and then select the required setting.
3. For standard users, open the **User Account Control: Behavior of the elevation prompt for standard users** setting, select **Define this policy setting**, and then select the required setting.

:::image type="content" source="../media/m1-security-options.png" alt-text="A screenshot of the Security Options node in Group Policy Management Editor. The User Account Control values are displayed.":::

## Implement Just Enough Administration

Just Enough Administration (JEA) is an administrative technology that allows you to apply role-based access control (RBAC) principles through Windows PowerShell remote sessions. Instead of allowing users general roles that often allow them to perform tasks that aren't directly related to their work requirements, JEA enables you to configure special Windows PowerShell endpoints that provide the functionality necessary to perform a specific task.

JEA allows you to lock down administrative sessions so that only a specific set of tasks can be performed through a remote Windows PowerShell session. JEA increases security by limiting the tasks that can be performed. You configure JEA by creating and modifying role-capability files and session-configuration files.

> [!IMPORTANT]
> JEA only supports Windows PowerShell remoting.