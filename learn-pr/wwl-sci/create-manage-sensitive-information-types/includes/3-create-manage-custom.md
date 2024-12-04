If the preconfigured sensitive information types (SITs) don't meet your needs, you can create your own custom SITs that you fully define. Since most organizations use individual patterns for information, they can't use a default built-in sensitive information type. Custom SITs are useful in various scenarios, such as:

- Protecting proprietary data like internal project numbers or unique operational codes.
- Securing personal employee information, including unique employee IDs and payroll details.
- Safeguarding financial records, such as internal accounting codes and transaction IDs.
- Complying with industry-specific regulations by ensuring that data such as patient health records or client legal documents isn't disclosed.

Custom SITs allow for the creation of specific protection strategies when the default, built-in SITs don't cover all organizational data protection requirements.

There are two ways to create a new sensitive information type:

- [from scratch where you fully define all elements](/purview/create-a-custom-sensitive-information-type?azure-portal=true#create-a-custom-sensitive-information-type)
- [copy and modify an existing sensitive information type](/purview/create-a-custom-sensitive-information-type?azure-portal=true#copy-and-modify-a-sensitive-information-type)

## Before you begin

Before creating a custom Sensitive Information Type (SIT), it’s important to understand how patterns and elements work to accurately detect sensitive data. Understanding these help ensure that your custom SITs meet your organization's needs.

- **[Regular expressions](https://www.boost.org/doc/libs/1_68_0/libs/regex/doc/html/?azure-portal=true)**:  Regular expressions are patterns used to identify specific formats or types of text, such as email addresses or employee IDs. When creating custom SITs, regex allows you to define the exact format of your data. For example, you could use a regex pattern like `\b\d{3}-\d{2}-\d{4}\b` to detect a U.S. Social Security Number. Using advanced regex features, such as lookaheads or character classes, helps improve detection accuracy and allows flexibility for different data formats.

- **Proximity**: Proximity defines how close the primary pattern (like an ID number) must be to supporting keywords (like "employee" or "ID badge"). Setting an appropriate proximity window ensures that related data elements are close enough to be considered a match, reducing the risk of false positives.

- **Keyword lists**: A keyword list consists of predefined terms commonly found near sensitive data. For example, if you're detecting employee IDs, terms like "employee" or "badge" might appear nearby. Creating a list of these keywords helps your SIT identify relevant data more accurately. You can use existing keyword lists or create a custom list based on the context where sensitive information is typically found.

- **Keyword dictionaries**: A keyword dictionary is a more extensive collection of terms, often used for complex or industry-specific detection needs. For example, a healthcare organization might create a dictionary with medical terminology or diagnosis codes. Dictionaries enable large-scale keyword detection and are ideal when handling specialized data across vast amounts of documents.

- **[SIT functions](/purview/sit-functions?azure-portal=true)**: SIT functions help validate sensitive information through extra checks, such as ensuring a credit card number passes the Luhn checksum. Functions add another layer of precision to your custom SIT, allowing you to verify that detected data is correctly formatted and valid.

- **Confidence levels**: Confidence levels let you control how much supporting evidence is required to classify data as sensitive. High confidence levels need more corroborating evidence, like matching keywords or proximity, while lower levels can trigger detection with less evidence. Adjusting this setting helps you reduce false positives and negatives, ensuring a better balance in detection accuracy.

- **[SIT limits](/purview/sit-limits?azure-portal=true)**: Microsoft Purview places restrictions on the size and complexity of custom SITs. Ensure that your SIT design complies with these limits to avoid performance issues or misconfigurations.

## Fundamental parts of a sensitive information type

Every sensitive information type entity includes these fields. Each component plays a role in how effectively the sensitive information type identifies and protects data.

- **Name**: The identifier of the SIT

- **Description**: Explains what data the SIT is looking for

- **Pattern**: A pattern defines the sensitive information detection criteria, consisting of:

  - **Primary element**: The main pattern that the sensitive information type is looking for. It can be a **regular expression** with or without a checksum validation, a **keyword list**, a **keyword dictionary**, or a **function**.

  - **Supporting element**: Extra evidence that increases the confidence of the match. For example, keyword "SSN" in proximity to a Social Security Number (SSN). It can be a regular expression with or without a checksum validation, keyword list, keyword dictionary.

  - **Confidence level**: Indicates how much supporting evidence is needed to classify data as sensitive. Higher confidence levels require more corroborating data, reducing the chance of false positives.

  - **Proximity**: The maximum allowed distance between the primary element and the supporting evidence to be considered a match.

## Create a custom sensitive information type

To create a custom sensitive information type, you need to:

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true).

1. In the Microsoft Purview portal, navigate to **Solutions** > **Information Protection**.

1. On the **Microsoft Information Protection** page, on the left sidebar, expand **Classifiers** then select **Sensitive info types**.

1. On the **Sensitive info types** page, select **+ Create sensitive info type**.

1. Fill in values for **Name** and **Description**, then select **Next**.

1. On the **Define patterns for this sensitive info type** page, select **Create pattern**.

   You can create multiple patterns, each with different elements and confidence levels, as you define your new sensitive information type.

1. A flyout panel appears to define your new pattern. Choose the default confidence level for the pattern. The values are **Low confidence**, **Medium confidence**, and **High confidence**.

1. In the flyout panel, choose one of these options as your **Primary element**:
   - **Regular expression**
   - **Keyword list**
   - **Keyword dictionary**
   - **Functions**

1. In the flyout panel, fill in a value for **Character proximity**.

1. (Optional) Add supporting elements if your data needs extra context to strengthen detection. Supporting elements can be a regular expression with or without a validator, a keyword list, keyword dictionary, or one of the predefined functions. These elements help refine the match by adding corroborating details.

1. (Optional) In the flyout panel, add any [**additional checks**](/purview/sit-regex-validators-additional-checks?azure-portal=true#sensitive-information-type-additional-checks). These checks can include validation processes such as checksums to further ensure that the detected data is valid and meets your criteria.

1. At the bottom of the flyout panel, select **Create**.

   :::image type="content" source="../media/sensitive-info-type-new-pattern.png" alt-text="Screenshot showing the new pattern options when creating a sensitive info type." lightbox="../media/sensitive-info-type-new-pattern.png":::  

1. Back on the **Define patterns for this sensitive info type** page, select **Next**.

1. Choose the **recommended confidence level** for this sensitive information type, then select **Next**.

1. On the **Review settings and finish** page review the settings and select **Create**. When successfully created select **Done**.

1. The **Sensitive info types** tab of the **Classifiers** page, lists all of the sensitive information types. select **Refresh** and then or use the search tool or browse the list to find your new SIT.
