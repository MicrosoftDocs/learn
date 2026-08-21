You know what Copilot reads and why the semantic model is the right place to fix ambiguity. Now you need to apply that to the design. Consider a question like "sales by city" — Copilot needs to find the right sales measure, follow the relationship to the right customer table, and pick the right city field. If any of those steps are unclear, Copilot can follow the wrong path. **You need to design a gold layer that gives Copilot one clear path from the question to the right data**.

## Clearly define business entities

Start with clear business entities across your fact and dimension tables. Tables like `Customer`, `Product`, and `Date` describe who buys an item, what they buy, and when they buy it. A `Sales` table records each sale. The relationship between `Sales` and `Customer` lets Copilot group the trusted sales measure by `Customer City`.

Table names also need to use business terms. `dim_customer_v2` describes how you build the table. `Customer` describes what the table means. **Clear names help Copilot follow the business path for the question**.

## Tell similar concepts apart

Names help Copilot find possible fields. Descriptions help Copilot choose the right field. If the semantic model contains `Customer City` and `Store City`, describe whose location each field represents. This difference tells Copilot to use `Customer City` when someone asks about customer locations.

- A table description answers what business entity or event each row represents.
- A column description answers what the value means and which unit or scope applies.
- A measure description answers which calculation and business rules produce the result.

Copilot in DAX query view reads only the first 200 characters of a semantic model description. Put the key difference first so Copilot **reads the context it needs to choose correctly**.

## Show business terms and hide technical fields

Visible fields define what Copilot can consider. For "sales by city," keep the trusted sales measure and `Customer City` visible. Hide `CustomerKey`, load metadata, and old fields because they don't help Copilot answer the question.

Users might say "revenue" when the semantic model uses `Total Sales`. Add "revenue" as a synonym for that clear measure. **Use synonyms for different words, not unclear design**.

Repeat "sales by city" to test the design. A correct answer shows that Copilot selects the trusted sales measure, follows the `Customer` relationship, and groups by `Customer City`. The gold layer now provides a clear business path. Next, you need to check whether Copilot needs guidance that the semantic model can't provide.

:::image type="content" source="../media/gold-layer-star-schema.png" alt-text="Diagram that shows the gold layer path from a sales by city question to the correct measure and field.":::

> [!TIP]
> Trace one question through your semantic model. Which measure, entity, relationship, and attribute should Copilot use, and which visible object could divert it?
