A Fabric app stores its data in a database that the platform creates from TypeScript code. The data model you write is the source of truth: the tables, the GraphQL API, and the typed client all come from the same classes. A mistake in the model doesn't stay in the model. It surfaces as a failed deployment or a dropped column.

You build a shared tool for store staff at Adventure Works Cycles to report product-quality issues. You model issues and stores as related entities, deploy the schema, and seed a few records. A few weeks later, requirements change. You add a field safely, and then a request to rename a column forces a decision about data loss.

:::image type="content" source="../media/store-quality-issue-diagram.png" alt-text="Diagram of one store related to many product-quality issues, with schema changes that preserve data or risk data loss.":::

In this module, you explore how decorators describe tables and columns, and how platform constraints shape a design before you write any code. You learn how to relate entities, register them, and apply schema changes. Short hands-on exercises in your own Fabric workspace follow each idea: you define entities, relate them, evolve the schema, and see how the CLI protects existing data. You build on the same app throughout, so each exercise starts from the previous result.

By the end of this module, you're able to design an app's data model with TypeScript decorators and apply schema changes without losing data.
