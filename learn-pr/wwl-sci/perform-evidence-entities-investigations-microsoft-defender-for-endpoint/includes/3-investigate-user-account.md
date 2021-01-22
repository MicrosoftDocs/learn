Identify user accounts with the most active alerts (displayed on the dashboard as "Users at risk") and investigate cases of potentially compromised credentials, or pivot on the associated user account when investigating an alert or device to identify possible lateral movement between devices with that user account.

You can find user account information in the following views:

- Dashboard

- Alert queue

- Device details page

A clickable user account link is available in these views, which will take you to the user account details page where more details about the user account are shown.

When you investigate a user account entity, you'll see:

- User account details, Azure Advanced Threat Protection (Azure ATP) alerts, and logged on devices, role, log-on type, and other details

- Overview of the incidents and user's devices

- Alerts related to this user

- Observed locations in the organization (devices logged on to)

  ![User Account Page](../media/advanced-threat-protection-user-details-view.png)

### User details

The User details pane on left provides information about the user, such as related open incidents, active alerts, SAM name, SID, Azure ATP alerts, number of devices the user is logged on to, when the user was first and last seen, role, and log-on types. Depending on the integration features you've enabled, you'll see other details. For example, if you enable the Skype for business integration, you'll be able to contact the user from the portal. The Azure ATP alerts section contains a link that will take you to the Azure ATP page if you have enabled the Azure ATP feature, and there are alerts related to the user. The Azure ATP page will provide more information about the alerts.

### Overview

The Overview tab shows the incident details and a list of the devices the user has logged on to. You can expand these to see details of the log-on events for each device.

### Alerts

The Alerts tab provides a list of alerts that are associated with the user account. This list is a filtered view of the Alert queue and shows alerts where the user context is the selected user account, the date when the last activity was detected, a short description of the alert, the device associated with the alert, the alert's severity, the alert's status in the queue, and who is assigned the alert.

### Observed in organization

The Observed in organization tab allows you to specify a date range to see a list of devices where this user was observed logged on to, the most frequent and least frequent logged on user account for each of these devices, and total observed users on each device.  Selecting an item on the Observed in organization table will expand the item, revealing more details about the device. Directly selecting a link within an item will send you to the corresponding page.

