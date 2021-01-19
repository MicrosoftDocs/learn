To configure automated investigation and remediation, turn on the features, and then set up device groups.

## **Turn on automated investigation and remediation**

As a global administrator or security administrator:

1. In the navigation pane, select **Settings**.

1. In the General section, select **Advanced features**.

1. Turn on both Automated Investigation and Automatically resolve alerts.

## Set up device groups

1. In the navigation pane, on the Settings page, under Permissions, select **Device groups**.

1. Select **+ Add device group**.

    - Create at least one device group, as follows:

        - Specify a name and description for the device group.

        - In the Automation level list, select a level, such as Full – remediate threats automatically. The automation level determines whether remediation actions are taken automatically or only upon approval. To learn more, see How threats are remediated.

        - In the Members section, use one or more conditions to identify and include devices.

        - On the User access tab, select the Azure Active Directory groups that should have access to the device group you're creating.

1. Select **Done** when you're finished setting up your device group.

### Automation levels

**Full - remediate threats automatically (also referred to as full automation)**

With full automation, remediation actions are performed automatically. All remediation actions that are taken can be viewed in the Action Center on the History tab. If necessary, a remediation action can be undone.

**Semi - require approval for any remediation (also referred to as semi-automation)**

With this level of semi-automation, approval is required for any remediation action. Such pending actions can be viewed and approved in the Action Center, on the Pending tab.

**Semi - require approval for core folders remediation (also a type of semi-automation)**

With this level of semi-automation, approval is required for any remediation actions needed on files or executables that are in core folders. Core folders include operating system directories, such as the Windows (\windows\*). Remediation actions can be taken automatically on files or executables that are in other (non-core) folders. Pending actions for files or executables in core folders can be viewed and approved in the Action Center, on the Pending tab. Actions that were taken on files or executables in other folders can be viewed in the Action Center, on the History tab.

**Semi - require approval for non-temp folders remediation (also a type of semi-automation)**

With this level of semi-automation, approval is required for any remediation actions needed on files or executables that are not in temporary folders.

Temporary folders can include the following examples:

- \users\*\appdata\local\temp\*

- \documents and settings\*\local settings\temp\*

- \documents and settings\*\local settings\temporary\*

- \windows\temp\*

- \users\*\downloads\*

- \program files\

- \program files (x86)\*

- \documents and settings\*\users\*

Remediation actions can be taken automatically on files or executables that are in temporary folders. Pending actions for files or executables that are not in temporary folders can be viewed and approved in the Action Center, on the Pending tab. Actions that were taken on files or executables in temporary folders can be viewed and approved in the Action Center on the History tab.

**No automated response (also referred to as 'no automation')**

With no automation, the automated investigation does not run on your organization's devices. As a result, no remediation actions are taken or pending as a result of an automated investigation. However, other threat protection features, such as protection from potentially unwanted applications, can be in effect, depending on how your antivirus and next-generation protection features are configured.

Using the no automation option is not recommended because it reduces the security posture of your organization's devices. Consider setting up your automation level to full automation (or at least semi-automation).

## Quickly configure remediation levels on Device groups

Another way to set or update remediation levels on Device groups is in the Settings, General, Auto remediation page.  The page provides a list of Device groups and the current remediation level for each.  Select the row will allow you to adjust the remediation setting.

