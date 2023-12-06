---
ms.custom:
  - build-2023
---
When a query is compiled, values for any parameters used in queries in a stored procedure or parameterized query are used to make decisions to build an execution plan. This concept is commonly known as parameter sniffing. Only one query plan can exist in cache for statements in a stored procedure or parameterized query. In most cases, this doesn't result in any performance problems for applications. However, there are situations where the data retrieved for queries based on parameters can be skewed, or not evenly distributed. In these cases, the single cache plan may not be optimal for different parameter values. This problem is known as a parameter sensitive plan (PSP).

In SQL Server 2022, the optimizer can detect parameter sensitive plan scenarios and cache multiple plans for the same stored procedure or parameterized query. The optimizer uses a concept called query variants to aggregate sets of parameter values to match a query plan best suited for those parameter values.

## Parameter Sensitive Plan optimization implementation

During the initial compilation, column statistics histograms identify nonuniform distributions and evaluate the most at-risk parameterized predicates, up to three out of all available predicates. In other words, if multiple predicates within the same query meet the criteria, PSP optimization chooses the top three. The PSP feature limits the number of predicates that are evaluated, in order to avoid bloating the plan cache and the Query Store (if Query Store is enabled) with too many plans.

For eligible plans, the initial compilation produces a dispatcher plan that contains the PSP optimization logic called a dispatcher expression. A dispatcher plan maps to query variants based on the cardinality range boundary values predicates.

## Parameter Sensitive Plan terminologies

- **Dispatcher expression**:
  Evaluates cardinality of predicates based on runtime parameter values and route execution to different query variants.

- **Dispatcher plan**:
  A plan containing the dispatcher expression is cached for the original query. The dispatcher plan is essentially a collection of the predicates that were selected by the feature with a few extra details. For each predicate that is selected, some of the details that are included in the dispatcher plan are the high and low boundary values. These values are used to divide parameter values into different buckets or ranges. The dispatcher plan also contains the statistics that were used to calculate the boundary values.

- **Query variant**:
  As a dispatcher plan evaluates the cardinality of predicates based on runtime parameter values, it places those values into buckets, and generates separate child queries to compile and execute. These child queries are called query variants. Query variants have their own plans in the plan cache and Query Store.

- **Predicate cardinality range**:
  At runtime, the cardinality of each predicate is evaluated based on runtime parameter values. The dispatcher places the cardinality values into three predicate cardinality ranges at compile time. For example, the PSP optimization feature can create three ranges that would represent low, medium, and high cardinality ranges, as shown in the following diagram.

  :::image type="content" source="../media/parameter-sensitive-plan-boundaries.png" alt-text="Diagram of the parameter sensitive plan boundaries.":::

  In other words, when a parameterized query is initially compiled, the PSP optimization feature generates a shell plan known as a dispatcher plan. The dispatcher expression has the logic that places queries into query variants based on the runtime values of parameters. When actual execution begins, the dispatcher performs two steps:

  - The dispatcher evaluates its dispatcher expression for the given set of parameters to compute the cardinality range.
  - The dispatcher maps these ranges to specific query variants and compiles and executes the variants. By virtue of having multiple query variants, the PSP optimization feature achieves having multiple plans for a single query.

## Considerations

- To enable PSP optimization, enable database compatibility level 160 for the database you're connected to when executing the query.
- For more insights into the PSP optimization feature, we recommend that Query Store integration is enabled, by turning on the Query Store.

For more information to build a deeper understanding of PSP, see [Parameter Sensitive Plan optimization](/sql/relational-databases/performance/parameter-sensitive-plan-optimization).
