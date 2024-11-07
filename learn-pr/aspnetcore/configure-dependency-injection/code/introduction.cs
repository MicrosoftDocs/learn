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
