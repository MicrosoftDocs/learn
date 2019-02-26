Clients consume your experiment's web service using RESTful API calls. Azure ML Studio gives you some sample header information showing how to successfully call the web service.

## View the Request and Response Headers

1. Click the **Request/Response** link under API Help Page for the Default Endpoint
    - Azure ML Studio opens another browser tab or window with the API documentation for this web service.

1. Scroll down and view the **Request Headers** and **Request Body** to get an idea of how the request will be formed. This request is what will be sent to the web service for evaluation and is in JSON format.

1. Scroll down further and evaluate the **Response Headers** and **Response Body** sample. 
    - This section shows the format of the data that will be returned along with a sample JSON response.  
    - You can use this sample to understand how to parse the JSON for the data you want to use in your application.

1. Scrolling down further presents information about the input and output parameters that includes the names and data types expected.
    - If you will be creating a class to represent the returned information, you can use these parameters to create the proper data types for your member variables. 
    - The last two items returned map to a **Scored Label Mean** value a **Scored Label Standard Deviation** value.

## Evaluate the Sample Code

The sample code is what you will use as a reference or basis for creating a client application to consume the web service for the experiment. Reviewing the code will give you an example of how to create the request and consume the response in your app.

> [!TIP]
> The Sample Code entry contains samples in C#, Python, and R.

1. Scroll all the way to the bottom of the web service API documentation window.
2. Select the tab of the language you are most familiar with and scroll through the code to see what it is doing.
3. Notice the placeholder for the API key. The value "abc123" must be replaced with a valid API key.
