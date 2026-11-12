Caldova can now decide where MDASH fits in its application security program. A useful evaluation starts with a clear need and accounts for the limits of the private preview.

## Identify useful scenarios

MDASH is most useful when a team needs deeper source-code analysis. Example scenarios include:

- **Investigating order ownership:** Agents trace identity and ownership checks across the merchant portal before customer order data is returned.
- **Examining memory-safety risks:** Agents reason about object lifetimes and unsafe memory use.
- **Protecting pharmacy operations:** A security team investigates code paths that can pause or change automated pharmacy activity.
- **Reviewing an important repository before release:** Caldova focuses on validated and high-severity findings in its portal and support-agent code.
- **Adding scanning to a development workflow:** The Defender CLI runs locally or in a continuous integration and continuous delivery (CI/CD) pipeline.
- **Finding repeated weakness patterns:** Security leaders compare findings across repositories.

The following image shows MDASH results in a compatible code-scanning interface.

:::image type="content" source="../media/mdash-code-scanning-results.png" alt-text="Screenshot of a code-scanning interface showing open security findings detected by the Defender AI scanner, including weakness names, source-code locations, and the main branch." lightbox="../media/mdash-code-scanning-results.png":::

## Describe the value of MDASH

MDASH provides four main types of value:

- **Deeper analysis:** Agents reason across complex code paths.
- **More evidence:** Validation and confidence help teams judge findings.
- **Clearer priorities:** Severity and context help teams focus their effort.
- **Connected workflows:** Portal views, scan history, SARIF output, and the Defender CLI support security and development teams.

MDASH doesn't find every vulnerability. It also doesn't replace static analysis, testing, threat modeling, or human review. Its value is the additional reasoning and evidence it brings to a layered security program.

## Review requirements and safeguards

Using MDASH requires supported Microsoft Defender and Microsoft Foundry resources, appropriate permissions, and access to source-code repositories.

Important safeguards include:

- Use read-only repository access for scanning.
- Give each person only the permissions required for their role.
- Review data residency and source-code handling requirements.
- Require developers to review and test suggested fixes.

Microsoft states that source code and scan results are encrypted at rest. Organizations still review their own security, compliance, and preview requirements before onboarding.

## Account for preview limits

Codename MDASH is in private preview. Current limits include:

- It scans source code, not compiled binaries or JAR files.
- Specialized language support covers Java, C and C++, C#, JavaScript and TypeScript, and Python.
- Scans can take time and run in the background.
- Capacity and regional availability vary.
- Customers can't bring their own models or agents.
- Suggested fixes require developer approval.

Caldova chooses the merchant portal and AI support agent repositories for its evaluation. It keeps existing security controls and assigns people to review findings, verify customer and operational impact, and approve changes.

A team should adopt MDASH when deeper code reasoning addresses a clear need and the preview requirements fit its environment.
