Alert settings in a data loss prevention (DLP) policy control how and when security teams are notified about risky activity. The configuration choices determine whether alerts are triggered for every policy match or only when certain thresholds are met. Understanding how to configure alerts and when to use different alert types is key to managing data risk effectively. Licensing also affects which alert options are available. Making the right choices ensures the right people are informed at the right time, without generating unnecessary noise.

## When do you configure alerts in a DLP policy?

When you create or edit a DLP policy in Microsoft Purview, you start by defining which conditions to monitor. You then decide what actions to take and how alerts should be handled. Alert settings are part of the rule configuration stage. After you define your conditions and actions, you decide whether to notify someone and whether an alert should be created.

To configure alerts when creating or editing a DLP policy:

1. Go to the Microsoft Purview portal.
1. Select **Solutions** > **Data Loss Prevention** > **Policies**.
1. Create a new DLP policy or select an existing policy to modify.
1. **Choose where to apply the policy** in locations such as Exchange, SharePoint, or devices.
1. Create a new rule or edit an existing rule.
1. After defining conditions and actions, configure incident reports and alerting behavior:

   :::image type="content" source="../media/configure-incident-reports.png" alt-text="Screenshot showing the configuration options for incident reports in a data loss prevention policy." lightbox="../media/configure-incident-reports.png":::

1. Choose to deploy your policy right away, in simulation mode, or off.
1. Save and submit your policy settings.

## Types of DLP alerts

There are two types of DLP alerts you can configure in Microsoft Purview:

- **Single-event alerts** generate an alert every time a policy rule match occurs. These alerts are best for low-volume, high-sensitivity events—like when a user emails a file containing multiple credit card numbers.
- **Aggregate-event alerts** generate alerts only when a threshold is met, such as 10 matching events within 24 hours. This configuration helps reduce alert fatigue in high-volume environments.

You can set thresholds by:

- **Number of matches** (for example, 10 matches in 60 minutes)
- **Volume of data** (for example, more than 1 MB of matching content)

To prevent alert overload, policy matches on the same item in the same location are grouped if they occur within a one-minute window.

## Licensing requirements

What you can configure depends on your Microsoft 365 license:

- **Single-event alerts**: Available with E1, F1, G1, E3, or G3 licenses.
- **Aggregate-event alerts**: Requires an E5 license or one of the following add-ons for E3/G3:
  - Office 365 Advanced Threat Protection Plan 2
  - Microsoft 365 E5 Compliance
  - Microsoft 365 eDiscovery and Audit add-on

Licensing also affects the aggregation time window:

- **One-minute window**: E5 or add-on license
- **15-minute window**: E3/G3 or lower without the add-on

## Roles required to configure alerts

To configure or view DLP alerts, users must be assigned specific roles in Microsoft Purview. These roles include:

- **Compliance Administrator**
- **Information Protection Admin**
- **Security Operator**
- **Security Reader**
- **Information Protection Investigator**

To access the DLP alert management dashboard, users must have the **Manage alerts** role, with membership in either the **DLP Compliance Management** or **View-Only DLP Compliance Management** role group.

For viewing matched content or using Content explorer, the **Content Explorer Content Viewer** role is also required.

## Where alerts appear

Email notifications deliver alerts and also display them in two key locations:

- **Microsoft Defender XDR**: Used for investigating alerts and managing incidents. This is where alerts are grouped, correlated with other events, and acted on.
- **Microsoft Purview alerts dashboard**: Used for configuring policies and reviewing alert history. You can change alert status, export activity data, or share events with others.

## How alerts behave after deployment

- Alerts, incident reports, and user notifications only trigger once per document, even if the same content is shared or accessed multiple times.
- It can take up to 3 hours for a new or updated policy to begin generating alerts.
- If your tenant uses Endpoint DLP or Teams DLP, alerts from those services also appear in the DLP alerts dashboard.

These behaviors help set expectations for how and when alerts are delivered, so that teams can act confidently on the signals they receive.
