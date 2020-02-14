![Process Element](../media/process.png)

Depicted by a circle, this element represents activities that can modify or redirect received input to their proper outputs. Examples include:

- A micro service that receives an API call request and forwards it to an API handling service
- Code that validates data input before it writes to a data store

Depending on the information depth level required for a data-flow diagram, you may use the process element to represent a few distinct use-cases:

- **Use the process element as a "stub"** - Using the process element as a "stub" on a higher-level data-flow diagram is a good way to help keep things clean. It involves creating a separate data-flow diagram for a specific process and mapping it back to the higher-level diagram. It works like a "zoom-in" feature, where the in-depth data-flow diagram is available when you "zoom-in" that process
- **Describe single or multiple tasks** - When a process handles more than one task. This context is important because it allows anyone looking at the data-flow diagram to apply the proper security controls for each task

Add a process element for:

- **Data stores** - communication handling
- **External entities** - task and communication handling
- **Other Processes** - task handling

Include the following context to each process element:

- **Code type** - Managed code? Native code?
- **Permission level** - Kernel? Local? Administrator?
- **Service isolation** - Sandbox?
- **Input control** - Administrator? Local? All?
- **Input validation checks** - Whitelisted input? Parser used?
- **Authentication and authorization mechanisms** - Azure Active Directory? Access Control Lists (ACL)?