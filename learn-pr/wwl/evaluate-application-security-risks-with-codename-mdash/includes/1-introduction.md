**Estimated completion time:** 45 minutes.

Application security helps protect software from design through operation. An important part of this work is finding **vulnerabilities**, which are weaknesses that an attacker might exploit.

## Understand what Codename MDASH means

The name **MDASH** comes from **multi-model agentic scanning harness**:

- **Multi-model:** The system uses more than one artificial intelligence (AI) model.
- **Agentic:** Specialized AI agents perform different security tasks.
- **Scanning harness:** A system coordinates the models, agents, analysis steps, and evidence.

Codename MDASH is a source-code scanner in Microsoft Defender. Source code is the human-readable code that developers write to create software. MDASH uses more than 100 specialized agents to help find, check, and prioritize vulnerabilities in that code.

The following Microsoft Security video introduces Codename MDASH and the security challenge it addresses.

> [!VIDEO https://www.youtube.com/embed/6HEqAevN1Pc]

## Place MDASH in an application security program

Traditional static analysis tools compare code with rules and known unsafe patterns. They provide broad, repeatable checks. However, some vulnerabilities depend on activity across several files or functions and don't match a simple pattern.

MDASH adds AI-based reasoning for these complex paths. It reports possible vulnerabilities, called **findings**, with information about their potential impact and the scanner's confidence.

MDASH complements existing security practices. It doesn't replace secure design, testing, threat modeling, or human review. Security teams still decide which findings matter, and developers review and test any proposed fix.

> [!NOTE]
> Codename MDASH is in private preview. Features, requirements, and availability can change.

## Follow the Caldova scenario

Caldova operates a robotic pharmacy-delivery service. Its merchant portal and AI support agent appear to work normally. However, a controlled security test that simulates attacker behavior shows that an attacker might be able to pause pharmacy operations or access another customer's order.

Caldova already uses static analysis, testing, and manual code review. After confirming the business impact, its security team evaluates MDASH to investigate whether authentication, authorization, identity, or resource-ownership checks fail across several parts of the application.

In this module, you learn:

- Why some vulnerabilities are difficult for pattern-based scanners to find.
- How MDASH finds and checks possible vulnerabilities.
- How teams prioritize findings.
- Where MDASH adds value and what its current limits are.

By the end of the module, you can explain the basic role of MDASH in an application security program.
