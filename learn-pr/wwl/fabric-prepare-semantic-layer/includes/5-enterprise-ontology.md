Your semantic model now gives Copilot clear answers for your team's reports. But other teams in your organization might ask the same questions about `Customer`, `Product`, or `Sales` using their own semantic models. If each team defines these terms differently, AI experiences across the organization return inconsistent answers. Fabric IQ lets you create an ontology that standardizes these definitions so every team and every AI experience uses the same business meaning.

## Why an ontology expands the value of your data

An ontology is a shared set of business term definitions — what each entity means, how entities relate to each other, and what properties describe them. Without an ontology, each semantic model defines its own version of `Customer`. The sales team might include resellers, while the service team means only direct buyers. When a data agent queries both models, it can't tell which definition to use. An ontology solves this by declaring one agreed definition that all semantic models align to. Your semantic model still holds its own measures, filters, and calculated columns — the ontology just makes sure the shared terms mean the same thing everywhere.

## When to create an ontology

You create an ontology when an entity meets two conditions: its definition is stable, and other teams need it. A reporting detail like a date filter or a calculated column only makes sense inside your reports — it stays in the semantic model. An entity like `Customer` that multiple teams reference belongs in the ontology.

:::image type="content" source="../media/ontology-boundary.png" alt-text="Diagram showing an ontology with agreed definitions connected to three team semantic models below.":::

Not every entity is ready. If your team is still changing what `Customer` means or who owns the definition, it's too early. **Publish only entities with stable definitions and clear owners.**

## How ontology generation works

Fabric IQ can generate an ontology from your semantic model. It creates entity types from tables, properties from columns, and relationship types from relationships. This gives you a starting point. You still need to review names, keys, and relationship direction before other teams rely on it.

One limit to know: if you want the ontology to answer questions directly from bound data, the semantic model needs Direct Lake mode with inbound public access enabled on the backing lakehouse workspace. Import and DirectQuery modes support definitions but not data bindings.

The semantic model design, Prep for AI controls, and ontology decisions are set. Next, you need to test whether these choices produce the right answers before you approve the semantic model.

> [!TIP]
> Which entity in your organization's semantic model has a definition stable enough for other teams to use? Which detail only makes sense inside your reports?
