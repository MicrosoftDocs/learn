Azure SQL Database enables you to import data using an external REST endpoint through the system-stored procedure [`sp_invoke_external_rest_endpoint`](/sql/relational-databases/system-stored-procedures/sp-invoke-external-rest-endpoint-transact-sql?azure-portal=true). You can call any HTTP REST endpoints directly from your SQL queries, making it possible to integrate with a wide range of services, including Azure Functions, Azure Logic Apps, and Azure App Service.

Also, if you want to invoke a REST service that isn't within the allowed list, you can use [Azure API Management](/azure/api-management/api-management-key-concepts?azure-portal=true) to securely expose the desired service and make it available to `sp_invoke_external_rest_endpoint`.

## Explore API usage

Let's explore some of the key use cases and scenarios where this functionality can be beneficial.

- **Data processing with Azure Functions:** You can use `sp_invoke_external_rest_endpoint` to call an Azure Function that processes data. For example, you might send a batch of data to an Azure Function for complex calculations or transformations, and then store the results back in your database.

- **Integration with Cognitive Services:** You can call Cognitive Services APIs to perform tasks such as sentiment analysis, image recognition, or language translation. For instance, you might send text data to the Text Analytics API to analyze customer feedback and store the sentiment scores in your database.

- **Event-driven workflows:** Use `sp_invoke_external_rest_endpoint` to trigger workflows in Logic Apps or Power Automate. This can be useful for automating business processes, such as sending notifications or updating records in other systems based on changes in your database.

- **Data enrichment:** Enrich your data by calling external APIs. For example, you might call a REST API to get additional information about a product or customer and then store the data in your database.

- **API Management:** Use `sp_invoke_external_rest_endpoint` to interact with APIs managed by [Azure API Management](/azure/api-management/api-management-key-concepts?azure-portal=true). This allows you to use existing APIs for various functionalities without having to write complex integration code.

## Implement secure API calls

REST endpoints often require authentication, which can be done via key-value pairs in the query string or HTTP headers. You can securely store this data using `DATABASE SCOPED CREDENTIALS` with the `IDENTITY` parameter specifying how to pass the authentication data. The `IDENTITY` parameter supports four options: *HTTPEndpointHeaders*, *HTTPEndpointQueryString*, *Managed Identity*, and *Shared Access Signature (SAS)*.

The created DATABASE SCOPED CREDENTIAL can be used via the `@credential` parameter in the `sp_invoke_external_rest_endpoint` stored procedure. The authentication information must be provided via the SECRET parameter in a flat JSON format.

```sql
CREATE DATABASE SCOPED CREDENTIAL [https://.azurewebsites.net/api/]
WITH IDENTITY = 'HTTPEndpointHeaders', SECRET = '{"x-functions-key":"<your-function-key>"}';
```

## Invoke REST endpoint

Let's consider a scenario where you want to import data from a REST API that provides weather information. You already have a `WeatherData` table in Azure SQL Database with `City`, `Temperature`, `Condition`, and `Timestamp` columns.

Use the `sp_invoke_external_rest_endpoint` stored procedure to call the REST API and insert the data into your table:

```sql
DECLARE @response NVARCHAR(MAX);
EXEC sp_invoke_external_rest_endpoint 
    @method = 'GET',
    @url = 'https://api.weather.com/v3/wx/conditions/current?apiKey=your_api_key&format=json',
    @response = @response OUTPUT;

INSERT INTO WeatherData (City, Temperature, Condition, Timestamp)
SELECT 
    JSON_VALUE(@response, '$.location.city'),
    JSON_VALUE(@response, '$.temperature'),
    JSON_VALUE(@response, '$.weatherCondition'),
    GETDATE();
```

When considering the use of REST endpoints, ensure that the endpoints you're calling are secure and that any sensitive data is handled appropriately. Be mindful of the performance implications of frequent API calls, especially when dealing with large datasets or high-frequency updates. Also, implement error handling to manage potential issues with API calls, such as timeouts or invalid responses.