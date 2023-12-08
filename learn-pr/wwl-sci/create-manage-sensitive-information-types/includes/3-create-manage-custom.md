If the preconfigured sensitive information types (SIT) don't meet your needs, you can create your own custom SITs that you fully define. Since most organizations use individual patterns for information, they can't use a default built-in sensitive information type. Custom SITs are useful in various scenarios, such as:

- Protecting proprietary data like internal project numbers or unique operational codes.
- Securing personal employee information, including unique employee IDs and payroll details.
- Safeguarding financial records, such as internal accounting codes and transaction IDs.
- Complying with industry-specific regulations by ensuring that data such as patient health records or client legal documents isn't disclosed.

Custom SITs allow for the creation of specific protection strategies when the default, built-in SITs don't cover all organizational data protection requirements.

There are two ways to create a new sensitive information type:

- [from scratch where you fully define all elements](/purview/create-a-custom-sensitive-information-type?azure-portal=true#create-a-custom-sensitive-information-type)
- [copy and modify an existing sensitive information type](/purview/create-a-custom-sensitive-information-type?azure-portal=true#copy-and-modify-a-sensitive-information-type)

### Before you begin

Before creating a custom SIT, you should be familiar with sensitive information types and what they're composed of. To get this understanding, see, [Learn about sensitive information types](/purview/sensitive-information-type-learn-about?azure-portal=true). It's important to understand the roles of:

- **[Regular expressions](https://www.boost.org/doc/libs/1_68_0/libs/regex/doc/html/?azure-portal=true)**: Patterns that match text. Microsoft 365 SITs use the Boost.RegEx 5.1.3 engine.
- **Keyword lists**: Pre-made or custom lists used in defining SITs.
- **[Keyword dictionaries](/purview/create-a-keyword-dictionary?azure-portal=true)**: Collections of terms for SITs.
- **[SIT functions](/purview/sit-functions?azure-portal=true)**: Features that enhance SIT identification.
- **[Confidence levels](/purview/sensitive-information-type-learn-about?azure-portal=true#more-on-confidence-levels)**: Indicators that assess the probability that identified information is sensitive based on the presence of supporting details. More supporting evidence increases the confidence level.
- **[SIT limits](/purview/sit-limits?azure-portal=true)**: Restrictions on SIT configurations.

Also, confirm your organization has a Microsoft Purview DLP-capable subscription like Office 365 Enterprise.

### Fundamental parts of a sensitive information type

Every sensitive information type entity includes these fields:

- **Name**: The identifier of the SIT
- **Description**: Explains what data the SIT is looking for
- **Pattern**: A pattern defines the sensitive information detection criteria, consisting of:
  - **Primary element**: The main pattern that the sensitive information type is looking for. It can be a **regular expression** with or without a checksum validation, a **keyword list**, a **keyword dictionary**, or a **function**.
  - **Supporting element**: Additional evidence that increases the confidence of the match. For example, keyword "SSN" in proximity to a Social Security Number (SSN). It can be a regular expression with or without a checksum validation, keyword list, keyword dictionary.
  - **Confidence level**: Reflects how much supporting evidence is detected along with the primary element, ranging from high to medium to low. The more supporting evidence an item contains, the higher the confidence that a matched item contains the sensitive info you're looking for.
  - **Proximity**: The number of characters between the primary and supporting elements.

### Create a custom sensitive information type

To create a custom sensitive information type, you need to:

1. **Identify your data**: Understand what unique data needs protection.
1. **Access the Microsoft Purview compliance portal**: Use the Microsoft Purview compliance portal to create SITs.
1. **Define your SIT**: Choose to start from scratch or modify an existing SIT. Include patterns like regular expressions and keyword lists that match your data.
1. **Test your SIT**: Run simulations to ensure your SIT accurately identifies the intended data.
1. **Deploy and monitor**: Implement your SIT in data loss prevention policies and monitor its efficacy.

For detailed instructions to create and edit custom sensitive information types see [Create a custom sensitive information type](/purview/create-a-custom-sensitive-information-type?azure-portal=true).
