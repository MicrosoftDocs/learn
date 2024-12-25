Microsoft Sentinel ingests data from many sources. Working with various data types and tables together requires you to understand each of them, and write and use unique sets of data for analytics rules, workbooks, and hunting queries for each type or schema.

Sometimes, you'll need separate rules, workbooks, and queries, even when data types share common elements, such as firewall devices. Correlating between different types of data during an investigation and hunting can also be challenging.

The Advanced Security Information Model (ASIM) is a layer that is located between these diverse sources and the user. ASIM follows the robustness principle: "Be strict in what you send, be flexible in what you accept". When the robustness principle is used as a design pattern, ASIM transforms Microsoft Sentinel's inconsistent, and hard to use source telemetry to user friendly data.

## Common ASIM usage

ASIM provides a seamless experience for handling various sources in uniform, normalized views, by providing the following functionality:

- **Cross source detection**. Normalized analytics rules work across sources, on-premises and cloud, and detect attacks such as brute force or impossible travel across systems, including Okta, AWS, and Azure.

- **Source agnostic content**. The coverage of both built-in and custom content using ASIM automatically expands to any source that supports ASIM, even if the source was added after the content was created. For example, process event analytics support any source that a customer may use to bring in the data, such as Microsoft Defender for Endpoint, Windows Events, and Sysmon.

- **Support for your custom sources**, in built-in analytics

- **Ease of use**. After an analyst learns ASIM, writing queries is simpler as the field names are always the same.

## ASIM and the Open Source Security Events Metadata

ASIM aligns with the Open Source Security Events Metadata (OSSEM) common information model, allowing for predictable entities correlation across normalized tables.

OSSEM is a community-led project that focuses primarily on the documentation and standardization of security event logs from diverse data sources and operating systems. The project also provides a Common Information Model (CIM) that can be used for data engineers during data normalization procedures to allow security analysts to query and analyze data across diverse data sources.

## ASIM components

The following image shows how non-normalized data can be translated into normalized content and used in Microsoft Sentinel. For example, you can start with a custom, product-specific, non-normalized table, and use a parser and a normalization schema to convert that table to normalized data. Use your normalized data in both Microsoft and custom analytics, rules, workbooks, queries, and more.

:::image type="content" source="../media/asim-architecture.png" alt-text="Diagram of the A S I M Architecture Components.":::

ASIM includes the following components:

| Component  | Description | 
| :--- | :--- | 
| Normalized schemas | Cover standard sets of predictable event types that you can use when building unified capabilities. Each schema defines the fields that represent an event, a normalized column naming convention, and a standard format for the field values. |
| Parsers | Map existing data to the normalized schemas using KQL functions. Many ASIM parsers are available out of the box with Microsoft Sentinel. More parsers, and versions of the built-in parsers that can be modified can be deployed from the Microsoft Sentinel GitHub repository.|
| Content for each normalized schema| Includes analytics rules, workbooks, hunting queries, and more. Content for each normalized schema works on any normalized data without the need to create source-specific content.|
|||

## ASIM terminology

ASIM uses the following terms:

| Term  | Description |
| :--- | :--- |
| Reporting device| The system that sends the records to Microsoft Sentinel. This system may not be the subject system for the record that's being sent.|
| Record| A unit of data sent from the reporting device. A record is often referred to as log, event, or alert, but can also be other types of data.|
| Content, or Content Item| The different, customizable, or user-created artifacts than can be used with Microsoft Sentinel. Those artifacts include, for example, Analytics rules, Hunting queries and workbooks. A content item is one such artifact.|

## View ASIM Parsers

To view ASIM functions in your Microsoft Sentinel environment.

- Navigate to your Microsoft Sentinel workspace in the Azure portal
- Select Logs from the left navigation
- Expand the schema and filter pane on the left side (if needed use the ellipsis to reveal all the tools)
- Select Functions
- Expand Microsoft Sentinel

You'll see functions starting with **_ASim_** and **_Im_**.
