Creating effective insider risk management policies begins with understanding the building blocks: policy templates. These templates are a required step in the policy creation process, providing predefined configurations that simplify the process and ensure alignment with specific insider risk scenarios.

## Why use policy templates?

Policy templates are the foundation of Insider Risk Management policies. Every policy must have a template assigned in the policy creation wizard before it can be created. These templates:

- **Address specific risks**: Each template is designed to detect and respond to scenarios like data theft, security violations, or data leaks.
- **Streamline setup**: Predefined structures reduce complexity, enabling faster policy deployment.
- **Ensure consistency**: Templates align with best practices, providing a reliable starting point for managing insider risks.

By starting with a policy template, organizations can quickly configure policies to meet their needs while maintaining privacy and operational efficiency.

## Insider Risk Management policy templates

Microsoft Purview Insider Risk Management includes various policy templates, each tailored to specific insider risk scenarios. These templates are designed to detect activities like data exfiltration, policy violations, or misuse of sensitive information. Selecting the right template helps your organization focus on the most relevant risks while simplifying the policy creation process.

### Data theft by departing users

The **Data theft by departing users** policy template focuses on detecting and addressing potential data exfiltration by employees near their resignation or termination date. This template uses predefined indicators to identify and alert on activities that might signal data theft.

**Example activities**:

- Downloading files from SharePoint Online.
- Copying sensitive files to personal cloud storage.
- Printing confidential documents.

**Key requirements**:

- Configure the Microsoft 365 HR Connector to import resignation and termination dates.
- If not using the HR Connector, select the **User account deleted from Microsoft Entra** option when configuring trigger events.

This policy is essential for protecting sensitive organizational data during employee transitions.

### Data leaks

The **Data leaks** policy template helps prevent accidental or malicious sharing of sensitive information outside the organization. It uses high-severity alerts and indicators to identify activities that might pose a risk.

**Example activities**:

- Downloading sensitive files from SharePoint Online.
- Sharing files or folders externally.
- Copying data to unauthorized cloud storage services.

**Key requirements**:

- Configure data loss prevention (DLP) policies to prioritize significant exfiltration risks.
- Align DLP policy rules and Insider Risk Management policies for consistent user scope.

This template is a critical tool for managing risks related to sensitive data sharing.

### Risky browser usage (Preview)

The **Risky browser usage** policy template helps detect activities where users visit potentially inappropriate or risky websites, such as phishing or adult content sites. This template aligns with organizational acceptable use policies.

**Example activities**:

- Visiting phishing sites.
- Accessing websites containing inappropriate or restricted content.

**Key requirements**:

- Configure browser signal detection using the Microsoft Insider Risk extension for Microsoft Edge or the Microsoft Purview extension for Chrome.
- Select browsing indicators to define triggering events.

This policy supports maintaining compliance and reducing risks associated with inappropriate website use.

### Security policy violations (preview)

The **Security policy violations** policy template focuses on detecting scenarios where users inadvertently or maliciously compromise security, such as disabling protections or installing harmful software.

**Example activities**:

- Disabling security features.
- Installing unauthorized or potentially harmful software.

**Key requirement**:

Enable Microsoft Defender for Endpoint and integrate it with Microsoft Purview compliance portal to receive security alerts.

This template is vital for identifying and addressing security threats within the organization.

### Health record misuse (preview)

The **Health record misuse** policy template is designed for healthcare organizations to safeguard patient records and prevent unauthorized access or data leaks. It supports compliance with regulations like HIPAA and HITECH.

**Example activities**:

- Accessing patient records without authorization.
- Exporting or modifying patient data.

**Key requirements**:

- Configure the Microsoft Healthcare Connector to track activity in electronic medical record (EMR) systems.
- Use the Microsoft HR Connector to import organizational profile data.

This policy template supports a secure healthcare environment by detecting improper access or misuse of patient information.

### Risky AI usage (preview)

The **Risky AI usage** policy template addresses emerging risks associated with generative AI tools. It identifies sensitive or risky prompts and responses that could expose an organization to security threats.

**Example activities**:

- Entering sensitive information into AI tools.
- Generative AI tools providing inappropriate or risky responses based on user input.

**Key requirements**:

- Install the Microsoft Insider Risk Extension for Microsoft Edge or Chrome browsers.
- Optionally, configure the Microsoft HR Connector and Communication Compliance Policies for broader risk detection.

This template is ideal for organizations embracing AI tools but seeking safeguards against unintentional data exposure.

Once you've identified the appropriate policy template, the next step is to decide between quick and custom policy creation.
