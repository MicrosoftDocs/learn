Contoso Ltd. manages large amounts of sensitive data, including personal information, financial records, and business documents. To protect this information, security teams first need to identify what data exists, where it's stored, and how sensitive it is. Data classification provides the foundation for applying the right security controls across cloud services, endpoints, and on-premises environments.

## The role of data classification

Data classification helps identify and organize sensitive information based on its content and business value. Once data is classified, organizations can apply security policies that protect it based on sensitivity.

- **Identify sensitive information**: Use built-in and custom policies to detect data such as financial records, personal identifiers, or confidential business information.
- **Assign sensitivity labels**: Apply labels that indicate how sensitive the data is and which protections should apply.
- **Automate classification**: Use built-in classifiers, trainable classifiers, or exact data match (EDM) techniques to automatically classify content as it's created or shared.

## Sensitivity labels for data protection

Sensitivity labels define how data is protected once classified. Labels stay with the content, ensuring protections remain in place wherever the data is stored or used.

Sensitivity labels allow organizations to:

- **Classify and protect data** with persistent labels that travel with content across emails, files, and cloud services.
- **Apply automatic or manual labels** based on content inspection and policy rules.
- **Restrict file sharing and enforce access controls** to ensure only authorized users can access or modify data.
- **Apply encryption that travels with the content to protect it from unauthorized access.**
- **Add visual markings** such as headers, footers, and watermarks to indicate data sensitivity.

## Enforcement with data loss prevention policies

Once sensitive data is classified and labeled, **data loss prevention (DLP)** policies can enforce how that data is used or shared. DLP policies help prevent accidental or unauthorized sharing of sensitive information across email, cloud storage, endpoints, and AI-powered services.

## Message encryption for secure communication

In some cases, organizations need to apply encryption directly to email messages. **Microsoft Purview Message Encryption** allows emails to be encrypted both inside and outside the organization. This ensures that sensitive messages remain protected even when shared with external recipients.

## Extending protection to on-premises content

Sensitive information might also reside on on-premises servers or file shares. The **Microsoft Purview Information Protection scanner** allows security teams to discover, classify, and apply protection to sensitive data stored in these locations, extending consistent policies across hybrid environments.

## End-to-end data protection with Microsoft Purview

Microsoft Purview combines classification, labeling, and protection across Microsoft 365 services. Contoso uses classification and labeling to secure sensitive information. Data loss prevention, message encryption, and on-premises scanning help apply consistent protection across cloud apps, email, endpoints, and hybrid environments.
