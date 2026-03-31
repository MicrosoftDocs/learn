Large language models can answer questions, summarize content, and generate text. But they only know what they learned during training. Ask about your company's products, customer orders, or compatible components, and the model has no useful answer. Retrieval Augmented Generation (RAG) solves this problem by giving the model access to your data at query time. Instead of hoping the model knows your product catalog, you retrieve the relevant products from your database and include them in the prompt. The model then generates a response grounded in actual, current information.

RAG keeps AI processing inside the database layer, where your data already lives. This approach avoids moving data between systems and lets you use Transact-SQL to control what context the model receives. The result is an application that can answer specific questions using real, up-to-date information from your tables.

Imagine a retail team building a customer support application on top of a product database. A customer asks "Which gloves work best for cold weather cycling?" The application needs to search the product catalog, find matching accessories, and generate a helpful response using an LLM. This workflow is RAG in action: retrieve relevant data, augment the prompt with that data, and generate a grounded response. By building this workflow in SQL, the team keeps the retrieval step close to the data and avoids building a separate retrieval service.

After completing this module, you'll be able to:

- Identify when RAG is the right approach for your application.
- Convert SQL query results to JSON for Large Language Model (LLM) processing.
- Construct prompts that combine instructions with database context.
- Call LLM endpoints from SQL.
- Parse LLM responses and return answers to your application.
