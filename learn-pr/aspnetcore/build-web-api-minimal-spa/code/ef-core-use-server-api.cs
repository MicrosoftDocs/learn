using Microsoft.EntityFrameworkCore;
using PizzaStore.Data;
using Microsoft.OpenApi.Models;
using PizzaStore.Models;

readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
var builder = WebApplication.CreateBuilder(args);
var connectionString = builder.Configuration.GetConnectionString("pizzas") ?? "Data Source=pizzas.db";

builder.Services.AddDbContext<PizzaDb>(options => options.UseSqlite(connectionString));
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
   c.SwaggerDoc("v1", new OpenApiInfo { Title = "Pizzas API", Description = "Pizza pizza", Version = "v1" });
});

builder.Services.AddCors(options =>
{
  options.AddPolicy(name: MyAllowSpecificOrigins,
    builder =>
    {
         builder.WithOrigins("*");
    });
});

var app = builder.Build();
app.UseSwagger();
app.UseSwaggerUI(c =>
{
&nbsp;&nbsp;c.SwaggerEndpoint("/swagger/v1/swagger.json", "Pizza API V1");
});

app.UseCors(MyAllowSpecificOrigins);

app.MapGet("/", () => "Hello World!");

app.MapGet("/pizza", async(PizzaDb db) => await db.Pizzas.ToListAsync());

app.MapPost("/pizza", async(PizzaDb db, Pizza pizza) => {
&nbsp;&nbsp;await db.Pizzas.AddAsync(pizza);
&nbsp;&nbsp;await db.SaveChangesAsync();
&nbsp;&nbsp;return Results.Created($"/pizza/{pizza.Id}", pizza);
});

app.MapPut("/pizza/{id}", async (PizzaDb db, Pizza updatePizza, int id) =>
{
&nbsp;&nbsp;var pizzaItem = await db.Pizzas.FindAsync(id);
&nbsp;&nbsp;if (pizzaItem is null) return Results.NotFound();
&nbsp;&nbsp;pizzaItem.Name = updatePizza.Name;
&nbsp;&nbsp;pizzaItem.Description = updatePizza.Name;
&nbsp;&nbsp;await db.SaveChangesAsync();
&nbsp;&nbsp;return Results.NoContent();
});

app.MapDelete("/pizza/{id}", async (PizzaDb db, int id) =>
{
&nbsp;&nbsp;var todo = await db.Pizzas.FindAsync(id);
&nbsp;&nbsp;if (todo is null)
&nbsp;&nbsp;{
&nbsp;&nbsp;&nbsp;&nbsp;return Results.NotFound();
&nbsp;&nbsp;}
&nbsp;&nbsp;db.Pizzas.Remove(todo);
&nbsp;&nbsp;await db.SaveChangesAsync();
&nbsp;&nbsp;return Results.Ok();
 });
app.Run();
