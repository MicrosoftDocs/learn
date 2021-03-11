The term "threat hunting" is defined differently by different people.  The most commonly used definition is the idea that you are proactively hunting through your environment for a threat or a set of activities that you have not previously detected.  The "not previously detected" part is what differentiates threat hunting from incident response or alert triage.

Other uses of the term hunting include searching for threats with newly obtained indicators.  If a Threat Intelligence Feed provides a new IP Address considered harmful, an analyst can then take the IP Address and search the logs to find if the new indicator was seen in the past.  Technically this is not threat hunting because you are using a known bad such as an IP Address. Azure Sentinel already provides hunting queries to facilitate this process. Next, hunt for more evidence-based threats from a current Incident or Alert as part of an Incident Analysis process.  It is vital to explore data based on evidence found in a current incident.  Both Azure Sentinel and Microsoft 365 Defender provide this type of hunting capability.

All of these approaches have one thing in common: using KQL queries to find threats.

Microsoft Defender and Microsoft Defender Endpoint are more focused on indicator and analysis types of hunting. Azure Sentinel provides more features to manage the threat hunting process.

## Proactive hunts

Why do proactive hunting?  As you hunt for "not previously detected" threats, the concern is that if you wait for the threat to be detected, the compromise impact could be more significant.  If we don't have a known indicator, then what are we hunting?  We hunt based on a Hypothesis.  The Hypothesis might start with "Operational Threat Intelligence," and then list the attackers' tactics and techniques.  A Hypothesis can search for a specific technique, not an indicator like an IP address.  If malicious activity is identified, we might have discovered the attacker earlier in the attack process before they have an opportunity to exfiltrate data.

## Process to hunt threats

:::image type="content" source="../media/learn-plan-8.png" alt-text="Threat Hunting Process":::

Threat hunting should be a continual process.  We start at the top of our cycle with our Hypothesis.  Our Hypothesis helps us plan out what we are going to hunt for, which requires us to understand where we are going to hunt and how we will do it. This means we need to understand the data we have, the tools we have, the expertise we have, and how to work with them. The hunting cycle doesn't stop when we execute the hunt. There are still several phases we need to conduct throughout the life cycle, including responding to anomalies. Even if we don't find an active threat, there will be activities to perform.

Routine tasks should include:

- Setting up new monitoring.

- Improving our detection capabilities.

Everything done in Threat Hunting should be documented. Documentation for the hunt should include:

- What, How, and Why

- Input and Output

- How to replicate the hunt

- Next Steps

