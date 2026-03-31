Identity determines who can access AI services. The next step is understanding where that access is enforced.

Azure separates access into two distinct layers: the **management plane** and the **data plane**. Each plane controls a different category of actions, and each introduces different security risks.

Understanding the distinction between these planes is essential for designing least-privilege access and avoiding misconfiguration.

## Management plane access

The management plane governs configuration and administrative operations. It controls how AI resources are created, modified, and managed.

Examples of management plane actions include:

- Creating or deleting an Azure AI resource
- Deploying or updating a model
- Changing network configuration
- Assigning role-based access control permissions

Management plane access is enforced through Azure role-based access control. Permissions are typically assigned at the subscription, resource group, or resource level.

If a user or application has excessive management plane permissions, they can alter how an AI system is deployed or secured. This can introduce risk even if runtime access is tightly controlled.

## Data plane access

The data plane governs runtime interaction with the AI service. It controls how identities interact with deployed models and associated data.

Examples of data plane actions include:

- Submitting prompts to a model endpoint
- Retrieving model responses
- Accessing training or grounding data
- Using embeddings or inference APIs

Data plane access determines who can use the model and how they can interact with it.

A common mistake is assuming that restricting management access is enough. An identity with broad data plane access can still expose sensitive data, misuse models, or operate outside intended boundaries.

## Why the distinction matters

Management plane and data plane permissions are evaluated independently. An identity might have access in one plane but not the other.

Because these planes control different categories of actions, failures have different consequences. Management plane misconfigurations alter how AI resources are structured, deployed, or governed. Data plane misconfigurations affect how models are invoked and what data they can process or expose.

This separation affects:

- How you design role assignments
- How you apply least privilege
- How you analyze misconfigurations
- How you interpret security alerts

When investigating an AI security issue, one of the first questions should be:

Was this action performed through the management plane or the data plane?

That distinction shapes both risk assessment and remediation.

Understanding these two planes allows you to design access intentionally rather than granting broad permissions that span configuration and runtime activity. That foundation makes it possible to examine how requests are authenticated and validated.
