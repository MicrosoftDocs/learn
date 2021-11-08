Choose the best response for each of the questions below. Then select **Check your answers**

## Multiple Choice
Within an IoT solution, what is message enrichment?
( ) An IoT hub feature that enables users to direct device messages to a service endpoint. {{Incorrect. Message routing is the IoT hub feature that directs device messages to a service endpoint.}}
( ) A real-time analytics and complex event-processing engine that accepts data from multiple sources simultaneously. {{Incorrect. Azure Stream Analytics is the real-time analytics and complex event-processing engine that accepts data from multiple sources simultaneously.}}
(x) The ability of IoT hub to stamp messages with additional information before the message is sent a designated endpoint. {{Correct. Message enrichment is a feature of IoT hub that is used to stamp messages with additional information before the message is sent a designated endpoint.}}

## Multiple Choice
What message size is used to calculate IoT hub's daily message quota for the Basic and Standard tiers?
( ) 0.5 KB {{Incorrect. A message size of 0.5 KB is to calculate the daily quota for the free tier of IoT hub, but not Basic and Standard tiers.}}
(x) 4 KB {{Correct. IoT hub uses message size of 4 KB to calculate the daily quota for Basic and Standard tiers, and a size of 0.5 KB for a free tier. The tier and number of units determine the maximum daily quota of messages that you can send.}}
( ) 256 KB {{Incorrect. 256 KB is the maximum size for a device-to-cloud message, but not the size used to calculate daily message quota.}}

