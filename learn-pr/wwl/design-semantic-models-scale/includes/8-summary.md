In this module, you explored what changes when semantic models need to handle larger datasets, more concurrent users, and broader consumption patterns in Microsoft Fabric. The challenge was clear: models built for small teams in Power BI Desktop don't automatically handle what comes with scale.

You learned to make four critical design decisions. First, you chose Direct Lake as the default storage mode and understood when Import, DirectQuery, or composite models are the better choice. Then you designed star schema relationships for clarity and performance, including referential integrity, inactive relationships, and cross-source connections. Next, you designed scalable calculations using calculation groups to reduce measure proliferation, variables and naming conventions to support team maintainability, and aggregations to handle large data volumes. Finally, you configured settings that control how the model handles large datasets, concurrent queries, and external tool access.

Together, these decisions prepare a semantic model for scale. They also prepare it for AI consumption, because AI demands the same things from a model that scale does: current data, clear relationships, descriptive structures, and capacity.

## Learn more

- [Direct Lake overview](/fabric/fundamentals/direct-lake-overview)
- [Create calculation groups in Power BI](/power-bi/transform-model/calculation-groups)
- [Large semantic model storage format](/fabric/enterprise/powerbi/service-premium-large-models)
