GitHub Copilot can be used with the PostgreSQL extension in Visual Studio Code to perform common database development tasks. By working through practical scenarios, developers use Copilot Chat to generate SQL queries and make schema changes, then review and execute the results using the PostgreSQL query editor.

Consider the Margie’s Travel scenario. The application stores property listings and customer reviews in PostgreSQL. Developers use Copilot Chat to speed up tasks such as writing SQL queries and modifying tables while remaining in control of what is executed.

## Generate a SQL query using Copilot Chat

Developers often start by asking Copilot for help writing a SQL query. After opening **Chat with this database**, they direct their request to the PostgreSQL context by using the `@pgsql` participant.

For example, a developer might enter the following prompt:

> `@pgsql I need help writing a SQL query to list recent reviews for each property, including the rating and review date`

Copilot responds with a suggested SQL query that reflects the tables and columns in the connected database. The developer reviews the generated SQL and runs it in the PostgreSQL query editor to verify the results.

This approach helps developers move quickly from a requirement to a working query, while still reviewing the SQL before execution.

## Modify a table with confirmation

In addition to querying data, Copilot Chat can assist with schema changes. When a prompt involves modifying database objects, Copilot requests explicit confirmation before making any changes.

For example, a developer at Margie’s Travel might enter:

> `@pgsql convert the listings table to store amenities in a JSONB column`

Copilot responds with SQL statements that describe the schema change and asks for permission to proceed. After reviewing the SQL, the developer confirms execution:

> `@pgsql Yes, please make the JSONB column for me`  
> `@pgsql Yes, I confirm`

Only after confirmation does Copilot apply the change. This workflow ensures that schema modifications are intentional and reviewed.

## Address query issues using Copilot Chat

Copilot Chat can also help when a SQL query produces an error or unexpected results. Developers describe the issue directly in Chat and review the suggested guidance.

For example, a developer might enter:

> `@pgsql I'm getting this error: 'ERROR: column orders.total_price must appear in the GROUP BY clause or be used in an aggregate function.'`

Copilot responds with guidance and suggested SQL adjustments. The developer reviews the suggestion, updates the SQL query in the editor, and reruns it to confirm the issue is resolved.

## Review and validate results

Copilot generates SQL queries and explanations in the Copilot Chat window. Developers review the generated SQL in Chat before running it.

After executing the SQL using the PostgreSQL extension, developers review the results in Visual Studio Code to confirm that the query behaves as expected.

At Margie’s Travel, developers use this review step to verify that Copilot-generated SQL queries return the intended data.

## Use Copilot Chat for optimization and application scenarios

Copilot Chat can also be used to help with more advanced scenarios, such as refining queries, improving performance, or supporting application development. Developers describe the problem they are trying to solve, and Copilot responds with guidance or example SQL that can be reviewed and adapted.

Copilot responds with suggested changes to the SQL query, such as adjusting joins, filters, or query structure. The developer reviews the response in the Copilot Chat window, applies the relevant changes, and then runs the updated query using the PostgreSQL extension.

For example, at Margie’s Travel a developer might ask Copilot Chat for help improving a query that retrieves property listings along with customer reviews. The developer could describe that the query is slow when filtering by review date and rating, or that it needs to support an application feature that shows recent reviews for each listing. The developer could also ask copilot to suggest indexing strategies to improve query performance. Or the request might be more complex, such as asking copilot to create a python function that connects to the database and retrieves listings with reviews. The sky is the limit of what copilot can help with!

## What you’ve learned

You learned how GitHub Copilot can be applied with the PostgreSQL extension in Visual Studio Code. You saw how Copilot Chat is used to generate SQL queries, modify database schemas with confirmation, and address query issues, followed by reviewing and executing results in the PostgreSQL query editor.
