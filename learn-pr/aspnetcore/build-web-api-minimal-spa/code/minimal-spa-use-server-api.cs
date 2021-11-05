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
c.SwaggerEndpoint("/swagger/v1/swagger.json", "Pizza API V1");
});

app.UseCors(MyAllowSpecificOrigins);

app.MapGet("/", () => "Hello World!");

app.MapGet("/pizza", async(PizzaDb db) => await db.Pizzas.ToListAsync());

app.MapPost("/pizza", async(PizzaDb db, Pizza pizza) => {
await db.Pizzas.AddAsync(pizza);
await db.SaveChangesAsync();
return Results.Created($"/pizza/{pizza.Id}", pizza);
});

app.MapPut("/pizza/{id}", async (PizzaDb db, Pizza updatePizza, int id) =>
{
var pizzaItem = await db.Pizzas.FindAsync(id);
if (pizzaItem is null) return Results.NotFound();
pizzaItem.Name = updatePizza.Name;
pizzaItem.Description = updatePizza.Name;
await db.SaveChangesAsync();
return Results.NoContent();
});

app.MapDelete("/pizza/{id}", async (PizzaDb db, int id) =>
{
var todo = await db.Pizzas.FindAsync(id);
if (todo is null)
{
return Results.NotFound();
}
db.Pizzas.Remove(todo);
await db.SaveChangesAsync();
return Results.Ok();
 });
app.Run();
