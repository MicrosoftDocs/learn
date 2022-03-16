Once you have a set of alerts, you can select a security alert to learn more about the events that triggered it and what steps, if any, you need to take to repel an attack. Security alerts are grouped by type and date. Selecting **Security alert** opens a view containing a list of alerts, as the following figure depicts.

:::image type="content" source="../media/3-defender-for-cloud-alert-details-pane.png" alt-text="Screenshot that shows the security alert details pane.":::

In this case, the alerts that were triggered refer to suspicious authentication activity. The first column lists the alert severity; the second column displays the type of alert; the third column indicates the affected resource; the fourth column displays the start time of the activity; the fifth column displays the kill chain intent of the alert; the sixth column displays the status of the alert.

After reviewing this information, a security engineer can select an alert, and then select **View full details** on the alert pane to get specific information about:

1. **What happened?** (_Possible compromised machine detected_)
1. **When did it happen?** (_Tuesday, March 01 2022 10:31:00 AM_)
1. **What resource was attacked?** (_CPSLab01001_)
1. **Where is the resource located?** (_Azure subscription_)
1. **What should you do about it?** (Take action)

:::image type="content" source="../media/3-defender-for-cloud-alert-full-details.png" alt-text="Screenshot that shows the full details pane for an alert.":::

### Responding to security alerts

The **Alert details** area has more details about this event. These details offer insight into what triggered the security alert, the target resource, the source IP address (when applicable), and recommendations about how to remediate the event. In some cases, the source IP address is empty (not available), because not all Windows security event logs include the IP address.

The remediation steps suggested by Defender for Cloud vary according to the security alert. In some cases, you might have to use other Azure capabilities to implement the recommended remediation. Select the **Take action** tab to see remediation recommendations. For example, the remediation for this attack is to enforce strong passwords or use just-in-time (JIT) access on the resource.

From this tab, you can also start an investigation to better understand the timeline of the attack, how the attack took place, which systems were potentially compromised, and which credentials were used, and you can get a graphical representation of the entire attack chain.

## Relating security alerts together

Attacks against cloud-based resources often generate large amounts of data, and picking through all the individual alerts can be a cumbersome process to identify the root cause. As seen above, Defender for Cloud tracks individual security alerts, but it also uses big data and machine learning technologies to combine different alerts into _incidents_.

An incident is a collection of related individual alerts. Combining of related alerts into incidents is an advanced capability of Defender for Cloud and requires enhanced security features for Microsoft Defender for Cloud.

By presenting related alerts together, a security engineer can quickly see the "big picture" of what's happening and start the process of blocking the attack.
