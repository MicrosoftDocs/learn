It's important to understand the identity landscape before reviewing other identity concepts. How does Microsoft think about identity when designing products and solutions? The essential lifecycle of identity.

| 1) Zero Trust |
|:--------------------------:|
| :::image type="icon" source="../media/icon-verify-explicitly.png" alt-text="Diagram showing a mock-up checklist to show you're verifying each record.":::Verify Explicitly      :::image type="content" source="../media/icon-least-privilege.png" alt-text="Decoration. Icon of a simple circuit showing that you should only grant the least level of access needed.":::Use Least Privilege   :::image type="content" source="../media/icon-assume-breach.png" alt-text="Decoration. Icon of two arrows with points together showing a point where a breach potentially occurred.":::Assume Breach |

| 2) Identity                  | 3) Actions                       |
|:--------------------------- |:------------------------------- |
| Business to Business (B2B)   | Authenticate - Prove - AuthN   |
| Business to Consumer (B2C)   | Authorize - Get - AuthZ        |
| Verifiable Credentials       | Administer - Configure          |
| (Decentralize Providers)     | Audit - Report                  |

| 4) Usage                     | 5) Maintain                      |
|:--------------------------- |:--------------------------------|
| Access applications and data | Protect - Detect - Respond |
| Secure - Cryptography        | |
| Dollars - Licenses           | |


1) **First** you have the guidance of always thinking and designing with Zero Trust in mind. Don't just give access to data and applications because the user had access previously. You need to always confirm.

2) **Second** you have systems to provide verified accounts for users and applications. Identity services come from Microsoft Entra ID, from business-to-business federation, from business-to-customer, and from decentralized identity providers.

3) **Third** you have specific actions identity provides and to keep the systems running. Users and applications can authenticate and authorize to gain access to systems. And administrators need to monitor and maintain the identity systems with proper governance.

4) **Fourth** you get many actions that can be performed once your credentials are verified. Use applications and data, while taking advantage of other identity based services.

5) **Fifth** and finally, you need to always keep your systems up to date.

### From classic identity to Zero Trust identity

Historically, identity kept all your assets behind the firewall. Submit a username and password to get through the gate, and you had full access to everything. In the modern world, with the large number of cyber-attacks securing just the network doesn't work. One lost or stolen credential and bad actors have access to everything. With Zero Trust, you protect your assets anywhere with policy.

| Classic identity | Zero Trust identity |
| :--------------- | :------------- |
| :::image type="content" source="../media/classic-identity.png" alt-text="Diagram of a set of assets like a database and an application protected behind a locked gate."::: | :::image type="content" source="../media/zero-trust-identity.png" alt-text="Diagram of a central policy in the form of a chart, giving access to different locally protected resources."::: |
| Restrict everything to a secure network | Protect assets anywhere with central policy |

Each of these subjects is covered in more detail over the rest of this module.
