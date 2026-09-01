The Group Policy feature of Windows operating systems has provided an infrastructure with which administrators can define settings centrally and then deploy them to computers across their organizations.

IT staff at Contoso can define, enforce, and update their entire configuration by using GPO settings. By using GPO settings, they can apply a set of configuration settings to an entire site or a domain within their organization, or they can narrow their focus to a single OU representing a department.

> [!TIP]
> Filtering based on security group membership and physical computer attributes also enables Contoso to define the target for their GPO settings even further.

## What is Group Policy?

Group Policy is a framework in Windows operating systems with components that reside in AD DS, on domain controllers, and on each Windows Server and client. By using these components, you can manage configuration in an AD DS domain. You define Group Policy settings within a Group Policy Object (GPO). A GPO is an object that contains one or more policy settings that apply to one or more configuration settings for a user or a computer.

:::image type="content" source="../media/group-policy.png" alt-text="A screenshot of the Group Policy Management console. The administrator has selected the Contoso.com domain. Displayed are three GPOs. Also displayed are the OUs in the domain, some of which have linked GPOs.":::

Group Policy is a powerful administrative tool. You can use GPOs to push various settings to a large number of users and computers. Because you can apply them to different levels, from the local computer to domain, you also can focus these settings precisely. Primarily, you use Group Policy to configure settings that you do not want users to configure. Additionally, you can use Group Policy to standardize desktop environments on all computers in an organizational unit (OU) or in an entire organization. You also can use Group Policy to provide additional security, to configure some advanced system settings, and for other purposes discussed in a subsequent demonstration unit.

:::image type="content" source="../media/group-policy-editor.png" alt-text="A screenshot of the Group Policy Management Editor. The administrator has expanded the Computer Configuration and User Configuration nodes to display the Policies and Preferences folders.":::

## What are GPOs?

A Group Policy Object (GPO) is a collection of group policy settings. An individual policy setting defines a specific configuration, such as a policy setting that prevents a user from accessing registry-editing tools. If you define that policy setting and then apply it to a user, that user will be unable to run tools such as Regedit.exe.

Some settings affect a user, known as user configuration settings or user policies, and some affect the computer, known as computer configuration settings or computer policies.

> [!IMPORTANT]
> Settings do not affect groups directly and apply only to user and computer objects.

Group Policy manages various policy settings, and the Group Policy framework is extensible. You can manage almost any configurable setting with Group Policy.

:::image type="content" source="../media/group-policy-auto-updates.png" alt-text="A screenshot of the Configure Automatic Updates dialog box in the Group Policy Management Editor. The setting is enabled. Other values are displayed.":::


To define a policy setting:

1.  In the Group Policy Management Editor, locate the policy setting and then select Enter. The policy setting **Properties** dialog box appears.
2.  Change the policy state to **Enabled** or **Disabled**. Most policy settings can have three states: Not Configured, Enabled, and Disabled.
3.  If required, configure additional values, and when complete, select **OK**.

GPOs store Group Policy settings. In a new GPO, every policy setting defaults to **Not Configured**. When you enable or disable a policy setting, Windows Server makes a change to the configuration of users and computers to which the GPO is applied.

To create a new GPO in a domain:

1.  In Group Policy Management, right-click or access the context menu for the **Group Policy Objects** container, and then select **New**.
2.  To modify the configuration settings in a GPO, right-click or access the context menu for the GPO, and then select **Edit**. This opens the Group Policy Management Editor snap-in.

The Group Policy Management Editor displays all the policy settings that are available in a GPO in an organized hierarchy that begins with the division between computer settings and user settings: the **Computer Configuration** node and the **User Configuration** node.

GPOs display in a container named Group Policy Objects. The next two levels of the hierarchy are nodes named **Policies** and **Preferences**. Progressing through the hierarchy, the Group Policy Management Editor displays folders, called nodes or policy setting groups. The policy settings are within the folders.

### Computer Configuration and User Configuration

At the top of every GPO, settings are divided into two nodes. This division is the most important structural distinction in a GPO because it determines what each setting affects:

- **Computer Configuration** contains settings that apply to a computer, regardless of which user signs in. These settings define operating-system behavior, security configuration, startup and shutdown scripts, and system-wide application settings. Examples include password and account-lockout requirements, service startup behavior, and settings that control Windows components for every user of the device.
- **User Configuration** contains settings that apply to a user, regardless of which computer that user signs in to. These settings define the desktop environment, such as the appearance of the Start menu, logon and logoff scripts, folder redirection, and restrictions on the tools and Control Panel items that a user can access.

Many settings appear in only one of the two nodes because they are relevant only to a computer or only to a user. Some settings appear in both nodes, in which case each instance configures its own target.

### Policies and preferences

Within both the **Computer Configuration** and **User Configuration** nodes, settings are grouped under two further nodes—**Policies** and **Preferences**—which behave differently:

- **Policies** contain managed settings that Group Policy enforces. A user typically cannot change a managed setting, and when the GPO no longer applies, the setting reverts to its previous value. Most policy settings write to protected areas of the registry.
- **Preferences** contain settings that establish an initial configuration that a user can subsequently change. Preferences are not enforced and, by default, are not removed when the GPO no longer applies. Preference items also support item-level targeting, which lets a single item apply only when defined conditions—such as a specific operating system, security group, or computer name—are met.

The practical difference between the two comes down to enforcement, persistence, and how the client writes the configuration. Policies are *managed*: the client writes them to four reserved, restricted registry keys (the Policies branches under `HKEY_LOCAL_MACHINE` and `HKEY_CURRENT_USER`), and a compliant Windows application reads those keys and disables the corresponding interface so that the user cannot override the value. Because policies live in this reserved space, they are removed and rewritten every time Group Policy refreshes, and when the GPO falls out of scope—because it is deleted, unlinked, or filtered away from the target—the value disappears and the setting returns to its default. This refresh-and-revert behavior is why policies are well suited to settings you want to lock down and keep continuously enforced. Preferences, by contrast, are *unmanaged*: the client writes them to the same registry and file-system locations that a user or administrator would configure manually, so the setting looks identical to one set by hand and the interface that controls it remains fully available. A preference therefore "tattoos" the configuration—it persists even after the GPO no longer applies, unless you explicitly choose the *Apply once and do not reapply* option or the *Remove this item when it is no longer applied* option for that item. Preferences add flexibility that policies lack, including item-level targeting for granular conditional application, multiple actions per item (Create, Replace, Update, and Delete), and the ability to configure things that have no policy setting at all, such as mapped drives, shortcuts, scheduled tasks, and local group membership. As a rule of thumb, use a policy when you need a setting to be mandatory and self-reverting, and use a preference when you need to deliver a sensible starting configuration that users may still adjust or that targets only a subset of computers or users.

### The Policies node

The **Policies** node contains three subfolders in both **Computer Configuration** and **User Configuration**:

- **Software Settings** holds the **Software installation** extension, which you use to deploy applications to computers or users.
- **Windows Settings** holds settings that configure the operating system. Common items include **Scripts** (startup and shutdown for computers, logon and logoff for users), **Security Settings** (such as account policies, local policies, and Windows Defender Firewall), **Name Resolution Policy**, and **Deployed Printers**. Under **User Configuration**, this folder also includes **Folder Redirection**.
- **Administrative Templates** holds hundreds of registry-based settings, organized into folders such as **Control Panel**, **Network**, **System**, **Printers**, and **Windows Components**. Each setting in this folder corresponds to a specific registry value that controls the behavior of Windows or an application.

### The Preferences node

The **Preferences** node organizes preference items into related groups:

- **Windows Settings** includes items such as **Drive Maps**, **Environment**, **Files**, **Folders**, **Registry**, and **Shortcuts**.
- **Control Panel Settings** includes items such as **Data Sources**, **Devices**, **Local Users and Groups**, **Power Options**, **Printers**, **Scheduled Tasks**, and **Services**.

### The structure of an individual policy setting

A single policy setting is the most granular element of a GPO, but each setting is more than a simple on/off switch. When you open a setting, its **Properties** dialog box exposes several elements:

- The **state** of the setting—**Not Configured**, **Enabled**, or **Disabled**.
- Any **additional options or values** that become available when the setting is enabled. For example, enabling a minimum-password-length policy requires you to specify the number of characters.
- An **explanatory help text** pane that describes what the setting does and how its options interact.
- **Supported on** information that identifies the operating-system versions and applications that honor the setting. A target that does not meet the requirement ignores the setting.

Because most policy settings are registry-based, enabling or disabling a setting causes the client to write a corresponding value to the registry. When a setting returns to **Not Configured**, Group Policy removes that value, and the configuration reverts to its default.

## What are starter GPOs?

You can use a Starter GPO as a template from which to create other GPOs within the Group Policy Management Console. Starter GPOs only have Administrative Template settings. You might use a Starter GPO to provide a starting point to create new GPOs in your domain. The Starter GPO might already have specific settings that are best practices for your environment. You can export starter GPOs to, and import them from, cabinet (.cab) files to make distribution to other environments simple and efficient.

> [!NOTE]
> The Group Policy Management Console stores Starter GPOs in a folder called **StarterGPOs**, which is in **SYSVOL**.

> [!NOTE]
> **SYSVOL** is a shared folder on domain controllers.

Microsoft includes pre-configured Starter GPOs for Windows client operating systems. These Starter GPOs have **Administrative Template** settings that reflect best practices that Microsoft recommends for the configuration of the client environment.
