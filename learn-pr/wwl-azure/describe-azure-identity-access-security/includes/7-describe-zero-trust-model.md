Zero Trust is a security model that assumes the worst case scenario and protects resources with that expectation. Zero Trust assumes breach at the outset, and then verifies each request as though it originated from an uncontrolled network.

Today, IT teams need a security model that effectively adapts to the complexity of the modern environment; embraces the mobile workforce; and protects people, devices, applications, and data wherever they're located.

To address this new world of computing, Microsoft highly recommends the Zero Trust security model, which is based on these guiding principles:

 -  **Verify explicitly** \- Always authenticate and authorize based on all available data points.
 -  **Use least privilege access** \- Limit user access with Just-In-Time and Just-Enough-Access (JIT/JEA), risk-based adaptive policies, and data protection.
 -  **Assume breach** \- Minimize blast radius and segment access. Verify end-to-end encryption. Use analytics to get visibility, drive threat detection, and improve defenses.

:::image type="content" source="../media/zero-trust-option-principles-triad.png" alt-text="Diagram showing the three Zero Trust guiding principles: Verify explicitly, Use least privilege access, and Assume breach, each with key actions listed.":::

## Adjusting to Zero Trust

Traditionally, perimeter-based networks were restricted, protected, and generally assumed safe. Only managed computers could join the network, VPN access was tightly controlled, and personal devices were frequently restricted or blocked.

The Zero Trust model flips that scenario. Instead of assuming that a device is safe because it’s within a trusted internal network, it requires everyone to authenticate. Then grants access based on authentication rather than location.

## Example in practice

Suppose a user signs in from an unmanaged device on a public network. A Zero Trust approach still evaluates identity signals, device state, and risk conditions before granting access. You might allow access to low-risk apps, require MFA for sensitive systems, or block sign-in entirely when risk is too high.

At a fundamentals level, Zero Trust means access decisions are continuous and context-aware, not based only on where the request originates.

:::image type="content" source="../media/zero-trust-option-traditional-vs-modern.png" alt-text="Diagram comparing traditional perimeter security, which trusts based on network location, with Zero Trust, which verifies every request using identity, device, and risk signals.":::

