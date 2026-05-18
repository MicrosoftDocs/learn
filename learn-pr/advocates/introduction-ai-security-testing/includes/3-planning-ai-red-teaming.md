The red teaming process is a best practice in the responsible development of applications and systems that use Large Language Models (LLMs). Red teaming complements the systematic measurement and mitigation work done by developers and helps to uncover and identify harms. Red teams also help enable measurement strategies to validate the effectiveness of mitigations.

When planning your approach to red teaming LLMs and AI-enabled applications, consider the following goals:

- Ensure that proper software security protocols are being followed for the application—AI doesn't exempt you from traditional security practices
- Test the LLM base model and determine whether there are gaps in existing safety systems, given the context of your application
- Provide feedback on failures that testing uncovers to drive improvements

The AI red teaming process has four phases: recruit the team, design adversarial tests, perform tests, and report results.

## Recruit the red team

The success of AI red teaming depends on the people you recruit. When selecting red team members, follow these principles:

- **Select for diverse experience and expertise**: Seek red team members with different backgrounds, areas of expertise, and use cases for the target system. For example, if probing a healthcare chatbot, a nurse has a different approach than a systems administrator who manages the chatbot's infrastructure.
- **Include both adversarial and benign mindsets**: Unlike traditional red teams staffed only with security professionals, AI red teams should also include ordinary users. Regular users can discover harmful behaviors through natural interaction patterns that security professionals might not think to test. For example, a nurse might convince a chatbot to release confidential patient data in a way that wouldn't occur to a security professional.
- **Assign team members to specific harms and features**: Assign members with specific expertise to probe for specific types of harms—for example, security experts probe for jailbreaks and metaprompt extraction. For multiple rounds, consider rotating assignments to bring fresh perspectives while allowing time for adjustment.
- **Provide clear objectives**: Give each team member clear instructions covering the goal, the product features to test, the types of issues to investigate, time expectations, and how to record results.

Provide a consistent way to record results, including the date, a unique identifier for reproducibility, the input prompt, and a description or screenshot of the output.

## Design adversarial tests

Because an application is built using a base model, test at both layers:

- **The LLM base model** with its safety system in place, typically through an API endpoint, to identify gaps that need addressing in the context of your application
- **The AI-enabled application** through its user interface, to test the full system including application-level safety mechanisms

Red teamers should test both layers before and after mitigations are in place.

## Perform tests

Begin by testing the base model to understand the risk surface and guide mitigation development. Test iteratively with and without mitigations to assess their effectiveness. Use both manual red teaming and systematic measurements, and test on the production UI as much as possible to replicate real-world usage.

Structure your testing around these activities:

### Determine scope of harm

Start with organizational policies on trust and safety or responsible AI, along with compliance regulations. Work with your legal and policy teams to identify the most important harms for this application. The outcome is a prioritized list of harms with examples.

Creative red teamers often find harms that weren't predicted by organizational policies. Multiple organizations have suffered reputational harm when the public discovered problematic AI outcomes that weren't tested for. A creative red team is more likely to discover these issues before release.

### Extend the list through open-ended testing

Supplement the policy-driven list with harms found through creative exploration. Prioritize harms for iterative testing based on severity and the context in which they're likely to surface. Add each newly discovered harm to the master list for future testing rounds.

### Retest after applying mitigations

Test the full list of known harms with mitigations in place. You may discover new harms or find that existing mitigations are insufficient. Update the harms list and be open to shifting priorities based on findings.

### Automate at scale

Manual red teaming is essential but difficult to scale. Supplement it with automated red teaming tools—frameworks that automate adversarial scanning of AI models and applications. For example, the open-source **Python Risk Identification Tool (PyRIT)** provides:

1. **Automated scans**: Simulates adversarial probing using curated seed prompts per risk category, with attack strategies that bypass safety alignments
2. **Scoring**: Generates an **Attack Success Rate (ASR)**—the percentage of successful attacks—giving you a quantifiable risk posture
3. **Reporting**: Produces scorecards of attack techniques and risk categories, tracked over time for compliance and continuous monitoring

For AI agents specifically, automated tools can test risk categories that are hard to reach through manual prompt testing alone, including prohibited actions, sensitive data leakage through tool calls, and task adherence.

Run automated tools in a nonproduction environment configured with production-like resources. Use them as a complement to manual testing—automation surfaces risks at scale, while human experts provide deeper analysis.

## Report results

Be strategic with data collection to avoid overwhelming red teamers while capturing critical information. For smaller exercises, a shared spreadsheet works well. For systematic testing at scale, automated tools provide structured result collection and metrics.

Share regular reports with key stakeholders that include:

- The top identified issues
- A link to the raw data
- The testing plan for upcoming rounds
- Acknowledgment of red teamers

Clarify that red teaming exposes and raises understanding of risk surface—it isn't a replacement for systematic measurement and rigorous mitigation work. Readers shouldn't interpret specific examples as a metric for the pervasiveness of that harm.
