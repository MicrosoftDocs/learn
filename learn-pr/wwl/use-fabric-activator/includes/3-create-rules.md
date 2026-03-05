Rules define the conditions you want to detect on your objects and the actions to take when those conditions are met.

## Build your first rule

Imagine you're managing a package delivery company with temperature-sensitive medicines. Each package has sensors sending temperature and location data to your Eventstream. You need to catch temperature problems before they damage valuable cargo.

Let's walk through creating a rule for this scenario. When you create a rule in the Activator interface, a *Definition* pane opens with several sections to configure. We'll focus on the first three sections in the *Definition* pane now - Monitor, Condition, and Property filter - and cover Actions in the next unit.

:::image type="content" source="../media/activator-definition-pane.png" alt-text="Screenshot of Microsoft Fabric Activator interface showing the Definition pane with Monitor, Condition, and Property filter sections for configuring a temperature rule." lightbox="../media/activator-definition-pane.png":::

### Choose what to monitor

The **Monitor** section is where you configure what Activator watches. This section directs Activator to monitor specific data properties.

First, you select an **Attribute** - the specific property from your event data. For our package delivery scenario, you'd choose Temperature from your package sensor data.

Raw temperature readings can be noisy. A package might show brief spikes when moved or dips when passing through different environments. That's where **Summarization** becomes crucial for seeing the bigger picture:

- **Average** - Smooth out the noise by averaging readings over time
- **Minimum/Maximum** - Catch the extreme values that matter most  
- **Count** - Track how many readings you're getting (useful for detecting sensor failures)
- **Total** - Add up values when you're counting events rather than measuring levels

When you add summarization, you control two timing settings:

- **Window size**: How much historical data to include (maybe 10 minutes of temperature readings)
- **Step size**: How often to recalculate (perhaps every 5 minutes for near real-time monitoring)

For example, instead of reacting to every single temperature reading, you might monitor the average temperature over 10-minute windows, updating every 5 minutes. This approach catches sustained problems while ignoring brief fluctuations.

### Define when to act

The **Condition** section sets your execution point - when Activator should spring into action.

You choose from different detection approaches:

- **Threshold monitoring**: Alert when values cross your safety limits (Temperature **is greater than** 68°F)
- **Change detection**: Monitor trends (Temperature **increases above** baseline)
- **Range monitoring**: Track entry/exit from safe zones
- **Missing data**: Catch sensor failures (**No new events for more than** 30 minutes)

You also set the **Value** (your threshold like 68°F) and **Occurrence** behavior:

- **Every time** for immediate alerts
- **When it has been true for** to identify persistent problems (stays high for 15 minutes)

### Focus your scope

You might want to apply your rule only to specific events, not every event in your stream. The **Property filter** section lets you narrow down which events get evaluated.

Maybe you only want to monitor:

- Cold chain packages: **ColdChainType equals** "medicine"
- High-priority routes: **City equals** "Seattle"  
- Warm shipments: **Temperature is greater than** 68°F

You can combine up to three filters to create precise targeting.

With your rule defined, the next step is configuring what actions Activator should take when the rule conditions are met.