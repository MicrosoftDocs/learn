This page provides monitoring and troubleshooting guidance for common issues and resolution for IoT Hub message routing.

## Monitor message routing

We recommend you monitor [IoT Hub metrics related to message routing and endpoints](/azure/iot-hub/monitor-iot-hub-reference#routing-metrics) to give you an overview of the messages sent. You can also create a diagnostic setting to send operations for [routes in IoT Hub resource logs](/azure/iot-hub/monitor-iot-hub-reference#routes) to Azure Monitor logs, Event Hubs or Azure Storage for custom processing.

We also recommend enabling the [fallback route](/azure/iot-hub/iot-hub-devguide-messages-d2c#fallback-route) if you want to maintain messages that don't match the query on any of the routes. These messages can be retained in the [built-in endpoint](/azure/iot-hub/iot-hub-devguide-messages-read-builtin) for the number of retention days configured.

## Top issues

The following are the most common issues observed with message routing.

* Messages from my devices aren't being routed as expected
* I suddenly stopped getting messages at the built-in Event Hubs endpoint

## Messages from my devices are not being routed as expected

To troubleshoot this issue, analyze the following areas:

* The routing metrics for this endpoint

    All the [IoT Hub metrics related to routing](/azure/iot-hub/monitor-iot-hub-reference#routing-metrics) are prefixed with *Routing*. You can combine information from multiple metrics to identify root cause for issues. For example, use metric **Routing Deliveries** to identify the number of messages that were delivered to an endpoint or dropped when they didn't match queries on any of the routes and fallback route was disabled. Check the **Routing Latency** metric to observe whether latency for message delivery is steady or increasing. A growing latency can indicate a problem with a specific endpoint and we recommend checking the [health of the endpoint](/azure/iot-hub/troubleshoot-message-routing#the-health-of-the-endpoint). These routing metrics also have [dimensions](/azure/iot-hub/monitor-iot-hub-reference#metric-dimensions) that provide details on the metric like the endpoint type, specific endpoint name and a reason why the message was not delivered.

* The resource logs for any operational issues

    Observe the [routes resource logs](/azure/iot-hub/monitor-iot-hub-reference#routes) to get more information on the routing and endpoint [operations](/azure/iot-hub/troubleshoot-message-routing#operation-names) or identify errors and relevant [error code](/azure/iot-hub/troubleshoot-message-routing#common-error-codes) to understand the issue further. For example, the operation name **RouteEvaluationError** in the log indicates the route couldn't be evaluated because of an issue with the message format. Use the tips provided for the specific [operation names](/azure/iot-hub/troubleshoot-message-routing#operation-names) to mitigate the issue. When an event is logged as an error, the log also provides more information on why the evaluation failed. For example, if the operation name is **EndpointUnhealthy**, an error code of 403004 indicates the endpoint ran out of space.

* The health of the endpoint

    Use the REST API [Get Endpoint Health](/rest/api/iothub/iothubresource/getendpointhealth#iothubresource_getendpointhealth) to get [health status](/azure/iot-hub/iot-hub-devguide-endpoints#custom-endpoints) of the endpoints. The Get Endpoint Health API also provides:
  * information on the last time a message was successfully sent to the endpoint
  * the [last known error](/azure/iot-hub/troubleshoot-message-routing#last-known-errors-for-iot-hub-routing-endpoints)
  * the last known error time and the last time a send attempt was made for this endpoint. Use the possible mitigation provided for the specific last known error.

## I suddenly stopped getting messages at the built-in endpoint

To troubleshoot this issue, analyze the following areas:

* Was a new route created?

    Once a route is created, data stops flowing to the built-in-endpoint, unless a route is created to that endpoint. To ensure messages continues to flow to the built-in-endpoint if a new route is added, configure a route to the events endpoint.

* Was the fallback route disabled?

    The fallback route sends all the messages that don't satisfy any of the query conditions on any of the existing routes to the [built-in-Event Hubs](/azure/iot-hub/iot-hub-devguide-messages-read-builtin) (messages and events), that is compatible with [Event Hubs](/azure/event-hubs/). If message routing is turned on, you can enable the fallback route capability. If there are no routes to the built-in endpoint and a fallback route is enabled, only messages that don't match any query conditions on routes are sent to the built-in-endpoint. Also, if all existing routes are deleted, the fallback route must be enabled to receive all data at the built-in-endpoint.

    You can enable or disable the fallback route in the Azure portal by using the Message Routing blade for the IoT hub. You can also use the Azure Resource Manager for [FallbackRouteProperties](/rest/api/iothub/iothubresource/createorupdate#fallbackrouteproperties) to use a custom endpoint for a fallback route.

## Last known errors for IoT Hub routing endpoints

[Get Endpoint Health](/rest/api/iothub/iot-hub-resource/get-endpoint-health?#iothubresource_getendpointhealth) in the REST API provides the health status of the endpoints, and the last known error, to identify the reason an endpoint isn't healthy. The [Last known error](/azure/iot-hub/troubleshoot-message-routing#last-known-errors-for-iot-hub-routing-endpoints) table lists the most common errors.

## Routes resource logs

The [Operation names and error codes](/azure/iot-hub/troubleshoot-message-routing#operation-names) table lists informational and error messages logged in the [routes resource logs](/azure/iot-hub/monitor-iot-hub-reference).
