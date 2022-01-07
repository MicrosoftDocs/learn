When you create a new container, you can specify the indexing policy at the point of creation using the CLI.

> [!NOTE]
> Remember, if you do not specify the indexing policy, the default policy will be used.

To create a new container with a custom index policy, you must use the **--idx** argument in one of two ways.

## JSON file

You can pass in the name of a JSON file with a custom index policy. Let's assume that you have an indexing policy defined in a file named **policy.json**.

```json
{
  "indexingMode": "consistent",
  "automatic": true,
  "includedPaths": [
    {
      "path": "/*"
    }
  ],
  "excludedPaths": [
    {
      "path": "/headquarters/*"
    },
    {
      "path": "/\"_etag\"/?"
    }
  ]
}
```

You only need to pass in the filename to the CLI command for the **--idx** argument.

```azurecli
az cosmosdb sql container create \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --partition-key-path '<partition-key-path-string>' \
    --idx '@.\policy.json' \
    --throughput '400'
```

## Raw JSON string

Alternatively, you can pass in a raw JSON string with the indexing policy defined. This example uses the same JSON indexing policy defined as a minified string:

```azurecli
az cosmosdb sql container create \
    --account-name '<account-name>' \
    --resource-group '<resource-group>' \
    --database-name '<database-name>' \
    --name '<container-name>' \
    --partition-key-path '<partition-key-path-string>' \
    --idx '{\"indexingMode\":\"consistent\",\"automatic\":true,\"includedPaths\":[{\"path\":\"/*\"}],\"excludedPaths\":[{\"path\":\"/headquarters/*\"},{\"path\":\"/\\\"_etag\\\"/?\"}]}' \
    --throughput '400'
```

> [!TIP]
> If you are planning to use a raw JSON string with the **--idx** argument, you should read up on your shell's specific behavior around escaping and processing strings. Common shells like Bash and PowerShell can have wildly different behaviors when processing JSON string literals.
