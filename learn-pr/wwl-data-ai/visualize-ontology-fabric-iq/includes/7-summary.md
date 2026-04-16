In this module, you explored the Lamna Healthcare ontology, discovering how bound data appears as entity instances and how those instances connect through the relationship graph.

You opened the entity type overview to see how your lakehouse and eventhouse data populates entity types. The entity instances table showed individual records—specific departments, rooms, and patients drawn from your bound sources. Selecting an instance revealed its property values and a scoped relationship graph showing that record's connections to other entity types.

You expanded the relationship graph to visualize how entity instances connect across your domain. Loading the default visualization populated the graph with real nodes and edges: departments connected to rooms, rooms to patients, patients to monitoring equipment. Selecting a node surfaced its property values. The graph showed actual connections between real records—business concepts linked the way your organization understands them.

You used the Query builder to filter and explore your data. Adding a filter on `RoomType` narrowed results to Critical Care rooms. The Components pane controlled which entity types and relationship types appeared as nodes and edges, keeping results focused. The results appeared in Diagram, Card, or Table view—three ways to interpret the same data depending on your question.

With visualization and exploration in place, you've completed the core workflow: define business vocabulary, bind it to data, and explore the connected semantic layer to answer questions without writing joins or navigating raw schemas.
