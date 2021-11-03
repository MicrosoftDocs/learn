In this exercise, we will do two things. First we will move out the static data from the app and into a mock server. Secondly, once that is working, we will use the actual server.

## Use a mock server

At this point, you have a frontend app with static data inside of the app. You want to move out the static data into a mock server, while waiting for the backend team to finish building the API. Performing this step will set you up nicely for using the actual API, once it's done.

1. In _Main.js_, locate this part of the code and cut it out:

   ```javascript
   let pizza = [{
      id: 1, name: 'Cheese pizza', description: 'very cheesy'
    },
    {
      id: 2, name: 'Al Tono pizza', description: 'lots of tuna'
    }];
   ```

   Next, you will move that into a JSON file _db.json_

1. Create a file _db.json_ and give it the following content:

   ```json
   {
     "pizza" : [{
        "id": 1, 
        "name": "Cheese pizza", 
        "description": "very cheesy"
      },
      {
        "id": 2, 
        "name": "Al Tono pizza", 
        "description": "lots of tuna"
      }]
   }
   ```

   What you are looking at is a JSON representation of your JavaScript array.

1. Locate the definition of your `Main` component in _Main.js_ and change it to the following code:

   ```javascript
   const Main = () => {
      useEffect(() => {
        fetchData();
      }, [])
      
      function fetchData() {
        fetch("/api/pizza")
          .then(response => response.json())
          .then(data => setPizzas(data)) 
      }
    
      const data = pizzas.map(pizza => <Pizza pizza={pizza} />)
    
      return (<React.Fragment>
        {pizzas.length === 0 ?
         <div>No pizzas</div> :
         <div>{data}</div>
        }
      </React.Fragment>)
        
      </React.Fragment>)
    }
   ```

   Also change the import at the top from:

   ```javascript
   import React, { useState } from "react";
   ```

   To:

   ```javascript
   import React, { useState, useEffect } from "react";
   ```

   The method `fetchData()` has been added, and it's being invoked which triggers a GET request to "http://localhost:5000/pizzas". Next, we need to ensure the mock server is up and running.

1. Run `npx json-server --watch --port 5000 db.json` in a separate terminal:

   This should bring up the mock server and you should see an output looking like so:

   ```output
   \{^_^}/ hi!
   Loading db.json
   Done
    
   Resources
   http://localhost:5000/pizza
    
   Home
   http://localhost:5000
   ```

1. In another terminal, run `yarn start`, it should bring up your React app:

   ```bash
   yarn start
   ```

   Your app should render like normal at "http://localhost:3000". Great, let's add a proxy next.

1. Add a proxy by opening up _package.json_ and the following entry:

   ```json
   "proxy": "http://localhost:5000"    
   ```

   Any calls to "/api/" will be translated as calling "http://localhost:5000".

1. Restart your app with `yarn start`:

   ```bash
   yarn start
   ```

   Your app should start as normal on "http://localhost:5000".

## Use the server API

At this point, the backend team has finished building the server. To use the server, you just need to fetch the code from GitHub and run it. You might need to configure CORS as well.

1. Clone the backend project by running `git clone`:

   ```bash
   cd ..
   git clone https://github.com/MicrosoftDocs/minimal-api-work-with-databases
   cd minimal-api-work-with-databases
   cd PizzaStore
   ```

1. In a terminal run `dotnet ef database` to apply the migrations that will create a database with tables.

   ```bash
   dotnet ef database update
   ```

1. Open up _Program.cs_ and add the following code to enable CORS, (code you need to add is in bold):

   <pre>
   using Microsoft.EntityFrameworkCore;
   using PizzaStore.Data;
   using Microsoft.OpenApi.Models;
   using PizzaStore.Models;

   <b>readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";</b>
   var builder = WebApplication.CreateBuilder(args);
   var connectionString = builder.Configuration.GetConnectionString("pizzas") ?? "Data Source=pizzas.db";

   builder.Services.AddDbContext<PizzaDb>(options => options.UseSqlite(connectionString));
   builder.Services.AddEndpointsApiExplorer();
   builder.Services.AddSwaggerGen(c =>
   {
      c.SwaggerDoc("v1", new OpenApiInfo { Title = "Pizzas API", Description = "Pizza pizza", Version = "v1" });
   });

   <b>
   builder.Services.AddCors(options =>
   {
     options.AddPolicy(name: MyAllowSpecificOrigins,
       builder =>
       {
            builder.WithOrigins("*");
       });
   });
   </b>

   var app = builder.Build();
   app.UseSwagger();
   app.UseSwaggerUI(c =>
   {
   &nbsp;&nbsp;c.SwaggerEndpoint("/swagger/v1/swagger.json", "Pizza API V1");
   });

   <b>app.UseCors(MyAllowSpecificOrigins);</b>

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
   </pre>

   The changes will configure CORS, so that you will be able to read and write towards the API, despite the frontend and backend running on different ports.

1. Start your API with `dotnet run` (Ensure you quit JSON server first)

   The server runs on port 5059. You will need to adjust the proxy in _package.json_ for the frontend app to match the port the server assumes.

   Your frontend should show one item with the title, "Pepperoni" .

Congratulations, you've managed to create a full stack application with a frontend and backend part.
