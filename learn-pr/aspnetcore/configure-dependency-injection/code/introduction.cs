#region snippet_program
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
#endregion

#region snippet_personservice
namespace MyApp.Services;

public class PersonService
{
    public string GetPersonName()
    {
        return "John Doe";
    }
}
#endregion

#region snippet_personserviceinterface
public interface IPersonService
{
    string GetPersonName();
}
#endregion

#region snippet_personserviceimplementation
internal sealed class PersonService : IPersonService
{
    public string GetPersonName()
    {
        return "John Doe";
    }
}
#endregion

#region snippet_programinterfaces
var builder = WebApplication.CreateBuilder(args);
    
builder.Services.AddSingleton<IPersonService, PersonService>();
var app = builder.Build();

app.MapGet("/", 
    (IPersonService personService) => 
    {
        return $"Hello, {personService.GetPersonName()}!";
    }
);
    
app.Run();
#endregion

#region snippet_test_program
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<IPersonService, PersonService>();

var app = builder.Build();

app.MapGet("/", (IPersonService personService) =>
{
    return $"Hello, {personService.GetPersonName()}!";
});

app.Run();
#endregion

#region snippet_test_personservice
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using MyWebApp;
using System.Net;

public class GreetingApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly WebApplicationFactory<Program> _factory;

    public GreetingApiTests(WebApplicationFactory<Program> factory)
    {
        _factory = factory;
    }

    [Fact]
    public async Task GetGreeting_ReturnsExpectedGreeting()
    {
        //Arrange
        var mockPersonService = new Mock<IPersonService>();
        mockPersonService.Setup(service => service.GetPersonName()).Returns("Jane Doe");

        var client = _factory.WithWebHostBuilder(builder =>
        {
            builder.ConfigureServices(services =>
            {
                services.AddSingleton(mockPersonService.Object);
            });
        }).CreateClient();

        // Act
        var response = await client.GetAsync("/");
        var responseString = await response.Content.ReadAsStringAsync();

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Equal("Hello, Jane Doe!", responseString);
    }
}
#endregion