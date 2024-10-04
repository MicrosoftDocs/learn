Sensitive information types (SITs) in Microsoft Purview help organizations identify and protect sensitive data such as personal identification numbers, financial information, and intellectual property. By using patterns like regular expressions, keywords, and checksums, SITs can automatically detect sensitive data in emails, documents, and databases to prevent unauthorized sharing or exposure. These built-in SITs, of which there are over 300, cover a wide range of common data types, including credit card numbers, social security numbers, and health records. Custom SITs can also be created to protect organization-specific data such as employee IDs and proprietary project codes.

Most organizations can meet compliance requirements using built-in SITs, which integrate seamlessly with tools like Data Loss Prevention (DLP) and retention policies in Microsoft Purview. For organizations with more specific needs, custom SITs offer flexibility in identifying and securing unique data sets. This ensures that sensitive information remains protected, aligned with the organization's governance and compliance strategies.

## Built-in sensitive information types

Built-in sensitive information types are preconfigured to detect common sensitive data such as credit card numbers, social security numbers, bank account information, and passport numbers. These SITs use predefined patterns, regular expressions, and checksums to identify sensitive data across documents, emails, and databases.

### Advantages of built-in SITs

- **Quick deployment**: Built-in SITs are ready to use out-of-the-box and require no extra setup. They allow organizations to rapidly deploy data protection solutions for common data types.

- **Managed by Microsoft**: Microsoft continuously updates and maintains built-in SITs to ensure they meet the latest compliance and regulatory standards.

- **Broad coverage**: These SITs cover a wide range of industries and sensitive data types, from financial information to healthcare records.

### When to use built-in SITs

Use built-in SITs when your organization deals with standard types of sensitive information, such as payment details, government-issued IDs, or health records. They're ideal for general compliance and data loss prevention (DLP) needs.

## Custom sensitive information types

Custom SITs allow organizations to define specific patterns and rules for identifying sensitive data unique to their industry or business operations. These can include internal employee IDs, proprietary project codes, or other forms of intellectual property.

### Features of custom SITs

- **Exact data match (EDM)**: Matches exact data values by comparing content to predefined databases, making it ideal for organizations that need to protect large datasets with precise information, such as patient records or employee data.

- **Document fingerprinting**: Converts standardized forms into custom SITs, enabling organizations to detect when sensitive documents, such as government forms or contracts, are shared.

- **Keyword dictionaries**: Allows organizations to manage and detect large lists of sensitive keywords and phrases specific to their operations or industry, such as internal product codes or terminology.

### Advantages of custom SITs

- **Flexibility**: Custom SITs allow organizations to create tailored protection for data that isn't covered by built-in options.

- **Industry-specific needs**: Organizations in niche industries or with proprietary data requirements can use custom SITs to protect information unique to their operations.
- **Exact precision**: By using features like exact data match or document fingerprinting, custom SITs offer higher accuracy in detecting specific sensitive information.

### When to use custom SITs

Use custom SITs when your organization has unique or proprietary data that needs protection, such as internal codes, specialized industry terminology, or precise employee data. Custom SITs are also valuable for regulatory compliance in highly specialized sectors.

## Compare built-in vs custom SITs

| **Criteria** | **Built-in SITs** | **Custom SITs** |
| --- | --- | --- |
| **Ease of use** | Preconfigured and ready to use | Requires manual setup and configuration |
| **Maintenance** | Managed and updated by Microsoft | Must be managed and updated by the organization |
| **Scope of coverage** | Covers common data types (financial, healthcare, etc.) | Can cover organization-specific data (employee IDs, project codes) |
| **Accuracy** | High, but might result in some false positives | Can be precise using exact data match or document fingerprinting |
| **Customization** | Limited to built-in data types | Fully customizable for unique data sets |
| **Regulatory compliance** | Suitable for standard regulations | Can be customized to meet specific regulatory requirements in specific industries |
| **Recommended use cases** | General data protection and compliance needs | Protecting proprietary or organization-specific data |

Starting with built-in sensitive information types allows organizations to address general information security and compliance needs. As specific requirements arise, creating custom sensitive information types enables tailored protection strategies. Finally, using advanced features like exact data match and document fingerprinting helps increase accuracy and simplifies data protection management.
