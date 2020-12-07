An Azure Cognitive Search index consists of a collection of JSON objects, each containing one or more data *fields*. The index can be populated in one of two ways:

- Data is *pushed* into the index using the API.
- Data is *pulled* from a supported data source.

To push data into the index, you can use the API to submit batches of data records to be added, updated, or deleted. This approach is useful for applications where there is no existing data storage tier, and data is captured for future search or analysis.

In many scenarios, the index must be populated with data objects that represent entities in a data store, such as a database or document store. To pull the data from its store and populate the index, you must define a *data source* in your Azure Cognitive Search resource.

An Azure Cognitive Search data source can reference any of the following types of data store:

- Azure Storage (blob or table).
- Azure Cosmos DB.
- Azure SQL Database, SQL Managed Instance, or SQL Server in a virtual machine.

![A data source.](../media/data-source.png)

> [!NOTE]
> In this module, we'll use Azure Storage as the data source for a search solution, but it's important to consider the available options. Azure Storage is appropriate when the data to be indexed consists of files, such as Microsoft Office or PDF documents. Cosmos DB is a great choice when you need to index JSON data documents, and includes native integration with Azure Cognitive Search in the Azure portal. Azure SQL Database is ideal for relational databases, commonly used for business application data storage.

## Create a data source for Margie's Travel

In the Margie's Travel scenario, the data consists of unstructured documents in Azure Storage, so you must create a data source for the blob container where the documents are stored.

Choose the language you want to use at the top of this page, and follow the steps to create a data source.

> [!NOTE]
> The exercises in this module assume you will use the same language for each task to incrementally build a search solution. If you wish, you can repeat each task in both languages, but doing so will create two search solutions - you can't use a mix of language-specific instructions to create a single solution.

:::zone pivot="csharp"

Azure Cognitive Search provides a software development kit (SDK) for Microsoft .NET, which you can use to write C# code that works with your search resources.

1. In Visual Studio Code, expand the **01-Create-a-search-solution** folder and the **C-Sharp** folder it contains.
2. Expand the **create-index** folder and open the **appsettings.json** file. This file contains configuration values for your C# code. Using a configuration file like this enables you to specify variable parameters separately from the code that uses them, adding flexibility to your infrastructure-as-code solution. It also avoids hard-coding sensitive values, such as keys and passwords in your code - enabling you to manage code files in a shared source control repository without compromising secure data.
3. Modify the values in the **appsettings.json** file to reflect the Azure Cognitive Search service name (<u>without</u> the .*search&#46;windows&#46;net* suffix), Azure Cognitive Search admin key, and Azure Storage blob container connection string for the Azure resources you created previously. Then save the **appsettings.json** file.
4. Open the **Program.cs** file, and view the code it contains. The **Main** function:
    - Gets the configuration settings from the **appsettings.json** file.
    - Creates a **SearchServiceClient** object for your Azure Cognitive Search service.
    - Prompts the user for input, calling the appropriate functions to create Azure Cognitive Search components.
5. View the **CreateOrUpdateDataSource** function, which creates a data source named **margies-docs-cs** that references the Azure Storage blob container where the PDF documents are stored.
6. Right-click (Ctrl+click if using a Mac) the **create-index** folder and select **Open in Integrated Terminal**. This will open a new bash terminal in this folder.
7. In the terminal for the **create-index** folder, enter the following command:
    ```bash
    dotnet run
    ```
8. When prompted, press **1** to create a data source. Then wait while the program creates the data source.
9. When the prompt is redisplayed, press **q** to quit the program.
10. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Data sources** tab to confirm that the data source has been created.

:::zone-end

:::zone pivot="python"

There is no Python SDK for creating Azure Cognitive Search objects, but you can use Python to submit requests to the Azure Cognitive Search REST API. In the case of a data source, the body of the REST request takes the form of a JSON document defining the data source to be created.

1. In Visual Studio Code, expand the **01-Create-a-search-solution** folder and the **Python** folder it contains.
2. Expand the **create-index** folder and open the **data_source.json** file. This contains the JSON definition for a data source that can be submitted to the Azure Cognitive Search REST interface.
3. Review the JSON code, which defines an Azure blob data source named **margies-docs-py** that references the **margies** container in an Azure Storage account. The connection string for the blob container is null - you will address this in your code later.
4. Open the **submit-rest&#46;py** code file and review the Python code it contains. The code contains the following functions:
    - **azsearch_rest**: This function submits an HTTP request to the Azure Cognitive Search REST interface. The specific operation initiated by the request is determined by the endpoint that is called and the JSON body that is submitted.
    - **main**: This is the main entry-point function for the script. It loads environment variables for the secure credentials required to connect to your Azure Cognitive Search resource, and the JSON file specified in the parameters used to call the script. If the *data_source.json* file is specified, the Azure Storage blob container connection string is loaded from the environment variables and inserted into the JSON body. Then the JSON is submitted to the **az_search** function along with the specified HTTP operation and method endpoint. The response returned for the request is then displayed as JSON.
5. Open the **.env** file, which contains environment variables for your Python code. Using environment variables enables you to specify variable parameters separately from the code that uses them, adding flexibility to your infrastructure-as-code solution. It also avoids hard-coding sensitive values, such as keys and passwords in your code - enabling you to manage code files in a shared source control repository without compromising secure data.
6. Modify the values in the **.env** file to reflect the Azure Cognitive Search endpoint, Azure Cognitive Search admin key, and Azure Storage blob container connection string for the Azure resources you created previously. **.env** file
7. Right-click (Ctrl+click if using a Mac) the **create-index** folder and select **Open in Integrated Terminal**. This will open a new bash terminal in this folder.
8. In the terminal for the **create-index** folder, enter the following command:
    ```bash
    python3 submit-rest.py 'POST' 'datasources' 'data_source.json'
    ```
9. Wait while Python runs the **submit-rest&#46;py** script, causing it to submit an HTTP POST request to the *datasources* REST endpoint with the JSON body defined in the *data_source.json* file.
10. Review the JSON response that is returned from the REST interface. It contains the full JSON definition of the data source (the data source connection string is null to avoid returning sensitive data).
11. Open your search service in the [Azure portal](https://portal.azure.com?portal=true) and view its **Data sources** tab to confirm that the data source has been created.

:::zone-end