Contoso Financial Services' SOC now has a layered automation architecture in place. Automation rules handle the triage layer—incidents are automatically tagged by category, assigned to the appropriate team, and known-benign alerts are suppressed during maintenance windows without analyst intervention. The prebuilt notification playbook from Content Hub delivers immediate Teams notifications with embedded incident details when high-severity incidents are created. And the custom Logic Apps playbook gives the team a reusable, version-controlled response workflow they can extend as Contoso's threat landscape grows.

In this module, you:

- Explained the difference between automation rules and playbooks and identified when to use each
- Created automation rules to assign, tag, and suppress incidents based on conditions and evaluation order
- Configured and activated a prebuilt Content Hub playbook with the correct managed identity permissions
- Authored a custom Logic Apps playbook using the Microsoft Sentinel incident trigger and connected it to an automation rule

## What's next

With automated response in place, Contoso's Microsoft Sentinel deployment is operationally ready. The final step is closing out the data lifecycle: making sure nonstandard event sources have a table to land in, compliance retention requirements are met at the right cost tier, and Purview Audit logs are queryable from the Defender portal for SOX compliance investigations.

> [!TIP]
> For the full catalog of prebuilt automation solutions, see [Microsoft Sentinel SOAR content catalog](/azure/sentinel/sentinel-soar-content).
