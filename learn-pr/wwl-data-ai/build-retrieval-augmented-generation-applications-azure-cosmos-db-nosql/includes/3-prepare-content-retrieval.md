The retrieval half of the loop reads whatever an earlier process wrote. That process makes one decision that shapes every answer the assistant ever gives, and it isn't which embedding model to call. It's what counts as one retrieval unit. In this unit, you size a retrieval unit, separate the text you embed from the text you ground on, and attach the metadata that lets an answer cite its sources.

## Size the retrieval unit

Retrieval returns whole items. Your definition of an item sets the granularity at which evidence reaches the model, and you can't change that granularity afterward through the query or the prompt.

Splitting long source content into retrieval-sized pieces is called chunking, and the size question has an answer that reads plainly and gets ignored constantly: **a retrieval unit should carry one answerable idea, and it should stand on its own to a reader who never sees what surrounded it.** Both halves matter, and they pull against each other.

:::image type="content" source="../media/retrieval-unit-sizing.png" alt-text="Diagram comparing three retrieval units: a fragment with lost context, a right-sized unit, and an oversized unit that dilutes its embedding." lightbox="../media/retrieval-unit-sizing.png":::

Units that are too small lose the context that made them meaningful. A sentence reading *This applies only to accounts created before the migration* retrieves perfectly against a question about the migration and tells the model nothing about what *this* is. The answer that follows is confidently incomplete.

Units that are too large dilute their own embedding. An embedding is one vector for the whole unit, so a page covering four topics produces a vector that sits between four meanings and resembles none of them strongly. Long units also crowd the prompt, and every token spent on the three paragraphs that don't answer the question is a token unavailable to the ones that do. Embedding models also cap their input. Azure OpenAI embedding models accept 8,192 tokens per input and return an HTTP 400 for anything longer. An oversized unit fails the ingestion call rather than quietly producing a worse vector, so count the tokens before you send them.

Three properties settle the size for a given corpus.

| Property | What to check |
| :--- | :--- |
| Structure of the source | Prose splits on paragraphs or sections; reference content splits on the boundary a reader already recognizes, such as a procedure or a record |
| Independence | Read a candidate unit with nothing around it. If a pronoun or a heading reference leaves it ambiguous, carry that context into the unit |
| Input limit of the embedding model | The unit has to fit, with room to spare. Azure OpenAI rejects an input over 8,192 tokens with an HTTP 400, and a batched request has a 300,000-token ceiling across all its inputs |

Overlapping consecutive units by a sentence or two is the common repair for the independence problem in flowing prose. It costs storage and duplicate retrievals, and it recovers ideas that fall across a boundary.

> [!IMPORTANT]
> Treat the chunking strategy as close to permanent. Changing it invalidates every stored embedding, because the vectors describe units that no longer exist, so the entire corpus needs re-embedding and the relevance measurements taken against the old units no longer describe the new ones.

### Recognize a corpus that's already chunked

Not every corpus needs splitting, and assuming it does wastes effort on a step that has nothing to do.

The CosmicWorks catalog is the clear case. Each of its 295 products is one record with a name, a category, a price, a SKU, and tags. The searchable text this learning path builds from a product's name and category name averages under seven words and never exceeds 60 characters, which is far below any chunk boundary you'd choose. **A product is already a retrieval unit**, and running a text splitter over it would produce one chunk per product and a pipeline stage that does nothing.

The interesting question inverts. Rather than *is this too big to retrieve*, it becomes *is this enough to answer from*. A shopper asking which light to buy for commuting needs the price, and the price isn't in the text that was embedded. That distinction is what the next section rests on.

## Separate the text you embed from the text you ground on

Two different consumers read a retrieval unit, and they want different content.

The **embedding** describes what the unit is about, so similarity search can find it. It wants the discriminating text and nothing else. Identifiers, timestamps, and boilerplate add tokens and blur the vector.

The **grounding block** is what the model reads when it composes an answer. It wants every field the answer might need, including ones no shopper would ever type: price, availability, SKU, category, effective date.

Nothing requires the text you embed and the text you ground on to be the same string, and treating them as the same string is the reason so many assistants retrieve the right item and then can't say what it costs. Store both, embed one, and project the other.

The catalog makes the case concretely. Its `description` property looks like the obvious text to embed, and measuring it shows why it isn't: all 295 descriptions follow one generated pattern that substitutes the product's own name into a fixed sentence, so embedding them produces a corpus whose only varying content is the name. The searchable text is built from the name and the category name instead, and that decision was reached by reading the values rather than the property list.

::: zone pivot="python"

```python
def build_search_text(product):
    return f"{product['name']} {product['categoryName']}"

def build_retrieval_item(product, vector):
    return {
        "id": product["id"],
        "categoryId": product["categoryId"],
        "name": product["name"],
        "categoryName": product["categoryName"],
        "price": product["price"],
        "sku": product["sku"],
        "searchText": build_search_text(product),
        "embedding": vector,
    }
```

::: zone-end

::: zone pivot="csharp"

```csharp
static string BuildSearchText(Product product) =>
    $"{product.name} {product.categoryName}";

static RetrievalItem BuildRetrievalItem(Product product, float[] vector) => new()
{
    id = product.id,
    categoryId = product.categoryId,
    name = product.name,
    categoryName = product.categoryName,
    price = product.price,
    sku = product.sku,
    searchText = BuildSearchText(product),
    embedding = vector
};
```

::: zone-end

The container that stores these items carries a vector policy and index on the embedding path and a full-text policy and index on the searchable text path. **You can add new vector path configurations or remove existing ones, but you can't edit the settings of an existing vector embedding policy or vector index in place.** To change those settings, remove the existing policy or index and add it again with the new configuration. Full-text policies and indexes can also be updated. Keeping stored vectors aligned with text that changes is a change feed job. These capabilities are covered in the earlier modules on native search, and this module builds on the container they produce rather than configuring it again.

## Carry the metadata that makes an answer citable

An answer that says *the Headlights - Dual-Beam costs 34.99* is useful. An answer that makes the same claim and names the item it read is checkable, and the difference is a property of what you stored, not of what you asked the model for.

To trace back to its source, every retrieval unit needs enough identity:

- **A stable identifier**, which for a catalog record is the item's own `id`. For a chunk of a longer document, it's an identifier of the chunk, not of the document.
- **The parent it came from**, when a unit is a fragment. A document identifier and an ordinal let the application show the surrounding text when a user asks where an answer came from.
- **The fields the answer quotes**, so a citation resolves to something a reader can verify rather than to an opaque key.

The parent identifier earns its place a second way. When several retrieved chunks come from one document, an answer that cites the document once reads better than one that cites four fragments of it, and collapsing them requires knowing they share a parent.

In this unit, you learn how to prepare content for retrieval in a retrieval-augmented generation application. You see how to build search text, construct retrieval items with embeddings, and carry the metadata necessary to make answers citable.
