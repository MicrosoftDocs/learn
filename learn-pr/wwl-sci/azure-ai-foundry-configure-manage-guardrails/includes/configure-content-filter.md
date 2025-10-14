Once you understand how each safety control works, the next step is configuring a **content filter** in **Azure AI Foundry**. Content filters are one of the key guardrail components that analyze prompts and responses for potentially harmful, ungrounded, or policy-violating content.

The **Guardrails + controls** workspace provides a single place to define how content is reviewed and filtered across AI workloads. The process involves creating a configuration, defining input and output filters, linking them to model deployments, and reviewing settings before deployment.

## Step 1: Add basic information

Start by naming your content filter. A clear, descriptive name makes it easy to identify and maintain configurations across projects.

- Choose names that describe the filter's purpose, like **InternalCopilotFilter** or **CustomerSupportFilter**.

- Keep naming conventions consistent so configurations can be tracked and updated easily.

Naming with purpose helps ensure the right protections are applied in the right environments.

:::image type="content" source="../media/basic-information.png" alt-text="Screenshot showing the Basic information page in Azure AI Foundry with a guardrail name entered." lightbox="../media/basic-information.png":::

## Step 2: Define input filters

Input filters evaluate prompts before they reach the model. These settings form your first layer of defense, helping you control what data and instructions are accepted.

- **Harm categories** define thresholds for blocking unsafe input across categories like violence, hate, sexual, and self-harm. Higher thresholds block more aggressively, while lower thresholds allow more flexibility.
- **Prompt Shields** detect jailbreak or indirect prompt-injection attempts. You can choose to annotate only, annotate and block, or turn them off depending on enforcement needs.
- **Blocklists** restrict sensitive phrases, code names, or internal identifiers. Applying a blocklist here helps reduce the risk of data leakage and enforces internal handling rules.

:::image type="content" source="../media/set-input-filter.png" alt-text="Screenshot showing the Input filter page with harm categories, prompt shields, and a selected RestrictedTermsList." lightbox="../media/set-input-filter.png":::

Input filters are especially valuable for protecting shared or externally accessible workloads where prompts can vary widely in quality and intent.

## Step 3: Configure output filters

Output filters review model responses before they're delivered to users. They protect against sensitive or inaccurate data being released and help maintain response integrity.

- **Harm category thresholds** determine what level of generated content is acceptable or blocked.
- **Protected material detection** identifies proprietary or non-Microsoft content in text or code and can either annotate or block it.
- **Groundedness detection** (preview) evaluates whether responses are supported by source data to improve reliability and reduce unsupported statements.

:::image type="content" source="../media/set-output-filter.png" alt-text="Screenshot showing the Output filter page with harm thresholds, protected material detection, and groundedness options." lightbox="../media/set-output-filter.png":::

You can mirror the input settings or adjust thresholds for outbound content. For example, internal workloads might allow more flexibility than customer-facing deployments.

## Step 4: Connect filters to deployments

Once your filters are configured, link them to the model deployments where they apply. This step determines where your protections take effect and ensures consistency across workloads.

- Connect filters to existing deployments or assign them to new ones during creation.
- Use shared configurations for similar workloads to maintain predictable safety behavior.
- Periodically review connections to ensure all active models remain protected.

:::image type="content" source="../media/apply-filter-deployments.png" alt-text="Screenshot showing the Connection page with a content filter applied to the Contoso Customer Support model deployment." lightbox="../media/apply-filter-deployments.png":::

Taking the time to review deployment connections helps you avoid gaps where a model might run without the intended guardrails in place.

## Step 5: Review and finalize

Before saving, verify that your configuration aligns with your organization's safety and compliance goals.

- Review all selected thresholds, Prompt Shield settings, and blocklists.
- Confirm that both input and output filters reflect your intended protection level.
- Save the configuration once you're confident it's ready for use.

:::image type="content" source="../media/review-filter.png" alt-text="Screenshot showing the Review page summarizing input, output, and blocklist settings before creating the guardrail." lightbox="../media/review-filter.png":::

Each content filter you create becomes a reusable policy component that can be duplicated, modified, or extended as organizational requirements evolve.

## Step 6: Validate the configuration

After configuration, validation ensures your filters behave as intended. Use the **Try it out** tab in **Guardrails + controls** to simulate prompts and verify that the system correctly classifies or blocks content.

- Test both **input** and **output** scenarios to confirm your filters respond appropriately.
- Record results to identify where thresholds or actions like _annotate only_ vs. _annotate and block_, might need adjustment.
- Confirm that detections appear in logs or activity details to verify audit visibility and traceability.

:::image type="content" source="../media/test-content-filter.png" alt-text="Screenshot showing the Try it out page in Azure AI Foundry with a built-in sample prompt triggering the Self-harm and Violence categories." lightbox="../media/test-content-filter.png":::

Validation helps fine-tune protections, catch configuration gaps, and build assurance that your AI workloads will respond safely under real-world conditions.

Configuring and validating content filters helps ensure prompts and responses remain within defined safety boundaries. These filters provide a consistent protection layer across AI workloads by combining harm detection, Prompt Shields, and blocklists into a single, enforceable control.
