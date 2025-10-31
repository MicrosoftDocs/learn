Blocklists act as a safeguard that prevents sensitive or restricted terms from being used in prompts or model responses.

In **Azure AI Foundry**, you can create and manage custom blocklists from the **Guardrails + controls** workspace and apply them to input or output filters as part of your guardrail configuration.

These lists help protect data and uphold internal or regulatory requirements by blocking content like:

- Confidential project names
- Proprietary code terms
- Internal URLs or data sources
- Words or phrases that could expose sensitive information

A well-designed blocklist strengthens control over how data flows through your AI systems and ensures the right protections are in place before workloads reach production.

## Step 1: Create a blocklist

Start by defining a blocklist that reflects the policy you want to enforce. A clear and descriptive name helps maintain visibility across teams and environments.

- Use names that describe the list's intent, like **RestrictedTermsList** for internal or confidential terms.
- Keep naming consistent so lists can be easily identified and maintained over time.

Taking a few moments to plan naming conventions early helps you avoid confusion as your environment scales.

## Step 2: Add restricted terms

Once the blocklist is created, begin adding the terms or patterns you want the system to detect and block. Each entry represents a specific control applied when prompts or responses are evaluated.

### Add new term

Use **Add new term** to define restricted items one at a time. Each entry can be configured as an **Exact match** or a **Regex** pattern, depending on the precision you need.

- **Exact match** detects specific words or phrases exactly as they appear.
- **Regex** allows for more flexible pattern matching to capture variations or partial phrases.

This flexibility lets you adapt the blocklist to your environment, whether you're targeting sensitive identifiers, code variables, or token-like strings.

:::image type="content" source="../media/add-blocklist-term.png" alt-text="Screenshot showing the Add new term dialog with options for exact match or regex." lightbox="../media/add-blocklist-term.png":::

### Bulk add items

For larger datasets, select **Bulk add** to upload a CSV file with multiple restricted terms.
Each row includes a **Term** and a **Type** column indicating whether it's an Exact match or Regex rule.

Bulk upload saves time and helps migrate existing policy lists or import approved terms directly into Foundry.

:::image type="content" source="../media/bulk-add-blocklist.png" alt-text="Screenshot showing the Bulk add dialog for uploading a CSV file with restricted terms." lightbox="../media/bulk-add-blocklist.png":::

## Step 3: Review and manage entries

After adding your terms, they appear in the list view automatically.
You can return to the blocklist at any time to edit, remove, or add entries as your policies evolve.

Each blocklist can be reused across multiple guardrail configurations, making it easy to maintain consistent enforcement across workloads.

:::image type="content" source="../media/restricted-terms-list.png" alt-text="Screenshot showing a created RestrictedTermsList with options to add or delete terms." lightbox="../media/restricted-terms-list.png":::

Periodic reviews keep your lists aligned with changing project names, environments, or regulatory requirements.

## Step 4: Apply blocklists to guardrails

When configuring a guardrail, select your blocklist under **Input filter** and **Output filter** settings.
This ensures restricted terms are caught both when prompts are submitted and when responses are generated.

- **Input filters** prevent users from submitting restricted content.
- **Output filters** block the model from returning confidential or protected material.

Applying blocklists in both directions helps create a complete protection boundary for model interactions and reinforces responsible use across teams.

## Step 5: Validate your blocklist

After configuration, confirm that your blocklist performs as expected. Use the **Try it out** page in **Guardrails + controls** to verify that restricted terms are properly detected and blocked.

- Test both input and output cases to confirm expected detections.
- Adjust entries or detection types (Exact match vs Regex) if results need refinement.
- Review portal results to ensure that actions like annotations or blocks appear correctly.

:::image type="content" source="../media/test-blocklist.png" alt-text="Screenshot showing a blocked prompt in Azure AI Foundry where a regex in the RestrictedTermsList detects and rejects Admin-Token 9876." lightbox="../media/test-blocklist.png":::

Validation is a key assurance step—it confirms that your configuration enforces policy accurately and without unnecessary overblocking.
Treat this step as both a final check and a learning opportunity to fine-tune your detection logic.

By defining, applying, and validating a blocklist, you create a repeatable control that reduces data exposure and keeps sensitive terms out of prompts and responses.
