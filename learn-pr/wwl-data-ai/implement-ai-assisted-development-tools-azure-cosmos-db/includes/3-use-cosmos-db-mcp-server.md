The Contoso developer building the shopping assistant inherits a catalog someone else modeled. Before writing retrieval code, they need to know which containers exist, what top-level properties appear in the Product items, and whether real queries return the expected results. Connecting an AI assistant through a Model Context Protocol (MCP) server lets them investigate these questions in the same window where they write code. The schema-inference tool samples item structure, but it doesn’t inspect the container’s indexing, full-text, or vector policies. Verify those policies separately through Data Explorer, an SDK, or the resource definition.

## What the protocol provides

Model Context Protocol (MCP) is an open standard for exposing tools to AI models. A server advertises the operations it supports and the parameters each one takes; a client, such as an AI assistant in an editor or an agent in a hosted runtime, discovers that list and lets the model call the operations by name. The model chooses which tool fits the request and supplies the arguments; the server executes against the real resource.

For Azure Cosmos DB, the assistant therefore queries your container instead of guessing at its contents. Ask it about the shape of the `product` documents and it samples them. Ask it which products mention a term and it issues a real query and reports real results. The protocol is language-agnostic, so the same server serves an assistant helping with C# and one helping with Python.

## Configure the server for development

The Azure MCP Server ships through several channels, including a Visual Studio Code extension, an npm package, and a container image. The extension keeps itself updated, which makes it the simpler path for a developer workstation. To wire the server into a single project instead, add a `.vscode/mcp.json` file at the root of the folder:

```json
{
  "servers": {
    "Azure MCP Server": {
      "command": "npx",
      "args": ["-y", "@azure/mcp@3.0.0-beta.49", "server", "start"]
    }
  }
}
```

This form launches the server through `npx`, so it needs Node.js on your path. Use an active long-term support release; the current package requires Node.js 22 or later. Visual Studio Code reads this file directly, but other clients look elsewhere for their configuration, so check your client's documentation if the server doesn't appear.

Azure MCP Server authenticates by using the signed-in developer’s identity. Resource discovery through Azure Resource Manager requires an appropriate Azure role, such as Reader, at the relevant subscription, resource-group, or account scope. Reading Azure Cosmos DB items requires a separate Azure Cosmos DB native data-plane role assignment.

```bash
az login
```

Assign the Cosmos DB Built-in Data Reader role at the narrowest scope the developer needs. For example, scope access to the cosmicworks database rather than the entire account:

```bash
az cosmosdb sql role assignment create \
    --account-name <account-name> \
    --resource-group <resource-group> \
    --scope "/dbs/cosmicworks" \
    --principal-id <your-object-id> \
    --role-definition-id 00000000-0000-0000-0000-000000000001
```

This role covers the Azure Cosmos DB read operations used by the tools. Vector search also calls an Azure OpenAI embedding deployment, so the identity needs permission to invoke that deployment, such as the Cognitive Services OpenAI User role on the Azure OpenAI resource.

### What the assistant can do

The Azure Cosmos DB tools in the Azure MCP Server cover discovery, retrieval, and search.

| Tool | What it does |
|:-----|:-------------|
| List accounts, databases, or containers | Walks the hierarchy from subscription down to container |
| Query container items | Runs a query in the Azure Cosmos DB for NoSQL query language and returns matching documents |
| Get container item | Reads 1 document by ID, using the partition key when supplied |
| List recently modified container items | Returns the most recent documents ordered by the `_ts` system property |
| Search container items by text | Matches a phrase with `FullTextContains` against an indexed property |
| Search container items by vector similarity | Embeds your search text, then ranks documents with `VectorDistance` |
| Infer container schema | Samples documents and reports top-level properties with their inferred types |

A session against Contoso's catalog usually starts with schema inference, because it answers the shape question in one call, then moves to a query once the property names are known.

### Where the boundaries are

Every one of these Azure Cosmos DB tools is read-only, idempotent, and nondestructive. Nothing in the set inserts, updates, or deletes an item, and nothing provisions or reconfigures a resource. The server as a whole isn't read-only, because it carries tools for other Azure services that write, so start it with its read-only option enabled if you want that guarantee across every service it reaches.

Several tools also depend on configuration you own:

- **Text search requires a full-text index** on the property being searched. Matching is word-tokenized rather than substring based, and it applies the container's configured analyzer, so stemming and stop-word removal behave as they do in your own queries.
- **Vector search requires a vector index** on the target property, plus an Azure OpenAI embedding deployment for the server to convert your search text into a query vector. The query embedding must be compatible with the stored embeddings. Use the same embedding model and preprocessing and request the same vector dimensions defined by the container’s vector policy. A model or dimension mismatch can make the query fail or produce meaningless similarity results.
- **Schema inference reports top-level properties only.** Nested objects and arrays come back typed as `object` or `array` with no recursion, so finding the path to a nested vector property means to read an individual document.

That last constraint catches people. The inferred schema is a sample-based approximation of a schemaless container, not a contract. Two documents in the same container can carry different properties, and the tool reports how many sampled documents contained each one precisely because that variation is expected.

## Serve an agent in production

The Azure Cosmos DB MCP Toolkit answers the other half of the problem: an agent running in Azure, not an assistant running in an editor. You deploy it into your own subscription, where it runs as a container app that reaches Azure Cosmos DB through a managed identity and validates caller tokens issued by a Microsoft Entra ID application registration.

Its tool set overlaps the Azure MCP Server's and adds one operation the design-time server doesn't carry: `hybrid_search`, which combines vector similarity with full-text keyword matching and fuses the two ranked lists with Reciprocal Rank Fusion. Hybrid search can improve relevance when queries depend on both exact terms and semantic similarity, but validate its quality and cost against representative queries before choosing it over either signal alone.

A Microsoft Foundry agent connects to the deployed server through the tool catalog, authenticating with the project's managed identity against the application registration's client ID.

One security property deserves attention before you deploy it. Once the server's identity holds a data-plane role on the account, any caller who authenticates successfully can read every database and container in that account. Scope the identity's role assignment to the specific database or container the agent needs, rather than to the account root, and treat the list of principals allowed to call the server as a security boundary in its own right.
