Promptbooks in Microsoft Security Copilot are prebuilt collections of prompts designed to accomplish specific security tasks. They automate repetitive steps for tasks like incident response or investigations, requiring specific inputs such as a code snippet or threat actor name. By incorporating promptbooks, you can streamline your security operations and generate detailed reports quickly.

### How to Use Promptbooks

#### Available promptbooks

The following prebuilt promptbooks are available in Security Copilot:

- Check impact of an external threat article
- Incident investigation
- Microsoft User analysis
- Suspicious script analysis
- Threat actor profile
- Threat Intelligence 360 report based on MDTI article
- Vulnerability impact assessment

#### Incident investigation
1. Select the Prompts button and type "incident investigation."
2. Choose the appropriate promptbook (for example, Microsoft Sentinel incident investigation or Microsoft Defender XDR incident investigation).
3. Enter the incident number and select Submit.
4. Review the responses, which build on each other to generate an executive report.

#### Threat actor profile
1. Select the Prompts button and type "threat actor profile."
2. Choose Threat Actor Profile.
3. Enter the threat actor name and select Submit.
4. Review the generated summary report, which includes known tools, tactics, and procedures (TTPs) and indicators, along with remediation suggestions.

#### Suspicious script analysis
1. Select the Prompts button and type "suspicious script analysis."
2. Choose Suspicious Script Analysis.
3. Paste the script and select Submit.
4. Review the report detailing script actions and threats.

#### Vulnerability impact assessment
1. Select the Prompts button and type "vulnerability impact assessment."
2. Choose Vulnerability Impact Assessment.
3. Enter the CVE number or vulnerability name and select Submit.
4. Review the report on the vulnerability's impact and mitigation steps.

#### Check impact of an external threat article
1. Make sure that you have turned on the **Microsoft Threat Intelligence** plugin.
2. Select the Prompts button and type "check impact of an external threat article."
3. Provide the URL of the external threat intelligence article you want to analyze.
4. Select Submit and review the generated responses, including extracted indicators and relevant analysis.

#### Microsoft User analysis
1. Go to the Promptbook library and look for the **Microsoft User Analysis** promptbook.
2. Select **Start new session**.
3. Provide the user principal name (UPN) and the time range for the analysis.
4. Select Submit and review the comprehensive user analysis, including sign-in data from Microsoft Entra, device information from Intune, unusual activity details from Microsoft Purview, and Defender summary.

#### Threat Intelligence 360 report based on MDTI article
1. Make sure that you have turned on the **Microsoft Threat Intelligence** plugin.
2. Select the Prompts button and type "Threat Intelligence 360 report."
3. Enter the name of the Defender Threat Intelligence article.
4. Select Submit and review the detailed report about whether the threats discussed in the article are affecting the organization.

#### Viewing the Promptbook Library

Access all promptbooks in the Promptbook Library by selecting it from the Copilot menu or home page. You can search, filter, and view details about each promptbook, including descriptions, owners, required plugins, and tags.

For more information, visit the [Microsoft Security Copilot documentation](/copilot/security/using-promptbooks).
