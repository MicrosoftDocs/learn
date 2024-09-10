
Sensitive information types help identify sensitive items, such as credit card numbers and EU debit card numbers. They search for specific patterns and validate data by examining its format, checksums, and relevant keywords or other information. Internal functions carry out some of this functionality.

Microsoft 365 offers over 100 built-in sensitive information types. These types help identify and protect data like credit card numbers, bank account numbers, and passport numbers. They use patterns defined by regular expressions (regex) or functions to detect sensitive information. These built-in definitions can help organizations to quickly deploy solutions in Microsoft 365 to protect company data, using data loss prevention (DLP), retention labels and policies and sensitivity labels.

While the built-in sensitive information types help organizations to quickly identify commonly used types of sensitive data, some sensitive information is organization-specific and require custom sensitive information types. For example, employee IDs, project numbers or other key values of intellectual property may be important to certain industry sectors. To find and protect this information, organizations can create a custom sensitive information type.

## Sensitive information type parts

The fundamental components of sensitive information types are the same for built-in and custom sensitive information types and described in the following table:

| **Component**| **Contains**|
| :--- | :--- |
| Primary pattern| Employee ID numbers, project numbers, etc. This identification is typically done using a regular expression (RegEx), but it can also be achieved through a list of keywords.|
| Additional evidence| Suppose you're looking for a nine-digit employee ID number. Not all nine-digit numbers are employee ID numbers, so you can look for more text with keywords like "employee", "badge", "ID", or other text patterns based on other regular expressions. This supporting evidence (also known as supporting or corroborative evidence) increases the likelihood that nine-digit number found in content is really an employee ID number and lowers the chance for false positives.|
| Character proximity| The closer the primary pattern and the supporting evidence are to each other, the more likely the detected content is going to be what you are looking for. You can specify the character distance between the primary pattern and the supporting evidence, which is also known as the proximity window. Specifying the proximity window is another factor that helps reduce false positives and increases the accuracy of finding actual sensitive information to protect.|
| Confidence level| Confidence levels (low, medium, high) indicate the amount of supporting evidence found with sensitive information. Higher confidence means more evidence and fewer false positives, while lower confidence means less evidence and more false negatives. Balancing confidence levels and counts helps improve detection accuracy.|

For example, the sensitive information type search pattern for a "U.S. social security number (SSN)" is defined as such:

- It uses four different functions to search for different regular expressions.

- When a regular expression is matched and within 300 characters of a keyword from the *Keyword_ssn* list, this adds more evidence by proximity.

> [!TIP]
> Whenever possible, use the built-in sensitive information types first, because your organization will benefit from the Microsoft managed data matching patterns from the start.

## Custom sensitive information type features

Typically, organizational requirements can be fulfilled using built-in sensitive information types. They help protect customer credit card numbers and personal information of employees and customers from accidental sharing. However, organizations may still need to protect custom sensitive data with custom sensitive information types. These requirements may include the need to protect exact data matches from spreadsheets or documents being shared.

The special features of custom sensitive information types include:

- Exact Data Match (EDM)-based classification

- Document Fingerprinting

- Keyword dictionaries

This table explains the use cases for the three special features:

| **Feature**| **What is it?**| **When to use it?**| **Recommendation**|
| :--- | :--- | :--- | :--- |
| **Exact Data Match (EDM)-based classification**| Enables the creation of databases with custom sensitive information types that refer to exact values is a feature that enables daily refreshes and can contain up to 100 million rows of data.| This feature is useful when large quantities of sensitive information need to be matched daily, such as all the stored personal information of an organization's employees. EDM-based classification enables you to find exact data matches. For instance, if an employee's first name, last name, and date of birth are sent in a message, EDM classification can match these specific details with its database of sensitive data.| Best for organizations that need to store large amounts of personal information, such as hospitals, can benefit from EDM-based classification to make sure no personal information of patients are being shared.|
| **Document Fingerprinting**| Converts a standard form into a sensitive information type.| A document fingerprint can be created on a blank patent template, Government forms or Employee information forms for Human Resources departments. Whenever the same template is used for creating a new form, the custom sensitive information type is matched independently from the rest of the content.| Ideally, organizations already have an established business practice of using certain forms to transmit sensitive information. Once you upload an empty form for conversion to a document fingerprint and set up a corresponding policy, any outbound mail or shared documents matching that fingerprint are detected.|
| **Keyword dictionaries**| Keyword dictionaries offer an easy way to manage reused keyword lists for matching company information on a large scale. They support up to 1 MB of keywords in any language.| Keyword dictionaries help identify generic content like healthcare-related communication (ICD classification) or inappropriate language. They detect specific words, allowing actions to be taken, such as preventing loss or enforcing company guidelines.| Keyword dictionaries are less accurate than EDM-based classification because they only detect simple keywords. However, they're useful for detecting industry-specific terms before sharing with internal or external parties and enforcing company guidelines.|

Most organizations should start with the built-in sensitive information types for general protection against data loss of most common sensitive data. Then organizations should analyze their individual needs to protect specific data by creating custom sensitive information types. Afterwards organizations should then use the advanced features of custom sensitive information types, to increase accuracy and simplify management.
