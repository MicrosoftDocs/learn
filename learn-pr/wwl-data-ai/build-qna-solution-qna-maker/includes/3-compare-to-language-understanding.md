
A question answering knowledge base is a form of language model, which raises the question of when to use question answering, and when to use the *conversational language understanding* capabilities of the Language service.

The two features are similar in that they both enable you to define a language model that can be queried using natural language expressions. However, there are some differences in the use cases that they are designed to address, as shown in the following table:

| | Question answering | Language understanding |
| --- | --- | --- |
| **Usage pattern** | User submits a question, expecting an answer | User submits an utterance, expecting an appropriate response or action |
| **Query processing** | Service uses natural language understanding to match the question to an answer in the knowledge base | Service uses natural language understanding to interpret the utterance, match it to an intent, and identify entities |
| **Response** | Response is a static answer to a known question | Response indicates the most likely intent and referenced entities |
| **Client logic** | Client application typically presents the answer to the user | Client application is responsible for performing appropriate action based on the detected intent |

The two services are in fact complementary. You can build comprehensive natural language solutions that combine conversational language understanding models and question answering knowledge bases.
