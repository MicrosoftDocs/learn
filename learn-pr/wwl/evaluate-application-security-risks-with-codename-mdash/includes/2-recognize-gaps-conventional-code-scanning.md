The controlled security test shows Caldova what an attacker can do, but it doesn't yet explain why the application allows those actions. Before Caldova evaluates MDASH, its security team needs to understand the code-analysis problem it solves.

## Compare patterns with code behavior

Traditional static analysis scans source code without running the application. It uses rules to find known unsafe patterns, such as risky functions or insecure data flows. This approach is efficient and remains an important security control.

Some vulnerabilities are harder to identify. For example, Caldova's merchant portal might confirm that a user is signed in but fail to check whether that user owns the requested pharmacy order. The identity check and order lookup can exist in different functions. Each function can look safe even though the complete path lets one customer access another customer's order.

MDASH uses specialized agents and AI models to examine these longer paths. It focuses on vulnerability types such as:

- Injection flaws.
- Memory-safety problems.
- Authentication, authorization, and resource-ownership failures.
- Other logic errors.

This approach can help find previously unknown vulnerabilities. However, no scanner finds every issue, and a scan doesn't guarantee the discovery of a new vulnerability.

## Understand why findings need validation

A scanner can report an issue that isn't reachable or doesn't affect a deployed application. Reviewing too many uncertain findings takes time and can reduce trust in the tool.

Teams therefore ask three basic questions:

1. **Is the weakness present?**
2. **Can an attacker reach it?**
3. **What could happen if it is exploited?**

MDASH uses separate agents to find possible issues and challenge the evidence. It reports **confidence**, which shows how certain the scanner is, and **severity**, which shows the potential impact.

People still make the final decision. They understand the application's purpose, deployment, data, and business importance.

## Use MDASH with other security controls

MDASH is one part of a layered application security program:

| Security practice | Main purpose |
|:--|:--|
| Static analysis | Finds known patterns across source code. |
| Dynamic testing | Tests the application while it runs. |
| Threat modeling | Examines security risks in the design. |
| Manual review | Applies technical and business context. |
| Codename MDASH | Reasons across complex source-code paths. |

MDASH doesn't scan compiled binaries or Java archive (JAR) files. It needs access to source code and has specialized support for several common programming languages.

For Caldova, MDASH doesn't replace existing tools. It adds another way to trace the code paths behind the merchant portal and AI support agent. The team can then investigate whether failed identity or ownership checks allow unauthorized order access or disruption to pharmacy operations.
