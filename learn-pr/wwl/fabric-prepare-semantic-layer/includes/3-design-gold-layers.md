The gold layer is the final, curated layer of your data that business users and AI tools consume. Whether you design this layer in a lakehouse or a data warehouse, the structure and naming conventions you choose directly affect how well Copilot and data agents interpret your data. In this unit, you learn design principles that apply to gold layer tables and the semantic models built on top of them.

## Design with entities in mind

AI tools work best when your tables represent clear business entities. A table called `Customers` with columns like `Customer Name`, `Email`, and `Region` maps directly to how a business user thinks and how an AI interprets a question about customers.

Follow these principles when designing your gold layer tables in your lakehouse or warehouse:

- **One entity per table.** Each table represents a single business concept: Customers, Products, Sales, Stores.
- **Star schema structure.** Dimension tables describe entities (who, what, where). Fact tables capture events (transactions, orders, shipments). Star schemas map naturally to how AI tools navigate relationships.
- **Business-friendly table names.** Use `Sales Transactions` instead of `fact_sales_v2` or `dbo_FactSales`. AI tools use table names to determine which entity a user is asking about.

These principles apply whether you build your gold layer in a Fabric lakehouse using Delta tables, in a Fabric warehouse using SQL tables, or in any other structured storage. The semantic model you build on top of these tables inherits the structure and naming you establish here.

When your tables represent clear entities with well-defined relationships, AI tools can traverse your model to answer multistep questions. For example, Copilot can follow a relationship from `Sales` to `Products` to `Categories` to answer "What was the top product category by revenue?"

## Name for clarity

Copilot uses table names, column names, and measure names as primary signals when interpreting user prompts. Clear, consistent names reduce misinterpretation when using Copilot to analyze data.

**Column naming best practices:**

- Use full words: `Customer Name` instead of `CustNm` or `cust_name`.
- Be specific: `Order Date` instead of `Date` when multiple date columns exist.
- Include units when relevant: `Revenue (USD)` or `Weight (kg)`.
- Avoid prefixes like `dim_` or `fact_` that are meaningful to developers but not to business users or AI tools.
- Be consistent: if one table uses `Product Name`, don't use `ProductTitle` in another table.

**Measure naming best practices:**

- Describe the calculation: `Total Sales` is clear. `TS` is not.
- Include scope when helpful: `YTD Revenue` or `Sales (last 12 months)`.
- Avoid using the same name for measures and columns. Duplicate names across tables confuse both users and AI.

> [!TIP]
> When similar fields exist across tables (for example, `Name` in both `Customer` and `Store` tables), add concise descriptions to distinguish them. Copilot uses descriptions to disambiguate fields with similar names.

## Document for AI consumption

Descriptions are the primary way you provide business context to AI tools. Write descriptions as if you're explaining the field to a new team member who doesn't know your data.

**Table descriptions** should explain what the table represents and what kind of records it contains. For example: "Contains one row per completed sales transaction, including the product sold, the store location, and the transaction amount in USD." You can add descriptions in your lakehouse or warehouse using extended properties or metadata tables, or in the semantic model itself.

**Column descriptions** should clarify what values the column holds and any business rules. For example: "The unique identifier for each customer account. Assigned at account creation and doesn't change."

**Measure descriptions** (in the semantic model) should explain the business logic, including what's included and excluded. For example: "Sum of all completed transaction amounts in USD. Excludes returns, refunds, and canceled orders. Uses the transaction date for time filtering."

You can use Copilot in Power BI Desktop to generate measure descriptions automatically. Then you can review and revise the generated descriptions to verify accuracy and maintain consistency across your model.

> [!IMPORTANT]
> Descriptions are truncated after the first 200 characters when used as grounding data in the DAX query view experience. Keep the most important business context at the beginning of each description.

## Simplify for AI consumption

Not everything in your model should be visible to AI tools. Technical columns, internal IDs, and ETL artifacts add noise to the grounding surface and increase the chance of misinterpretation.

**Hide these from AI:**

- Surrogate key columns (like `ProductKey` or `CustomerID`) when a natural key or name column exists.
- ETL metadata columns (like `LoadDate`, `BatchID`, or `SourceSystem`).
- Deprecated or unused columns that remain in the model for backward compatibility.

**Keep visible:**

- Business-facing columns that users reference in questions.
- Measures that represent key business metrics.
- Date table columns used for time intelligence.

Hiding a field in the semantic model removes it from Copilot's consideration entirely. Hidden fields reduce the number of schema elements Copilot processes during the grounding step.

## Set up linguistic modeling in Power BI

Linguistic modeling is a Power BI feature that enhances how Copilot and Q&A interpret natural language queries against your semantic model. You configure linguistic modeling through the Q&A setup in Power BI Desktop.

Linguistic modeling includes two components:

- **Synonyms** map alternate terms to field names. If your measure is called `Revenue`, you can add synonyms like `Sales`, `Turnover`, and `Income`. When a user asks about "sales" and your model has a measure called "Revenue," Copilot uses the synonym mapping to identify the correct field.
- **Linguistic relationships** define verbs that connect entities in natural language queries. For example, you can specify that "Customers **buy** Products" or "Stores **are located in** Regions." These relationships help Copilot understand how to traverse your model based on the way users phrase questions.

You configure linguistic modeling in the **Modeling** ribbon under **Q&A Setup**. Copilot can suggest synonyms automatically. Review these suggestions and add domain-specific terms your users actually use.

> [!NOTE]
> Linguistic modeling applies to semantic models in Power BI. Q&A must be enabled on your semantic model for linguistic modeling to take effect. Enable it under **File** > **Options and settings** > **Options** > **Data Load** > **Turn on Q&A**.

Linguistic modeling requires ongoing maintenance. As your model evolves and business terminology changes, update synonyms and relationships to keep them current.
