Since early versions of Windows Server, the Group Policy feature of Windows operating systems has provided an infrastructure with which administrators can define settings centrally and then deploy them to computers across their organizations.

Consequently, IT staff at Contoso can define, enforce, and update their entire configuration by using GPO settings. By using GPO settings, they can affect an entire site or a domain within their organization, or they can narrow their focus to a single OU.

> [!TIP]
> Filtering based on security group membership and physical computer attributes also enables Contoso to define the target for their GPO settings even further.

## What is Group Policy?

Group Policy is a framework in Windows operating systems with components that reside in AD DS, on domain controllers, and on each Windows Server and client. By using these components, you can manage configuration in an AD DS domain. You define Group Policy settings within a GPO. A GPO is an object that contains one or more policy settings that apply to one or more configuration settings for a user or a computer.

:::image type="content" source="../media/m8-group-policy-1-3047661e.png" alt-text="A screenshot of the Group Policy Management console. The administrator has selected the Contoso.com domain. Displayed are three GPOs. Also displayed are the OUs in the domain, some of which have linked GPOs.":::


Group Policy is a powerful administrative tool. You can use GPOs to push various settings to a large number of users and computers. Because you can apply them to different levels, from the local computer to domain, you also can focus these settings precisely. Primarily, you use Group Policy to configure settings that you do not want users to configure. Additionally, you can use Group Policy to standardize desktop environments on all computers in an organizational unit (OU) or in an entire organization. You also can use Group Policy to provide additional security, to configure some advanced system settings, and for other purposes discussed in a subsequent demonstration unit.

:::image type="content" source="../media/m8-group-policy-2-07377f9d.png" alt-text="A screenshot of the Group Policy Management Editor. The administrator has expanded the Computer Configuration and User Configuration nodes to display the Policies and Preferences folders.":::


## What are GPOs?

The most granular component of Group Policy is an individual policy setting. An individual policy setting defines a specific configuration, such as a policy setting that prevents a user from accessing registry-editing tools. If you define that policy setting and then apply it to a user, that user will be unable to run tools such as Regedit.exe.

Some settings affect a user, known as user configuration settings or user policies, and some affect the computer, known as computer configuration settings or computer policies.

> [!IMPORTANT]
> Settings do not affect groups directly and apply only to user and computer objects.

Group Policy manages various policy settings, and the Group Policy framework is extensible. You can manage almost any configurable setting with Group Policy.

:::image type="content" source="../media/m8-group-policy-3-4bb956fe.png" alt-text="A screenshot of the Configure Automatic Updates dialog box in the Group Policy Management Editor. The setting is enabled. Other values are displayed.":::


To define a policy setting:

1.  In the Group Policy Management Editor, locate the policy setting and then select Enter. The policy setting **Properties** dialog box appears.
2.  Change the policy state to **Enabled** or **Disabled**. Most policy settings can have three states: Not Configured, Enabled, and Disabled.
3.  If required, configure additional values, and when complete, select **OK**.

GPOs store Group Policy settings. In a new GPO, every policy setting defaults to **Not Configured**. When you enable or disable a policy setting, Windows Server makes a change to the configuration of users and computers to which the GPO is applied.

> [!NOTE]
> When you return a setting to its **Not Configured** value, you return it to its default value.

To create a new GPO in a domain:

1.  In Group Policy Management, right-click or access the context menu for the **Group Policy Objects** container, and then select **New**.
2.  To modify the configuration settings in a GPO, right-click or access the context menu for the GPO, and then select **Edit**. This opens the Group Policy Management Editor snap-in.

The Group Policy Management Editor displays all the policy settings that are available in a GPO in an organized hierarchy that begins with the division between computer settings and user settings: the **Computer Configuration** node and the **User Configuration** node.

GPOs display in a container named Group Policy Objects. The next two levels of the hierarchy are nodes named **Policies** and **Preferences**. Progressing through the hierarchy, the Group Policy Management Editor displays folders, called nodes or policy setting groups. The policy settings are within the folders.

## What are starter GPOs?

You can use a Starter GPO as a template from which to create other GPOs within the Group Policy Management Console. Starter GPOs only have Administrative Template settings. You might use a Starter GPO to provide a starting point to create new GPOs in your domain. The Starter GPO might already have specific settings that are best practices for your environment. You can export starter GPOs to, and import them from, cabinet (.cab) files to make distribution to other environments simple and efficient.

> [!NOTE]
> The Group Policy Management Console stores Starter GPOs in a folder called **StarterGPOs**, which is in **SYSVOL**.

> [!NOTE]
> **SYSVOL** is a shared folder on domain controllers.

Microsoft includes pre-configured Starter GPOs for Windows client operating systems. These Starter GPOs have **Administrative Template** settings that reflect best practices that Microsoft recommends for the configuration of the client environment.
