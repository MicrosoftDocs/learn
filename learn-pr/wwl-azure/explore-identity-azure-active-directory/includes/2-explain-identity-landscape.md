
It's important to understand the identity landscape before reviewing other identity concepts.  How does Microsoft think about identity when designing products and solutions? The essential lifecycle of identity.

| 1) Zero Trust |
|:--------------------------:|
| :::image type="icon" source="../media/icon-verify-explicitly.png" alt-text="Diagram showing a mock-up checklist to show you're verifying each record.":::Verify Explicitly      :::image type="content" source="../media/icon-least-privilege.png" alt-text="Decoration. Icon of a simple circuit showing that you should only grant the least level of access needed.":::Use Least Privilege   :::image type="content" source="../media/icon-assume-breach.png" alt-text="Decoration. Icon of two arrows with points together showing a point where a breach might have occurred.":::Assume Breach |

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


**First** you have the guidance of always thinking and designing with zero trust in mind.  Don't just give access to data and applications because the user has had access previously.  You need to always confirm.

**Second** you have systems to provide verified accounts for users and applications.  Identity services come from Azure AD, from business-to-business federation, from business-to-customer, and from decentralized identity providers.

**Third** you have specific actions identity provides and to keep the systems running.  Users and applications can authenticate and authorize to gain access to systems.  And administrators need to monitor and maintain the identity systems with proper governance.

**Fourth** you get many actions that can be performed once your credentials are verified.  Use applications and data, while taking advantage of other identity based services.

**Fifth** and finally, you need to always keep your systems up to date.

### From classic identity to zero trust identity

Historically, identity kept all your assets behind the firewall.  Submit a username and password to get through the gate, and you had full access to everything.  In the modern world, with the large number of cyber-attacks securing just the network doesn't work.  One lost or stolen credential and bad actors have access to everything.  With zero trust, you protect your assets anywhere with policy.

| Classic identity | Zero trust identity |
| :--------------- | :------------- |
| :::image type="content" source="../media/classic-identity.png" alt-text="Diagram of a set of assets like a database and an application protected behind a locked gate."::: | :::image type="content" source="../media/zero-trust-identity.png" alt-text="Diagram of a central policy in the form of a chart, giving access to different locally protected resources."::: |
| Restrict everything to a secure network | Protect assets anywhere with central policy |

Each of these subjects will be covered in more detail over the rest of this module.
