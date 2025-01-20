Testing is an essential part of developing high-quality software. Testing can help you find and fix bugs, improve performance, and ensure that your code meets the requirements and expectations of your users. Testing can also help you automate the deployment process and prevent regressions in the future. .NET Aspire provides tools and libraries to simplify the development, testing, and deployment of distributed applications. 

In this unit, you learn how to test .NET Aspire projects using xUnit, a popular testing framework for .NET. You learn how to create different types of tests, such as integration tests and functional tests, and how to run them using the .NET Aspire CLI or Visual Studio. 

## Create a test project 

The easiest way to create a .NET Aspire test project is to use the testing project template. You can use the `dotnet new` command to create a standard class library project, and then add the references to the .NET Aspire testing libraries and the xUnit packages.

```dotnetcli
dotnet new aspire-xunit
```

## Explore the test project 

The following example test project was created as part of the **.NET Aspire Starter Application** template. If you're unfamiliar with it, see [Quickstart: Build your first .NET Aspire project](/dotnet/aspire/get-started/build-your-first-aspire-app). The .NET Aspire test project takes a project reference dependency on the target app host. Consider the template project:

```xml
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <ImplicitUsings>enable</ImplicitUsings>
    <Nullable>enable</Nullable>
    <IsPackable>false</IsPackable>
    <IsTestProject>true</IsTestProject>
  </PropertyGroup>


  <ItemGroup>
    <PackageReference Include="Aspire.Hosting.Testing" Version="8.1.0" />
    <PackageReference Include="coverlet.collector" Version="6.0.2" />
    <PackageReference Include="Microsoft.NET.Test.Sdk" Version="17.11.0" />
    <PackageReference Include="xunit" Version="2.9.0" />
    <PackageReference Include="xunit.runner.visualstudio" Version="2.8.2" />
  </ItemGroup>

  <ItemGroup>
    <ProjectReference Include="..\AspireApp.AppHost\AspireApp.AppHost.csproj" />
  </ItemGroup>

  <ItemGroup>
    <Using Include="System.Net" />
    <Using Include="Microsoft.Extensions.DependencyInjection" />
    <Using Include="Aspire.Hosting.ApplicationModel" />
    <Using Include="Aspire.Hosting.Testing" />
    <Using Include="Xunit" />
  </ItemGroup>

</Project>
```

The preceding project file is fairly standard. There's a `PackageReference` to the [Aspire.Hosting.Testing](https://www.nuget.org/packages/Aspire.Hosting.Testing) NuGet package, which includes the required types to write tests for .NET Aspire projects.

The template test project includes a `WebTests` class with a single test. The test verifies the following scenario:

- The app host is successfully created and started.
- The `webfrontend` resource is available and running.
- An HTTP request can be made to the `webfrontend` resource and returns a successful response (HTTP 200 OK).

Consider the following test class:

```csharp
namespace AspireApp.Tests;

public class WebTests
{
    [Fact]
    public async Task GetWebResourceRootReturnsOkStatusCode()
    {
        // Arrange
        var appHost = await DistributedApplicationTestingBuilder
            .CreateAsync<Projects.AspireApp_AppHost>();

        appHost.Services.ConfigureHttpClientDefaults(clientBuilder =>
        {
            clientBuilder.AddStandardResilienceHandler();
        });

        await using var app = await appHost.BuildAsync();

        var resourceNotificationService = app.Services
            .GetRequiredService<ResourceNotificationService>();
        
        await app.StartAsync();

        // Act
        var httpClient = app.CreateHttpClient("webfrontend");

        await resourceNotificationService.WaitForResourceAsync(
                "webfrontend",
                KnownResourceStates.Running
            )
            .WaitAsync(TimeSpan.FromSeconds(30));
        
        var response = await httpClient.GetAsync("/");

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
    }
}
```

The preceding code:

- Relies on the `DistributedApplicationTestingBuilder` to asynchronously create the app host.
  - The `appHost` is an instance of `IDistributedApplicationTestingBuilder` that represents the app host.
  - The `appHost` instance has its service collection configured with the standard HTTP resilience handler. For more information, see [Build resilient HTTP apps: Key development patterns](/dotnet/core/resilience/http-resilience).
- The `appHost` has its `BuildAsync` method invoked, which returns the `DistributedApplication` instance as the `app`.
  - The `app` has its service provider get the <xref:Aspire.Hosting.ApplicationModel.ResourceNotificationService> instance.
  - The `app` is started asynchronously.
- An `HttpClient` is created for the `webfrontend` resource by calling `app.CreateHttpClient`.
- The `resourceNotificationService` is used to wait for the `webfrontend` resource to be available and running.
- A simple HTTP GET request is made to the root of the `webfrontend` resource.
- The test asserts that the response status code is `OK`.
