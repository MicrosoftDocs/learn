### Centralized Identity

Centralized Identity Management or Central Identity System is a single identity tool where credentials are stored and managed, to provide authentication and authorization capabilities. This system can be on-premises or cloud based.  The system is centrally managed by an identity authority or administrator. The central identity system can then be used to offer verified access to tools, data, and other resources.

:::image type="content" source="../media/central-identity-system.png" alt-text="Diagram of a database storing verified identities.  A couple of icons showing users granted access to resources, based on their identity.":::

- Credentials are verified when stored
- Management is by single authority
   - Admin or Admin group
- Used for identity and access management
- Example: Microsoft Entra ID

**Secure adaptive access** - Protect access to resources and data using strong authentication and risk-based adaptive access policies without compromising user experience.

**Seamless user experience** - Provide an easy, fast sign-in experience to keep your users productive, reduce time managing passwords, and increase end-user productivity.

**Unified identity management** - Manage all your identities and access to all your apps in a central location, whether they’re in the cloud or on-premises, to improve visibility and control.

**Simplified identity governance** - Control access to apps and data for all users and admins efficiently with automated identity governance to ensure only authorized users have access.

### Decentralized Identity

A decentralized identity approach helps people, organizations, and things interact with each other transparently and securely, in an identity trust fabric. People control their own digital identity and credentials. Decentralized Identifiers (DIDs) are different. DIDs are user-generated, self-owned, globally unique identifiers rooted in decentralized systems. They possess unique characteristics, like greater assurance of immutability, censorship resistance, and tamper evasiveness. These attributes are critical for any ID system that is intended to provide self-ownership and user control.

To acquire a DID, you use a device under your control to download a DID User Agent app. Just as a web browser is a trusted user agent that helps you navigate the web, a DID User Agent helps you manage all aspects of DIDs—creation of identifiers, authentication, data encryption, and management of keys and permissions. A common misconception about decentralized identity is that all identity data is exposed on public systems like blockchains. Microsoft believes DID implementations should use decentralized systems strictly to anchor identifiers and non-PII DPKI metadata (as listed above) to enable routing and authentication for the DID owner without risk of censorship. A user’s actual identity data resides encrypted “off-chain,” under the user’s sole control.

:::image type="content" source="../media/decentralized-identity-flow.png" alt-text="Diagram of the flow of decentralized credentials from an external provider into the Microsoft identity system.":::

#### Components of decentralized identity

**W3C Decentralized Identifiers (DIDs)** — IDs users create, own, and control independently of any organization or government. DIDs are globally unique identifiers linked to Decentralized Public Key Infrastructure (DPKI) metadata composed of JSON documents that contain public key material, authentication descriptors, and service endpoints.

**Decentralized systems (for example, blockchains and ledgers)** — DIDs are rooted in decentralized systems that provide the mechanism and features required for DPKI. Microsoft is participating in the community development of standards and technologies for DID implementations.  The standards support various blockchains and ledgers.

**DID User Agents** — applications that enable real people to use decentralized identities. User Agent apps aid in creating DIDs, managing data and permissions, and signing/validating DID-linked claims. Microsoft will offer a Wallet-like app that can act as a User Agent for managing DIDs and associated data.

**DIF Universal Resolver** — a server that utilizes a collection of DID Drivers to provide a standard means of lookup and resolution for DIDs across implementations and decentralized systems and that returns the DID Document Object (DDO) that encapsulates DPKI metadata associated with a DID.

**DIF Identity Hubs** — a replicated mesh of encrypted personal datastores, composed of cloud and edge instances (like mobile phones, PCs or smart speakers), that facilitate identity data storage and identity interactions.

**DID Attestations** — DID-signed attestations are based on standard formats and protocols. They enable identity owners to generate, present, and verify claims. The beginning of trust between users of the systems.

**Decentralized apps and services** — DIDs paired with Identity Hub personal datastores enable the creation of a new class of apps and services. They store data with the user’s Identity Hub and operate within the confines of the permissions they're granted.
