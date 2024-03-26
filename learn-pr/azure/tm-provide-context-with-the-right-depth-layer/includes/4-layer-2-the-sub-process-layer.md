The subprocess layer of data-flow diagrams is the third layer. You should use it whenever you create systems that are highly sensitive. Data-flow diagrams at this layer contain separate data-flow diagrams detailing each system subpart.

**Goal**: Represent **system subparts** with enough context to help you understand how they work and interact with each other.

Similar to the process layer, data-flow diagrams in the system subprocess layer should fit in a single page and contain all processes for their respective system subparts.

> [!IMPORTANT]
> Check with your team to make sure this level of depth is required.

## When to use the subprocess layer

Use the subprocess layer for systems the organization considers critical. A breach in a system subpart could put the entire system, customers, and organization at critical risk.

Examples include systems that:

- Are used in secured environments.
- Handle sensitive data.
- Have a high risk rating.

## Deep diving into a system subpart

Any system subparts requiring deeper dives should follow the same rule from the process layer and have their own separate data-flow diagrams. The lower-level view allows users to "zoom-in" and "zoom-out" of the system with as much context and clarity as possible. Here's how:

|Step|Guidance|
|----|--------|
|1|Create a process element with a clear description label, such as *Input Parser Name*.|
|2|Create a new file and name it exactly the same as the description label, with a tree-like structure, such as *Web Service Name - Web Service Worker Name - Input Parser Name*.|
|3|Focus the data-flow diagram only on the lower-level system subpart you're "zooming into."|

The result is a series of data-flow diagrams in the **lower-level layer**, known as layer 3.

> [!TIP]
> The path-like file naming structure helps you differentiate between the different levels.
