Contoso's search box accepts whatever a shopper types. Some of that input is a product name. Some of it describes a need, and one box has to serve both. In this unit, you match a retrieval method to the query it answers and the text it runs against, and you decide when running two methods is worth what it costs.

## Compare what each method scores on

Full-text search and vector search rank the same items, and they rank them on different evidence.

BM25 scores an item on the terms it contains: how often a term appears, how rare that term is across the container, and how long the text is, which makes it precise on exact strings. A part designation, a model name, or a rare word gives BM25 a strong signal, and the score is explainable, because you can point at the terms that produced it.

Vector search scores an item on the distance between its embedding and the query's embedding, which makes it tolerant of vocabulary. A shopper and a catalog can describe the same object with no words in common, and the two embeddings still sit close together.

Each strength has a matching structural limit, and the limits are what decide most designs.

| Characteristic | Full-text search | Vector search |
| :--- | :--- | :--- |
| Ranks on | Term frequency, term rarity, text length | Distance between embeddings |
| Strong for | Exact names, identifiers, rare terms | Paraphrase, synonyms, described intent |
| Can't do | Match a concept whose words are absent from the text | Guarantee an exact token match |
| Needs at query time | Nothing beyond the query text | A query vector, generated or reused from a cache |
| Explains itself | The matched terms are visible | The distance is a number with no reasons |

The Contoso catalog demonstrates both limits. It holds three items in the *Accessories, Lights* category, and no product name or category name in all 295 products contains the word *see* or the word *night*. A shopper who types *something to see the road at night* gives BM25 one usable term, *road*, which 96 items carry. Vector search reaches the three lights, because the phrase and the products describe the same purpose.

Reverse the query, and the advantage moves with it. The catalog holds four size variants of *Touring-1000 Blue*, all at the same price and all differing by two characters. A shopper who types one of those names gives BM25 exactly the terms it needs. An embedding of that name sits almost equally close to all four, because the strings almost are the same string.

## Match the method to the query and the text

Two inputs drive the decision, and teams usually consider only the first one.

The **query shape** is the visible input. Short identifier-like input is a keyword problem. Descriptive natural-language input is a semantic problem. Input you can't characterize, which is what a public search box receives, is a hybrid problem.

The **shape of the indexed text** is the input that decides whether either method can work at all, and it deserves the same scrutiny you give a partition key.

### Audit the text before you index or embed it

Keyword search can only return items whose indexed text carries the query's terms, so the full-text path defines the ceiling on what keyword search can ever find. The Contoso catalog indexes a `searchText` property built from the product name and its category. Product SKUs live in a separate `sku` property that the full-text policy doesn't cover, so no keyword query against `searchText` retrieves a product by SKU, however well the query is written. That design decision is about the indexed path, not a tuning problem.

Embedding quality follows the same rule, and it fails more quietly. The CosmicWorks `description` property looks like the obvious text to embed. Every one of the 295 descriptions is the same generated sentence with the product name substituted into it, and a check against the raw data finds zero exceptions. The repeated wording adds little descriptive information, but the product names still provide lexical and semantic signal. An embedding represents the whole input text, not a separate fragment for each word. To include category context as well, the catalog builds `searchText` from the name and the category.

The habit that transfers is small and cheap. Before you index or embed a text path, run an aggregate over the raw data and look at how the values vary. Identical text provides no lexical distinction between those items. Shared wording with different names or categories can still support ranking, so evaluate the information that varies.

:::image type="content" source="../media/retrieval-strategy-reviewed.png" alt-text="Diagram of a decision path selecting keyword, semantic, or hybrid retrieval from the query shape and the indexed text." lightbox="../media/retrieval-strategy-reviewed.png":::

## Decide when hybrid earns its cost

Hybrid retrieval runs both methods and fuses the two rankings, so its database work includes both retrievals and the fusion. It also needs a query vector, which the application can generate or reuse from a cache. Generating a new embedding with a remote model adds a network round trip before the database receives the query. To decide whether the extra coverage is worth its cost, measure that step when it occurs, alongside the database query.

Hybrid earns its cost when the input is unpredictable, when a miss is expensive, or when the corpus mixes identifiers with prose. A retrieval-augmented chat feature is the clearest case: the grounding passages a model never sees can't be reasoned about, so recall is worth more than the request charge. A public catalog search is the next clearest, because shoppers type both names and needs and the application can't tell which it received.

Hybrid doesn't earn its cost when the input is uniform. An internal lookup by part number is a keyword problem or, more often, an equality filter that needs no ranking at all. Names, categories, images, and other meaningful data can support vector retrieval even without prose. A query path that requires a fresh remote embedding must include that call in its latency budget; a cached or otherwise available query vector avoids that call.

One prerequisite belongs in the decision rather than in the implementation. Hybrid queries need enrollment in both the vector search capability and the full-text search feature, a full-text index, and a container vector policy that's fixed when the container is created. Choosing hybrid later means creating a container and moving the data, so the strategy choice sits in the design, not in the query.

Hybrid also isn't limited to one keyword method plus one semantic method. `RRF` fuses any set of scoring functions, so two full-text scores over a title path and a body path fuse equally well, and so do two vector distances over a text embedding and an image embedding. Reading hybrid as a family of fusions rather than one fixed pairing opens designs that a strict keyword-plus-vector reading hides.

In this unit, you learn how to evaluate the shape of your queries and the structure of your indexed text to choose between keyword, semantic, and hybrid retrieval strategies effectively. Next, you can apply these principles to design and implement a search feature that balances coverage, cost, and performance.
