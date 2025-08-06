Microsoft Purview Data Loss Prevention (DLP) plays a key role in protecting sensitive data when users interact with generative AI tools. As these tools become more common in the workplace, there's a growing risk that users might paste or upload sensitive content into AI chat interfaces or web apps that store or process the data. DLP addresses this challenge by monitoring and restricting browser and endpoint activity that could expose sensitive information.

## Understand where DLP protections apply

Microsoft Purview DLP includes several enforcement points that apply to browser-based interactions with generative AI tools:

- **Endpoint DLP**: Controls pasting and uploading sensitive data on supported browsers across onboarded Windows or macOS devices.
- **Browser DLP (Microsoft Edge for Business)**: Blocks sensitive content from being shared to specific AI apps in Microsoft Edge on Intune-managed devices.
- **Network data security (preview)**: Classifies traffic from integrated network security solutions and surfaces AI-related data-sharing events in Activity Explorer.

## Use DSPM for AI to create DLP policies

Data Security Posture Management (DSPM) for AI in Microsoft Purview includes one-click recommendations that create DLP policies for blocking or auditing interactions with generative AI tools. These policies use endpoint DLP to apply protections when users interact with content in the browser, helping you secure AI usage with minimal configuration.

**Two one-click policy options are available:**

- **Detect sensitive info added to AI sites**: Audits pasting actions into generative AI websites. This policy is active immediately after creation.
- **Block sensitive info from AI sites**: Blocks pasting and uploading actions for elevated-risk users using Adaptive Protection. This policy starts in simulation mode.

Both policies use the built-in **Generative AI Websites** service domain group, which contains commonly used generative AI tools such as ChatGPT and Google Gemini.

To create these policies:

1. Go to **DSPM for AI** in the Microsoft Purview portal.
1. On the **Overview** or **Recommendations** page, select either:

   - **Extend your insights for data discovery**
   - **Fortify your data security**

1. Follow the prompts to create the recommended policy.

## Manually configure endpoint DLP for pasting and uploading

If you need more control over your DLP policies, you can configure endpoint DLP manually to audit or restrict pasting and uploading sensitive content into AI websites.

When defining a rule, enable one or both of these actions:

- **Paste to supported browsers**
- **Upload to a restricted cloud service domain**

You can apply these actions to the built-in **Generative AI Websites** service domain group or create a custom domain group to match specific URLs.

Use these restrictions to:

- Block sensitive data from being pasted into AI chat interfaces
- Prevent uploads of documents to AI tools or cloud apps that retain user input
- Require justification through override prompts before risky actions are completed

Policies can be enforced across Microsoft Edge, Google Chrome (with extension), and Mozilla Firefox (with extension).

> [!NOTE]
> These protections only apply to devices that are onboarded to Microsoft Purview and meet the minimum version and configuration requirements.

## Configure browser DLP for managed Microsoft Edge devices

> [!NOTE]
> Browser DLP in Microsoft Edge for Business is currently in public preview.

Browser DLP allows you to block sharing of sensitive information from Microsoft Edge to unmanaged AI apps on Intune-managed devices. This configuration includes both a Purview DLP policy and a Microsoft Edge browser policy deployed through the Microsoft Edge Management Service.

To configure browser DLP:

1. Create a DLP policy scoped to **Data in browser activity**.
1. Target one or more AI apps, such as ChatGPT or Gemini.
1. Add conditions based on sensitive info types or custom classifiers.
1. Configure the action to **Restrict browser and network activities**, such as **Text upload** > **Block**.
1. Turn on simulation mode for testing, then enable full enforcement.

After creating the policy, use the Microsoft Edge admin center to apply a configuration profile that activates enforcement in Microsoft Edge.

> [!IMPORTANT]
> The user must be in scope of both the DLP policy and the Microsoft Edge configuration profile for protections to apply.

## Extend coverage with network data security (preview)

Some AI-related interactions can happen outside managed browsers or endpoints, such as through unmanaged apps or shadow IT usage. Microsoft Purview **Network Data Security** extends DLP protections by integrating with non-Microsoft network security solutions (SASE) to classify and track sensitive data shared with external AI apps and services.

This capability is useful for identifying patterns like:

- Users submitting sensitive prompts to unmanaged AI chat interfaces
- Uploading files to unsanctioned cloud storage platforms
- Sharing information through online forms or social media

These interactions are captured through **collection policies**, classified using existing DLP classifiers, and made visible in **Activity Explorer** and **DSPM for AI**.

> [!NOTE]
> Network Data Security is currently in public preview and requires both Microsoft 365 E5 licensing and a pay-as-you-go billing setup.

You can start with one-click DLP policies from DSPM for AI and expand coverage with browser, endpoint, or network-based protections. For elevated-risk users, use Adaptive Protection to apply stricter controls without disrupting productivity for everyone.
