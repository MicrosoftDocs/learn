Exact data match (EDM) allows you to create a sensitive information type (SIT) that uses exact data values for identifying and protecting sensitive information. With EDM, you can ensure your SIT:

- **Is easily updated**: Quickly adapt to changes in your sensitive data.
- **Reduces false positives**: Accurately identify the correct information, minimizing mistakes.
- **Fits structured data**: Works well with organized data sets.
- **Ensures privacy**: Keeps sensitive data secure and private, even from Microsoft.
- **Integrates across services**: Functions with a range of Microsoft cloud services for better data governance.

For example, if you have customer account numbers, EDM specifically flags those numbers only, which significantly lessens the risk of incorrect flags.

 :::image type="content" source="../media/exact-data-match-classification.png" alt-text="Diagram showing how exact data match based classification works." lightbox="../media/exact-data-match-classification.png":::  

EDM-based classification enables you to create custom sensitive types that match exact values from a database, which can hold up to 100 million rows of data. This database can be refreshed daily to reflect changes such as new or departing employees, patients, or clients, ensuring your custom sensitive information types remain current and relevant. You can also apply these classifications to policies for enhanced data protection. Examples include [Microsoft Purview Data Loss Prevention policies](/purview/dlp-learn-about-dlp?azure-portal=true) or [Microsoft Cloud App Security file policies](/defender-cloud-apps/data-protection-policies?azure-portal=true).

## What's different in an EDM SIT

When you work with EDM SITs, it's helpful to understand a few concepts that are unique to them.  

### Schema

The schema is a blueprint in an XML file format. It defines:

- The name of the schema, later referred to as the _DataStore_.
- The field names that your sensitive information source table contains. Each schema field corresponds directly to a column in your table.
- Which fields are searchable.
- A _configurable match_, which is an adjustable parameter for refining your search, like ignoring case sensitivity or punctuation in the data you're searching for.

### Sensitive information source table

The sensitive information source table contains the values that the EDM SIT looks for. It contains:

- Column headers represent the field names.
- Rows correspond to individual records.
- Each cell holds the specific value for its record and field.

Here's a simple example of a sensitive information source table:

|First name|Last name|Date of birth|
|---|---|---|
|Isaiah|Langer| 05-05-1960|
|Ana|Bowman|11-24-1971|
|Oscar|Ward|02-12-1998|

### Rule package

Every SIT has a rule package. You use the rule package in an EDM SIT to define:

- **Matches** specify the field used as the primary element for exact lookups. It can be a regular expression with or without a checksum validation, a keyword list, a keyword dictionary, or a function.
- **Classification** determines the specific sensitive information type match criteria that triggers a search using EDM.
- **Supporting elements** are extra pieces of data that, when found near the primary data, increase the likelihood that a match is correct. For instance, finding the keyword "SSN" in close proximity to an actual social security number. A supporting element can be a regular expression with or without a checksum validation, keyword list, or a keyword dictionary
- **Confidence Levels** indicate the degree of certainty in a match, ranging from high to low, based on the amount of supporting evidence found with the primary element.
- **Proximity** refers to the distance, in characters, between the primary and supporting elements.

### You supply your own schema and data

[Microsoft Purview comes with many predefined SITs](/purview/sensitive-information-type-entity-definitions?azure-portal=true). These SITs come with schemas, regex patterns, keywords and confidence levels. But, with EDM SITs, you're responsible for defining the schema and both the primary and secondary fields that identify sensitive items. Because the schema and primary and secondary data values are highly sensitive, you encrypt them via a [hash](/dotnet/standard/security/ensuring-data-integrity-with-hash-codes?azure-portal=true) function that includes a randomly generated or self-supplied [salt](https://en.wikipedia.org/wiki/Salt_(cryptography)?azure-portal=true) value. Only the hashed values are uploaded to the service, so your sensitive data is never in the open.

### Primary and secondary support elements

In an EDM SIT, a _primary element_ is the specific information you're looking to identify and protect, such as a credit card number or a social security number. EDM requires that the primary element are discoverable through an existing SIT. This process means before you set up your EDM SIT, you need to match your primary element to one of the predefined SITs that the system can already identify.

For example, if your EDM SIT schema has U.S. _social security number_ as the primary element, you need to associate it with the [U.S. social security number (SSN)](/purview/sit-defn-us-social-security-number?azure-portal=true) SIT. This requirement is important because primary elements need to be in a specific format in order to be detected.

Once the primary element is found in a scanned item, EDM looks for a _secondary_ or supporting element. Secondary elements reinforce the identification of the primary element as sensitive. Secondary elements don't need to follow a fixed pattern unless they contain multiple tokens. If it contains multiple tokens, this condition requires association with a SIT, similar to a primary element. Secondary elements must be within a certain proximity to the primary element.

## How matching works

EDM works by comparing strings in your documents and emails against values in the sensitive information source table. It checks if the values in the scanned content are present in the table. The comparison is done by comparing one-way cryptographic hashes.

For a more effective detection system, you can use EDM in combination with the standard SITs provided by the system. Set up the EDM with high confidence levels, meaning it alerts you when it finds a precise match with the sensitive data you specified. At the same time, you can use a standard SIT, like the one for U.S. Social Security Numbers, with a lower confidence level. This way, you're covered both for exact matches and for times when there's just a hint of something sensitive, catching more potential risks.

For a list of services that EDM supports, see [Services that EDM supports](/purview/sit-learn-about-exact-data-match-based-sits?azure-portal=true#services-that-edm-supports).

## Create an EDM-based SIT

Creating and making an exact data match (EDM) based sensitive information type (SIT) available is a multi-phase process. You can use the _new experience_, the existing _classic experience_, or via PowerShell.

### The new EDM experience

The new EDM experience combines the functionality of the EDM schema and EDM sensitive info types wizards into a single user experience. The new experience adds:

- **Simplified workflow**: The creation of schemas and SITs is now a unified process, reducing steps and providing clear directions for mapping data elements to the system’s predefined SITs. This integrated approach also automatically sets the appropriate confidence levels for the detection rules, making the setup faster and more user-friendly.
- **Automated schema and SIT creation**: By uploading a non-sensitive sample data file, the system can auto-generate a schema, then suggest the best SITs to link with your primary data fields. This automation eliminates the need to manually input schema details and helps ensure that the SITs are correctly matched, leading to more accurate data protection.
- **Additional guardrails to ensure better performance**: The new system alerts you when a primary field is connected to a SIT that's too broad. This measure helps avoid potentially irrelevant matches that could slow down the process. These proactive notifications are designed to help maintain optimal system performance by steering you away from configurations that might lead to inefficiencies or errors in data matching.

### The new EDM experience workflow at a glance

|Phase|Requirements|
|---|---|
|[Phase 1: Export source data for exact data match based sensitive information type](/purview/sit-get-started-exact-data-match-export-data?azure-portal=true#export-source-data-for-exact-data-match-based-sensitive-information-type)|- Read access to the sensitive data|
|[Phase 2:Create the sample file](/purview/sit-create-edm-sit-unified-ux-sample-file?azure-portal=true)|- Know the column headers and the format of the data you're looking for in each column.
|[Phase 3: Create the EDM SIT](/purview/sit-create-edm-sit-unified-ux-schema-rule-package?azure-portal=true)|- Access to **Microsoft Purview Compliance portal** > **Data classification** > **Exact data match** |
|[Phase 4: Hash and upload the sensitive information source table for exact data match sensitive information types](/purview/sit-get-started-exact-data-match-hash-upload?azure-portal=true)|- Custom security group and user account </br>- **Hash and upload from one computer**: local admin access to a computer with direct internet access and to host the EDM Upload Agent </br>- **Hash and upload from separate computers**: local admin access to a computer with direct internet access and host the EDM Upload Agent for the upload and local admin access to a secure computer to host the EDM Upload Agent to hash the sensitive information source table </br>- Read access to the sensitive information source table file|
|[Phase 5: Test an exact data match sensitive information type](/purview/sit-get-started-exact-data-match-test?azure-portal=true#test-an-exact-data-match-sensitive-information-type)| - Access to the Microsoft Purview compliance portal

### The classic EDM experience

You can toggle back and forth between the new and classic experiences, but we recommend using the new experience unless your needs fall into one or more of these four use cases:

1. **Multiple SITs per schema**: The classic experience allows for multiple SITs to be mapped to a single schema, which isn't possible in the new experience.
1. **Managing more than 10 SITs**: If you need to create or manage more than 10 SITs, you need to use the classic experience. Because you can map multiple EDM SITs to the same schema, you can have more than 10 EDM SITs. Attempting to create an eleventh schema with the new experience generates an error.
1. **Custom schema names**: The classic experience lets you specify custom names for your EDM schemas, unlike the new experience that auto-generates schema names.
1. **Editing existing schemas**: If you need to edit schemas created in the classic experience or uploaded via PowerShell, you must use the classic experience, as the new experience doesn't support this functionality.

### The classic EDM experience workflow at a glance

 :::image type="content" source="../media/swimlane-exact-data-match-process.png" alt-text="Diagram showing the process of creating an exact data match sensitive information type with the classic experience." lightbox="../media/swimlane-exact-data-match-process.png":::  

|Phase|Requirements|
|---|---|
|[Phase 1: Export source data for exact data match based sensitive information type](/purview/sit-get-started-exact-data-match-export-data?azure-portal=true#export-source-data-for-exact-data-match-based-sensitive-information-type)|- Read access to the sensitive data|
|[Phase 2: Create the schema for exact data match based sensitive information types](/purview/sit-get-started-exact-data-match-create-schema?azure-portal=true#create-the-schema-for-exact-data-match-based-sensitive-information-types)|- Access to the sensitive information type wizard in the compliance portal </br>- access to the [Microsoft 365 admin center via Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell) |
|[Phase 3: Hash and upload the sensitive information source table for exact data match sensitive information types](/purview/sit-get-started-exact-data-match-hash-upload?azure-portal=true#hash-and-upload-the-sensitive-information-source-table-for-exact-data-match-sensitive-information-types)|- Custom security group and user account </br>- **Hash and upload from one computer**: local admin access to a computer with direct internet access and to host the EDM Upload Agent </br>- **Hash and upload from separate computers**: local admin access to a computer with direct internet access and host the EDM Upload Agent for the upload and local admin access to a secure computer to host the EDM Upload Agent to hash the sensitive information source table </br>- Read access to the sensitive information source table file </br> the schema file |
|[Phase 4: Create exact data match sensitive information type/rule package](/purview/sit-get-started-exact-data-match-create-rule-package?azure-portal=true#create-exact-data-match-sensitive-information-typerule-package) |- Access to the Microsoft Purview compliance portal |
|[Test an exact data match sensitive information type](/purview/sit-get-started-exact-data-match-test?azure-portal=true#test-an-exact-data-match-sensitive-information-type)| - Access to the Microsoft Purview compliance portal

## Identify data using exact data match-based classification interactive guide

In this interactive guide, you see how Information Protection can help you categorize content with exact data match (EDM) classifiers and label sensitive items to protect your organization's data.

[:::image type="content" source="../media/exact-data-match-interactive-guide.png" alt-text="Illustration of the cover of an interactive guide that says Identify data using exact data match-based classification interactive guide." border="false":::](https://mslearn.cloudguides.com/guides/Identify%20data%20using%20exact%20data%20match-based%20classification%20in%20Microsoft%20Purview%20Information%20Protection)

## Learn more

- [Learn about exact data match based sensitive information types](/purview/sit-learn-about-exact-data-match-based-sits?azure-portal=true)
- [Get started with exact data match based sensitive information types](/purview/sit-get-started-exact-data-match-based-sits-overview?azure-portal=true)
- [Create exact data match sensitive information type workflow new experience](/purview/sit-create-edm-sit-unified-ux-workflow?azure-portal=true)
- [Create exact data match sensitive information type workflow classic experience](/purview/sit-create-edm-sit-classic-ux-workflow?azure-portal=true)
