Your Lamna Healthcare ontology binds Hospital, Department, Room, Patient, and VitalSignEquipment data from both a lakehouse and an eventhouse. Querying across those sources traditionally means knowing which table is in which source, which IDs join them, and how to write the query. The Query builder removes that requirement. Because your entity type bindings and relationship configurations describe how everything connects, you query using business concepts—and the ontology handles the cross-source federation.

## Understand cross-source querying

When you run a query that includes both Patient and VitalSignEquipment instances, the ontology translates that into separate queries against the lakehouse (for patient data) and the eventhouse (for equipment readings). The relationship binding—VitalSignEquipment monitors Patient—defines how those results connect. The graph returns the joined view without you writing a single JOIN statement.

This federation is what makes the Query builder powerful. You don't need to know that vital sign equipment assignments exist in the vitalsignequipment table or that PatientId is the linking key. The bindings you configured carry that knowledge. You express what you want in business terms, and the semantic layer does the rest.

## Use the Query builder controls

In the full graph view, the **Query builder** ribbon provides the controls for building and running queries.

:::image type="content" source="../media/query-builder-ribbon.png" alt-text="Screenshot of the Query builder ribbon showing Add filter, Components pane toggle, and Run query buttons.":::

The three controls you use most are:

- **Add filter** — Narrow results by property value.
- **Components** — Show or hide specific entity types and relationship types in the graph and results.
- **Run query** — Execute the current query and display results.

These controls work together. Filters narrow which instances appear. Components control which entity types and relationships are visible. Running the query executes the combined specification.

## Add filters

Select **Add filter** to narrow results based on a property value. For example, to find rooms in the Cardiology department, add a filter on the Department entity type where `DepartmentName` equals "Cardiology."

:::image type="content" source="../media/query-filter.png" alt-text="Screenshot of the Add filter dialog showing a filter on the Department entity type with DepartmentName set to Cardiology.":::

Filters support equality on string properties and comparison operators on numeric properties. Adding `Floor > 1` to the Room entity type returns only rooms above the ground floor. Multiple filters apply together—results must satisfy all active conditions simultaneously.

To narrow results to ICU rooms in Cardiology, add a Department filter for `DepartmentName = Cardiology` and a Room filter for `RoomType = ICU`. The query returns only the instances that match both conditions.

## Control components

The **Components** pane lists every entity type and relationship type in the current query as checkboxes. Checking or unchecking an entry controls whether it appears as a node or edge in the graph and results.

:::image type="content" source="../media/components-pane.png" alt-text="Screenshot of the Components pane showing Nodes and Edges categories with checkboxes for each entity type and relationship type.":::

When you open the graph from the Department entity type, components default to showing Department nodes and all directly connected entity types and edges. To answer "Which patients are assigned to rooms in Cardiology?", you only need three node types and two edge types:

- **Nodes**: Department, Room, Patient
- **Edges**: Department has Room, Room has Patient

Uncheck Hospital, VitalSignEquipment, and their associated edges. This focuses the query and keeps the results graph readable.

## Run the query and view results

After setting filters and components, select **Run query**. Results appear below the graph. You have three view options.

**Diagram view** shows the graph structure with nodes and edges. Nodes represent entity instances; edges represent relationship instances. Select a node to inspect its property values. Hover to highlight connected nodes. Drag to reposition nodes for clarity.

**Card view** displays each instance as a card with its property values listed side by side. Useful when you want to scan specific attributes—like current RoomType or PatientName—across many instances without focusing on relationships.

**Table view** shows results in rows and columns. One row per instance, one column per property. Table view works well for comparing values across many results or exporting data for further review.

:::image type="content" source="../media/query-results-views.png" alt-text="Screenshot showing the Diagram, Card, and Table view tabs above the query results pane.":::

Switch between views using the tabs above the results pane. The underlying query doesn't change—only how results are displayed.

## Refine and clear queries

Select **Clear query** to reset results and remove all active filters. Use **Remove filter** to remove a specific condition without clearing everything else. This iterative approach works well when building a complex query: start with one filter, run to confirm the right entity types are returning, then add a second filter to narrow further.

With the Query builder, every business question in your Lamna Healthcare scenario maps to a combination of filters and components. Which patients are in Cardiology? Which vital sign monitors are active in the ICU? Which departments are on the second floor? Each answer is a query run from the same graph view, against the same ontology—no table knowledge required.
