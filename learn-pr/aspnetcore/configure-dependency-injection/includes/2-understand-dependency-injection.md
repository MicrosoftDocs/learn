ASP.NET Core apps often need to access the same services across multiple components. For example, several components might need to access a service that fetches data from a database. ASP.NET Core uses a built-in dependency injection (DI) container to manage the services that an app uses.

## Dependency injection and Inversion of Control (IoC)

The dependency injection pattern is a form of Inversion of Control (IoC). In the dependency injection pattern, a component receives its dependencies from external sources rather than creating them itself. This pattern decouples the code from the dependency, which makes code easier to test and maintain.

Consider the following *Program.cs* file:

:::code language="csharp" source="~/../aspnetcore-snippets/learn-pr/aspnetcore/configure-dependency-injection/introduction.cs" id="snippet_program" highlight="8,11-16":::

And the following *PersonService.cs* file:

:::code language="csharp" source="~/../aspnetcore-snippets/learn-pr/aspnetcore/configure-dependency-injection/introduction.cs" id="snippet_personservice":::

To understand the code, start with the highlighted `app.MapGet` code. This code maps HTTP GET requests for the root URL (`/`) to a delegate that returns a greeting message. The delegate's signature defines an `PersonService` parameter named `personService`. When the app runs and a client requests the root URL, the code inside the delegate *depends* on the `PersonService` service to get some text to include in the greeting message.

Where does the delegate get the `PersonService` service? It's implicitly provided by the service container. The highlighted `builder.Services.AddSingleton<PersonService>()` line tells the service container to create a new instance of the `PersonService` class when the app starts, and to provide that instance to any component that needs it.

Any component that needs the `PersonService` service can declare a parameter of type `PersonService` in its delegate signature. The service container will automatically provide an instance of the `PersonService` class when the component is created. The delegate doesn't create the `PersonService` instance itself, it just uses the instance that the service container provides.

## Interfaces and dependency injection

To avoid dependencies on a specific service implementation, you can instead configure a service for a specific interface and then depend just on the interface. This approach gives you the flexibility to swap out the service implementation, which makes the code more testable and easier to maintain.

Consider an interface for the `PersonService` class:

:::code language="csharp" source="~/../aspnetcore-snippets/learn-pr/aspnetcore/configure-dependency-injection/introduction.cs" id="snippet_personserviceinterface":::

This interface defines the single method, `GetPersonName`, that returns a `string`. This `PersonService` class implements the `IPersonService` interface:

:::code language="csharp" source="~/../aspnetcore-snippets/learn-pr/aspnetcore/configure-dependency-injection/introduction.cs" id="snippet_personserviceimplementation":::

Instead of registering the `PersonService` class directly, you can register it as an implementation of the `IPersonService` interface:

:::code language="csharp" source="~/../aspnetcore-snippets/learn-pr/aspnetcore/configure-dependency-injection/introduction.cs" id="snippet_programinterfaces" highlight="3,7":::

This example *Program.cs* differs from the previous example in two ways:

- The `PersonService` instance is registered as an *implementation* of the `IPersonService` interface (as opposed to registering the `PersonService` class directly).
- The delegate signature now expects an `IPersonService` parameter instead of a `PersonService` parameter.

When the app runs and a client requests the root URL, the service container provides an instance of the `PersonService` class because it's registered as the implementation of the `IPersonService` interface.

> [!TIP]
> Think of `IPersonService` as a contract. It defines the methods and properties that an implementation **must** have. The delegate wants an instance of `IPersonService`. It doesn't care at all about the underlying implementation, only that the instance has the methods and properties defined in the contract.

## Testing with dependency injection

Using interfaces makes it easier to test components in isolation. You can create a mock implementation of the `IPersonService` interface for testing purposes. When you register the mock implementation in the test, the service container provides the mock implementation to the component being tested.

For example, say that instead of returning a hard-coded string, the `GetPersonName` method in the `PersonService` class fetches the name from a database. To test the component that depends on the `IPersonService` interface, you can create a mock implementation of the `IPersonService` interface that returns a hard-coded string. The component being tested doesn't know the difference between the real implementation and the mock implementation.

Also suppose your app maps an API endpoint that returns a greeting message. The endpoint depends on the `IPersonService` interface to get the name of the person to greet. The code that registers the `IPersonService` service and maps the API endpoint might look like this:

:::code language="csharp" source="~/../aspnetcore-snippets/learn-pr/aspnetcore/configure-dependency-injection/introduction.cs" id="snippet_test_program" highlight="3,7-10":::

This is similar the previous example with `IPersonService`. The delegate expects an `IPersonService` parameter, which the service container provides. As mentioned earlier, assume that the `PersonService` that implements the interface fetches the name of the person to greet from a database.

Now consider the following XUnit test that tests the same API endpoint:

> [!TIP]
> Don't worry if you're not familiar with XUnit or Moq. Writing unit tests is outside the scope of this module.  This example is just to illustrate how dependency injection can be used in testing.
    
:::code language="csharp" source="~/../aspnetcore-snippets/learn-pr/aspnetcore/configure-dependency-injection/introduction.cs" id="snippet_test_personservice" highlight="20-21,27":::

The preceding test:

- Creates a mock implementation of the `IPersonService` interface that returns a hard-coded string.
- Registers the mock implementation with the service container.
- Creates an HTTP client to make a request to the API endpoint.
- Asserts that the response from the API endpoint is as expected.

The test doesn't care how the `PersonService` class gets the name of the person to greet. It only cares that the name is included in the greeting message. The test uses a mock implementation of the `IPersonService` interface to isolate the component being tested from the real implementation of the service. 
