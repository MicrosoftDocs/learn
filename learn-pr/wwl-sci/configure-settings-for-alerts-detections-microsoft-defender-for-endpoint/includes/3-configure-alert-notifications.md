You can configure Defender for Endpoint to send email notifications to specified recipients for new alerts. This feature enables you to identify a group of individuals who will immediately be informed and can act on alerts based on their severity.

Only users with 'Manage security settings' permissions can configure email notifications. If you've chosen to use basic permissions management, users with Security Administrator or Global Administrator roles can configure email notifications.

You can set the alert severity levels that trigger notifications. You can also add or remove recipients of the email notification. New recipients get notified about alerts encountered after they're added. For more information about alerts, see View and organize the Alerts queue.

If you're using role-based access control (RBAC), recipients will only receive notifications based on the device groups that were configured in the notification rule. Users with the proper permission can only create, edit, or delete notifications limited to their device group management scope. Only users assigned to the Global administrator role can manage notification rules that were configured for all device groups.

The email notification includes basic information about the alert and a link to the portal where you can do further investigation.

## Create rules for alert notifications

You can create rules that determine the devices and alert severities to send email notifications to notification recipients.

1. In the Microsoft Defender portal, select **Settings** then select **Endpoints** and then select **Email notifications**.

1. Select **+ Add item**.

1. Specify the General information:

    - Rule name - Specify a name for the notification rule.

    - Include organization name - Specify the customer name that appears on the email notification.

    - Include tenant-specific portal link - Adds a link with the tenant ID to allow access to a specific tenant.

    - Include device information - Includes the device name in the email alert body.

    - Devices - Choose whether to notify recipients for alerts on all devices (Global administrator role only) or selected device groups. For more information, see Create and manage device groups.

    - Alert severity - Choose the alert severity level.

1. Select **Next**.
 
1. Enter the recipient's email address, then select **Add recipient**. You can add multiple email addresses.

1. Check that email recipients are able to receive the email notifications by selecting Send test email.

1. Select **Save notification rule**.