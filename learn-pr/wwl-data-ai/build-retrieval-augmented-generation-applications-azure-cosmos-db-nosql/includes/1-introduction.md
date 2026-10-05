Retrieval works. Contoso's product knowledge base returns the three headlights for a shopper who types *something to see the road at night*, and the exact touring bike for a shopper who types a model number. What it returns is a ranked list of records, and the shopper still has to read them.

The next request from the business is an assistant that answers in sentences. *Which light should I buy for commuting, and how much is it?* No ranked list answers that question. A language model can, and on its own it answers confidently and wrongly, because Contoso's catalog isn't in its training data. It invents a product and a price, and states both with the fluency it uses for facts.

Retrieval-augmented generation closes that gap by putting the retrieval you already built in front of the model. The application retrieves the records that bear on the question, hands them to the model as the only permitted source, and asks for an answer built from them. The model supplies the language. Your data supplies the facts. Azure Cosmos DB for NoSQL holds the operational record, the searchable text, and the vector in one item, so retrieval reads the same document the catalog writes, not a copy that drifts.

The engineering sits in three places a demonstration skips. Deciding what a retrieval unit is, so each result answers something on its own. Assembling a prompt that grounds the answer, cites its sources, and treats retrieved text as data rather than as instructions. And wiring the stages into a pipeline that survives a follow-up question and knows when one retrieval pass isn't enough.

In this module, you work through the retrieval-augmented generation loop, prepare content for retrieval, ground and cite an answer, and orchestrate the pipeline for multi-turn and multi-step questions.

By the end of this module, you can build a retrieval-augmented generation application on Azure Cosmos DB for NoSQL whose answers trace back to the data that produced them.
