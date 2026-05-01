AI overreliance occurs when people accept the output of AI systems as correct without applying critical analysis or independent verification. Unlike the other attack techniques covered in this module, overreliance isn't something an adversary does to the system—it's a human behavioral risk that can be just as damaging to an organization's security posture.

## Why overreliance is a security concern

Overreliance on AI creates security vulnerabilities in several ways:

- **Unverified decisions**: A company might rely on AI-generated security assessments to make critical decisions without verifying the analysis. If the AI produces a confidently stated but incorrect output, the organization may take inappropriate action.
- **Missed errors in AI-generated code**: Developers who accept AI-generated code without review might introduce security vulnerabilities into production systems—for example, code that doesn't properly validate inputs or that exposes sensitive data.
- **Automation bias**: People tend to favor AI-generated suggestions over their own judgment, especially when the AI provides output quickly and confidently. This cognitive bias makes it harder for users to catch errors.
- **Erosion of human expertise**: Over time, teams that consistently defer to AI may lose the skills needed to independently evaluate decisions, creating an organizational dependency.

## Plausible-sounding but factually incorrect output

Cases where a model generates plausible-sounding but factually incorrect outputs are a key driver of overreliance risk. Generative AI models don't "know" whether their output is correct. They produce text based on statistical patterns, which means they can state false information with the same confidence as true information. Users who don't understand this limitation are especially vulnerable to acting on incorrect AI output.

Examples of risks driven by incorrect output include:

- An AI citing a legal case that doesn't exist, leading to embarrassment or legal consequences
- An AI recommending a security configuration that sounds reasonable but contains a critical flaw
- An AI summarizing a document and omitting or inventing key details

## Mitigating overreliance

Addressing overreliance requires a combination of technical controls, user education, and thoughtful user experience (UX) design.

### Technical controls

- **Confidence indicators**: Where possible, display the model's confidence level alongside its output so users can gauge reliability
- **Source citations**: Require the AI to cite sources for claims so that users can verify accuracy
- **Human-in-the-loop workflows**: For high-stakes decisions (security assessments, financial approvals, medical diagnoses), require human review and approval before action is taken
- **Output disclaimers**: Include clear notices that AI output should be verified, especially in professional contexts

### User education

- Train users to understand that AI models can and do make mistakes
- Educate teams on how to recognize instances where a model generates plausible-sounding but factually incorrect output
- Establish organizational policies that define when AI output requires independent verification
- Create awareness of automation bias and provide strategies for critical evaluation

### UX design strategies

User experience designers play a crucial role in mitigating AI overreliance:

- **Explanations**: Create interfaces that provide clear explanations for AI recommendations. When users understand the reasoning behind suggestions, they're less likely to blindly rely on them.
- **Customization options**: Allow users to customize AI behavior. Giving users control over settings and preferences empowers them to make informed decisions.
- **Feedback mechanisms**: Enable users to provide feedback on AI performance. This feedback loop helps improve the system and ensures users remain engaged and critical.
- **Friction by design**: Intentionally add small verification steps for consequential actions, such as requiring users to confirm they've reviewed AI-generated output before submitting it.

Research shows that simply providing AI-generated explanations don't significantly reduce overreliance compared to providing predictions alone. People tend to accept explanations that sound plausible without questioning them. This finding reinforces the need for multiple mitigation strategies working together, rather than relying on any single approach.
