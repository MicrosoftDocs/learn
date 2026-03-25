Microsoft Entra Verified ID is a managed verifiable credentials service based on open standards. Verified ID automates verification of identity credentials and enables privacy-protected interactions between organizations and users.

#### Why do we need it?

In the digital world, transactions are increasingly done over the web and often require individuals to make claims or assertions that organizations can digitally verify. Currently, it's difficult for individuals to obtain and present a digital credential that is cryptographically secure, privacy-compliant, and machine-readable. In addition, once you share a digital identity to access a service, it can be hard to retain control of how your identity data is used and shared.

Verifiable credentials help address these challenges. They provide individuals and organizations a way to express their qualifications and personal information over the web in a manner that is cryptographically secure, compliant with privacy requirements, and machine-readable for verification. Microsoft actively collaborates with various organizations and standards bodies, including the W3C and the Decentralized Identity Foundation (DIF), to create a decentralized identity solution that puts individuals in control of their own digital identities.

#### How it works

This diagram illustrates the participation of three parties in a verifiable credential interaction. This solution automates verification of identity credentials and claims.

:::image type="content" source="../media/verified-id-flow-inline.png" lightbox="../media/verified-id-flow-expanded.png" alt-text="Diagram showing the flow for the issuance and verification of a verifiable credential.":::

- **The issuer** is an organization that attests to claims and grants digitally signed credentials to the user. An issuer can be an identity verification provider, a government agency, an employer, a university, or any other organization that can provide proof of the user's credential.
- **The user** receives and approves the credentials obtained from the issuer, stores and manages credentials in their digital wallet, and presents them to the verifier. The credential claims are cryptographically signed with the user's private key.
- **The verifier** is an organization that requests proof and, upon receipt, verifies that the claims in the credentials satisfy requirements. A verifier could be a prospective employer, an airline, a mortgage company, or any organization that's requesting proof of the user's credential.

Supporting it all is a verifiable data registry. The underlying verifiable data registry is a collection of systems involved in creating and recording meta data that are used with verifiable credentials, including public keys. The way to think about the verifiable data registry is as an underlying network that represents a trust system. The verifier interacts with the data registry to read the meta-data associated with the credential to then verify the credential that is presented by the user.

Microsoft Entra Verified ID uses the `did:web` trust system, where the issuer's decentralized identifier (DID) is linked to a web domain that the organization controls. Trust is established through the web domain's existing reputation—verifiers trust the credential because they trust the organization that owns the domain.

A common scenario with any credential is that the credential may expire, or the issuer may need to revoke that credential. The standard for verifiable credentials includes property fields in the credential to account for these scenarios.

#### Account recovery with Verified ID

Verified ID plays a key role in Microsoft Entra ID account recovery. Account recovery helps users regain access to their accounts when they've lost all their authentication methods—for example, when their phone is lost or stolen and no backup methods are available. Unlike self-service password reset (SSPR), which requires the user to have at least one registered authentication method, account recovery re-establishes trust in the user's identity through comprehensive identity verification.

During the recovery process, users verify their identity through a trusted third-party identity verification provider (available through the Microsoft Security Store), which validates government-issued identification documents. A verifiable credential is then issued into the user's Microsoft Authenticator app. Verified ID Face Check, powered by Azure AI services, adds a critical layer of trust by matching the user's real-time selfie to the photo from their identity document. Only the match results are shared—not sensitive identity data—preserving user privacy. Once identity is confirmed, the user receives a Temporary Access Pass (TAP) to sign in and re-register their authentication methods.

#### AI and verifiable credentials

As AI-generated content and deepfakes become more prevalent, verifiable credentials play an increasingly important role in establishing digital trust. Organizations can use Verified ID to confirm that interactions involve real, verified individuals, helping mitigate risks associated with AI-driven identity fraud and impersonation.
