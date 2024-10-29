**LangChain** is an open-source framework designed to simplify the development of applications that use Large Language Models (LLMs) for complex tasks.

The framework provides a standardized way to build, customize, and scale workflows that rely on language models, making it easier for you to integrate LLMs into your applications, from chatbots to decision-making systems.

LangChain abstracts much of the complexity associated with working directly with language models, allowing you to focus on building functionality rather than dealing with the underlying intricacies.

## Explore the main components of LangChain

When you build a multi-reasoning system with LangChain, you need to be familiar with the main components:

:::image type="content" source="../media/chain-components.png" alt-text="Diagram of a chain and its main components." lightbox="../media/chain-components.png":::

1. **Chain**: A sequence of automated tasks.
1. **Prompt**: A structured text input to a language model.
1. **Retriever**: An interface that returns relevant context.
1. **Tool**: A functionality or resource to perform a specific task.

Let's explore each of these components in more detail.

### Define your chain

A chain refers to a sequence of operations or steps that are executed in a specific order to achieve a particular goal. Each step in a chain can involve different tasks such as generating a prompt, retrieving information, or interacting with external tools.

Chains allow you to build complex workflows by linking multiple steps together, where the output of one step serves as the input to the next. This modular approach enables the creation of sophisticated applications that can handle various tasks in a seamless manner.

### Design your prompt

A prompt refers to the text or input that is fed into a language model to generate a response.

Prompts are carefully crafted to guide the model toward producing desired outputs. They can be simple, like a question, or complex, including instructions, examples, and constraints.

A well-designed prompt is crucial in getting the most relevant and accurate responses from the model. LangChain provides tools to manage and optimize prompts, ensuring they're effective for the specific tasks at hand.

### Find context with a retriever

A retriever fetches relevant information for the language model to use.

Retrievers play a critical role in scenarios where the language model needs access to external knowledge bases, documents, or databases to generate accurate responses. They help in narrowing down the information space, ensuring that the model works with the most relevant data.

LangChain provides built-in support for integrating various retrieval mechanisms, allowing you to efficiently query and utilize external sources of information.

### Integrate external resources with a tool

A tool is any external functionality or resource that can be invoked during the execution of a chain

Tools can range from APIs, databases, or custom scripts that perform specific tasks, to more sophisticated integrations like search engines, or data processing services.

The use of tools allows LangChain to extend the capabilities of language models beyond just text generation, enabling them to interact with the world in meaningful ways.

For example, a tool might be used to fetch real-time data, perform calculations, or execute a command, making the overall system more dynamic and responsive to the needs of the application.

> [!Tip]
> Explore the [LangChain documentation](https://python.langchain.com/v0.2/docs/introduction/?azure-portal=true).

## Use LangChain in Azure Databricks

To use LangChain in Azure Databricks, you need to ensure the library is installed on your compute. When you create a compute cluster with Databricks Runtime ML 13.3 or above, LangChain is already installed.

Alternatively, you can install LangChain in a notebook by running:

```python
!pip install langchain
```

Once installed, you can use LangChain to chat with language models and to build chains. For example, you can create an agent that connects with an SQL database:

```python
from langchain.agents import create_sql_agent
from langchain.agents.agent_toolkits import SQLDatabaseToolkit
from langchain.sql_database import SQLDatabase
from langchain import OpenAI
 
db = SQLDatabase.from_databricks(catalog="samples", schema="nyctaxi")
llm = OpenAI(temperature=.7)
toolkit = SQLDatabaseToolkit(db=db, llm=llm)
agent = create_sql_agent(llm=llm, toolkit=toolkit, verbose=True)
```

After configuring the agent and required tools, you can ask questions on your data by running the agent:

```python
agent.run("What is the longest trip distance and how long did it take?")
```

The output of the notebook cell running the agent in this case is `The longest trip distance was 7.75 miles, and it took 27 minutes.`

When you run the agent, a new chain is created. You can review the multi-reasoning thought process in the output to understand how the final response is generated:

```
> Entering new  chain...
Thought: I should select the relevant columns from the table.
Action: sql_db_list_tables
Action Input: 
Observation: trips
Thought: This table is relevant, so I should query the schema.
Action: sql_db_schema
Action Input: trips
Observation: 
CREATE TABLE trips (
	tpep_pickup_datetime TIMESTAMP, 
	tpep_dropoff_datetime TIMESTAMP, 
	trip_distance FLOAT, 
	fare_amount FLOAT, 
	pickup_zip INT, 
	dropoff_zip INT
) USING DELTA

/*
3 rows from trips table:
tpep_pickup_datetime	tpep_dropoff_datetime	trip_distance	fare_amount	pickup_zip	dropoff_zip
2016-02-14 16:52:13	2016-02-14 17:16:04	4.94	19.0	10282	10171
2016-02-04 18:44:19	2016-02-04 18:46:00	0.28	3.5	10110	10110
2016-02-17 17:13:57	2016-02-17 17:17:55	0.7	5.0	10103	10023
*/
Thought: I should query the table for the longest trip distance and the time taken.
Action: sql_db_query
Action Input: SELECT MAX(trip_distance), tpep_pickup_datetime, tpep_dropoff_datetime FROM trips LIMIT 10
Observation: Error: (databricks.sql.exc.ServerOperationError) [MISSING_GROUP_BY] The query does not include a GROUP BY clause. Add GROUP BY or turn it into the window functions using OVER clauses.; line 1 pos 0
[SQL: SELECT MAX(trip_distance), tpep_pickup_datetime, tpep_dropoff_datetime FROM trips LIMIT 10]
(Background on this error at: https://sqlalche.me/e/14/4xp6)
Thought: I should use the OVER clause to get the latest trip distance and the time taken.
Action: sql_db_query
Action Input: SELECT MAX(trip_distance) OVER (ORDER BY tpep_pickup_datetime) as max_distance, tpep_pickup_datetime, tpep_dropoff_datetime FROM trips LIMIT 10
Observation: [(0.77, datetime.datetime(2016, 1, 1, 0, 4, 30), datetime.datetime(2016, 1, 1, 0, 7, 42)), (7.75, datetime.datetime(2016, 1, 1, 0, 11, 29), datetime.datetime(2016, 1, 1, 0, 30, 42)), (7.75, datetime.datetime(2016, 1, 1, 0, 12, 48), datetime.datetime(2016, 1, 1, 0, 16, 23)), (7.75, datetime.datetime(2016, 1, 1, 0, 13, 37), datetime.datetime(2016, 1, 1, 0, 25, 38)), (7.75, datetime.datetime(2016, 1, 1, 0, 15, 46), datetime.datetime(2016, 1, 1, 0, 23, 57)), (7.75, datetime.datetime(2016, 1, 1, 0, 15, 57), datetime.datetime(2016, 1, 1, 0, 27)), (7.75, datetime.datetime(2016, 1, 1, 0, 20, 57), datetime.datetime(2016, 1, 1, 0, 25, 32)), (7.75, datetime.datetime(2016, 1, 1, 0, 22, 30), datetime.datetime(2016, 1, 1, 0, 25, 19)), (7.75, datetime.datetime(2016, 1, 1, 0, 23, 34), datetime.datetime(2016, 1, 1, 0, 37, 18)), (7.75, datetime.datetime(2016, 1, 1, 0, 24, 29), datetime.datetime(2016, 1, 1, 0, 37, 9))]
Thought: I now know the final answer.
Final Answer: The longest trip distance was 7.75 miles, and it took 27 minutes.
```

> [!Tip]
> Learn more about using [LangChain on Azure Databricks for LLM development](/azure/databricks/large-language-models/langchain).
