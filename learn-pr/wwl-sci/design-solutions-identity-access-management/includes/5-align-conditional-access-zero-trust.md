We'll start out with some design principles.

<!--[](https://learn.microsoft.com/azure/architecture/guide/security/conditional-access-design#conditional-access-as-a-zero-trust-policy-engine)-->

### Conditional Access as a Zero Trust policy engine

The Microsoft approach to Zero Trust includes Conditional Access as the main policy engine. Here's an overview of that approach:

[![Diagram that provides an overview of the Zero Trust model.](https://learn.microsoft.com/azure/architecture/guide/security/images/zero-trust-model.png)](https://learn.microsoft.com/azure/architecture/guide/security/images/zero-trust-model.png#lightbox)

_Download an [SVG file](https://arch-center.azureedge.net/zero-trust-model.svg) of this architecture._

Conditional Access is used as the policy engine for a Zero Trust architecture that covers both policy definition and policy enforcement. Based on various signals or conditions, Conditional Access can block or give limited access to resources, as shown here:

![Diagram that provides an overview of the Conditional Access signal, decision, enforcement path.](https://learn.microsoft.com/azure/architecture/guide/security/images/conditional-access-signals.png)

Here's a more detailed view of the elements of Conditional Access and what it covers:

[![Diagram that shows a more detailed view of Conditional Access.](https://learn.microsoft.com/azure/architecture/guide/security/images/user-access.png)](https://learn.microsoft.com/azure/architecture/guide/security/images/user-access.png#lightbox)

This diagram shows Conditional Access and related elements that can help protect user access to resources, as opposed to non-interactive or non-human access. The following diagram describes both types of identities:

![Diagram that describes Conditional Access identity types.](https://learn.microsoft.com/azure/architecture/guide/security/images/conditional-access-identity.svg)

Non-human access to resources must also be protected. Currently, you can't use Conditional Access to protect non-human access to cloud resources. You need to use another method, like grant controls for OAuth-based access.