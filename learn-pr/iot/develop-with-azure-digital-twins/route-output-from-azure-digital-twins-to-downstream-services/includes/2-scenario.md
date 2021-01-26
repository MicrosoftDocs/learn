Suppose you work at a chocolate manufacturing factory as a technical specialist who supports factory line operators. You're commissioned to launch a new near real-time dashboard to monitor the running operations for the roasting, grinding, and molding processes. The dashboard will enable line operators to resolve these kinds of issues:

- Find all time windows during the past 24 hours when the temperature during roasting is greater than 150° F. Trace back events in Azure Digital Twins that correlate to these time windows.
- Visualize vibration readings during approximately the past two minutes. Check if there are unusual spikes or dips to ensure the process meets manufacturing quality standards. (You'll focus on this scenario throughout the exercises in this module.)
- Find all incidents with a higher than normal molding temperature over the previous five days.

Also, you might need to gather historical data that can be used for postmortem root cause analysis when an operation fails, to correct a problem, or to set up a better notification system for such incidents. (With the introduction of multi-layered storage, Time Series Insights Gen2 now supports the analysis of historical data.) 

:::image type="content" source="../media/chocolate-manufacturing-process.png" alt-text="Diagram that shows the main chocolate manufacturing processes in scope: roasting, grinding, and molding.":::

**The main chocolate manufacturing processes in scope: roasting, grinding, and molding.**

## Solution architecture

To visualize and query data, you'll attach Time Series Insights to Azure Digital Twins by using the pattern illustrated in this diagram:

:::image type="content" source="../media/azure-digital-twins-solution-architecture.png" alt-text="Diagram that illustrates the high-level solution architecture.":::

**High-level solution architecture diagram.**
