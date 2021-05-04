Clients consume your experiment's web service by using RESTful API calls. Azure Machine Learning Studio gives you some sample header information that shows how to call the web service.

## View the request and response headers

1. Under **API Help Page for the Default Endpoint**, select the **Request/Response** link. Machine Learning Studio opens another browser tab or window to show the API documentation for this web service.

1. Scroll down to **Request Headers** and **Request Body** to get an idea of how the request will be formed. This request will be sent to the web service for evaluation. It's in JSON format.

1. Scroll down more and evaluate the **Response Headers** and **Response Body** sample. This section shows the format of the data that will be returned along with a sample JSON response. Use this sample to understand how to parse the JSON code for the data you want to use in your application.

1. Scroll down more to find information about the input and output parameters. These parameters include the expected names and data types. If you create a class to represent the returned information, you can use these parameters to create the proper data types for your member variables. The last two returned items map a **Scored Label Mean** value to a **Scored Label Standard Deviation** value.

## Evaluate the sample code

You'll use the sample code as a reference or basis to create a client application that will consume the web service for the experiment. Review the code to see how to create the request and consume the response in your app.

> [!TIP]
> The **Sample Code** entry contains samples in C#, Python, and R.

To view the sample code:

1. Scroll all the way to the bottom of the web service API documentation window.

1. Select the tab of the language you're most familiar with. Then review the code to see what it's doing.

1. Notice the placeholder for the API key. You'll need to replace the value **abc123** with a valid API key.
