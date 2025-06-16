

## Multiple Choice
Which of the following event schema properties requires a value?
( ) Topic {{Incorrect. Event Grid will provide this value.}}
( ) Data {{Incorrect. A value isn't required in this property.}}
(x) Subject {{Correct. The subject property specifies the publisher-defined path to the event subject and is required.}}

## Multiple Choice
Which of the following Event Grid built-in roles is appropriate for managing Event Grid resources?
(x) Event Grid Contributor {{Correct. The Event Grid Contributor role has permissions to manage resources.}}
( ) Event Grid Subscription Contributor {{Incorrect. The Event Grid Subscription Contributor role has permissions to manage subscription operations.}}
( ) Event Grid Data Sender {{Incorrect. The Event Grid Data Sender role has permissions to send events to topics.}}

## Multiple Choice
What is the purpose of the CloudEvents schema in Azure Event Grid?
( ) To provide a proprietary event schema specific to Azure services. {{Incorrect. The CloudEvents schema is an open specification, not proprietary to Azure.}}
(x) To simplify interoperability by providing a common event schema for publishing and consuming cloud-based events. {{Correct. The CloudEvents schema enables uniform tooling and easier integration across platforms.}}
( ) To replace the Event Grid event schema entirely for all event types. {{Incorrect. The CloudEvents schema complements the Event Grid schema but does not replace it.}}

## Multiple Choice
What happens when Event Grid receives a 400 (Bad Request) or 413 (Request Entity Too Large) response code during event delivery?
( ) Event Grid retries the delivery indefinitely until the endpoint responds. {{Incorrect. Event Grid does not retry indefinitely for these error codes.}}
(x) Event Grid schedules the event for dead-lettering if a dead-letter location is configured. {{Correct. These error codes indicate delivery failure, prompting dead-lettering if configured.}}
( ) Event Grid immediately drops the event without further action. {{Incorrect. Event Grid does not drop the event immediately; it schedules it for dead-lettering if configured.}}

## Multiple Choice
What is the purpose of the validation handshake in Azure Event Grid when using a custom webhook endpoint?
(x) To prove ownership of the webhook endpoint before delivering events {{Correct. The validation handshake ensures that only the rightful owner receives events.}}
( ) To ensure the webhook endpoint is hosted on Azure infrastructure {{Incorrect. The validation handshake does not verify the hosting location of the endpoint.}}
( ) To encrypt the event data being sent to the webhook endpoint {{Incorrect. The validation handshake is not related to encryption of event data.}}

## Multiple Choice
What is the purpose of advanced filtering in Azure Event Grid?
( ) To filter events based on the geographic location of the event source {{Incorrect. Advanced filtering does not involve geographic location filtering.}}
(x) To filter events by values in data fields using specific comparison operators {{Correct. Advanced filtering allows filtering by data field values with comparison operators.}}
( ) To filter events by specifying only the event type and subject {{Incorrect. Filtering by event type and subject is a simpler form of filtering, not advanced filtering.}}
