In an enterprise scenario, security operation teams are typically assigned a set of devices. These devices are grouped together based on a set of attributes such as their domains, computer names, or designated tags.

In Microsoft Defender for Endpoint, you can create device groups and use them to:

- Limit access to related alerts and data to specific Microsoft Entra user groups with assigned RBAC roles

- Configure different auto-remediation settings for different sets of devices

- Assign specific remediation levels to apply during automated investigations

- In an investigation, filter the Devices list to specific device groups by using the Group filter.

You can create device groups in the context of role-based access (RBAC) to control who can take specific action or see information by assigning the device group(s) to a user group.

As part of the process of creating a device group, you'll:

- Set the automated remediation level for that group.

- Specify the matching rule that determines which device group belongs to the group based on the device name, domain, tags, and OS platform. If a device is also matched to other groups, it's added only to the highest ranked device group.

- Select the Microsoft Entra user group that should have access to the device group.

- Rank the device group relative to other groups after it's created.

## Create a device group

To create a device group:

1. In the navigation pane, select **Settings**, select **Endpoints** and then under **Permissions** select **Device groups**.

1. Select **+ Add device group**.

1. Enter the group name and automation settings and specify the matching rule that determines which devices belong to the group. See How the automated investigation starts.

1. Preview several devices that will be matched by this rule. If you're satisfied with the rule, select the User access tab.

1. Assign the user groups that can access the device group you created.  You can only grant access to Microsoft Entra user groups that have been assigned to RBAC roles.

1. Select **Close**. The configuration changes are applied.
