The Contoso developer has several tools available and one assistant to build. Using every tool creates unnecessary dependencies and an architecture that’s difficult to operate. Ignoring all of them means rebuilding capabilities that existing tools already provide. Start from the requirement and select only the tools that address it.

## Match the tool to the need

Each tool has a primary purpose. Model Context Protocol (MCP) servers are among these tools.

| The need | The tool | Why |
|:---------|:---------|:----|
| Apply Azure Cosmos DB best practices while writing or reviewing code | Azure Cosmos DB Agent Kit | Supplies curated, on-demand guidance to an AI coding agent without accessing the database |
| Explore an unfamiliar container while writing code | Azure MCP Server | Runs in your editor, authenticates as you, read-only Azure Cosmos DB tools |
| Let a deployed agent query your data at run time | Azure Cosmos DB MCP Toolkit | Self-hosted MCP server with caller-token validation, managed identity, and vector, full-text, and hybrid search |
| Remember what a user said across messages and sessions | Agent Memory Toolkit | Public-preview SDK providing memory storage, extraction, summarization, reconciliation, and retrieval |
| Answer complex questions that span many documents | Agentic Retrieval | Iterative retrieval, with gap detection and optional diversity selection in its decomposed mode |
| Implement requirements that don’t fit an existing pattern | The Azure Cosmos DB SDK | Provides direct control over database operations and application architecture |

These tools can complement each other because they operate at different layers. The Agent Kit helps a coding agent produce and review Azure Cosmos DB designs and code. Agent Memory Toolkit supplies durable shopper context at application runtime. Agentic Retrieval supplies a more complex retrieval loop for questions that a single search can’t answer.

The two MCP servers usually serve different environments. Azure MCP Server primarily supports development and Azure resource exploration. Azure Cosmos DB MCP Toolkit is deployed for runtime agent access. Safe access doesn't automatically follow from MCP itself or an MCP server: the exposed tool set, the server configuration, the identity used to access Azure Cosmos DB, and the scope of its role assignments define the effective permission boundary.

The last row matters as much as the others. A tool that does 60 percent of what you need and blocks the other 40 percent costs more than the SDK would. When your requirements diverge from what a toolkit encodes, the toolkit is the wrong choice even though it's the closer fit.

## Separate the tool's scope from yours

Every tool in this set encodes decisions. It doesn't make them disappear, and the ones it doesn't encode remain yours whether or not you notice them.

**The tools own the pattern.** The memory toolkit packages conversation storage, memory derivation, and recall. The retrieval toolkit packages multi-step searches and answer synthesis. Adopting either means accepting a processing workflow and a set of callable methods. The two MCP servers in the table expose a defined set of database operations to a model, without Azure Cosmos DB writes.

**You own the data model.** Partition key choice, container layout, and item shape stay with you for anything the toolkit doesn't create. The memory toolkit provisions its own containers with a sensible hierarchical key, but the catalog those memories describe is yours to model, and the retrieval toolkit asks you for a partition key path per source rather than choosing one.

**You own cost and throughput.** Every database request, embedding request, model invocation, and reranking operation is billed through resources you own. When Agent Memory Toolkit provisions its topology, it creates three primary memory containers plus counter and lease containers, with hierarchical partition keys and its required vector and full-text policies. Its provisioning helper defaults cosmos_throughput_mode to serverless, which omits explicit container throughput, and it also supports an autoscale mode with a configured maximum throughput in request units per second. Select a mode compatible with the Azure Cosmos DB account and expected workload rather than assuming the toolkit automatically chooses the least expensive configuration. If you provision the containers yourself, their topology and policies must match the toolkit’s requirements.

Agentic Retrieval can run multiple retrieval and model-call rounds for one question, so its cost and latency can be substantially higher than a single query. Agent Memory Toolkit runs extraction, summaries, and reconciliation according to configurable cadence thresholds. Measure request charges, model-token usage, latency, and throughput under representative traffic before adopting either implementation for production.

**You own security scope.** Data-plane role assignments, the scope those assignments cover, and the list of principals allowed to call a deployed MCP server are yours. A deployed server whose identity holds a role at the account root can read every container in the account, including ones the agent shouldn't read.

**You own relevance and evaluation.** No tool tells you whether the answers are good. The retrieval toolkit ships a question file format that carries your ground-truth answers alongside the generated ones in a single batch output, precisely because judging output quality against your own corpus is work only you can do.

## Distinguish the tools from the SDK

A useful way to keep the boundary clear is to ask what each layer does with a request.

The **SDK** performs the operation you asked for. It has no opinion about why.

An **MCP server** exposes a defined set of tools to a model and executes the tool the model selects. A tool can wrap one SDK operation or orchestrate several operations and other services, such as generating an embedding before running a vector query. MCP supplies tool discovery and invocation; authentication, authorization, tool filtering, confirmation, and Azure role assignments provide the security controls.

A **toolkit** performs a sequence of operations that implement a pattern, including operations you didn't ask for explicitly. Writing a turn may trigger extraction, summarization, and contradiction resolution. That implicit work is both the value and the risk: the pattern arrives complete, and the model calls it makes are billed to you whether or not you noticed the threshold that fired them.

## A short decision path

Three questions resolve most cases.

- **Is the consumer a developer or an application?** A developer exploring data wants an MCP server. An application that needs a capability wants a toolkit or the SDK.
- **Does an existing pattern match your requirement closely?** If the memory taxonomy or the retrieval loop fits what you were about to build, adopt it. If the pattern immediately conflicts with your requirements, build on the SDK.
- **Can you afford the pattern's runtime cost?** Multi-step retrieval and per-turn extraction both trade money and latency for quality. Measure the trade before you commit to it.

Contoso's assistant comes out of that path with the Azure MCP Server during development, the memory toolkit for shopper context, and the retrieval toolkit only for the multi-product questions that a single search answers badly. Simple product lookups keep using a direct query, because nothing about them needs a retrieval loop.
