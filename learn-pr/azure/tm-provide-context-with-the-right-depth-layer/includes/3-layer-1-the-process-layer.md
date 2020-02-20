The Process Layer focuses on data-flow diagrams for each system part. The goal is to understand how they work and interact with each other.

## When Should I Use This Layer?

Use the Process Layer for every system, especially if it handles sensitive data. The likelihood of a breach in those systems would be higher. The context at this level helps you identify threats and ways to reduce or eliminate risks more efficiently.

## What If I Need to Deep Dive Into One of the System Subparts?

In some cases, system parts may require more granular context because of their increased sensitivity and risk. Threats and risk reduction strategies are best assessed by going down to this layer. Follow the same rule from the Context Layer:

|Step|Guidance|
|----|--------|
|1|Create a process element with a clear description label, such as "Web Service Worker Name"|
|2|Create a new file and name it exactly the same way as the description label, with a path-like structure, such as "Web Service Name - Web Service Worker Name"|
|3|Focus the data-flow diagram only on the system subpart you're "zooming into"|

The result will be a series of data-flow diagrams in the **Subprocess Layer**, known as Layer 2.

> [!TIP]
> The path-like file naming structure helps you differentiate between the different levels

## Remember

Similar to the System Layer, data-flow diagrams in the Process Layer should fit in a single page and contain all processes for their respective system parts.

> [!IMPORTANT]
> Most data-flow diagrams **require** a Process Level depth layer to be assessed properly