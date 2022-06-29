Implementing data modeling best practices is key to performant, scalable data models.

## Choose the correct Power BI model framework

Choosing the correct Power BI model framework is at the heart of building any scalable solution. 

The first place to start with your Power BI data model is *import mode*. Import mode offers you the most options, design flexibility, and delivers fast performance.

Use *DirectQuery* when your data source stores large volumes of data and/or your report needs to deliver near real-time data.

Finally, use a *composite model* when you need to:
- Boost the query performance of a DirectQuery model.
- Deliver near real-time query results from an import model.
- Extend a Power BI dataset (or Azure Analysis Services model) with other data.

> [!Important]
> Review the [Choose a Power BI model framework](/learn/modules/choose-power-bi-model-framework/) module for more information on using import, DirectQuery, or composite models.

## Implement data modeling best practices

There are some basic principles to abide by when building any data model. These principles become even more important as data begins to grow.

Most importantly, you want to do as much data preparation work as possible **before data reaches Power BI**, as far upstream as possible. For example, if you have the opportunity to transform data in the data warehouse, that's where it should be done. Transformation at the source level produces consistency for any other solutions built on that data and ensures that your Power BI model doesn't need to do any extra processing. This may require working with your data engineer or other members of the data team and is critically important.

### Best practices for import mode:

- Always **start with import mode** if you can. 
- **Only bring in data you need**. 
  - Remove unnecessary rows and columns.
  - Consider partitioning and incremental refresh to avoid loading data you don’t need to.
- **Avoid wide tables**. 
  - Use a [star schema](/power-bi/guidance/star-schema) in Power BI. 
    - If your source is a beautifully modeled data warehouse, you're a step ahead.
    - Big data is often in wide flat tables. Take advantage of dimensional models for their performance benefits.
    - Power BI supports multiple fact tables with different dimensionality and different granularities – you don’t have to put everything into one large table.
- **Group and summarize data** where possible.
- **Avoid high cardinality columns**.
  - Consider breaking a datetime column into two columns, one for date and one for time.
- **Use appropriate data types**.
  - Use integers instead of strings for ID columns. 
  - Use surrogate keys for ID columns if necessary.
- **Disable auto date/time**.
  - Connect to a date table at the source or create your own date table.
- If querying a relational database, **query database views rather than tables**. 
  - A view provides an abstraction layer to manage columns, and relates back to the first consideration, pushing transformations as close to the source as possible.
- Check to **ensure [query folding](/power-query/power-query-folding) is achieved**.
    - If query folding isn't possible, you have another opportunity to work with the data engineer to move transformation upstream.

> [!TIP]
> Learn more about [techniques to help reduce the data loaded into import models](/power-bi/guidance/import-modeling-data-reduction)

### Best practices specific to DirectQuery mode:
- Keep things as **simple** as possible.
  - Try not to apply transformations to your data. 
- Set relationships to enforce integrity using the **[Assume referential integrity property](/power-bi/connect-data/desktop-assume-referential-integrity)** on relationships.
  - The Assume Referential Integrity setting on relationships enables queries to use INNER JOIN statements rather than OUTER JOIN.
- **Limit the use of bi-directional filters** on relationships.
  - Use only when necessary.
- Limit the **complexity of DAX calculations**.
  - Because query folding occurs by default in DirectQuery, more complex DAX measures means added complexity at the source, leading to slow queries.
  - The need for complex DAX also leads back to the key principle of applying transformations as far upstream as possible. You may need to work with the data engineer to apply transformations at the source.
- **Avoid relationships on calculated columns**
- **Avoid relationships on Unique Identifier columns**
- Use **hybrid tables, aggregation tables, and dual storage** mode appropriately.
  
> [!NOTE]
> Refer to the [DirectQuery model guidance](/power-bi/guidance/directquery-model-guidance) for a complete list of considerations in developing DirectQuery models.

In the next unit, you'll learn how to configure the large dataset storage format using Power BI premium.

