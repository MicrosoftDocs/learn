In this module, you explored the Lamna Healthcare ontology you built in the previous module, discovering how bound data appears as entity instances and how those instances connect through the relationship graph.

You opened the entity type overview to see how your lakehouse and eventhouse data populates entity types. The entity instances table showed individual records—specific departments, rooms, and patients drawn from your bound sources. Selecting an instance revealed its property values and a scoped relationship graph showing that record's connections to other entity types.

You expanded the relationship graph to visualize how entity instances connect across your domain. Running the default query populated the graph with real nodes and edges: departments connected to rooms, rooms to patients, patients to monitoring equipment. Selecting a node surfaced its property values. The graph showed actual connections between real records—business concepts linked the way your organization understands them.

You used the Query builder to run targeted queries. Adding a filter on `DepartmentName` narrowed results to a specific department. The Components pane controlled which entity types and relationship types appeared as nodes and edges, keeping results focused. Running the query returned results in Diagram, Card, or Table view—three ways to interpret the same data depending on your question.

Finally, you learned how to keep the graph model current. Schema changes to the ontology trigger automatic re-ingestion. Data changes in your upstream lakehouse and eventhouse sources require a manual refresh or a configured recurring schedule. Understanding when each applies helps you maintain accurate, timely results for the teams relying on your ontology for operational decisions.

With visualization and querying in place, you've completed the core workflow: define business vocabulary, bind it to data, and explore the connected semantic layer to answer questions without writing joins or navigating raw schemas.
