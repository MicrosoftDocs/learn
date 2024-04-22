The Azure AI extension is a powerful tool created by the Postgres team at Microsoft that provides seamless integration between your Azure Database for PostgreSQL - Flexible Server database and various Azure AI services. This integration streamlines the development process and enables you to effortlessly incorporate AI features into your applications.

You can access Azure AI services such as natural language processing, text analytics, and large language models (LLMs) from your SQL queries using a simple function call. This extension means you can use the power of Azure AI to add advanced analytics and insights to your applications without leaving your PostgreSQL database.

The Azure AI extension also allows you to build generative AI applications directly within your PostgreSQL database. You can use large language models (LLMs) to create advanced AI applications that generate text, images, and other media directly from your database. The extension makes it easy to integrate Azure OpenAI, the Azure AI Language service, and Azure Machine Learning directly from your database, enabling you to build sophisticated AI applications quickly.

Overall, the Azure AI extension is a game-changer for developers looking to add AI features to their applications. Its rich capabilities and seamless integration with Azure AI services simplify the development process and enable you to build advanced AI applications directly within your PostgreSQL database.

## What is the Azure AI extension?

The `azure_ai` extension provides a comprehensive suite of tools that can enhance the capabilities of a PostgreSQL database by integrating Azure AI Services. These tools include a collection of schemas, user-defined functions (UDFs), and composite types that can be seamlessly integrated into any PostgreSQL database. When you use the power of Azure AI Services, you can benefit from advanced analytics, machine learning, and other AI-driven capabilities to gain deeper insights and make better decisions. With the `azure_ai` extension, PostgreSQL you can unlock a whole new level of functionality and performance.

1. **Generative AI integration**: With the `azure_ai` extension, you can seamlessly incorporate generative AI capabilities into your database. Whether you're working with text, images, or other data, this extension enables you to create new content based on existing information.

2. **Azure OpenAI and Cognitive Services**: The extension allows your database to call into various Azure AI services, including **Azure OpenAI** and **Azure Cognitive Services**. These services simplify the development process, making integrating AI features into your applications more accessible.

3. **Vector embeddings**: By invoking the **Azure OpenAI API**, you can generate vector embeddings and store them directly in your PostgreSQL database. These embeddings enable powerful capabilities like semantic search, recommendations, and anomaly detection.

4. **Model inference**: The extension allows you to connect to **Azure Machine Learning** to perform inference, using a trained machine learning model to make predictions or generate outputs based on new, unseen data.

## Enabling the azure_ai extension

Before you can use the `azure_ai` extension, it must be allowed and installed with your database:

1. **Allowlist configuration**: Add the extension to your allowlist by running `SHOW azure.extensions;`.
2. **Installation**: Connect to your target database and execute the following command to install the extension:

    ```sql
    CREATE EXTENSION IF NOT EXISTS azure_ai;
    ```

## Schema creation

Once installed, the extension creates four schemas within the database:

| Schema | Description |
| ------ | ----------- |
| `azure_ai` | Contains the configuration table and functions for interacting with the extension. |
| `azure_cognitive` | Contains functions and composite types related to Azure Cognitive Services. |
| `azure_ml` | Contains functions related to Azure Machine Learning inference. |
| `azure_openai` | Contains the functions related to Azure OpenAI. |

## Configuring the extension

The extension creates the `azure_ai.settings` table, which is crucial in configuring and managing the extension settings. The table securely hosts endpoint and key settings related to the Azure AI Services you integrate into your database. To configure the extension, provide the necessary endpoints and API keys for authentication.

1. **Setting values**:

    - The `azure_ai.set_setting()` function allows you to **set** various configuration values for Azure AI services. You can assign values to specific keys using this function.
    - For example, you can set the **Azure OpenAI endpoint** and provide the corresponding **subscription key** using the following commands:

        ```sql
        SELECT azure_ai.set_setting('azure_openai.endpoint', '{endpoint}');
        SELECT azure_ai.set_setting('azure_openai.subscription_key', '{api-key}');
        ```

2. **Retrieving settings**:

    - The `azure_ai.get_setting()` function lets you **retrieve** the values you previously set using `set_setting()`.
    - Specify the key of the setting you want to view, and the function returns the associated value.
    - For instance, to verify the settings written in the configuration table, use:

        ```sql
        SELECT azure_ai.get_setting('azure_openai.endpoint');
        SELECT azure_ai.get_setting('azure_openai.subscription_key');
        ```

## Access keys and security

Your Azure AI access keys are similar to your account's root passwords. It's crucial to handle them with care. The best approach is to use Azure Key Vault to manage and rotate your keys.

Users who need to manage service keys used by the extension require the `azure_ai_settings_manager` role in the database. Functions that require this role include `azure_ai.set_setting()` and `azure_ai.get_setting()`.

## How does the azure_ai extension work?

Let's get hands-on! Here's a quick taste of how easy it's to use azure_ai with Azure Database for PostgreSQL:

- **Generating embeddings**: You can create embeddings by calling a user-defined function (UDF) inline from SQL. For example:

    ```sql
    SELECT azure_openai.create_embeddings('text-embedding-ada-002', 'Learn about building intelligent applications with azure_ai extension and vector');
    ```

- **Language services**: Need sentiment analysis? It's as simple as a UDF call from SQL:

    ```sql
    SELECT a.* FROM azure_cognitive.analyze_sentiment('The GenAI session was awesome', 'en') a;
    ```

- **Additional features**: You can add vector columns to tables, create HNSW (Hierarchical Navigable Small World) indexes, and perform semantic searches—all powered by the `azure_ai` extension.
