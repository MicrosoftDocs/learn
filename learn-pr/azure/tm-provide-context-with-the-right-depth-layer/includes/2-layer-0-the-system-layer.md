The System Layer is the **starting ground** for any system and must be created for all your systems. Data-flow diagrams in this layer contain major system parts with enough context to help you understand how they work and interact with each other.

## When Should I Use This Layer?

The System Layer should be required for every system you're building. The high-level context helps anyone learn more about your system to engage in more meaningful discussions.

## What If I Need to Deep Dive Into One of the System-Parts?

In most cases, system parts **will** require a deeper dive because of the risk they introduce. Examples include:

- **Any** new system that introduces unknown risks to the environment
- New parsers, protocols, and file formats
- New authentication and authorization mechanisms
- New secret storage or encryption algorithms
- Integration with third-party authentication systems, like Facebook
- Required elevated privileges for main functionality
- Required unencrypted communication channels

If that's the case, create additional data-flow diagrams for each system part. Follow these steps:

|Step|Guidance|
|----|--------|
|1|Create a process element with a clear description label, such as "Web Service Name"|
|2|Create a new file and name it exactly the same way as the description label|
|3|Focus the data-flow diagram only on the system part you're "zooming into"|

The result will be a series of data-flow diagrams in the **Process Layer**, known as Layer 1.

## Remember

The System Layer diagrams should fit in a single page. It should also contain only major processes handled by the system. Provide as much as context as possible and clearly label each element so anyone understands how it works.

> [!TIP]
> The **System Layer** is also called the **Context Layer**