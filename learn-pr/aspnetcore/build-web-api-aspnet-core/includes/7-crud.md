The retailer's storefront UI should display all products in the inventory. To fulfill such a requirement, an action responding to an HTTP GET action verb is needed.

The following table depicts the relationship between HTTP action verbs, CRUD operations, and ASP.NET Core attributes. For example, an HTTP PUT action verb is most often used to support an update operation. Such an action is annotated with the `[HttpPut]` attribute.

|HTTP action verb|CRUD operation|ASP.NET Core attribute|
|----------------|--------------|----------------------|
|POST            |Create        |`[HttpPost]`          |
|GET             |Read          |`[HttpGet]`           |
|PUT             |Update        |`[HttpPut]`           |
|DELETE          |Delete        |`[HttpDelete]`        |

In addition to the action verbs in the preceding table, a web API in ASP.NET Core supports HEAD, OPTIONS, and PATCH.

The following sections demonstrate how to support each of these four actions in the web API.


// more stuff here?