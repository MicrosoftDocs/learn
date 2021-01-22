Sensitive information types are used to identify sensitive items. Credit card number and EU debit card number are examples of sensitive information types. Sensitive information types look for specific patterns. Sensitive information types validate the data by looking at its format, its checksums, and look for relevant keywords or other information. Some of this functionality is performed by internal functions.  

Microsoft 365 provides more than 100 built-in sensitive information types, that can help to identify and protect credit card numbers, bank account numbers, passport numbers, and more, based on patterns that are defined by a regular expression (regex) or a function. These built-in definitions can help organizations to quickly deploy solutions in Microsoft 365 to protect company data, using data loss prevention (DLP), retention labels and policies and sensitivity labels.

While the built-in sensitive information types help organizations to quickly identify commonly used types of sensitive data, some sensitive information is organization-specific and require custom sensitive information types. For example, employee IDs, project numbers or other key values of intellectual property may be important to certain industry sectors. To find and protect this information, organizations can create a custom sensitive information type.

## Sensitive Information Type parts

The fundamental components of sensitive information types are the same for built-in and custom sensitive information types and described in the following table:

| **Component**| **Contains**|
| :--- | :--- |
| Primary pattern| Employee ID numbers, project numbers, etc. This is typically identified by a regular expression (RegEx), but it can also be a list of keywords.|
| Additional evidence| Suppose you're looking for a nine-digit employee ID number. Not all nine-digit numbers are employee ID numbers, so you can look for more text with keywords like "employee", "badge", "ID", or other text patterns based on other regular expressions. This supporting evidence (also known as supporting or corroborative evidence) increases the likelihood that nine-digit number found in content is really an employee ID number and lowers the chance for false positives.|
| Character proximity| The closer the primary pattern and the supporting evidence are to each other, the more likely the detected content is going to be what you are looking for. You can specify the character distance between the primary pattern and the supporting evidence, that is also known as the proximity window. This is another factor to reduce false positives and increases the accuracy of finding actual sensitive information to protect.|
| Confidence level| The more supporting evidence you have, the higher the likelihood that a match contains the sensitive information you are looking for. You can assign higher levels of confidence for matches that are detected by using more evidence. However, this also raises the number of false positives.|

For example, the sensitive information type search pattern for a " U.S. social security number (SSN)" is defined as the following:

- It uses four different functions to search for different regular expressions).

- When a regular expression is matched and within 300 characters of a keyword from the *Keyword_ssn* list, this adds more evidence by proximity.

- The confidence level defines the possible false positive rate within the found matches with more evidence.

> [!TIP]
> Whenever possible, use the built-in sensitive information types first, because your organization will benefit from the Microsoft managed data matching patterns from the start.

## Custom Sensitive Information Type Features

Typically, organizational requirements can be fulfilled using the built-in sensitive information types such as protecting customer credit card numbers or employees and customer personal information from accidental sharing. However, organizations may still need to protect custom sensitive data with custom sensitive information types. These requirements may include the need to protect exact data matches from spreadsheets or documents being shared.

The special features of custom sensitive information types include:

- Exact Data Match (EDM)-based classification

- Document Fingerprinting

- Keyword dictionaries

The following table explains the use cases for the three special features:

| **Feature**| **What is it?**| **When to use it?**| **Recommendation**|
| :--- | :--- | :--- | :--- |
| **Exact Data Match (EDM)-based classification**| Enables the creation of databases with custom sensitive information types that refer to exact values. The database can be refreshed daily and contain up to 100 million rows of data.| When large quantities of sensitive information need to be matched daily, for example all the stored personal information of employees of an organization. EDM-based classification enables you to find exact data matches. For example, if the first- and family name and the date of birth of a certain employee is sent in a message, EDM classification can match this information from its database of sensitive information.| Best for organizations that need to store large amounts of personal information, such as hospitals, can benefit from EDM-based classification to make sure no personal information of patients are being shared.|
| **Document Fingerprinting**| Converts a standard form into a sensitive information type.| A document fingerprint can be created on a blank patent template, Government forms or Employee information forms for Human Resources departments. Whenever the same template is used for creating a new form, the custom sensitive information type is matched independently from the rest of the content.| Ideally, organizations already have an established business practice of using certain forms to transmit sensitive information. After uploading an empty form to be converted to a document fingerprint, and then set up a corresponding policy, any documents in outbound mail or being shared, that match that fingerprint, are detected.|
| **Keyword dictionaries**| Keyword dictionaries provide a simple solution for managing reused keyword lists for matching of company information at a large scale, supporting up to 100 KB of keywords in any language.| When identifying generic content, such as healthcare-related communication (ICD classification) or inappropriate or explicit language, keyword dictionaries can be used to detect certain words and take actions on them, such as preventing loss or enforcing company guidelines.| Keyword dictionaries are not as accurate as EDM-based classification, because they only provide simple keywords detection, but they are useful when organizations need to detect industry-specific terms before they are shared with internals or externals or to enforce company guidelines.|

Most organizations should start with the built-in sensitive information types for general protection against data loss of most common sensitive data. Then organizations should analyze their individual needs to protect specific data by creating custom sensitive information types. Afterwards organizations should then use the advanced features of custom sensitive information types, to increase accuracy and simplify management.

