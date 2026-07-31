The **Active Directory schema** is the formal set of rules for object classes, attributes, constraints, and directory structure. The schema specifies:

- **Object classes** that can exist (such as users, groups, computers, and organizational units)
- **Attributes** those objects can have (such as `displayName`, `mail`, or `memberOf`)
- The relationships and constraints that govern how those objects and attributes are used

Every user, group, computer, and service account in Active Directory Domain Services (AD DS) exists because the *schema* defines what those objects are and which attributes they can hold. The schema is shared by every domain in a forest. Installing a new version of Windows Server can raise the schema so that domain controllers understand new object types and attributes. Deploying a product such as Microsoft Exchange Server extends the schema with hundreds of classes and attributes before mailboxes can exist.

## What this module covers

In this module you learn how to:

- Explain how the schema defines and constrains objects across a forest.
- Interpret `classSchema` and `attributeSchema` definitions, including identifiers, inheritance, and relationships.
- Locate and inspect the schema, the schema master, and the schema version with read-only tools.
- Decide when a requirement justifies a schema extension.
- Govern the permanence, testing, deployment, cache, and replication of a controlled change.
- Evaluate the security, indexing, global catalog, read-only domain controller, and replication effects of a design.
- Diagnose common version, cache, permission, identifier, and replication problems.

## Scope and boundaries

This module is written from the perspective of the AD DS schema on Windows Server 2025. Throughout the module, examples use the `contoso.com` forest. Naming contexts are always discovered through RootDSE rather than assumed from a hard-coded forest distinguished name.
