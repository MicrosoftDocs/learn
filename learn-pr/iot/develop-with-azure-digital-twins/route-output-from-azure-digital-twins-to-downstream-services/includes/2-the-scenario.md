---
metadata:
  title: The Scenario
  description: This unit presents the scenario covered in this module
  ms.date: 11/30/2020
  author: raniabayoumy
  ms.author: Rania.Bayoumy
  ms.topic: interactive-tutorial
  ms.prod: learning-azure
title: The Scenario
durationInMinutes: 3
---

Suppose you work at a chocolate manufacturing factory as technical specialist to support the factory line operators. To support the staff, you're tasked with launching a new, near real-time dashboard to support monitoring the running operations for the **roasting**, **grinding** and **molding** processes, which will enable line operators to answer questions such as:

- *find all time windows when temperature during roasting is greater than 150°F during the past 24 hours, and trace back events in Azure Digital Twins correlating to these time windows*
- *Visualize vibration readings in the past ~2 minutes and check if there are unusual spikes or dips to ensure the process meets manufacturing quality standards* ***(this is the scenario you'll focus on throughout the exercises in this module)***
- *Find all incidents with an unusual, higher than normal molding temperature in the previous 5 days*

Also, you may need to gather historical data that can be used for postmortem root-cause analysis when an operation fails, to correct a problem, or to set up a better notification system for such incidents (which is now a supported feature in Azure Time Series Insights Gen2 with the introduction of Multi-layered storage).

:::image type="content" source="../media/adt-chocolate-manufacturing-process.png" alt-text="The main Chocolate Manufacturing Processes in scope: Roasting, Grinding and Molding":::

**The main chocolate manufacturing processes in scope: roasting, grinding and molding.**

## Solution Architecture

To visualize and query data, you'll attach Time Series Insights to Azure Digital Twins using the pattern illustrated in the following diagram:

:::image type="content" source="../media/adt-solution-architecture.png" alt-text="A high-level Solution Architecture Diagram":::

**A high-level Solution Architecture Diagram.**
