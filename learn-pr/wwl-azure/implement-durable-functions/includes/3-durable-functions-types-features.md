

There are currently four durable function types in Azure Functions: orchestrator, activity, entity, and client. The rest of this section goes into more details about the types of functions involved in an orchestration.

## Orchestrator functions

Orchestrator functions describe how actions are executed and the order in which actions are executed. Orchestrator functions describe the orchestration in code (C# or JavaScript) as shown in the previous unit. An orchestration can have many different types of actions, including activity functions, sub-orchestrations, waiting for external events, HTTP, and timers. Orchestrator functions can also interact with entity functions.

Orchestrator functions are written using ordinary code, but there are strict requirements on how to write the code. Specifically, orchestrator function code must be deterministic. Failing to follow these determinism requirements can cause orchestrator functions to fail to run correctly. 

> [!NOTE]
> The [Orchestrator function code constraints](/azure/azure-functions/durable/durable-functions-code-constraints) article has detailed information on this requirement.

## Activity functions

Activity functions are the basic unit of work in a durable function orchestration. For example, you might create an orchestrator function to process an order. The tasks involve checking the inventory, charging the customer, and creating a shipment. Each task would be a separate activity function. These activity functions may be executed serially, in parallel, or some combination of both.

Unlike orchestrator functions, activity functions aren't restricted in the type of work you can do in them. Activity functions are frequently used to make network calls or run CPU intensive operations. An activity function can also return data back to the orchestrator function. 

An activity trigger is used to define an activity function. .NET functions receive a `DurableActivityContext` as a parameter. You can also bind the trigger to any other JSON-serializeable object to pass in inputs to the function. In JavaScript, you can access an input via the `<activity trigger binding name>` property on the `context.bindings` object. Activity functions can only have a single value passed to them. To pass multiple values, you must use tuples, arrays, or complex types.

## Entity functions

Entity functions define operations for reading and updating small pieces of state. We often refer to these stateful entities as durable entities. Like orchestrator functions, entity functions are functions with a special trigger type, *entity trigger*. They can also be invoked from client functions or from orchestrator functions. Unlike orchestrator functions, entity functions do not have any specific code constraints. Entity functions also manage state explicitly rather than implicitly representing state via control flow. Some things to note:

* Entities are accessed via a unique identifier, the *entity ID*. An entity ID is simply a pair of strings that uniquely identifies an entity instance.
* Operations on entities require that you specify the **Entity ID** of the target entity, and the **Operation name**, which is a string that specifies the operation to perform.

## Client functions

Orchestrator and entity functions are triggered by their bindings and both of these triggers work by reacting to messages that are enqueued in a task hub. The primary way to deliver these messages is by using an orchestrator client binding, or an entity client binding, from within a *client function*. Any non-orchestrator function can be a client function. For example, You can trigger the orchestrator from an HTTP-triggered function, an Azure Event Hub triggered function, etc. What makes a function a client function is its use of the *durable client output binding*.

Unlike other function types, orchestrator and entity functions cannot be triggered directly using the buttons in the Azure portal. If you want to test an orchestrator or entity function in the Azure portal, you must instead run a client function that starts an orchestrator or entity function as part of its implementation. For the simplest testing experience, a *manual trigger* function is recommended.

