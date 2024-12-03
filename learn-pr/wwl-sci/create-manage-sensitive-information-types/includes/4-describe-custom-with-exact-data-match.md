Exact data match (EDM) allows you to create a sensitive information type (SITs) that uses exact data values for identifying and protecting sensitive information. With EDM, you can ensure your SIT:

- **Is easily updated**: Quickly adapt to changes in your sensitive data.
- **Reduces false positives**: Accurately identify the correct information, minimizing mistakes.
- **Fits structured data**: Works well with organized data sets.
- **Ensures privacy**: Keeps sensitive data secure and private, even from Microsoft.
- **Integrates across services**: Functions with a range of Microsoft cloud services for better data governance.

For example, if you have customer account numbers, EDM specifically flags those numbers only, which significantly lessens the risk of incorrect flags.

 :::image type="content" source="../media/exact-data-match-classification.png" alt-text="Diagram showing how exact data match based classification works." lightbox="../media/exact-data-match-classification.png":::  

EDM-based classification enables you to create custom sensitive types that match exact values from a database. This database can hold up to 100 million rows of data and can be refreshed daily to reflect changes such as new or departing employees, patients, or clients. This ensures your custom sensitive information types remain current and relevant.

## What's different in an EDM SIT

An EDM SIT is different from standard SITs because it matches exact data values instead of relying only on patterns or keywords. It also includes a few specific concepts:

### Schema

The schema is an XML file that serves as the blueprint for your EDM SIT. It defines:

- The name of the schema, later referred to as the _DataStore_.
- Field names that correspond to the columns in your sensitive information source table.
- Which fields are searchable, allowing precise control over what the SIT will check.
- A _configurable match_ to refine your search, such as case sensitivity or ignoring punctuation.

### Sensitive information source table

The sensitive information source table is the actual dataset used for matching. It contains:

- Column headers representing the field names (like _First Name_, _Last Name_, _Date of Birth_).
- Rows representing individual records, with each cell containing the specific value for its field.

Example table:

|First name|Family name|Date of birth|
|---|---|---|
|Isaiah|Langer| 05-05-1960|
|Ana|Bowman|11-24-1971|
|Oscar|Ward|02-12-1998|

### Rule package

The rule package in an EDM SIT defines:

- **Matches** specify the primary element used for exact lookups, such as a regular expression or a function.
- **Classification** determines the type of sensitive information being searched for.
- **Confidence levels** measure the likelihood of a match, based on how much supporting evidence is present.
- **Proximity** defines the allowable character distance between the primary and supporting elements.
- **Supporting elements** provide additional context, improving accuracy by reducing false positives and increasing confidence. For instance, finding "SSN" near a social security number helps confirm it.

### Primary and secondary support elements

In an EDM SIT, the _primary element_ is the key data point you're looking to protect, such as a social security number or credit card number. You must match the primary element to an existing SIT that Microsoft Purview can already identify.

Once the primary element is detected, EDM looks for a _secondary supporting element_, like finding the term "SSN" near the actual social security number. This further confirms the identification, increasing confidence in the match.

Supporting elements don't always need fixed patterns, but if they contain multiple words, a defined pattern is required.

## Create an EDM-based SIT

Creating an EDM SIT is a multi-phase process. You can use either the **new experience** or the **classic experience**, depending on your needs.

### The new EDM experience

The new EDM experience integrates schema creation and SIT definition into a streamlined workflow:

- **Simplified workflow**: The new EDM experience streamlines the process by combining schema and SIT creation, reducing steps and guiding you through mapping data fields to predefined SITs.
- **Additional guardrails to ensure better performance**: Alerts you when fields are too broad, helping you avoid inefficient matches and ensuring high performance.

### The classic EDM experience

You can toggle back and forth between the new and classic experiences, but we recommend using the new experience unless your needs fall into one or more of these four use cases:

1. **Multiple SITs per schema**: The classic experience allows for multiple SITs to be mapped to a single schema, which isn't possible in the new experience.
1. **Managing more than 10 SITs**: If you need to create or manage more than 10 SITs, you need to use the classic experience. Because you can map multiple EDM SITs to the same schema, you can have more than 10 EDM SITs. Attempting to create an eleventh schema with the new experience generates an error.
1. **Custom schema names**: The classic experience lets you specify custom names for your EDM schemas, unlike the new experience that auto-generates schema names.
1. **Editing existing schemas**: If you need to edit schemas created in the classic experience or uploaded via PowerShell, you must use the classic experience, as the new experience doesn't support this functionality.

Use the procedure to understand how to create an EDM SIT. Select the appropriate tab for guidance on creating one with the **new** or **classic** experience.

## [New EDM experience](#tab/new)

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true), then navigate to **Solutions** > **Information Protection** > **Classifiers** > **EDM classifiers**.

1. Make sure the **New EDM experience** toggle is set to **On**.

   :::image type="content" source="../media/new-edm-toggle.png" alt-text="Screenshot showing the toggle to use the new EDM experience." lightbox="../media/new-edm-toggle.png":::  

1. Select **Create EDM classifier**.

1. Review the **Familiarize yourself with the steps needed to put your classifier to work** page, then select **Create EDM classifier**.

1. On the **Name and describe your EDM classifier** page, name the SIT and add a description. The system uses this name, appended with the word _schema_, for the associated schema it generates.

1. Select **Next**.

1. On the **Choose a method for defining your schema** page, select the method you want to use for your schema: either **Upload a file containing sample data**, or **Manually define your data structure**.

   Best practice is to upload a sample data file. The rest of this procedure assumes this option.

1. Select **Next**.

1. On the **Upload your sample file** page, select your sample file and then select **Upload file**. Select **Next**.

   If errors display during the upload, address them and then try again.

1. On the **Select primary elements** page:

    1. In the **Primary element** column, select your primary element. Each primary element must be mapped to a SIT. Best practice is to select fields that show **Full match** under the **Match Validation** column.

    1. In the **Match mode** column for each field, designate which of the following matching options to apply:
        - **Option 1:** Do nothing to accept the system-suggested SIT.
        - **Option 2:** Expand the dropdown menu. Under **Sensitive Info type (SIT)**, choose the pencil (**Edit**) icon and then select another existing SIT.
        - **Option 3:** Under **Match mode** select **Single token**.
        - **Option 4:** Under **Match mode** select **Multi-token**.

1. Select **Next**.

1. **Configure settings for data in selected columns**.
    - The toggle **Use the same settings for all columns** is set to **On** by default. If you want to use separate settings for each data field, set the toggle to **Off**.
    - The **Data in columns are case-insensitive** option is selected by default. To enforce **case-sensitive** detection, uncheck this box.
    - If needed, select the option to **Ignore delimiters and punctuation for data in all columns** You can then either select the delimiters and punctuation marks you want to ignore from a list or you can enter custom delimiters and punctuation marks to ignore.

1. On the **Review settings and finish** page, select **Submit**.

1. On the **You successfully created an EDM classifier** page, capture the **Schema name**. This name is required when hashing and uploading the sensitive information source table to ensure proper mapping of the data to the schema.

1. Once you've captured the schema name, select **Done**.

Once you create your EDM schema, the next step is to hash and upload your sensitive data. This ensures the data can be used securely for classification. For detailed steps on hashing and uploading your source table, see [Hash and upload the sensitive information source table for exact data match sensitive information types](/purview/sit-get-started-exact-data-match-hash-upload?azure-portal=true)

# [Classic EDM experience](#tab/classic)

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true), then navigate to **Solutions** > **Information Protection** > **Classifiers** > **EDM classifiers**.

1. Make sure the **New EDM experience** toggle is set to **Off**.

   :::image type="content" source="../media/new-edm-toggle-off.png" alt-text="Screenshot showing the toggle to use the new EDM experience." lightbox="../media/new-edm-toggle-off.png":::  

1. Ensure the tab for **EDM schemas** is selected, then select **Create EDM schema** to open the schema tool configuration flyout.

1. In the **New EDM schema** flyout panel, fill in an appropriate **Name** and **Description**.

1. In the flyout panel, select **Ignore delimiters and punctuation for all schema fields** if you want to apply the **Ignore...** behavior for the entire schema.

1. In the flyout panel, fill in your desired values for your **Schema field #1**. Add more fields as needed. Each schema field must be identical to the column headers in your sensitive information source file.

1. In the flyout panel, if necessary, set the per-field values for the following:

    - **Field is searchable**
    - **Field is case-insensitive**
    - **Choose delimiters and punctuation to ignore for this field**
    - **Enter custom delimiters and punctuation for this field**

1. Select **Save** at the bottom of the flyout panel. Your schema is now listed and available for use.

   :::image type="content" source="../media/edm-classic-schema-configuration.png" alt-text="Screenshot showing the new schema configuration options for EDM classic." lightbox="../media/edm-classic-schema-configuration.png":::

1. Back on the EDM classifiers page, select the tab for **EDM sensitive info types**.

1. Select **+ Create EDM sensitive info type** to start the **EDM rule package** wizard.

1. On the **Define data store schema** page, **Choose an existing EDM schema** or select **New EDM schema** to create a new one.

1. Select **Next**.

1. On the **Define patterns for this EDM sensitive info type** page, select **Create pattern**.

1. A flyout panel appears to define your new pattern. Choose the default confidence level for the pattern. The values are **Low confidence**, **Medium confidence**, and **High confidence**.

1. In the flyout panel, select the **Primary element** for your EDM SIT. The options available for the primary element are based on fields you selected as searchable when you created your EDM schema.

1. In the flyout panel, select an appropriate sensitive info type for your primary element.

1. (Optional) In the flyout panel, add supporting elements if your data needs extra context to strengthen detection. The options available for the supporting element are based on the available fields that aren't your primary element.

1. In the flyout panel, choose the **Matching options for supporting elements**. If multiple supporting elements are specified, select whether all or any must match. For Match if any, set the minimum and maximum number of matches (pre-filled with 1 and the total number of elements).

1. Select **Done** in the flyout panel.

1. **Define patterns for this EDM sensitive info type**, then select **Next**.

1. Choose the **recommended confidence level and character proximity** for this EDM SIT, then select **Next**.

1. **Name and describe your EDM sensitive info type**, then select **Next**.

1. **Review and finish** creating your EDM SIT by selecting **Submit**.

Once you create your EDM schema, the next step is to hash and upload your sensitive data. This ensures the data can be used securely for classification. For detailed steps on hashing and uploading your source table, see [Hash and upload the sensitive information source table for exact data match sensitive information types](/purview/sit-get-started-exact-data-match-hash-upload?azure-portal=true)
