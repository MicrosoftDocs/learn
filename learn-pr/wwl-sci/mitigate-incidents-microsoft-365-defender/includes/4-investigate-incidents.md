The incident page provides the following information and navigation links.

## Incident overview

The overview page gives you a snapshot glance into the top things to notice about the incident.

:::image type="content" source="../media/incidents-overview.png" alt-text="Screenshot of the Incident overview pane." lightbox="../media/incidents-overview.png":::

The attack categories give you a visual and numeric view of how advanced the attack has progressed against the kill chain. As with other Microsoft security products, Microsoft Defender XDR is aligned to the MITRE ATT&CK™ framework.

The scope section gives you a list of top impacted assets that are part of this incident. If there's specific information regarding this asset, such as risk level, investigation priority, and any tagging on the assets, it will also surface in this section.

The alerts timeline provides a sneak peek into the chronological order in which the alerts occurred and the reasons that these alerts linked to this incident.

And last - the evidence section provides a summary of how many different artifacts were included in the incident and their remediation status, so you can immediately identify if any action is needed on your end.

This overview can help the initial triage of the incident by providing insight into the top characteristics of the incident that you should be aware of.

## Alerts

You can view all the alerts related to the incident and other information about them such as severity, entities that were involved in the alert, the source of the alerts (Microsoft Defender for Identity, Microsoft Defender for Endpoint, Microsoft Defender for Office 365), and the reason they were linked together.

By default, the alerts are ordered chronologically to allow you to first view how the attack played out over time. Clicking on each alert leads you to the **relevant alert page,** where you can conduct an in-depth investigation of that alert.

## Devices

The devices tab lists all the devices where alerts related to the incident are seen.

Clicking on the name link of the machine where the attack was conducted navigates you to its Device page. On the Device page, you can see alerts that were triggered on it and related events provided to ease investigation.

## Users

See users that are identified to be part of or related to a given incident.

Clicking the username navigates you to the **user's Microsoft Defender for Cloud Apps page,** where further investigation can be conducted.

## Mailboxes

Investigate mailboxes that are identified to be part of or related to an incident.

## Apps

Investigate Apps that are identified to be part of or related to an incident.

## Investigations

Select Investigations to see all the automated investigations triggered by alerts in this incident. The investigations perform remediation actions or wait for analyst approval of actions.

Select an investigation to navigate to its Investigation details page to get full information on the investigation and remediation status. If any actions are pending for approval as part of the investigation, they appear in the Pending actions tab.

## Evidence and Responses

Microsoft Defender XDR automatically investigates all the incidents' supported events and suspicious entities in the alerts, providing you with autoresponse and information about the important files, processes, services, emails, and more. This helps quickly detect and block potential threats in the incident.

Each of the analyzed entities are with a verdict (Malicious, Suspicious, Clean) and a remediation status. This helps you understand the remediation status of the entire incident and the next steps to further remediate.

## Incident Graph

The graph visualizes associated cybersecurity threats information into an incident so you can see the patterns and correlations coming in from various data points. You can view such correlation through the incident graph.

The Graph tells the story of the cybersecurity attack. For example, it shows you the entry point, which indicator of compromise or activity was observed on which device, etc.

You can select the circles on the incident graph to view the details of the malicious files, associated file detections, how many instances there are worldwide, whether it’s observed in your organization, if so, how many instances.

### Blast radius analysis (Preview)

Blast radius analysis extends the incident graph with an advanced, interactive view of both the current impact of a breach (post‑breach) and the potential future impact (pre‑breach) in one consolidated graph. It evaluates possible propagation paths from a selected entity (for example, a compromised device or user) toward predefined critical targets, helping analysts quickly assess business impact and prioritize containment.

> [!NOTE]
> Blast radius analysis extends and replaces Attack path analysis.

This capability utilizes Microsoft Sentinel graph and requires onboarding to the Microsoft Sentinel data lake (the underlying graph and data infrastructure). Without the Sentinel data lake, the blast radius experience doesn’t appear.

Key value:

- Unifies pre‑breach exposure and post‑breach spread in a single visualization.
- Highlights top-rated attack paths (potential lateral movement routes) to critical assets.
- Supports role‑based scoping: paths and nodes rendered reflect the viewer’s RBAC permissions.

Typical use cases by role:

- Security analysts: Rapidly gauge scope and escalate or trigger disruption/containment along vulnerable paths.
- SOC / IT engineers: Prioritize remediation and allocate resources based on potential reach to critical targets.
- Incident responders: Visual incident map to guide targeted actions.
- Security leadership (CISO): Communicate impact, set progress metrics, and track defensive posture over time.

Prerequisites:

- Onboarded to Microsoft Sentinel data lake (Graph auto‑provisioned; see “Onboard to Microsoft Sentinel data lake and graph”).
- Appropriate Defender XDR unified RBAC permissions (Exposure management read or higher).

How to use (from the incident graph):

1. Select an entity node and choose “View blast radius.”
2. Review the initial graph showing the top attack paths (you can open the full path list for expanded details).
3. Expand grouped targets to view discrete paths to individual critical assets.
4. Use context actions on nodes (isolate device, disable user, etc.) to interrupt likely lateral movement.
5. Select “Hide blast radius” to return to the default incident graph.

:::image type="content" source="../media/blast-radius.png" alt-text="Screenshot showing the blast radius context menu item." lightbox="../media/blast-radius.png":::

Limitations & modeling notes (summary):

- Path depth is bounded (up to 7 hops overall; typical max 5 for cloud/on‑prem, 3 for hybrid).
- Graph renders possible—not guaranteed—paths derived from known attack vectors.
- Data freshness lag may temporarily omit newly emerged relationships.
- Visibility constrained by user’s RBAC scope; out‑of‑scope nodes/edges aren’t shown.
- Island (disconnected) nodes can appear due to collection/calculation timing.
