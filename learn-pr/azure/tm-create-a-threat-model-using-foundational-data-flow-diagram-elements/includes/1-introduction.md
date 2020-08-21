Data-flow diagrams are made up of elements represented as shapes and lines. They graphically represent every major part of your system. 

Examples include:

- Azure DB used to store customer data
- Web service that handles a user request
- User interacting with your system
- Data-flow crossing a trust zone level change

Elements and their interactions are used in threat modeling to help identify threats and reduce system risk. The process helps engineers collaborate more efficiently while securing their systems against the most common threats.

In this module, you'll explore each element of a data-flow diagram. These have distinct shapes, functions, and require specific context.

> [!NOTE]
> Elements may be also referred as Stencils throughout this learning path.

## When to use elements

Use elements whenever you create a data-flow diagram. It shows how data is created, manipulated, stored, and removed from your system. Let's build on the examples from the first module:

- **Azure micro-service** - add elements to specify users, authentication processes, data storage, data request, and response-handling processes.
    - Don't forget to specify trust zone level changes.
- **Public API** - add elements to specify users, data storage, logging and monitoring processes and other parts of the system.
- **New feature on existing application** - add elements to represent existing and new parts of the system.

## Learning objectives

In this module, you'll be able to:

- Distinguish between the shape and function of each element
- Include the right context for an element when creating a data-flow diagram

## Prerequisites

- None
