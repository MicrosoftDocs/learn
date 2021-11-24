Azure Cosmos DB SQL API uses the already popular Structured Query Language (SQL) syntax to perform queries over semi-structured data. If you have performed queries in database platforms like MySQL or SQL, then you may already have some of the tools necessary to write queries in Azure Cosmos DB SQL API.

For this module, we will focus on a fictional container of **products** with the following structure:

| **Property** | **Value** |
| --- | --- |
| **id** | *String* &vert; *unique identifier* |
| **categoryId** | *String* &vert; *partition key* |
| **categoryName** | *String* |
| **sku** | *String* |
| **description** | *String* |
| **price** | *Number* |
| **tags** | *Array* &vert; *[ String id, String name ]* |

Here is an example of a JSON object that would be in this container:

```json
{
    "id": "86FD9250-4BD5-42D2-B941-1C1865A6A65E",
    "categoryId": "F3FBB167-11D8-41E4-84B4-5AAA92B1E737",
    "categoryName": "Components, Touring Frames",
    "sku": "FR-T67U-58",
    "name": "LL Touring Frame - Blue, 58",
    "description": "The product called \"LL Touring Frame - Blue, 58\"",
    "price": 333.42,
    "tags": [
        {
            "id": "764C1CC8-2E5F-4EF5-83F6-8FF7441290B3",
            "name": "Tag-190"
        },
        {
            "id": "765EF7D7-331C-42C0-BF23-A3022A723BF7",
            "name": "Tag-191"
        }
}
```
