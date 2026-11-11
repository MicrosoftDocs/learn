::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=c0a3b59e-7b3b-4f4d-9ca6-211763eb781d]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In this module, you learned two approaches for creating ontologies in Fabric IQ: building manually to understand core concepts, or generating from a Power BI semantic model to automate initial structure. Both approaches produce entity types, properties, and relationship types that define your business vocabulary. You review keys where needed, and generated metrics retain calculations from the source semantic model.

You connected ontology definitions to actual data by configuring bindings to lakehouse records and timestamped eventhouse observations. These bindings map business concepts to sources without copying data into the ontology. Consuming experiences use that context to query the relevant sources.

You can explore eligible connected data through an optional materialized graph. Unlike a source binding, [graph materialization](/fabric/iq/ontology/how-to-use-ontology-graph) loads selected data into a graph and requires you to consider source support and refresh.

::: zone-end
