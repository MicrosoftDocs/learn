MITRE ATT&CK is a publicly accessible knowledge base of tactics, techniques, and procedures (TTP) that are commonly used by attackers, and is created and maintained by observing real-world observations. Many organizations use the MITRE ATT&CK knowledge base to develop specific threat models and methodologies that are used to verify security status in their environments.

Microsoft Sentinel analyzes ingested data, not only to detect threats and help you investigate, but also to visualize the nature and coverage of your organization's security status.

When developing a threat hunting hypothesis, it's critical to understand the tactics (why), techniques (how), and procedures (implementations) you're searching for. The MITRE ATT&CK framework is used throughout Microsoft Sentinel.

Use the MITRE ATT&CK selection under Threat Management in Microsoft Sentinel to view the detections already active in your workspace, and those available for you to configure, to understand your organization's security coverage, based on the tactics and techniques from the MITRE ATT&CK® framework.

## View current MITRE coverage

## [Defender portal](#tab/defender-portal)

In Microsoft Sentinel, in the [Defender portal](https://security.microsoft.com/), select the *Threat management* section of the navigation menu, select MITRE ATT&CK. By default, Active scheduled query, Active near real-time (NRT) rules, and Active anomaly query rules are indicated in the coverage matrix.

- **Use the legend at the top-right** to understand how many detections are currently active in your workspace for specific technique.

- **Use the search bar** at the top right to search for a specific technique in the matrix, using the technique name or ID, to view your organization's security status for the selected technique.

- **Select a specific technique** in the top row of the matrix to view in the details pane on the right. There, use the links to jump to any of the following locations:

  - Select *View full tactic or technique details* links for more information in the MITRE ATT&CK framework knowledge base.

  - Select links to any of the *Active coverage* rules to jump to the relevant area in Microsoft Sentinel.
  
- **View MITRE by threat scenarios** to view the coverage matrix by threat scenarios:

  - Drag the **View MITRE by threat scenarios** slider to the right to view the coverage matrix by threat scenarios. The matrix is filtered to show only the techniques that are relevant to the selected scenario.

    :::image type="content" source="../media/mitre-threat-hunting-scenario.png" alt-text="Screenshot of the MITRE ATT&CK threat scenarios drop down menu." lightbox="../media/mitre-threat-hunting-scenario.png":::

## Simulate possible rules coverage

In the MITRE matrix, simulated coverage refers to detections that are available, but not currently configured, in your Microsoft Sentinel workspace. View your simulated coverage to understand your organization's possible security status, were you to configure all detections available to you.

> [!IMPORTANT]
> If you have the *View MITRE by threat scenarios* slider enabled, and have selected a scenario, the Simulated rules (Product simulation) will be disabled.

- From the Microsoft Defender navigation menu, expand the Microsoft Sentinel section, and select *Threat management*, then select MITRE ATT&CK.

- Select items in the Simulated rules drop-down menu to simulate your organization's possible security status.

- For example, select **Hunting queries**, and then select *Hunting queries* **View** link to jump to the Microsoft Sentinel Hunting page. There, you see a filtered list of the hunting queries that are associated with the selected technique, and available for you to configure in your workspace.

## [Azure portal](#tab/azure-portal)

In Microsoft Sentinel, in the [Azure portal](https://portal.azure.com/), select the *Threat management* section of the navigation menu, then select **MITRE ATT&CK (Preview)**. By default, Active scheduled query, Active near real-time (NRT) rules, and Active anomaly query rules are indicated in the coverage matrix.

- **Use the legend at the top-right** to understand how many detections are currently active in your workspace for specific technique.

- **Use the search bar** At the top-left to search for a specific technique in the matrix, using the technique name or ID, to view your organization's security status for the selected technique.

- **Select a specific technique** in the matrix to view more details on the right. There, use the links to jump to any of the following locations:

  - Select *View full tactic or technique details* links for more information in the MITRE ATT&CK framework knowledge base.

  - Select links to any of the *Active coverage* rules to jump to the relevant area in Microsoft Sentinel.

## Simulate rule detections

In the MITRE coverage matrix, simulated coverage refers to detections that are available, but not currently configured, in your Microsoft Sentinel workspace. View your simulated coverage to understand your organization's possible security status, were you to configure all detections available to you.

- In Microsoft Sentinel, select the *Threat management* section of the navigation menu, select MITRE ATT&CK.

- Select items in the Simulated rules drop-down menu to simulate your organization's possible security status.

- For example, select **Hunting queries**, and then select *Hunting queries* **View** link to jump to the Microsoft Sentinel Hunting page. There, you see a filtered list of the hunting queries that are associated with the selected technique, and available for you to configure in your workspace.

    :::image type="content" source="../media/mitre-simulated-rules.png" alt-text="Screenshot of the MITRE ATT&CK simulated rule coverage." lightbox="../media/mitre-simulated-rules.png":::

---

## Use the MITRE ATT&CK framework in analytics rules and incidents

Having a scheduled analytical rule with MITRE techniques applied running regularly in your Microsoft Sentinel workspace enhances the security status shown for your organization in the MITRE coverage matrix.

- **Analytics rules:**

  - When configuring analytics rules, select specific MITRE techniques to apply to your rule.
  - When searching for analytics rules, filter the rules displayed by technique to find your rules quicker.
  
    :::image type="content" source="../media/mitre-analytic-rule-technique.png" alt-text="Screenshot of the MITRE ATT&CK analytics rules configuration." lightbox="../media/mitre-analytic-rule-technique.png":::
  
- **Incidents:**

When incidents are created for alerts that are surfaced by rules with MITRE techniques configured, the techniques are also added to the incidents.

- **Threat hunting:**

  - When creating a new hunting query, select the specific tactics and techniques to apply to your query.

  - When searching for active hunting queries, filter the queries displayed by tactics by selecting an item from the list above the grid. Select a query to see tactic and technique details on the right.

  - When creating bookmarks, either use the technique mapping inherited from the hunting query, or create your own mapping.
