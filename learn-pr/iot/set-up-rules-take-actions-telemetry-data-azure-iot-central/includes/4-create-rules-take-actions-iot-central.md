In this unit, we discuss the mechanics of rules, and the range of possible actions.

## Rules and actions

A _rule_ is a set of conditions, that triggers when all conditions are met.

Given our scenario of a refrigerated truck, we might be concerned if the temperature of the contents exceeded freezing point (0 degrees C). A simple rule would be one that fires when the contents temperature meets or exceeds zero. This rule could be summarized as:

| Telemetry | Operator | Value |
| -- | -- | -- |
| Contents Temperature | Is greater than or equal to | 0 |

Perhaps the action to take if this rule is triggered, is a warning sent as an email to the IoT Central operator.

However, if the rule is triggered, it might fire every time telemetry is sent, resulting in a spam load of email in the operators inbox. If we add time aggregation to the condition, we can reduce the volume of email. For example, if we set the condition as being triggered when the maximum temperature of the contents exceeds 0 degrees in any five-minute period, then at most one email every five minutes would be sent. We can summarize our revised condition as:

| Telemetry | Aggregation | Operator | Value |
| -- | -- | -- | -- |
| Contents Temperature | Maximum | Is greater than or equal to | 0 |

It's a judgment call as to how often to send warnings. If the truck was on fire, perhaps a continuous stream of warnings is appropriate!

More complex rules can be built up by combining conditions. And rules and actions don't need to be warnings or failures. We might specify a rule to report to the IoT Central operator that everything is OK with the truck contents. Consider the following rule:

| Telemetry | Aggregation | Operator | Value |
| -- | -- | -- | -- |
| Contents Temperature | Maximum | Is less than | -1 |
| Contents Temperature | Minimum | Is greater than | -18 |

This rule could send an "OK" message every 10 minutes, letting the operator know that contents temperature is within a desired limit.

Yet more complex rules can be built around a truck's location. Location in Azure Maps is specified using latitude, longitude, and altitude. We don't use altitude in our app. Consider the following rule:

| Telemetry | Operator | Value |
| -- | -- | -- |
| Location / Latitude | Is greater than | 47.1 |
| Location / Latitude | Is less than | 47.9 |
| Location / Longitude | Is greater than | -122.9 |
| Location / Latitude | Is less than | -122.1 |
| Truck state | Equals | enroute |

This rule will fire if the truck is in the specified area, and is in the required _enroute_ state. We can use such a rule to determine when trucks are entering, and leaving, certain geographical areas. It's possible that more than one email action may be triggered by the rule. In other words, an operator may get several messages that a truck is leaving.

Rules can be fired if either all the conditions are true, or if any of the conditions are true. This can be configured for each rule.

### The range of actions

One rule can trigger one, or more, actions. You could, for example, email any number of addresses when a rule fires.

Currently, there are two available actions: email and webhooks. We use email in this module, though webhooks are potentially the more powerful option. A webhook will send a JSON file to a given URL. Any URL can be entered, but consider the following four options:

* Azure functions
* Microsoft Flow
* Azure Logic Apps
* Your custom app

Using webhooks enables more automation to be added to your IoT Central system.

In the next unit, we'll define a range of rules, similar to the rules outlined in this unit. Then, we'll put the rules to the test!
