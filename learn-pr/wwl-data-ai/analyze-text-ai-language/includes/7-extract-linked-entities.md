
In some cases, the same name might be applicable to more than one entity. For example, does an instance of the word "Venus" refer to the planet or the goddess from mythology?

Entity linking can be used to disambiguate entities of the same name by referencing an article in a knowledge base. Wikipedia provides the knowledge base for Azure Language text analysis. Specific article links are determined based on entity context within the text.

As with all Azure Language functions, you can submit one or more documents for analysis:

```python
# Example text to analyze
documents = ["A Solar day (sunrise to sunrise) on Venus is about 116.75 Earth days.",
             "Venus is the Roman goddess of love."]

# Extract linked entities
response = client.recognize_linked_entities(documents=documents)
for doc in response:
    print(f"Entities in document {doc.id}:")
    for entity in doc.entities:
        print(f" - {entity.name} ({entity.data_source}): {entity.url}")
```

The response includes the entities identified in the text along with links to associated articles:

```output
Entities in document 0:
 - Solar time (Wikipedia): https://en.wikipedia.org/wiki/Solar_time
 - Venus (Wikipedia): https://en.wikipedia.org/wiki/Venus
 - Earth (Wikipedia): https://en.wikipedia.org/wiki/Earth
Entities in document 1:
 - Venus (mythology) (Wikipedia): https://en.wikipedia.org/wiki/Venus_(mythology)
```
