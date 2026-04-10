Contoso Financial Services started with Foundational Cloud Security Posture Management (CSPM) active but no workload protection plans enabled. Their environment had visibility into misconfigurations but no runtime threat detection—no alerts when attackers accessed storage, exploited server vulnerabilities, or attempted suspicious database queries. By enabling the right CWPP plans, configuring layer-specific settings, and deploying protection at scale, the security team transformed Defender for Cloud into an active threat detection platform. The Coverage workbook now confirms full protection across all critical workloads.

In this module, you explored how CSPM provides posture recommendations while Cloud Workload Protection Plans (CWPP) deliver runtime threat detection—and you identified which plan protects each Azure workload type. You enabled plans through Environment Settings and compared Defender for Servers Plan 1 (foundational endpoint protection and vulnerability management) with Plan 2 (which adds just-in-time VM access, file integrity monitoring, agentless scanning, OS configuration assessment, and 500-MB free daily data ingestion). You configured Defender for Storage's three protection layers—activity monitoring, malware scanning, and sensitive data threat detection—and enabled Defender for Databases subplans for SQL, open-source databases, and Cosmos DB. You deployed protection at scale using management groups and Azure Policy, then verified coverage with the Coverage workbook to confirm no gaps remain.

CWPP plans transform Defender for Cloud from a compliance and posture tool into a comprehensive threat detection platform. Posture recommendations reduce your attack surface by fixing vulnerabilities before exploitation. CWPP plans catch threats in real time—detecting malicious activity, blocking malware uploads, and alerting on anomalous database queries. Together, they create defense in depth: fewer vulnerabilities to exploit, and immediate detection when attacks occur.

## Learn more

- [What is Microsoft Defender for Cloud?](/azure/defender-for-cloud/defender-for-cloud-introduction)
- [Enable Defender for Cloud enhanced security features](/azure/defender-for-cloud/connect-azure-subscription)
- [Defender for Servers overview](/azure/defender-for-cloud/defender-for-servers-overview)
- [What is Microsoft Defender for Storage](/azure/defender-for-cloud/defender-for-storage-introduction)
- [Protect your databases with Defender for Databases](/azure/defender-for-cloud/tutorial-enable-databases-plan)
- [About Microsoft Defender for APIs](/azure/defender-for-cloud/defender-for-apis-introduction)
- [AI threat protection in Defender for Cloud](/azure/defender-for-cloud/ai-threat-protection)

**Ready to practice?** Try the [hands-on lab for this module](../labs/lab-enable-configure-workload-protection-plans.md) to apply what you learned in a live Azure environment.
