The engineering team at Contoso decides to perform a trial of Microsoft Defender for Cloud. As part of the trial, they have a number of VM resources that they want to protect. From the **Overview** page of **Microsoft Defender for Cloud**, the team members review the overall security picture. The team notices that the **Secure score** is just 38 percent. They also notice that there are many security recommendations. They decide to tighten security on their resources.

## Audit your VM’s regulatory compliance

The team starts by reviewing regulatory compliance. Microsoft Defender for Cloud continually assesses resource configuration against assigned standards, benchmarks, and best practices. By default, Azure subscriptions are assessed against the Microsoft Cloud Security Benchmark (MCSB). You can add more standards when your organization needs to measure compliance against specific frameworks.

The following table describes examples of compliance standards against which you can measure your security.

|Compliance standard|Description|
|-------------------|-----------|
|**Microsoft Cloud Security Benchmark**|The Microsoft Cloud Security Benchmark provides Microsoft-recommended security controls and best practices for Azure and other cloud platforms.|
|**PCI DSS v4.0.1**|The Payment Card Industry Data Security Standard (PCI DSS) addresses security issues for organizations that manage credit card payments and is intended to reduce card fraud.|
|**CIS Azure Foundations v2.1.0**|The Center for Internet Security (CIS) Azure Foundations Benchmark provides independent best-practice recommendations for securing Azure environments.|
|**SOC 2023**|The Service Organization Controls (SOC) framework focuses on controls for safeguarding the confidentiality, availability, processing integrity, security, and privacy of information.|
|**ISO/IEC 27001:2022**|ISO/IEC 27001 defines requirements for establishing, implementing, maintaining, and improving an information security management system.|

To review your compliance posture relative to these standards, use the following procedure:

1. In the Azure portal, in **Microsoft Defender for Cloud**, select **Regulatory compliance**.
2. Select the compliance standard you want to review. For example, select **Microsoft Cloud Security Benchmark** or **PCI DSS v4.0.1**.
3. Review the standard's controls, control status, and failed assessments.
4. If you need an offline copy, export or download the report for the selected standard, and then review the report contents.

To review compliance remediation details, on the **Regulatory compliance** page, use the following procedure:

1. Select the appropriate standard.
2. Select a control or assessment that has failed resources.
3. Review the affected resources and remediation steps.
4. Apply the recommended remediation to the affected resources.

## Remediate security recommendations

It's important to do more than just review how your organization compares with security and compliance standards. You should also tighten your security to try to meet those standards. Defender for Cloud calculates secure score from recommendations that help you improve your security posture. Use the following procedure to review and apply recommendations for your subscription:

1. In **Microsoft Defender for Cloud**, select **Recommendations**.
2. Filter recommendations by subscription, resource type, severity, or initiative as required.
3. Select a specific recommendation, and then review the description, affected resources, attack path context where available, and remediation steps.
4. Apply the remediation steps to the affected resources.

    > [!TIP]
    > In some circumstances, you can apply a quick fix by selecting **Fix** or **Remediate** on the specific recommendation. Quick fixes apply supported remediations automatically to selected resources.

5. Where supported, use workflow automation or governance rules to notify resource owners, create tasks, or trigger a Logic Apps playbook.

## Run a vulnerability assessment against your Windows Server IaaS VM

You can use Microsoft Defender for Cloud to perform vulnerability assessment on your VMs. Defender for Servers provides integrated vulnerability scanning through Microsoft Defender Vulnerability Management. Defender for Servers supports two scanning approaches:

- **Agent-based scanning** uses the Defender for Endpoint sensor and is available with Defender for Servers Plan 1 and Plan 2.
- **Agentless scanning** scans supported machines without deploying another endpoint agent and is available with Defender for Servers Plan 2.

### Enable integrated vulnerability scanning

To enable integrated vulnerability scanning on your VMs, use the following procedure:

1. Open **Microsoft Defender for Cloud**, and then select **Recommendations**.
2. Select the **Machines should have a vulnerability assessment solution** recommendation if it appears.
3. Select the affected machines that require a vulnerability assessment solution.
4. Follow the remediation steps to enable Microsoft Defender Vulnerability Management through Defender for Endpoint, or enable agentless scanning by using Defender for Servers Plan 2.

> [!TIP]
> If your organization already uses a supported third-party vulnerability scanner, you can bring your own license (BYOL) for supported Qualys or Rapid7 integrations. Integrated Microsoft Defender Vulnerability Management is the recommended built-in experience.

### Perform the vulnerability assessment

After integrated vulnerability scanning is enabled, Defender for Cloud starts collecting vulnerability data from Microsoft Defender Vulnerability Management. To review vulnerability findings:

1. In Microsoft Defender for Cloud, select **Recommendations**.
2. Select **Machines should have vulnerability findings resolved**.
3. Review the findings for the selected subscriptions. Defender for Cloud lists findings by severity.
4. To filter findings by a specific VM, open **Affected resources**, and then select the VM.
5. Select a vulnerability to review affected CVEs, evidence, and remediation steps.
6. Apply the recommended remediation, such as installing an update, removing vulnerable software, or changing a configuration.

> [!NOTE]
> In the Microsoft Defender portal, cloud vulnerability data is also available under **Exposure Management** > **Vulnerability Management** > **Overview** > **Cloud**.
