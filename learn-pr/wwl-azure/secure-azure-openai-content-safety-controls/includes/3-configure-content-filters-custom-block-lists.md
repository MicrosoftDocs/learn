With Azure AI Content Safety integrated into your Azure OpenAI deployment, you gain three distinct control layers: Microsoft-managed default filters, custom severity thresholds, and organization-specific blocklists. Each layer addresses different governance requirements, working together to create comprehensive content protection aligned with your business policies.

Microsoft-managed default filters provide baseline protection that applies automatically to every Azure OpenAI deployment. These filters use continuously updated machine learning models that detect harmful content across all four categories without requiring configuration. You can't disable default filters—they represent Microsoft's minimum responsible AI standards for the platform. While defaults protect against obvious policy violations, most organizations need finer control over what content their specific use cases allow. This is where custom filter thresholds and blocklists become essential.

## Configure custom content filter thresholds

Custom filter thresholds let you adjust the strictness of content blocking for each harm category independently. Unlike default filters that apply uniform protection, custom thresholds acknowledge that different applications have different risk profiles. A healthcare chatbot might accept violence severity level 4 when discussing medical procedures, while a children's education app blocks anything above level 0. You configure these thresholds at the Azure OpenAI deployment level through the Azure portal's content filters blade.

When you create a custom content filter configuration, you see four severity sliders corresponding to hate/fairness, sexual content, violence, and self-harm categories. Moving a slider to the right increases blocking sensitivity—level 0 blocks only the most severe content, while level 6 blocks nearly any reference to the category. The portal displays example content at each level, helping you understand the trade-offs between safety and functionality. For instance, setting violence to level 2 blocks graphic descriptions but allows mention of historical conflicts or news events. Setting it to level 6 blocks even metaphorical references like "the deadline is killing me."

At the same time, you can configure different thresholds for prompts versus completions. Some organizations apply stricter filtering to model outputs than to user inputs, reasoning that they control what the model generates but not what users submit. Others use identical settings for both directions, preferring consistent policy enforcement regardless of content origin. Your choice depends on whether you prioritize preventing users from seeing harmful content (strict output filtering) or preventing users from submitting harmful requests (strict input filtering). Most compliance-focused deployments choose the stricter of the two thresholds for both directions to minimize risk.

Once configured, custom filters apply immediately to new requests without requiring deployment restarts or application updates. You can adjust thresholds iteratively as you observe real-world usage patterns, tightening restrictions if you see policy violations or relaxing them if false positives impact user experience. Response headers include the detected severity scores, allowing you to identify threshold adjustments that would have blocked problematic content while maintaining legitimate functionality. This data-driven approach helps security engineers balance safety requirements against operational needs.


:::image type="content" source="../media/configured-custom-filters-apply-immediate.png" alt-text="Diagram showing how organizations can adjust thresholds iteratively to observe real-world usage patterns.":::

## Implement custom blocklists for organization-specific terms

Beyond category-based severity filtering, custom blocklists provide exact-match blocking for specific terms, phrases, or patterns unique to your organization. While content filters catch broad harmful patterns, blocklists target content that violates your specific policies but might not trigger category-level detection. Common blocklist use cases include competitor brand names, internal project code names, regulated terminology in financial or healthcare contexts, and deprecated product names that shouldn't appear in customer-facing communications.

You create blocklists as shared resources within your Azure OpenAI account, then associate them with one or more deployments. Each blocklist supports up to 10,000 terms with exact matching or wildcard patterns. For example, adding "competitor" blocks "CompetitorBrand," "competitor-product," and any variation containing that prefix. Blocklists operate independently from content filters—even if a prompt receives safe severity scores across all categories, blocked terms trigger immediate rejection with a 400 error response. This layered approach ensures both broad content safety and precise policy enforcement coexist.

:::image type="content" source="../media/create-block-lists-shared-resources.png" alt-text="Diagram showing how blocklists operate independently from content filters.":::

Building on this concept, blocklists excel at preventing leakage of confidential information. Suppose your organization uses internal code names for unreleased products or maintains lists of regulated terminology that requires special handling. Adding these terms to a blocklist ensures they never appear in Azure OpenAI responses, regardless of what prompts users submit or how models attempt to generate them. Compliance officers typically maintain these lists, updating them as new confidential projects launch or regulatory requirements change. The Azure portal supports bulk CSV import for initial blocklist population and REST API updates for programmatic lifecycle management.

Consider what happens when both content filters and blocklists evaluate the same request. Azure AI Content Safety check blocklists first for performance reasons—exact string matching completes faster than machine learning inference. If a prompt contains blocked terms, the service returns an error immediately without invoking category detection. If the prompt passes blocklist checks, content filters then analyze severity across all categories. This evaluation order means blocklists provide a fast-path rejection mechanism for known policy violations, reducing processing time and costs for requests that would fail anyway. Security engineers use this characteristic to optimize filtering performance when managing large-scale deployments with thousands of daily requests.

## Layer multiple protection mechanisms

The most robust content safety configurations combine default filters, custom thresholds, and multiple blocklists addressing different policy domains. For example, a financial services deployment might maintain separate blocklists for competitor products (managed by marketing), regulatory terminology (managed by compliance), and internal account identifiers (managed by security). Each list evolves independently based on its domain requirements, while all three apply simultaneously to every request. This separation of concerns allows different stakeholders to maintain their relevant policies without coordinating updates across teams.

With this approach, prompt shields add a fourth protection layer targeting adversarial attacks rather than content categories. While content filters and blocklists focus on what content contains, prompt shields detect how users structure prompts to bypass safety measures. Jailbreak attempts use social engineering techniques like role-playing or hypothetical scenarios to make models ignore their instructions. Document injection embeds malicious prompts within uploaded files that might escape initial detection. Enabling prompt shields adds specialized detection for these attack patterns, creating defense-in-depth protection against sophisticated adversaries. Security teams typically enable this feature for public-facing deployments while keeping it optional for internal tools where users are trusted employees.

:::image type="content" source="../media/layered-content-safety-architecture-azure.png" alt-text="Diagram showing a layered content safety architecture for Azure OpenAI production deployments.":::


*Layered content safety architecture for Azure OpenAI production deployments*


## Additional resources

- [Configure content filters for Azure OpenAI](/azure/ai-services/openai/how-to/content-filters) - Step-by-step guidance for creating and applying custom content filter configurations
- [Manage custom blocklists](/azure/ai-services/content-safety/how-to/use-blocklist) - Technical documentation for creating, updating, and associating blocklists with deployments

