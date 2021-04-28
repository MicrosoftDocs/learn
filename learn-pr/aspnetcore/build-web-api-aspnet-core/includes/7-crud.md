The retailer's storefront UI should display all products in the inventory. To fulfill such a requirement, an action responding to an HTTP GET action verb is needed.

The following table depicts the relationship between HTTP action verbs, CRUD operations, and ASP.NET Core attributes. For example, an HTTP PUT action verb is most often used to support an update operation. Such an action is annotated with the `[HttpPut]` attribute.

|HTTP action verb|CRUD operation|ASP.NET Core attribute|
|----------------|--------------|----------------------|
|POST            |Create        |`[HttpPost]`          |
|GET             |Read          |`[HttpGet]`           |
|PUT             |Update        |`[HttpPut]`           |
|DELETE          |Delete        |`[HttpDelete]`        |

In addition to the action verbs in the preceding table, a web API in ASP.NET Core supports HEAD, OPTIONS, and PATCH.

## POST

To enable the endpoint to have the ability for users to add pizza, we must implement the POST action using the [HttpPost]. By passing a Pizza into the method as a parameter, ASP.NET Core will automatically convert any application/json that is sent to the endpoint into a Pizza object.

```csharp
```

## PUT 

Modifying or updating a pizza in our inventory is similar to the POST method we implemented, but will use the [HttpPut] attribute and take in the id in addition to the Pizza object that needs to be updated.

```csharp
```

## DELETE
One of the easier actions to implement is the DELETE action that takes in just the id of the pizza to remove from the in-memory cache.

```csharp
//Code sample
```

The following sections demonstrate how to support each of these four actions in the web API.
