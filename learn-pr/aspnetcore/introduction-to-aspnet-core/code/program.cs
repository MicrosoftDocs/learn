// <snippet_all>
var builder = WebApplication.CreateBuilder(args);

builder.Logging.ClearProviders();
builder.Logging.AddConsole();
builder.Logging.AddDebug();

var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.Run();
// </snippet_all>
