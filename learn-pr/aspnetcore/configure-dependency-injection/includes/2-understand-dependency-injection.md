ASP.NET Core apps often have a need to access the same services across multiple components. For example, several components might need to access a service that fetches data from a database. ASP.NET Core users a built-in dependency injection (DI) container to manage the services that an app uses.

## Dependency injection and Inversion of Control (IoC)

The dependency injection pattern is a form of Inversion of Control (IoC). In the dependency injection pattern, a class receives its dependencies from external sources rather than creating them itself. This pattern decouples the class from the dependency, which makes code easier to test and maintain.

Consider the following *Program.cs* file:

```csharp
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using MyApp.Services;

var builder = WebApplication.CreateBuilder(args);
    
builder.Services.AddSingleton<PersonService>();
var app = builder.Build();

app.MapGet("/", 
    (PersonService personService) => 
    {
        return $"Hello, {personService.GetPersonName()}!";
    }
);
    
app.Run();
```

And the following *PersonService.cs* file:

```csharp
namespace MyApp.Services;

public class PersonService
{
    public string GetPersonName()
    {
        return "John Doe";
    }
}
```

To understand the code, start near the bottom of the *Program.cs* example with the `app.MapGet` line. This line maps a GET request to the root URL (`/`) to a delegate that returns a greeting message. The delegate's signature defines an `PersonService` parameter named `personService`. When the app runs and a client requests the root URL, the code inside the delegate *depends* on the `PersonService` service to get some text to include in the greeting message.

Where does the delegate get the `PersonService` service? It's implicitly provided by the service container. The `builder.Services.AddSingleton<PersonService>()` line tells the service container to create a new instance of the `PersonService` class when the app starts, and to provide that instance to any component that needs it.

Any component that needs the `PersonService` service can declare a parameter of type `PersonService` in its delegate signature. The service container will automatically provide an instance of the `PersonService` class when the component is created. The delegate doesn't create the `PersonService` instance itself, it just uses the instance that the service container provides.

## Interfaces and dependency injection

Registering a service like this is a good start, but it's not the best practice. It's better to register services using interfaces. This approach makes the code more flexible and easier to maintain.

Consider an interface for the `PersonService` class:

```csharp
public interface IPersonService
{
    string GetPersonName();
}
```

This interface defines the single method, `GetPersonName`, that returns a string. This `PersonService` class implements the `IPersonService` interface:

```csharp
public class PersonService : IPersonService
{
    public string GetPersonName()
    {
        return "John Doe";
    }
}
```

The registration in the `Program.cs` file changes to:

```csharp
builder.Services.AddSingleton<IPersonService, PersonService>();
```

This differs from the previous registration in two ways:

1. The service is registered using the `IPersonService` interface instead of the `PersonService` class.
1. The `PersonService` class is registered as the implementation of the `IPersonService` interface.

The `app.MapGet` line changes to:

```csharp
app.MapGet("/", 
    (IPersonService personService) => 
    {
        return $"Hello, {personService.GetPersonName()}!";
    }
);
```

Note the signature of the delegate now expects an `IPersonService` parameter instead of a `PersonService` parameter. When the app runs and a client requests the root URL, the service container provides an instance of the `PersonService` class because it's registered as the implementation of the `IPersonService` interface.

> [!TIP]
> Think of `IPersonService` as a contract. It defines the methods and properties that an implementation **must** have. The delegate wants an instance of `IPersonService`. It doesn't care at all about the underlying implementation, only that the instance has the methods and properties defined in the interface.

## Testing with dependency injection

Using interfaces makes it easier to test components in isolation. You can create a mock implementation of the `IPersonService` interface for testing purposes. When you register the mock implementation in the test, the service container provides the mock implementation to the component being tested.

For example, say that instead of returning a hard-coded string, the `GetPersonName` method in the `PersonService` class fetches the name from a database. To test the component that depends on the `IPersonService` interface, you can create a mock implementation of the `IPersonService` interface that returns a hard-coded string. The component being tested doesn't know the difference between the real implementation and the mock implementation.

Consider this XUnit test:

```csharp
using Xunit;
using Moq;
using MyApp.Services;

public class PersonServiceTests
{
    [Fact]
    public void GetPersonName_ReturnsName()
    {
        var mockPersonService = new Mock<IPersonService>();
        mockPersonService.Setup(service => service.GetPersonName()).Returns("Jane Doe");

        IPersonService personService = mockPersonService.Object;
        Assert.Equal("Jane Doe", personService.GetPersonName());
    }
}
```

In this test, a mock implementation of the `IPersonService` interface is created using the Moq library. The mock implementation returns a hard-coded string when the `GetPersonName` method is called. The test asserts that the `GetPersonName` method returns the expected string.
