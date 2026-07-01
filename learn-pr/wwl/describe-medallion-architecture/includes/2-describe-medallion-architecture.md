Source systems (transactions, CRM exports, logs) organize data for operational efficiency, not analytics. The **medallion architecture** gives you a structured way to reshape that data progressively, preserving the original as a source of truth while preparing it layer by layer for reporting and analysis.

The architecture consists of three layers (bronze, silver, and gold), each serving a different audience. Bronze is the raw landing zone for data engineers. Silver is a clean, integrated dataset for analysts and data scientists. Gold is a dimensional model for business users. That separation is what makes the pattern powerful: each team gets what they need without anyone overwriting what others depend on.

:::image type="content" source="../media/lakehouse-medallion.png" alt-text="Diagram of a medallion architecture where data flows from the source to the bronze, silver, and gold layers." lightbox="../media/lakehouse-medallion.png":::

## The three layers

### Bronze layer

The bronze layer is the landing zone for all data, whether it's structured, semi-structured, or unstructured. The bronze layer stores data in its original format, without modification. Keeping data raw here is intentional. If a downstream transformation goes wrong, you can always reprocess from bronze rather than going back to the source system.

### Silver layer

The silver layer is where you validate and refine your data. Typical activities include combining and merging data from multiple sources and enforcing data quality rules like removing nulls and deduplicating. The result is a consistent, integrated dataset that analysts and data scientists can use directly, and that feeds the gold layer.

### Gold layer

The gold layer is where you model data for business use, typically as a **star schema** with facts and dimensions. Once data reaches the gold layer, it's ready for downstream consumers: analysts running reports, data scientists building models, and business users exploring dashboards.

## Adapt the architecture to your needs

The three-layer pattern is a starting point, not a strict rule. Depending on your use case, you might add a landing zone before bronze for data arriving in a specific format, or a domain-specific layer beyond gold for a particular team's needs. The names and number of layers are flexible. What matters is that each layer has a clear purpose and a clear audience.

In the next unit, you plan how to implement this in Fabric: how to structure your lakehouse, which tools move and transform data through each layer, and how to serve the gold layer to consumers.