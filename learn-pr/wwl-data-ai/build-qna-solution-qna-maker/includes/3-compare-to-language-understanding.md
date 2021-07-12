A QnA Maker knowledge base is a form of language model, which raises the question of when to use the QnA Maker service, and when to use the Language Understanding service.

The two services are similar in that they both enable you to define a language model that can be queried using natural language expressions. However, there are some differences in the use cases that they are designed to address, as shown in the following table:

| | QnA Maker | Language Understanding |
| --- | --- | --- |
| Usage pattern | User submits a question, expecting an answer | User submits an utterance, expecting an appropriate response or action |
| Query processing | Service uses natural language understanding to match the question to an answer in the knowledge base | Service uses natural language understanding to interpret the utterance, match it to an intent, and identify entities |
| Response | Response is a static answer to a known question | Response indicates the most likely intent and referenced entities |
| Client logic | Client application typically presents the answer to the user | Client application is responsible for performing appropriate action based on the detected intent |

The two services are in fact complementary. You can build comprehensive natural language solutions that combine both Language Understanding models and QnA Maker knowledge bases.
