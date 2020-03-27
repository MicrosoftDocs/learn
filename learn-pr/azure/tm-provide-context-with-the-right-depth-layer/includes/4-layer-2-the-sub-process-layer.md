The Subprocess Layer is the third layer and should be used whenever you create systems that are highly sensitive.

## What Does This Layer Contain?

Data-flow diagrams at this layer contain separate data-flow diagrams detailing **each system subpart**. The goal is to understand how each system subpart works and interacts with each other.

## When Should I Use This Layer?

Use the Subprocess Layer for systems considered critical by the organization. Examples include systems that:

- Are used in secured environments
- Handle sensitive data
- Have a high risk rating

A breach in a system subpart could put the entire system, customers, and organization at critical risk.

## What If I Need to Deep Dive Further?

Any system subparts requiring deeper dives should follow the same rule from the Process Layer and have their own separate data-flow diagrams. The lower-level view allows users to "zoom-in" and "zoom-out" of the system with as much context and clarity as possible. Here's how:

|Step|Guidance|
|----|--------|
|1|Create a process element with a clear description label, such as "Input Parser Name"|
|2|Create a new file and name it exactly the same as the description label, with a tree like structure, such as "Web Service Name - Web Service Worker Name - Input Parser Name"|
|3|Focus the data-flow diagram only on the lower-level system subpart you're "zooming into"|

The result will be a series of data-flow diagrams in the **Lower-Level Layer**, known as Layer 3.

> [!TIP]
> The path-like file naming structure helps you differentiate between the different levels

## Remember

Similar to the Process Layer, data-flow diagrams in the System Subprocess Layer should fit in a single page and contain all processes for their respective system subparts.

> [!IMPORTANT]
> Check with your team to make sure this level of depth is required.