The system layer of data-flow diagrams is the starting point for any system. You need to create it for all your systems. 

**Goal**: Represent **major system parts** with enough context to help you understand how they work and interact with each other.

Data-flow diagrams in the system layer should fit in a single page. They should also contain only major processes handled by the system. Provide as much as context as possible and clearly label each element so anyone understands how it works.

> [!TIP]
> The **system layer** is also called the **context layer**.

## When to use the system layer

The system layer should be required for every system you create. The high-level context helps anyone learn more about your system so they can engage in more meaningful discussions.

## Deep diving into a system part

In most cases, system parts **will** require a deeper dive because of the risk they introduce.

Examples include:

- **Any** new system that introduces unknown risks to the environment.
- New parsers, protocols, and file formats.
- New authentication and authorization mechanisms.
- New secret storage or encryption algorithms.
- Integration with third-party authentication systems like Facebook.
- Required elevated privileges for main functionality.
- Required unencrypted communication channels.

If that's the case, create data-flow diagrams for each system part. Follow these steps:

|Step|Guidance|
|----|--------|
|1|Create a process element with a clear description label, such as *Web Service Name*.|
|2|Create a new file and name it exactly the same way as the description label.|
|3|Focus the data-flow diagram only on the system part you're "zooming into".|

The result is a series of data-flow diagrams in the **process layer**, known as layer 1.
