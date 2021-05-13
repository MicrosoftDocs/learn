Once you have a set of alerts, you can select a security alert to learn more about the events that triggered it and what steps, if any, you need to take to repel an attack. Security alerts are grouped by type and date. Selecting a security alert opens a view containing a list of the grouped alerts, as the following figure depicts.

![Screenshot that depicts a pane containing a list of grouped security alerts.](../media/M3-ASC-Alerts3.png)

In this case, the alerts that were triggered refer to suspicious malware activity. The first column lists the attacked resources; the second column displays how many times attack was detected; the third column indicates the time of the attack; the fourth column displays the environment; the fifth column displays the state of the alert; the sixth column displays severity of the attack.

After reviewing this information, a security engineer can select an attacked resource to get specific information about:

1. **What happened?** (_Possible compromised machine detected_)
1. **When did it happen?** (_Sunday, August 11 2019 3:01:00 AM_)
1. **What resource was attacked?** (_vm4_)
1. **Where is the resource located?** (_Azure_)
1. **What should you do about it?** (Remediation steps)

![Screenshot that depicts details about a resource that was attacked.](../media/M3-ASC-Alerts4.png)

### Responding to security alerts

The **DESCRIPTION** area has more details about this event. These details offer insight into what triggered the security alert, the target resource, the source IP address (when applicable), and recommendations about how to remediate the event. In some cases, the source IP address is empty (not available), because not all Windows security event logs include the IP address.

The remediation steps suggested by Security Center vary according to the security alert. In some cases, you might have to use other Azure capabilities to implement the recommended remediation. For example, the remediation for this attack is to run a full malware scan on the machine.

From this page, you can also start an investigation to better understand the timeline of the attack, how the attack took place, which systems were potentially compromised, and which credentials were used, and you can get a graphical representation of the entire attack chain.

## Relating security alerts together

Attacks against cloud-based resources often generate large amounts of data, and picking through all the individual alerts can be a cumbersome process to identify the root cause. As seen above, Security Center tracks individual security alerts, but it also uses big data and machine learning technologies to combine different alerts into _incidents_.

An incident is a collection of related individual alerts. Note that this combining of related alerts into incidents is an advanced capability of Security Center and requires at least the Standard tier for Azure Security Center.

By presenting related alerts together, a security engineer can quickly see the "big picture" of what's happening and start the process of blocking the attack.
