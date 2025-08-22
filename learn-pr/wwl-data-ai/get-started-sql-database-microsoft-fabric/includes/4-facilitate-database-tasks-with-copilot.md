In today's fast-paced tech world, understanding AI is essential for enhancing applications and staying competitive. SQL Database in Fabric is key to this transformation, offering a robust platform for integrating AI. With capabilities like Natural Language to SQL, code completion, quick actions, and intelligent insights, it empowers users to harness AI, and boost application performance. 

These tools enable the creation of intelligent, responsive, and efficient applications that meet modern user demands.

## Use Copilot for SQL database in Fabric

[Microsoft Copilot](/azure/azure-sql/copilot/copilot-azure-sql-overview?azure-portal=true) is integrated with SQL database in Fabric, enhancing SQL management and troubleshooting. It boosts productivity by offering natural language to SQL conversion and self-help for users.

Copilot can automatically correct T-SQL code errors as they occur. By sharing context with the active query tab, Copilot offers helpful suggestions to fix SQL query errors seamlessly. You can also generate T-SQL queries by asking questions in natural language.

With the [**natural language to SQL**](/fabric/database/sql/copilot-chat-pane?azure-portal=true) capability, which translates natural language queries into SQL within the query editor in Fabric portal, database interactions become more intuitive. This integration allows Copilot to answer questions based on your database context, as Copilot is schema-aware.

```
Which employees have completed more than two projects this quarter?
List all products that were out of stock last month.
Provide the rank of each department by employee satisfaction score and show the department name, average score, and rank.
Create a primary key constraint named PK_Product_ProductID to the column ProductID in the table Product
```

Copilot in Fabric SQL database includes several key features:

- **Chat pane**: Use natural language to ask questions and generate T-SQL queries
- **Code completion**: Automatic suggestions while typing T-SQL code  
- **Quick actions**: Explain and Fix buttons in the query editor toolbar to help understand and correct queries

To access Copilot features in the Fabric portal, open your SQL database and select the **Copilot** button in the ribbon to open the chat pane, or use the **Explain** and **Fix** quick action buttons in the query editor toolbar.

> [!NOTE]
> Copilot for SQL database does not use data in tables to generate T-SQL suggestions.
