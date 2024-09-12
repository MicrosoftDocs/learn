// <snippet_all>
// <snippet_web_application_builder>
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
// </snippet_web_application_builder>

// <snippet_web_mapget>
app.MapGet("/", () => "Hello World!");
// </snippet_web_mapget>

app.Run();
// </snippet_all>
