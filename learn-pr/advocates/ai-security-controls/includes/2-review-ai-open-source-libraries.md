Open-source software (OSS) is an integral part of modern software development, and AI systems are no exception. AI projects typically depend on open-source frameworks, model libraries, pretrained models, and data processing tools. Just like other OSS components, AI-specific libraries introduce supply chain risks that require a comprehensive security review before adoption.

## Why AI open-source libraries need special attention

AI OSS libraries carry some risks that go beyond those of traditional software dependencies:

- **Pre-trained models**: Many AI libraries ship with or download pretrained models. A compromised model can contain backdoors or biased behavior that's difficult to detect through code review alone.
- **Data pipeline dependencies**: AI libraries often handle data loading, transformation, and feature extraction. Vulnerabilities in these components can expose training data or allow data poisoning.
- **Serialization risks**: AI models are frequently saved and loaded using serialization formats (such as pickle in Python). Deserializing untrusted model files can lead to arbitrary code execution.
- **Rapid release cycles**: AI libraries evolve quickly, with frequent breaking changes. Organizations that pin to older versions may miss critical security patches.

<!-- IMAGE PLACEHOLDER: Conceptual diagram
Alt text: Diagram showing four AI-specific supply chain risks for open-source libraries
Suggested source: Custom diagram needed
Capture instructions: Create a diagram with four risk categories (pre-trained models with backdoors, data pipeline vulnerabilities, serialization/deserialization risks, rapid release cycles) branching from a central "AI OSS Library" node.
Suggested filename: ai-oss-supply-chain-risks.png
Priority: Medium
-->

## Assess the suitability of OSS libraries

Before adopting an AI OSS library, evaluate it from both functional and security perspectives:

- **Context and purpose**: Define why you're reviewing this library. Are you integrating it into a production system, using it for experimentation, or evaluating it against alternatives? Establish clear acceptance criteria for the review.
- **Risk assessment**: Consider the potential risks of using the library. Use threat modeling to identify attack vectors—how does this library fit into your application's attack surface? What happens if the library is compromised?
- **License compliance**: Verify that the library's license is compatible with your organization's policies, especially for commercial or government use.
- **Maintenance health**: Check how actively the library is maintained. Look at commit frequency, issue response times, and the number of active contributors. Abandoned or minimally maintained libraries are higher risk.

## Code review and dependency analysis

Perform a technical review of the library's code and its dependency chain:

- **Code inspection**: Examine the library's source code for security flaws such as injection vulnerabilities, insecure cryptographic practices, and unsafe deserialization. Pay attention to authentication mechanisms, input validation, and error handling.
- **Dependency evaluation**: Assess the library's transitive dependencies. Outdated or vulnerable components in the dependency tree can introduce risks even if the library's own code is secure.
- **Software composition analysis (SCA)**: Use automated SCA tools to identify known vulnerabilities (CVEs) in the library and its dependencies. Many organizations integrate these tools into their CI/CD pipeline to catch issues early.

## AI-specific supply chain controls

Beyond standard OSS review practices, apply these AI-specific controls:

- **Model provenance verification**: When a library includes pretrained models, verify where the model came from, who trained it, and whether the training data and process are documented. An AI bill of materials (AI-BOM)—a structured inventory of model components, training data sources, and dependencies—helps establish trust.
- **Model scanning**: Scan downloaded model files for known malicious payloads before loading them. Avoid deserializing model files from untrusted sources.
- **Reproducibility checks**: Where possible, verify that models can be reproduced from documented training data and configurations. This helps confirm that the model hasn't been tampered with.
- **Sandboxed evaluation**: Test new AI libraries in isolated environments before deploying them in production to contain any unexpected behavior.

## Vulnerability scanning and remediation

Don't assume that others have performed vulnerability checks. Apply your own assessment toolchain:

- **Comprehensive scans**: Use vulnerability scanners to identify potential security weaknesses in the library and its dependencies.
- **Prioritized remediation**: If vulnerabilities are detected, assess their impact and exploitability. Prioritize fixes based on severity and exposure.
- **Continuous monitoring**: OSS vulnerability databases are updated regularly. Set up automated alerts for new CVEs affecting libraries in your AI stack.

:::image type="content" source="../media/ai-oss-library-review-process.png" alt-text="Flowchart of the AI open-source library security review process from assessment to approval." lightbox="../media/ai-oss-library-review-process.png":::
