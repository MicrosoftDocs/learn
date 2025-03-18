Data-flow diagrams are made up of elements represented as shapes and lines. They graphically represent every major part of your system.

Examples include:

- An Azure DB used to store customer data.
- A web service that handles a user request.
- A user interacting with your system.
- Data flow crossing a trust-zone level change.

We use elements and their interactions in threat modeling to help identify threats and reduce system risk. The process helps engineers collaborate more efficiently while securing their systems against the most common threats.

In this module, you explore each element of a data-flow diagram. These elements have distinct shapes and functions, and require specific context.

> [!NOTE]
> We might also refer to elements as as *Stencils* throughout this learning path.

## When to use elements

Use elements whenever you create a data-flow diagram. The diagram shows how data is created, manipulated, stored, and removed from your system. Let's build on the examples from the first module:

- **Azure micro-service**: Add elements to specify users, authentication processes, data storage, data-request processes, and response-handling processes.
  - Don't forget to specify trust-zone level changes.
- **Public API**: Add elements to specify users, data storage, logging and monitoring processes, and other parts of the system.
- **New feature on existing application**: Add elements to represent existing and new parts of the system.

## Learning objectives

In this module, you learn how to:

- Distinguish between the shape and function of each element.
- Include the right context for an element when creating a data-flow diagram.

## Prerequisites

- None
