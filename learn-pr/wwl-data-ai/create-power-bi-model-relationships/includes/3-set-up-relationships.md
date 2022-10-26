A model relationship relates one column in a table to one column in a different table. (There's one specialized case where this requirement isn't true, and it applies only to multi-column relationships in DirectQuery models. This topic is described in the next unit.)

> [!NOTE]
> It's not possible to relate a column to a different column in the same table. This concept is sometimes confused with the ability to define a relational database foreign key constraint that’s table self-referencing. You can use this relational database concept to store parent-child relationships (for example, each employee record is related to a "reports to" employee). However, you can’t use model relationships to generate a model hierarchy based on this type of relationship. To create a parent-child hierarchy, see [Parent and Child functions](/dax/parent-and-child-functions-dax).

## Set relationship cardinality

Each model relationship is defined by a cardinality type. There are four cardinality type options, representing the data characteristics of the "from" and "to" related columns. The "one" side means the column contains unique values; the "many" side means the column can contain duplicate values.

> [!NOTE]
> If a data refresh operation attempts to load duplicate values into a "one" side column, the entire data refresh will fail.

The four options, together with their shorthand notations, are described in the following bulleted list:

- One-to-many (1:*)

- Many-to-one (*:1)

- One-to-one (1:1)

- Many-to-many (*:*)

When you create a relationship in Power BI Desktop, the designer automatically detects and sets the cardinality type. Power BI Desktop queries the model to know which columns contain unique values. For import models, it uses internal storage statistics; for DirectQuery models, it sends profiling queries to the data source.

Sometimes, however, Power BI Desktop can get it wrong. It can get it wrong when tables are yet to be loaded with data, or because columns that you expect to contain duplicate values currently contain unique values. In either case, you can update the cardinality type as long as any "one" side columns contain unique values (or the table is yet to be loaded with rows of data).

### One-to-many (and many-to-one) cardinality

The **one-to-many** and **many-to-one** cardinality options are the same, and they're also the most common cardinality types.

When configuring a one-to-many or many-to-one relationship, you'll choose the one that matches the order in which you related the columns. Consider how you would configure the relationship from the **Product** table to the **Sales** table by using the **ProductID** column found in each table. The cardinality type would be one-to-many, as the **ProductID** column in the **Product** table contains unique values. If you related the tables in the reverse direction, **Sales** to **Product**, then the cardinality would be many-to-one.

### One-to-one cardinality

A **one-to-one** relationship means both columns contain unique values. This cardinality type isn't common, and it likely represents a suboptimal model design because of the storage of redundant data. It’s often a better idea to use Power Query to consolidate the two tables into one.

For more information on using this cardinality type, see [One-to-one relationship guidance](/power-bi/guidance/relationships-one-to-one).

### Many-to-many cardinality

A **many-to-many** relationship means both columns can contain duplicate values. This cardinality type is infrequently used. It's typically useful when designing complex model requirements. You can use it to relate many-to-many facts or to relate higher grain facts. For example, when sales target facts are stored at product category level and the product dimension table is stored at product level.

For guidance on using this cardinality type, see [Many-to-many relationship guidance](/power-bi/guidance/relationships-many-to-many).

> [!TIP]
> In Power BI Desktop model view, you can interpret a relationship's cardinality type by looking at the indicators (1 or *) on either side of the relationship line. To determine which columns are related, you'll need to select, or hover the cursor over, the relationship line to highlight the related columns.  
>
> ![Depiction of two tables in the model diagram with the cardinality indicators highlighted.](../media/model-diagram-cardinality.png)

## Set cross filter direction

Each model relationship is defined with a cross filter direction. Your setting determines the direction(s) that filters will propagate. The possible cross filter options are dependent on the cardinality type.

| **Cardinality type**| **Cross filter options** |
| - | - |
| One-to-many (or many-to-one)| Single <br> Both |
| One-to-one| Both |
| Many-to-many| Single (Table1 to Table2) <br> Single (Table2 to Table1) <br> Both |


Single cross filter direction means "single direction", and Both means "both directions". A relationship that filters in both directions is commonly described as bi-directional.

For one-to-many relationships, the cross filter direction is always from the "one" side, and optionally from the "many" side (bi-directional). For one-to-one relationships, the cross filter direction is always from both tables. Lastly, for many-to-many relationships, cross filter direction can be from either one of the tables, or from both tables. Notice that when the cardinality type includes a "one" side, that filters will always propagate from that side.

When the cross filter direction is set to **Both**, an additional property becomes available. It can apply bi-directional filtering when Power BI enforces row-level security (RLS) rules. For more information about RLS, see the [Row-level security (RLS) with Power BI Desktop](/power-bi/create-reports/desktop-rls) article.

You can modify the relationship cross filter direction, including the disabling of filter propagation, by using a model calculation. It's achieved by using the [CROSSFILTER](/dax/crossfilter-function) DAX function, which is described in Unit 3.

Bear in mind that bi-directional relationships can impact negatively on performance. Further, attempting to configure a bi-directional relationship could result in ambiguous filter propagation paths. In this case, Power BI Desktop may fail to commit the relationship change and will alert you with an error message. Sometimes, however, Power BI Desktop may allow you to define ambiguous relationship paths between tables. Precedence rules that affect ambiguity detection and path resolution are described in Unit 4.

We recommend using bi-directional filtering only as needed. For more information, see [Bi-directional relationship guidance](/power-bi/guidance/relationships-bidirectional-filtering).

> [!TIP]
> In Power BI Desktop model view, you can interpret a relationship's cross filter direction by noticing the arrowhead(s) along the relationship line. A single arrowhead represents a single-direction filter in the direction of the arrowhead; a double arrowhead represents a bi-directional relationship.  
>  
> ![Screenshot of two tables in the model diagram with the cross filter arrowhead highlighted.](../media/model-diagram-cross-filter-direction.png)

## Set active vs inactive relationships

There can only be one active filter propagation path between two model tables. However, it's possible to introduce additional relationship paths, though you must set these relationships as inactive. Inactive relationships can only be made active during the evaluation of a model calculation. It’s achieved by using the [USERELATIONSHIP](/dax/userelationship-function-dax) DAX function, which is described in Unit 3.

Generally, we recommend defining active relationships whenever possible. They widen the scope and potential of how report authors can use your model. Using only active relationships means that role-playing dimension tables should be duplicated in your model.

In specific circumstances, however, you can define one or more inactive relationships for a role-playing dimension table. You can consider this design when:

- There's no requirement for report visuals to simultaneously filter by different roles.

- You use the `USERELATIONSHIP` DAX function to activate a specific relationship for relevant model calculations.

For more information, see [Active vs inactive relationship guidance](/power-bi/guidance/relationships-active-inactive).

> [!TIP]
> In Power BI Desktop model view, you can interpret a relationship's active vs inactive status. An active relationship is represented by a solid line; an inactive relationship is represented as a dashed line.  
>
> ![Screenshot of two tables in the model diagram and two relationships; one solid line for active and one dashed line for inactive.](../media/model-diagram-active-inactive-relationship.png)

## Set assume referential integrity

The **Assume referential integrity** property is available only for one-to-many and one-to-one relationships between two DirectQuery storage mode tables that belong to the same source group. You can only enable this property when the “many” side column doesn’t contain NULLs.

When enabled, native queries sent to the data source will join the two tables together by using an `INNER JOIN` rather than an `OUTER JOIN`. Generally, enabling this property improves query performance, though it does depend on the specifics of the data source.

Always enable this property when a single-column database foreign key constraint exists between the two tables. Even when a foreign key constraint doesn't exist, consider enabling the property as long as you're certain data integrity exists.

> [!IMPORTANT]
> If data integrity should become compromised, the inner join will eliminate unmatched rows between the tables. For example, consider a model **Sales** table with a **ProductID** column value that didn’t exist in the related **Product** table. Filter propagation from the **Product** table to the **Sales** table will eliminate sales rows for unknown products. This would result in an understatement of the sales results.

For more information, see [Assume referential integrity settings in Power BI Desktop](/power-bi/connect-data/desktop-assume-referential-integrity).