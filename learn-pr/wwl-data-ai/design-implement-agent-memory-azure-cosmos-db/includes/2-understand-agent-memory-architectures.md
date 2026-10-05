An agent that remembers is an agent with a second data store behind it. In this unit, you separate the two kinds of memory that store holds, name the record types worth writing, and lay out the containers and partition keys that make both retrievable.

## Separate what the conversation needs from what the user needs

Agent memory divides along a line that has nothing to do with storage technology and everything to do with lifespan.

**Short-term memory** is the current conversation: the last several turns, the tool results those turns produced, and the intermediate state of whatever task is in progress. It's high volume. It's only interesting while the thread is open, and its value drops to near zero once the thread ends. Contoso's assistant needs it to answer *does it run longer on a charge* without asking what *it* refers to.

**Long-term memory** is what remains true after the conversation closes. Preferences, constraints, decisions, and the shape of past interactions. It's low volume. It accumulates across every thread a person ever opens, and its value is highest at the *start* of a session, before the user says anything. That the shopper rides a touring bike and requires lights that run for at least eight hours per charge is worth three sentences of storage and saves two turns of questioning every session.

The line matters because the two behave in opposite ways under every design decision you make next.

| Characteristic | Short-term | Long-term |
| :--- | :--- | :--- |
| Volume | High, grows with every message | Low, grows with every distinct fact |
| Scope | 1 thread | 1 user, across all threads |
| Retrieval | Recent-first, ordered | Relevance-first, by meaning |
| Lifetime | Days to weeks | Until contradicted or erased |
| Written by | The application, on every turn | A distillation step, on a cadence |

Short-term memory is a log. Long-term memory is a profile derived from that log. Treating them as one store gives you the worst of both: a profile you have to scan a log to build, and a log you can't expire because the profile lives inside it.

:::image type="content" source="../media/memory-tiers-split.png" alt-text="Diagram of two panels comparing short-term conversation state with long-term derived memory, and the container and partition key each one gets." lightbox="../media/memory-tiers-split.png":::

## Name the record types worth writing

*Memory* covers several record types with different production costs and different recall value. The Agent Memory Toolkit for Azure Cosmos DB ships a taxonomy worth borrowing whether or not you use the toolkit, because each type answers a question the others answer badly.

| Type | What it holds | Answers |
| :--- | :--- | :--- |
| `turn` | 1 raw message from a user, agent, tool, or system | *What was said?* |
| `fact` | 1 discrete assertion distilled from a thread | *What's true about this person?* |
| `episodic` | A bounded stretch of interaction treated as 1 episode | *What happened, and how did it go?* |
| `thread_summary` | A compact summary of 1 conversation | *What was that conversation about?* |
| `user_summary` | A cross-thread profile for 1 user | *Who is this user, before they say anything?* |
| `procedural` | A rule about how to work with this user | *How should I behave here?* |

Facts are the main record type. They're small, independently retrievable, and independently correctable, which matters because people change their minds. Summaries trade precision for coverage: one `user_summary` gives an opening context injection that costs a single point read instead of a search. Episodic records preserve the shape of an interaction, including that a recommendation was refused, which no fact captures on its own.

An episodic record describes a bounded experience through a title, a timeline of events, an optional outcome, and lessons. Facts and episodes carry a confidence score from 0 through 1. That score lets retrieval filter weakly grounded records instead of treating an inference as equivalent to an explicit user statement.

> [!NOTE]
> The Agent Memory Toolkit is in preview and is provided without a service-level agreement. Its taxonomy is also ahead of its documentation: the overview page lists four types, and the shipped package defines the six in the table, adding `procedural` and `episodic`. The page also names the per-thread summary type `summary`, which the package rejects. The accepted value is `thread_summary`. Read the type list from the package you install rather than from the table.

The important design property is that every type except `turn` is *derived*. Turns arrive from the conversation. A distillation step you schedule produces everything else, which means memory quality is something you control rather than something the conversation hands you.

## Lay out containers and partition keys

Two questions decide the physical design: what shares a container, and what shares a logical partition.

Group by lifecycle, not by topic. Raw turns expire on a schedule and are read in thread order. Derived memories persist, are read by similarity, and carry vectors. Putting both in one container forces one time-to-live setting, one indexing policy, and one vector policy onto records with opposite needs. The toolkit's layout makes the split explicit, with turns in `memories_turns`, the derived facts, episodes, and procedures in `memories`, and the two summary types in `memories_summaries`.

Those three toolkit containers use hierarchical `/user_id` and `/thread_id` partition keys. The summary container also stores vectors for search. Two supporting containers complete the layout: `counter` tracks turn counts per thread and per user, and `leases` supports change feed processing. These five containers use the toolkit's schema, distinct from the application-owned containers in the examples that follow.

For the partition key, the [agent memories guidance](/azure/cosmos-db/gen-ai/agentic-memories) sets out three choices, and the right one follows from the query you run most.

- **A unique value per item**, typically a globally unique identifier. Writes spread perfectly and nothing is colocated, so every read fans out. Reasonable for an append-only turn log you analyze in bulk and rarely replay.
- **The thread identifier.** Every turn in a conversation lands in one logical partition, so *the last N turns of this thread* is a single-partition query. The thread identifier is the right default for conversation state, provided you have enough concurrent threads to spread the write load.
- **A hierarchy**, such as tenant then thread, or user then thread. Locality within a thread is preserved, and a prefix query still reaches everything for one tenant or one user efficiently.

Long-term memory inverts the choice. Its whole purpose is recall across threads for one person, so the thread identifier is the wrong key: it scatters a user's facts across as many partitions as there are conversations for that user. Partition long-term memory on the user, or use a hierarchy whose first level is the user.

Hierarchical keys go up to three levels and are declared with `kind` set to `MultiHash`. They aren't a free upgrade: the Azure CLI's `az cosmosdb sql container create` takes a single `--partition-key-path` value, so a hierarchical key comes from the portal, an SDK call, or an Azure Resource Manager template rather than from that command.

One constraint applies to every layout. Creating a database or a container is a control-plane operation, and the [data-plane security reference](/azure/cosmos-db/reference-data-plane-security) lists no action that grants it. On an account with key-based authentication disabled, application code holding a data-plane role can write memories but can't create the containers that hold them. Provision the memory store as infrastructure, and let the agent connect to it.
