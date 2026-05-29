The monitoring hub tells you what happened — a dataflow failed, a notebook ran longer than expected. But the monitoring hub requires you to look at it. Activator in Microsoft Fabric closes this gap by automatically detecting conditions in your data and triggering actions in response. Where the monitoring hub is a reactive tool you check manually, Activator is a proactive engine that watches your data continuously and acts when something needs attention.

Activator is part of Real-Time Intelligence in Microsoft Fabric. It connects to data sources, evaluates rules you define, and executes actions like sending email alerts, posting Teams messages, running Power Automate workflows, or starting Fabric notebooks and pipelines.

<!-- IMAGE PLACEHOLDER: Screenshot of the Activator item in Microsoft Fabric showing the rule definition canvas with events, objects, and rules. Alt text: "Screenshot of the Activator canvas in Microsoft Fabric." Source: Take a new screenshot from the Fabric portal. Priority: High — this unit has no images. -->

## How Activator works

Activator operates on a simple loop: data comes in from a source, Activator evaluates that data against your rules, and when a rule condition is met, Activator executes the configured action.

The four core concepts in Activator are:

- **Events** — Each record in a data stream represents something that happened at a specific point in time. A temperature reading from a sensor, a row loaded by a dataflow, or a pipeline status change are all events.
- **Objects** — Events can represent real-world entities you want to monitor, like packages, devices, or customers. Activator groups events by a unique identifier (like a device ID or order number) to track each object independently.
- **Properties** — The fields in your event data map to properties of each object. A temperature field becomes a property you can evaluate; a status field becomes another. Properties reflect the current state of each object as new events arrive.
- **Rules** — Rules define the conditions to check and the actions to take. A rule might say: "When the average temperature over the last 10 minutes exceeds 86°F, send an email to the operations team."

## Connect to data sources

Activator can monitor several types of event sources:

- **Eventstreams** — Continuous streams from IoT devices, Azure Event Hubs, and other real-time sources. For example, sensor data from a fleet of delivery trucks.
- **Fabric events** — Events generated within your Fabric workspace, such as a data pipeline failing or a semantic model refresh completing. This makes Activator directly useful in monitoring workflows — you can trigger an alert when a scheduled pipeline fails.
- **Azure events** — Events from Azure services like Azure Blob Storage (for example, when a new file lands in a container).
- **Power BI reports and Real-Time dashboards** — Activator can monitor report visuals and dashboard tiles, triggering actions when visualized data changes.

When you connect a data source, you choose which fields identify your objects and which fields serve as properties to monitor. Activator then continuously processes incoming events and updates the state of each object.

## Define rules

Rules are where you specify what Activator should watch for. Each rule has three parts:

### Monitor section

The **Monitor** section specifies which property to watch and how to interpret its values. You select an attribute from your object properties — for example, `Temperature` — and optionally apply a **summarization** to smooth out noisy data:

- **Average** — Averages readings over a time window to filter out brief spikes.
- **Minimum/Maximum** — Catches extreme values that might indicate a problem.
- **Count** — Tracks how many events arrive, which is useful for detecting sensor failures (a count of zero means no data is coming in).

When you use summarization, you configure a **window size** (how much history to include) and a **step size** (how often to recalculate).

### Condition section

The **Condition** section defines when the rule should fire:

- **Threshold monitoring** — Fires when a value crosses a specific limit (for example, temperature is greater than 86°F).
- **Change detection** — Fires when a value increases or decreases beyond a baseline.
- **Range monitoring** — Fires when a value enters or exits a defined range.
- **Missing data** — Fires when no new events arrive for a specified duration, which helps detect source failures.

Rules can be **stateless** or **stateful**. A stateless rule evaluates each event individually — every event that meets the condition triggers an action. A stateful rule tracks changes over time and only fires when a new state is entered. For example, a stateful rule that checks whether temperature exceeds 80°F fires once when temperature crosses the threshold, but doesn't fire again for the same object until the temperature drops below 80°F and crosses back up. Stateful rules prevent repeated alerts for an unchanged condition.

### Property filter section

The **Property filter** section narrows which events the rule evaluates. You might only want to monitor high-priority shipments, events from a specific region, or a particular item type. You can combine up to three filters.

## Configure actions

When a rule's conditions are met, Activator executes an action. Four types of actions are available:

- **Email** — Sends a detailed message with context about the condition that was detected. Use email when the recipient needs comprehensive information and doesn't need to respond immediately.
- **Teams** — Posts a message to a Teams channel or individual. Use Teams when you need quick visibility and team coordination.
- **Power Automate** — Starts a Power Automate flow to execute multi-step business processes across different systems. For example, a flow could create a support ticket, update a database, and send a notification — all from a single trigger.
- **Fabric items** — Runs a data pipeline or notebook. Use this action when the response to a condition requires data processing — for example, running a remediation notebook when a data quality check fails.

## Activator in a monitoring strategy

Activator complements the monitoring hub rather than replacing it. Use the monitoring hub for day-to-day visibility into what's running and what failed. Use Activator to automate the response — so when a pipeline fails at 2 AM, the on-call engineer gets a Teams message immediately instead of discovering the failure the next morning.

Common monitoring scenarios for Activator include:

- Sending an alert when a scheduled dataflow fails or runs longer than expected.
- Posting to a Teams channel when a semantic model refresh completes, so analysts know fresh data is available.
- Running a remediation notebook when a data quality rule detects anomalous values.
- Notifying a manager when a pipeline hasn't run within its expected window.

> [!TIP]
> For a deeper exploration of configuring Activator objects, rules, and actions, see [Use Activator in Microsoft Fabric](/training/modules/use-fabric-activator/).