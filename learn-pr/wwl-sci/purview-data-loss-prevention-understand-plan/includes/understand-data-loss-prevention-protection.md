Data loss prevention (DLP) decisions are based on more than where data lives or who accesses it. To apply protection without disrupting normal work, DLP evaluates **what the data is**, **how it's being used**, and **where the risk occurs**.

Understanding this evaluation model is essential before planning policies or deciding where enforcement should apply.

## How DLP evaluates data

DLP evaluates multiple signals together to decide when an action puts data at risk:

- **Content**: The type of data involved, such as sensitive information types or labeled content.

- **Context**: Where the data is stored or shared, who is involved, and the application or device used.

- **Action**:  What is happening to the data, such as sharing, copying, uploading, or pasting.

DLP decisions are made by combining these signals. The same data might be allowed in one situation and restricted in another, depending on how it's used. Once DLP evaluates these signals, how protection is applied depends on where the action occurs.

## Where DLP applies protection

In Microsoft Purview, DLP can apply protection across multiple locations and surfaces. These include cloud services, endpoints, and supported browser scenarios.

Rather than thinking in terms of individual products, it's more useful to think in terms of **where data moves**:

- Data shared through email or collaboration services
- Files accessed or modified on devices
- Content copied, uploaded, or pasted through browsers

Policies can span these locations, but protections aren't identical everywhere. Understanding these differences helps avoid assumptions about what DLP enforces in each scenario.

## How classification influences DLP decisions

DLP relies on classification signals to identify sensitive content.

These signals can come from:

- **Sensitive information types**, which detect patterns or keywords
- **Sensitivity labels**, which classify content based on its importance to the organization

When data is labeled or detected as sensitive, DLP can use that information to determine whether an action should be allowed, restricted, or logged. Without classification, DLP has limited ability to make meaningful decisions.

## Why enforcement differs across locations

DLP is designed to apply consistent policy intent across locations, but enforcement depends on the surface involved. Some actions are easier to control in cloud services, while others require endpoint or browser-based protection.

Recognizing these limits early helps with planning. It prevents assuming that a single policy behaves the same way everywhere and prepares you to design policies that align with how people actually work.
