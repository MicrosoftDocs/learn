In the previous exercise, you registered services using the singleton service lifetime. In a code review, your team lead asks you to investigate the differences between the **singleton**, **scoped**, and **transient** service lifetimes.

## Test the singleton service lifetime

1. The app should still be running from the previous exercise. If it's not, run the app as before.
1. Refresh the browser window and note the time displayed in the welcome message.
1. Wait a few seconds, and then refresh the browser window again. The welcome message doesn't change. The timestamp and GUID remain the same.

    The time and GUID displayed in the welcome message don't change because the `WelcomeService` service is registered as a Singleton service. The service is created once when the app starts and is reused for the lifetime of the app. Every request, from every client, uses the same instance of the service. No other instance of the service is created.

1. Stop the app by pressing **Shift+F5** in Visual Studio Code.

## Test the scoped service lifetime

To understand the scoped service lifetime, you need to change how the `WelcomeService` service is registered.

1. In the *Program.cs* file, change the registration of the `WelcomeService` service to use the scoped service lifetime:

    ```csharp
    builder.Services.AddScoped<IWelcomeService, WelcomeService>();
    ```

    This code registers the `WelcomeService` class with the service container with a scoped lifetime.

1. Run the app as before.
1. Note the time and GUID displayed in the welcome message. Refresh the browser window and note that the time changes every time and the GUID is different each time.

    The data displayed in the welcome message changes because the `WelcomeService` service is now registered as a scoped service. The service is created once per client request and is disposed of when the request is completed. Every request, from every client, uses a new instance of the service.

1. Stop the app by pressing **Shift+F5** in Visual Studio Code.

1. Let's examine the behavior of the scoped service lifetime when attempting to use two instances of the same `WelcomeService` service on the same request. Change the `app.MapGet()` line to the following code:

    ```csharp
    app.MapGet("/", async (IWelcomeService welcomeService1, IWelcomeService welcomeService2) => 
        {
            string message1 = $"Message1: {welcomeService1.GetWelcomeMessage()}";
            string message2 = $"Message2: {welcomeService2.GetWelcomeMessage()}";
            return $"{message1}\n{message2}";
        });
    ```

    In the preceding code:

    - The `app.MapGet()` delegate now has two parameters of type `IWelcomeService`. The delegate generates two welcome messages, one for each service instance.
    - The delegate returns both messages in a single response.

1. Run the app as before. Observe that even though the two welcome messages are generated at different times, and they were passed to the delegate as separate parameters, the messages are identical.

    This behavior is because the `WelcomeService` service is registered as a *scoped* service. The service is created once per client request, and the same instance is provided to all components that need it during the same request. `welcomeService1` and `welcomeService2` are both references to the same instance of the `WelcomeService` service.

1. Refresh the page a few times. Observe that the timestamp and GUID in the welcome messages change each time, but the two messages are always identical.
1. Stop the app by pressing **Shift+F5** in Visual Studio Code.

## Test the transient service lifetime

Now let's examine the transient service lifetime.

1. Change the registration of the `WelcomeService` service to use the transient service lifetime:

    ```csharp
    builder.Services.AddTransient<IWelcomeService, WelcomeService>();
    ```

    This code registers the `WelcomeService` class with the service container with a transient lifetime.

1. Run the app as before. The time in both messages remains the same because both instances of the `WelcomeService` service are created at the same time. However, the GUID in each message is different because each instance of the service is unique.

    This behavior is representative of the transient service lifetime. Every time the service is injected into a component, a new instance of the service is created. Since it's injected into the delegate twice, two instances of the service are created.

1. Refresh the page a few times. Each time you refresh the page, the timestamp is always the same across both messages, but the GUID in each message is different.
1. Stop the app by pressing **Shift+F5** in Visual Studio Code.    
