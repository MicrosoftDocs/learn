An HTTP request is a common operation on all platforms and devices. Whether it's a request to look up a word in a dictionary or to get the local weather, we send HTTP requests all the time. Azure Functions allow us to quickly create a piece of logic that will be executed when receiving an HTTP request.  

Here, you'll learn how to create and invoke an Azure Function using an HTTP trigger. You will also explore some of the customization options available.

## What is an HTTP trigger?

An HTTP trigger is a trigger that executes a function when it receives an HTTP request. HTTP triggers have many capabilities and customizations including:

- Providing authorized access by supplying keys.
- Restricting which HTTP verbs are supported.
- Returning data back to the caller.
- Receiving data through query string parameters or through the request body.
- Supporting URL route templates to modify the function URL.

When you create an HTTP trigger you'll want to select a programming language, provide a trigger name, and select an Authorization level.

## What is an HTTP trigger Authorization level?

An HTTP trigger Authorization level is a flag that indicates if the function requires that the HTTP request contains an API key for authentication reasons.

There are three Authorization levels:

1. Function.
2. Anonymous.
3. Admin.

The **Function** and **Admin** levels are "key" based. This means that to send an HTTP request you must supply a key for authentication. There are two types of keys: *function* and *host* keys. The differences between the two keys are the scope of them. *Function* keys are specific to a function whereas *host* keys apply to all functions inside the entire Azure Function application. If your Authorization level is set to Function, you can use either a *function* or a *host* key. If your Authorization level is set to Admin, you must supply a *host* key.

The **Anonymous** level means that there is no authentication required. We'll use this level in our exercise.

## How to create an HTTP trigger

Just like a timer trigger, you can also create an HTTP trigger through the Azure portal. Inside your Azure Function, you'll select **HTTP trigger** from the list of predefined trigger types. Then you'll enter your logic that you want to execute and make any customizations like restricting the use of certain HTTP verbs. 

One setting that is important to understand is the **Request parameter name**. This is a string that represents the name of the parameter that contains the information about an incoming HTTP request. By default, the name of the parameter is *req*.

## How to invoke an HTTP trigger

To invoke an HTTP trigger, you need to send an HTTP request to your functions URL. To get your function's URL, you can go to your function's code page and select the **Get function URL** link.

![Function URL](../media/5-function-url.png)

Once you have your function URL, you can begin sending HTTP requests. If your function receives data, remember that you can use either query string parameters or supply it through the request body.

## Summary

An HTTP trigger invokes an Azure function when it receives an HTTP request to its function URL. HTTP triggers not only allow you to receive data, but they also allow you to return data back to the caller.

