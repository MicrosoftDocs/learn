In this unit, you'll learn how to consume machine learning models in Model Builder.

## Code snippet

If you have an existing application you'd like to use your model to make predictions, the code snippet simplifies the process. To use the code snippet in your application:

1. Add a reference to your class library containing your model from the project you'll use the model in.
1. Add the code snippet to your application.

The code snippet does the following:

1. Creates an instance of your model input.
1. Uses the `Predict` method in the *.consumption.cs* file to make predictions using the input data you've provided.

## Project templates

Like the training and consumption code that is auto-generated, Model Builder provides you with templates to auto-generate .NET applications that include your model for predictions. The templates include:

- **Console app**: A C# .NET console application that uses your model to make predictions.
- **Web API**: An ASP.NET Core Web API project built using the ASP.NET Minimal API application model to simplify hosting your model as a web service. Web APIs provide the flexibility of being able to make predictions with your model over HTTP web requests from a variety of clients like desktop, web, and mobile applications.  

## Console app

The console application contains the following files:

- **Program.cs**: The entrypoint of your application. Similar to the code snippet, this file creates an instance of your model's input, uses the `Predict` method in the *.consumption.cs* file, and displays the result out to the console. 
- **\<MODEL-NAME\>.mbconfig**: The *.mbconfig* file for your model and generated training and consumption code. This is copied over from the class library project you originally added the machine learning project to.

### Web API

The Web API project template contains the following files:

- **Program.cs**: The entrypoint of your application. In this file, your application configures the `PredictionEnginePool` service using dependency injection, defines a single `/predict` endpoint, and starts your application to listen for incoming HTTP requests. As part of the `predict` endpoint definition, a handler is defined as well that uses the `PredictionEnginePool` service to make predictions on incoming JSON requests containing your model input data and returning the results of those predictions back to the client.
- **\<MODEL-NAME\>.mbconfig**: The *.mbconfig* file for your model and generated training and consumption code. This is copied over from the class library project you originally added the machine learning project to.

> [!IMPORTANT]
> The Web API project does not use the `Predict` method in the *.consumption.cs* file. Instead, it registers a `PredictionEnginePool` as a service using dependency injection.  `PredictionEngine` is not thread-safe. Additionally, you have to create an instance of it everywhere it is needed within your application. As your application grows, this process can become unmanageable. For improved performance and thread safety, use a combination of dependency injection and the `PredictionEnginePool` service, which creates an `ObjectPool` of `PredictionEngine` objects for use throughout your application.
>
> To learn more about dependency injection, see [dependency injection in ASP.NET Core](/aspnet/core/fundamentals/dependency-injection).

In the next unit, you'll consume your predictive maintenance model from a console application.