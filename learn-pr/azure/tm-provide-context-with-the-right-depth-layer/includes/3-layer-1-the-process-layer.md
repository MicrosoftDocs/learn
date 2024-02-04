The process layer of data-flow diagrams is the second layer. You should use it for most systems. Data-flow diagrams at this layer contain separate data-flow diagrams detailing each system part. 

**Goal**: Represent **secondary system parts** with enough context to help you understand how they work and interact with each other.

Similar to the system layer, data-flow diagrams in the process layer should fit in a single page and contain all processes for their respective system parts.

> [!IMPORTANT]
> Most data-flow diagrams **require** a process-level depth layer for proper assessment.

## When to use the process layer

Use the process layer for every system, especially if it handles sensitive data. Systems with sensitive data are at a higher risk of being breached. The context at this level helps you identify threats and ways to reduce or eliminate risks more efficiently.

## Deep diving into a system part

In some cases, system parts may require more granular context because of their increased sensitivity and risk. You can best assess threats and risk-reduction strategies by going down to this layer. Follow the same rule from the system layer.

|Step|Guidance|
|----|--------|
|1|Create a process element with a clear description label, such as *Web Service Worker Name*.|
|2|Create a new file and name it exactly the same way as the description label, with a path-like structure, such as *Web Service Name - Web Service Worker Name*.|
|3|Focus the data-flow diagram only on the system subpart you're "zooming into."|

The result is a series of data-flow diagrams in the **subprocess layer**, known as layer 2.

> [!TIP]
> The path-like file naming structure helps you differentiate between the different levels.
