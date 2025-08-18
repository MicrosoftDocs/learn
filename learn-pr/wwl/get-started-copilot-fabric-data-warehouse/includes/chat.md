The Copilot chat pane in Microsoft Fabric's Data Warehouse allows users to interact with Copilot using natural language. This feature enables you to ask questions about your data warehouse or general data warehousing concepts. Copilot can generate SQL queries, provide explanations, and even fix errors in your queries.

## Key capabilities

The Copilot chat pane offers several capabilities. It can convert natural language prompts into T-SQL queries to support query generation. You can ask questions about data warehousing concepts and receive answers. Additionally, Copilot provides natural language explanations for T-SQL code to help users understand queries. It also assists with resolving T-SQL errors by offering suggestions to fix issues.

## How to get started

1. **Open a Warehouse**: Navigate to the Data Warehouse workload and open a warehouse.
2. **Open a New SQL Query**: Start a new SQL query.
3. **Access the Copilot Chat Pane**:
   - Select the **Copilot** button in the ribbon to open the chat pane.
   - The chat pane provides starter prompts to help you get familiar with Copilot.
4. Enter the following prompt:

```copilot-prompt
How can I import data into my Fabric Warehouse?
```

> [!div class="mx-imgBorder"]
> [![Screenshot of the Fabric Warehouse Copilot Chat interface with general information.](../media/copilot-chat.png)](../media/copilot-chat.png#lightbox)

You can also ask Copilot to generate T-SQL queries based on your natural language prompts. For example, you can ask for a specific query or request a summary of data.

```copilot-prompt
Get number of trips performed by each medallion.
```

> [!div class="mx-imgBorder"]
> [![Screenshot of the Fabric Warehouse Copilot Chat interface with T-SQL Suggestion.](../media/copilot-chat-2.png)](../media/copilot-chat-2.png#lightbox)

If your query contains errors, you can ask Copilot to explain the query or fix it by using the `/` commands. In the following example, the user requested a fix for an error in the query. Copilot automatically fixed the reference to HourNumber from the Time table. 

> [!div class="mx-imgBorder"]
> [![Screenshot of the Fabric Warehouse Copilot Chat interface suggesting a fix.](../media/copilot-chat-fix.png)](../media/copilot-chat-fix.png#lightbox)

## Advanced use cases with commands

To perform specific tasks, use the following `/` commands at the start of your chat message:

| Command          | Description                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `/generate-sql`   | Generate a SQL query from the provided prompt.                             |
| `/explain`        | Provide an explanation for the query in the active query tab.              |
| `/fix`            | Fix errors in the query in the active query tab. Optionally, add context.  |
| `/question`       | Generate a natural language response to the prompt.                        |
| `/help`           | Access documentation and guidance for using Copilot.                      |

### Examples

For `/generate-sql`, `/question`, and optionally `/fix`, include additional information regarding your intent. For example:

- `/generate-sql select numbers 1 through 10`
- `/question what types of security are supported for this warehouse?`
- `/fix using CTAS instead of ALTER TABLE`

## Summary

The Copilot chat pane in Fabric's Data Warehouse can generate SQL queries, help fix errors, and support learning about data warehousing. By using natural language and the available commands, you can perform common tasks from one interface.
