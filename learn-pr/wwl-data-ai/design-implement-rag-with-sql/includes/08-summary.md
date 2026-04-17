Retrieval Augmented Generation connects your database to the capabilities of large language models. Instead of relying on a model's training data, you provide current, relevant information from your own tables.

The entire RAG pattern executes in T-SQL. Your database orchestrates the flow: search, format, prompt, call, parse. You can add AI capabilities to existing applications by modifying stored procedures, without rearchitecting your application stack.

In this module, you learned how to:

- **Identify RAG use cases**: Recognize scenarios where grounding Large Language Model (LLM) responses in database content improves accuracy and relevance
- **Prepare context from SQL**: Use `FOR JSON` to convert query results into text that LLMs can process effectively
- **Construct augmented prompts**: Build request payloads that combine system instructions, retrieved context, and user questions
- **Execute the RAG pipeline**: Call Azure OpenAI endpoints using `sp_invoke_external_rest_endpoint` and parse the responses

## Learn more

- [sp_invoke_external_rest_endpoint (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-invoke-external-rest-endpoint-transact-sql)
- [Intelligent applications and AI](/azure/azure-sql/database/ai-artificial-intelligence-intelligent-applications)
- [Format query results as JSON with FOR JSON](/sql/relational-databases/json/format-query-results-as-json-with-for-json-sql-server)
- [Intelligent applications and AI FAQ](/sql/sql-server/ai/artificial-intelligence-intelligent-applications-faq)
