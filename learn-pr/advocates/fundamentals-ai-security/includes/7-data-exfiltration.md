Data exfiltration is the unauthorized transfer of information from computers or devices. In AI systems, data exfiltration presents unique risks because AI models contain, access, and generate valuable data at multiple levels. MITRE ATLAS catalogs exfiltration attacks under tactic AML.TA0010.

Three types of data exfiltration related to AI are:

- Exfiltration of the AI model
- Exfiltration of training data
- Exfiltration of interaction data

## Exfiltration of the AI model

Model exfiltration is the unauthorized extraction of an AI model's architecture, weights, or other proprietary components. Attackers can exploit this to replicate or misuse the model for their own purposes, potentially compromising its integrity and intellectual property.

Model theft can occur through:

- **Direct access**: An attacker gains access to model files stored in a repository, cloud storage, or deployment environment
- **API-based extraction**: An attacker sends a large number of carefully crafted queries to the model's API and uses the responses to reconstruct a functional copy of the model (sometimes called model stealing or model cloning)
- **Side-channel attacks**: An attacker observes indirect information such as response times, memory usage, or power consumption to infer details about the model's internal structure

:::image type="content" source="../media/data-exfiltration-types-model-theft.png" alt-text="Three-column diagram of AI data exfiltration types: model theft, training data extraction, and interaction leakage with a highlight around model theft." lightbox="../media/data-exfiltration-types-model-theft.png":::

## Exfiltration of training data

Training data exfiltration occurs when the data used to build an AI model is illicitly transferred or leaked. This involves unauthorized access to sensitive datasets, which can lead to privacy breaches, regulatory violations, or adversarial attacks that exploit knowledge of the training data.

Attackers may also use **membership inference attacks** to determine whether specific data points were included in the training set—for example, confirming that a specific person's medical records were used to train a healthcare model.

:::image type="content" source="../media/data-exfiltration-types-data-extraction.png" alt-text="Three-column diagram of AI data exfiltration types: model theft, training data extraction, and interaction leakage with a highlight around training data extraction." lightbox="../media/data-exfiltration-types-data-extraction.png":::

## Exfiltration of interaction data

When users interact with AI systems—especially AI agents—they routinely provide sensitive information through prompts: financial figures, customer details, internal strategy, or proprietary code. Beyond what users type directly, AI agents also pull in organizational data through retrieval-augmented generation (RAG), tool calls, and file attachments. This creates a rich collection of sensitive data that extends well beyond the original training set.

Interaction data is vulnerable to exfiltration in several ways:

- **Prompt and response harvesting**: An attacker who gains access to conversation logs or intercepts API calls can extract the sensitive information users shared during their sessions.
- **Indirect prompt injection**: A malicious instruction hidden in a document or email can cause an agent to leak retrieved organizational data through its responses—without the user realizing what happened.
- **Tool-call payload interception**: When an agent calls external tools or APIs, it passes data between systems. If these connections aren't properly secured, an attacker can intercept the payloads to capture the data being exchanged.
- **Conversation log exposure**: Stored conversation histories contain both the user's sensitive inputs and the system's responses, which often include summarized confidential information. These logs become a high-value target if not properly protected.

Unlike model or training data exfiltration, interaction data exfiltration is an ongoing risk that occurs every time a user works with an AI system. The volume and sensitivity of this data grows with each interaction.

:::image type="content" source="../media/data-exfiltration-types-data-leakage.png" alt-text="Three-column diagram of AI data exfiltration types: model theft, training data extraction, and interaction leakage with a highlight around data leakage." lightbox="../media/data-exfiltration-types-data-leakage.png":::

## The dual role of AI in data exfiltration

AI plays a pivotal role in both preventing and enabling data exfiltration. While AI-powered tools can help detect anomalous data access patterns and identify potential breaches, AI also provides attackers with advanced capabilities to steal sensitive information more efficiently. This dual influence creates a complex challenge for organizations.

## Mitigation strategies

Data exfiltration can be mitigated through a combination of standard security practices and AI-specific controls:

- **Principle of least privilege**: Restrict access to models, training data, and interaction logs to only those who need it
- **Data classification and labeling**: Classify and label data accessed by AI applications so that monitoring systems can enforce appropriate access controls
- **Zero-trust architecture**: Don't assume trust based on network location; verify every access request
- **Encryption**: Encrypt data at rest and in transit, including conversation logs and API communications
- **Retention policies**: Limit how long interaction data is stored to reduce the window of exposure
- **Input sanitization**: Clean inputs before they're passed to external tools to prevent data leakage through agent actions
- **Behavioral monitoring**: Track agent behavior for unexpected data access patterns that might indicate an exfiltration attempt
- **Rate limiting**: Limit API query volumes to make model extraction attacks impractical


