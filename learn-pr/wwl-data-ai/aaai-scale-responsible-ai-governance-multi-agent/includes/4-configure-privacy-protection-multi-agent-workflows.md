Fabrikam's multi-agent code review system processes proprietary enterprise source code containing business logic, security implementations, and integration patterns that represent significant competitive value. As code flows through eight specialized agents—from preprocessing to security analysis to quality assessment—each processing stage creates privacy exposure points. Multi-agent workflows amplify privacy risks because data crosses multiple model boundaries, storage stages, and processing contexts. Configuring comprehensive privacy protection requires detecting sensitive information before agent processing, minimizing data exposure at each stage, enforcing consent and purpose limitations, and controlling data residency throughout the workflow. The Azure AI Language Service detects and redacts sensitive information before it reaches the agent pipeline, while Microsoft Foundry project settings enforce consent boundaries and data residency requirements.

The following table illustrates how multi-agent workflows multiply privacy exposure points compared to single-agent processing:

| Privacy Challenge | Single Agent | Multi-Agent Workflow |
|-------------------|--------------|---------------------|
| PII exposure points | One model call | Eight agent processing stages |
| Data minimization | One input scope | Different data needs per agent |
| Consent tracking | One purpose | Multiple processing purposes |

## Recognize PII in source code repositories

Source code contains more personally identifiable information than traditional business data privacy frameworks typically address. While database schemas and API payloads receive scrutiny for PII, source code repositories accumulate sensitive information through the natural development process.

Developer email addresses appear in commit metadata, inline comments for code reviews, and documentation headers. Personal API keys and credentials get hard-coded during local development and accidentally committed before being rotated. Test data files include real customer records copied from production databases "just to make the tests realistic." Configuration files contain file paths with Windows usernames, connection strings with embedded credentials, and environment-specific settings revealing infrastructure details. Comments and documentation include names of team members, references to internal projects, and sometimes even phone numbers or Slack handles for "contact me if this breaks."

For Fabrikam's enterprise customers, this PII represents multiple privacy concerns. Under GDPR, developer email addresses are personal data requiring protection. API keys and credentials, even if later rotated, represent security risks if exposed. Real customer data in test files violates purpose limitation principles—data collected for production use shouldn't appear in development code repositories.

Your multi-agent code review workflow processes all of this. Without PII detection and removal, customer names, developer identities, and potentially sensitive business information flows through eight agents' processing stages, gets logged in reasoning traces, and persists in audit records. Each stage multiplies the exposure.

## Implement PII detection before agent processing

Privacy protection begins before the first agent receives code. You implement a pre-processing PII detection stage using the Azure AI Language Service that scans all code submissions for sensitive information before any review agent processes the content.

The PII detector operates on the raw code submission and identifies patterns matching: email addresses, phone numbers, IP addresses, credit card numbers, personal names in comments and logs, API keys and credentials (using entropy detection), physical addresses and postal codes, and social security numbers or national identity numbers. The detector uses pattern matching for structured PII like email addresses and phone numbers, and machine learning classifiers for unstructured PII like names appearing in natural language comments.

When PII is detected, you apply contextual redaction. Email addresses in commit metadata are preserved because code attribution is part of the legitimate code review purpose—but these addresses are flagged to prevent them from being included in training data. Hard-coded API keys and credentials are redacted completely and replaced with placeholder values like `[REDACTED-API-KEY]`, while simultaneously triggering a security alert to the development team that credentials were committed. Personal names in comments are evaluated contextually—"Contact Sarah Chen for questions about this algorithm" gets redacted to "Contact [TEAM-CONTACT] for questions", while "The Chen algorithm is described in..." is preserved because it's a technical reference, not PII.

```python
from azure.ai.textanalytics import TextAnalyticsClient
from azure.core.credentials import AzureKeyCredential
import re

def detect_and_redact_pii(code_content, language_endpoint, language_key):
    """
    Detect and redact PII from source code before multi-agent processing.

    Returns redacted code and PII detection report for audit logging.
    """
    client = TextAnalyticsClient(
        endpoint=language_endpoint,
        credential=AzureKeyCredential(language_key)
    )

    # Analyze text for PII using Azure AI Language Service
    response = client.recognize_pii_entities([code_content], language="en")
    result = response[0]

    redacted_code = code_content
    pii_detections = []

    if not result.is_error:
        # Process detected PII entities (sorted in reverse offset order to preserve positions)
        sorted_entities = sorted(result.entities, key=lambda e: e.offset, reverse=True)
        for entity in sorted_entities:
            pii_detections.append({
                'type': entity.category,
                'text': entity.text,
                'confidence': entity.confidence_score,
                'offset': entity.offset,
                'length': entity.length
            })

            # Apply contextual redaction
            if entity.category == 'Email':
                # Preserve structure but anonymize: test@example.com -> [EMAIL-n]@redacted.local
                redaction = f"[EMAIL-{len(pii_detections)}]@redacted.local"
            elif entity.category in ['CreditCardNumber', 'IPAddress']:
                # Full redaction for sensitive data
                redaction = f"[REDACTED-{entity.category.upper()}]"
            elif entity.category == 'Person':
                # Context-dependent: preserve technical references, redact personal
                if is_technical_reference(entity.text, code_content):
                    continue  # Don't redact technical algorithm names
                redaction = "[TEAM-CONTACT]"
            else:
                redaction = f"[REDACTED-{entity.category.upper()}]"

            # Replace PII with redaction placeholder (reverse order keeps offsets valid)
            redacted_code = (
                redacted_code[:entity.offset]
                + redaction
                + redacted_code[entity.offset + entity.length:]
            )

    # Additional pattern-based detection for API keys (high entropy strings)
    api_key_pattern = r'["\']([A-Za-z0-9_\-]{32,})["\']'
    for match in re.finditer(api_key_pattern, redacted_code):
        if calculate_entropy(match.group(1)) > 4.5:  # High entropy indicates key
            pii_detections.append({
                'type': 'ApiKey',
                'text': '[REDACTED]',
                'confidence': 0.85,
                'offset': match.start(),
                'length': len(match.group(1))
            })
            redacted_code = redacted_code.replace(match.group(1), '[REDACTED-API-KEY]')

    return {
        'redacted_code': redacted_code,
        'pii_detected': len(pii_detections) > 0,
        'detections': pii_detections,
        'detection_timestamp': '2026-04-07T10:30:00Z'
    }

def is_technical_reference(person_name, code_context):
    """Check if person name is technical reference (algorithm, pattern) vs personal name."""
    technical_indicators = ['algorithm', 'method', 'pattern', 'theorem', 'function']
    context_window = code_context[max(0, code_context.find(person_name) - 100):
                                   code_context.find(person_name) + 100]
    return any(indicator in context_window.lower() for indicator in technical_indicators)

def calculate_entropy(text):
    """Calculate Shannon entropy to identify high-entropy strings like API keys."""
    import math
    from collections import Counter
    
    if not text:
        return 0
    
    counts = Counter(text)
    frequencies = [count / len(text) for count in counts.values()]
    return -sum(freq * math.log2(freq) for freq in frequencies)
```

## Minimize data exposure in agent chains

Each agent in the review pipeline needs different information to perform its task. The style analysis agent evaluates code formatting and doesn't need to know which developer submitted the code. The security analysis agent examines input validation and exception handling but doesn't need the full file context—only the relevant functions. Data minimization means each agent receives exactly the data required for its specific function, and no more.

You implement data mapping that defines minimum required inputs per agent. The preprocessing agent receives the complete code submission because its purpose is to extract relevant sections and patterns for downstream agents. The security analysis agent receives: code sections containing user input handling, database interactions, authentication logic, and error handling—but not utility functions, UI components, or test files unrelated to security. The quality assessment agent receives: function implementations, class structures, and documentation—but not commit metadata or developer context.

This mapping is enforced by the orchestrator. When routing work to agents, the orchestrator filters the input to include only fields marked as required for that agent's function in the data mapping. If a compromised agent attempts to access data beyond its scope, the access is denied because the data wasn't included in the request.

Data minimization reduces privacy exposure—fewer agents processing PII means fewer points where data could leak. It also reduces costs because agents process smaller inputs, consuming fewer tokens. For Fabrikam's enterprise customers, it demonstrates privacy-by-design: the system is architecturally incapable of exposing certain data to certain agents.

## Enforce consent and purpose limitation

Enterprise customers contract with Fabrikam for code review services. This contract establishes the legal basis and scope for processing their code. Using that code for other purposes—training future models, benchmarking against other customers, or incorporating code patterns into general knowledge—requires separate, explicit consent.

You configure Microsoft Foundry project settings to opt out of training data collection for all enterprise tenant deployments. The `customerManagedKey` and `publicNetworkAccess: Disabled` settings ensure customer code stays within the contracted boundary and doesn't contribute to Microsoft's broader model training. This configuration is set at the Microsoft Foundry project level and applies to all model deployments within that project.

Purpose limitation logging tracks how code is used. Every time code flows through an agent, the processing logs include the purpose: "code review - security analysis", "code review - quality assessment", "audit - compliance verification". When enterprise customers request data processing records, you provide a complete purpose log showing their code was processed only for the contracted code review service, never for other purposes.

Consent status is tracked per tenant. The data processing agreement with each enterprise customer specifies: allowed processing purposes (code review, security analysis, quality assessment), prohibited purposes (model training, public benchmarking), data retention period after contract termination (typically 90 days), and data residency requirements (which Azure region stores their code). These preferences are stored in tenant configuration and enforced automatically by the orchestrator.

## Control data residency throughout workflows

Enterprise customer source code is intellectual property protected by confidentiality agreements. Many contracts specify that code must remain in a particular Azure region to comply with data sovereignty requirements or corporate policy. For customers in Europe, GDPR considerations may require code to stay within EU data centers.

You design data flow architecture that proves code never leaves the contracted region. All Microsoft Foundry resources—model deployments, vector stores, search indices, blob storage—are deployed in the same Azure region specified in the customer's contract. Network egress is locked down using private endpoints and VNet integration. The orchestrator coordinates agents using regional endpoints only, preventing code from being routed through global endpoints that might cross regions.

Data flow diagrams document the complete path code takes through the system. The diagram shows: code submission arrives via API Management in the contracted region, code flows to storage account in the same region (with geo-replication disabled to prevent region copies), all agent processing occurs in compute resources within the region, reasoning traces and audit logs write to Log Analytics workspace in the region, and code review results return through the regional API gateway. Every component includes the region designation, making the diagram a compliance artifact for demonstrating data residency.

For customers with different residency requirements, you maintain regional deployments. European customers' code processes through agents deployed in the West Europe region. US customers with FedRAMP requirements use agents in US Government regions. This regional separation is enforced at the Azure subscription level—different subscriptions for different compliance boundaries, preventing accidental cross-region data flow even during development or operations.

> [!TIP]
> A developer commits code containing a hardcoded API key inside a comment that also references a colleague by name. The code flows through your eight-agent review pipeline. How would you design the PII detection stage to handle both the credential and the personal reference without losing the code review's technical value?

With comprehensive privacy protection in place—PII detection before agent processing, data minimization per agent function, consent and purpose enforcement, and regional data residency controls—you ensure Fabrikam's multi-agent system respects the confidentiality of enterprise source code. The final governance dimension establishes accountability mechanisms that prove the system operates as designed and enables continuous improvement through audit feedback.
