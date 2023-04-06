<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
# Parameter Sensitive Plan optimization

When a query is compiled, values for any parameters used in queries in a stored procedure or parameterized query are using to make decisions to build an execution plan. This concept is commonly known as parameter sniffing. Only one query plan can exist in cache for statements in a stored procedure or parameterized query. In most cases this does not result in any performance problems for applications. However, there are situations where the data retrieved for queries based on parameters can be skewed, or not evenly distributed. In these cases, the single cache plan may not be optimal for different parameter values. This problem is known as a parameter sensitive plan.

In SQL Server 2022, the optimizer can detect parameter sensitive plan scenarios and cache multiple plans for the same stored procedure or parameterized query. The optimizer uses a concept called query variants to aggregate sets of parameter values to match a query plan best suited for those parameter values.

## Terminology
### Dispatcher expression
Evaluates cardinality of predicates based on runtime parameter values and route execution to different query variants.
### Dispatcher plan
A plan containing the dispatcher expression is cached for the original query. The dispatcher plan is essentially a collection of the predicates that were selected by the feature with a few extra details. For each predicate that is selected some of the details that are included in the dispatcher plan are the high and low boundary values. These values are used to divide parameter values into different buckets or ranges. The dispatcher plan also contains the statistics that were used to calculate the boundary values.
### Query variant
As a dispatcher plan evaluates the cardinality of predicates based on runtime parameter values, it bucketizes those values, and generates separate child queries to compile and execute. These child queries are called query variants. Query variants have their own plans in the plan cache and Query Store.


<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
TODO: add your scenario sub-task

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
TODO: write your prose table-of-contents

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
TODO: add a visual element

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->