SQL Server and Azure SQL Database provide you with three ways to search text data, full-text search, vector search, and hybrid search. Each works differently, and choosing the right one depends on what your users need to find.

To see why the right search approach matters, imagine a customer searching your product catalog. They type "lightweight hiking backpack" but your best-selling item is listed as "ultralight trail bag." A traditional keyword search finds nothing. A smarter search option understands that both descriptions mean the same thing. The search approach you choose determines whether your users find what they need or not.

## Understand the three search approaches

Let's look at how each approach works and when you'd use it.

**Full-text search** looks for words and phrases. When a customer searches for "mountain bike helmet," full-text search finds products containing those exact terms. It understands language rules, so searching for "ride" can also find "riding" or "rode." Use full-text search when users know the specific words they want.

**Semantic vector search** looks for meaning. Instead of matching words, it compares the mathematical representation of concepts. When a customer searches for "something to keep me visible on evening rides," vector search can find products described as "reflective cycling vest" or "LED bike lights" even though those words don't appear in the search. This approach works well when users describe what they need rather than name it.

**Hybrid search** uses both. It runs a full-text search and a vector search, then combines the results. A customer searching for "comfortable seat for long tours" gets products matching those keywords and products like "touring saddle" or "gel bike seat" that vector search identifies as semantically related.

## Match the approach to the query intent

Your users express different intentions when they search. Some know exactly what they want. Others are exploring.

Consider these two searches against a product database:

- `"Model XR-500"` - The user wants that specific product. Full-text search handles this search perfectly.
- `"something to keep drinks cold on a hike"` - The user describes a need. Vector search understands this means "insulated water bottle" or "portable cooler."

When you can't predict how users search, hybrid search covers both cases. The user who types "XR-500 portable cooler" gets results matching the model number and results matching the concept.

## Evaluate the trade-offs

Choosing a search approach involves trade-offs. Consider these factors as you design your solution.

**Precision versus recall** - Full-text search returns fewer results, but they closely match the query terms. Vector search returns more results, including items that are conceptually related but use different words. If your application needs exact matches, lean toward full-text. If it needs discovery, lean toward vector search.

**Data requirements** - Full-text search needs a full-text index on your text columns. Vector search needs embeddings stored in vector columns. You might need to prepare your data differently depending on which approach you choose.

**Performance characteristics** - Full-text indexes are optimized for fast keyword lookup. Vector search performance depends on how many vectors you're comparing and whether you use approximate or exact methods. Hybrid search runs both, so it takes longer than either one alone.

These trade-offs aren't about which approach is better. The right choice depends on which approach fits your scenario.

## Combine approaches with hybrid search

Full-text or vector search alone doesn't handle every situation. Full-text search misses documents that express the same idea with different words. Vector search might return conceptually related items that don't contain important terms the user specified.

Hybrid search solves this issue by running both approaches and merging the results. A user searching for "Azure SQL backup strategies" gets documents containing those keywords and documents about "database recovery planning" that vector search identifies as related.

The challenge is combining two ranked lists into one. How do you decide which result should appear first when full-text search ranks it #3 and vector search ranks it #7?

## Merge results with Reciprocal Rank Fusion

Reciprocal Rank Fusion (RRF) is an algorithm for combining ranked results from different searches. Instead of comparing raw scores, which use different scales, RRF calculates a score based on each document's position (the **rank**) using the formula `1/(rank + k)`. The constant **k** is 60, a value established by the original RRF research and used by Azure AI Search. Documents appearing in multiple result sets have their scores summed, which is where RRF really shines.

Here's how it works. Suppose a customer searches for "comfortable bike seat" and you run both full-text and vector search:

| Rank | Full-text results | Vector search results |
|------|-------------------|----------------------|
| 1 | Bike Seat Comfort Pro | Ergonomic Touring Saddle |
| 2 | Comfortable Handlebar Grips | Gel Cushion Saddle |
| 3 | Racing Bike Seat | Bike Seat Comfort Pro |

Full-text search finds products containing the words *comfortable*, *bike*, and *seat*. Vector search finds semantically similar products, including saddles that don't use the word *seat* at all.

Notice that "Bike Seat Comfort Pro" appears in both lists: rank 1 in full-text and rank 3 in vector search. RRF calculates its combined score by summing:

- Full-text rank 1: `1/(60+1) = 0.0164`
- Vector rank 3: `1/(60+3) = 0.0159`
- **Combined: 0.0323**

Compare that to "Ergonomic Touring Saddle," which only appears in vector search at rank 1:

- Vector rank 1: `1/(60+1) = 0.0164`
- **Combined: 0.0164**

Even though "Ergonomic Touring Saddle" ranked #1 in vector search, "Bike Seat Comfort Pro" wins the combined ranking because appearing in both lists doubled its score. The merged results:

| Rank | Combined results | RRF Score |
|------|------------------|-----------|
| 1 | Bike Seat Comfort Pro | 0.0323 |
| 2 | Ergonomic Touring Saddle | 0.0164 |
| 3 | Comfortable Handlebar Grips | 0.0161 |
| 4 | Gel Cushion Saddle | 0.0161 |
| 5 | Racing Bike Seat | 0.0159 |

Notice that ranks 3 and 4 have identical scores. When RRF produces ties, the ordering between those results depends on the implementation and might be arbitrary or alphabetical. In practice, tied results are equally relevant, so the exact order between them matters less than ensuring they all appear above results with lower scores.

RRF rewards documents that perform well across multiple search methods, surfacing results that match both keywords and meaning.

## Key takeaways

Full-text search, vector search, and hybrid search each serve different purposes. Full-text search excels at finding exact keywords and phrases, vector search captures semantic meaning across different phrasings, and hybrid search combines both to maximize relevance. Your choice depends on how your users search and what trade-offs you can accept between precision, recall, and performance. When you implement hybrid search, Reciprocal Rank Fusion (RRF) is a powerful technique for merging ranked results from full-text and vector searches, ensuring that items relevant to both methods rise to the top of the results list.
