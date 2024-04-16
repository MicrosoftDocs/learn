In today's world, our digital and physical lives are becoming increasingly intertwined with the apps, services, and devices we use. This digital revolution has opened up a world of possibilities, allowing us to connect with countless companies and individuals in ways that were once unimaginable.

This increased connectivity introduces a greater risk of identity theft and data breaches. These breaches can have a devastating impact on our personal and professional lives. But there is hope. Microsoft is working with a diverse community to create a Decentralized Identity solution that puts individuals in control of their own digital identities, providing a secure and private way to manage identity data without relying on centralized authorities or intermediaries

## Why we need decentralized identity

Today we use our digital identity at work, at home, and across every app, service, and device we use. It’s made up of everything we say, do, and experience in our lives—purchasing tickets for an event, checking into a hotel, or even ordering lunch. Currently, our identity and all our digital interactions are owned and controlled by other parties, in some cases, even without our knowledge.

Every day users grant apps and devices access to their data. A great deal of effort would be required for them to keep track of who has access to which pieces of information. On the enterprise front, collaboration with consumers and partners requires high-touch orchestration to securely exchange data in a way that maintains privacy and security for all involved.

We believe a standards-based Decentralized Identity system can unlock a new set of experiences that give users and organizations greater control over their data—and deliver a higher degree of trust and security for apps, devices, and service providers.

## What are DIDs?

Before we can understand DIDs, it helps to compare them with other identity systems. Email addresses and social network IDs are human-friendly aliases that for collaboration but are now overloaded to serve as the control points for data access across many scenarios beyond collaboration. This creates a potential problem, because access to these IDs could be removed at any time.

Decentralized Identifiers (DIDs) are different. DIDs are user-generated, self-owned, globally unique identifiers rooted in decentralized systems trust systems. They possess unique characteristics, like greater assurance of immutability, censorship resistance, and tamper evasiveness. These attributes are critical for any ID system intended to provide self-ownership and user control.<br>

Microsoft’s verifiable credential solution uses decentralized credentials (DIDs) to cryptographically sign as proof that a relying party (verifier) is attesting to information proving they are the owners of a verifiable credential. A basic understanding of DIDs is recommended for anyone creating a verifiable credential solution based on the Microsoft offering.

## What are verifiable credentials?

We use IDs in our daily lives. We have drivers licenses that we use as evidence of our ability to operate a car. Universities issue diplomas that prove we attained a level of education. We use passports to prove who we are to authorities as we arrive to other countries/regions. The data model describes how we could handle these types of scenarios when working over the internet but in a secure manner that respects users' privacy.

In short, verifiable credentials are data objects consisting of claims made by the issuer attesting information about a subject. These claims are identified by schema and include the DID issuer and subject. The issuer's DID creates a digital signature as proof that they attest to this information.<br>

## Approaches to identity

Today most organizations use centralized identity systems to provide employees credentials. They also use various methods to bring customers, partners, vendors, and relying parties into the organization’s trust boundaries. These methods include federation, creating and managing guest accounts with systems like Microsoft Entra B2B, and creating explicit trusts with relying parties. Most business relationships have a digital component, so enabling some form of trust between organizations requires significant effort.

## How decentralized identity systems work

In decentralized identity architectures, the issuer, user, and relying party (RP) each have a role in establishing and ensuring ongoing trusted exchange of each other’s credentials. The public keys of the actors’ DIDs are resolvable via the trust system, which allows signature validation and therefore trust of any artifact, including a verifiable credential. Relying parties can consume verifiable credentials without establishing trust relationships with the issuer. Instead, the issuer provides the subject a credential to present as proof to relying parties. All messages between actors are signed with the actor’s DID; DIDs from issuers and verifiers also need to own the DNS domains that generated the requests.

For example: When VC holders need to access a resource, they must present the VC to that relying party. They do so by using a wallet application to read the RP’s request to present a VC. As a part of reading the request, the wallet application uses the RP’s DID to find the RP’s public keys using the trust system, validating that the request to present the VC hasn't been tampered with. To prove domain ownership, the wallet also checks that the DID is being referenced in a metadata document hosted in the DNS domain of the RP.

:::image type="content" source="../media/dec-how-decentralized-works-3cb92d07.png" alt-text="Diagram showing how decentralized identity systems work.":::


### Flow 1: Verifiable credential issuance

In this flow, the credential holder interacts with the issuer to request a verifiable credential as illustrated in the following diagram

:::image type="content" source="../media/dec-issuance-9ccef32c.png" alt-text="Diagram showing an example of a verifiable credential issuance.":::


1.  The holder starts the flow by using a browser or native application to access the issuer’s web frontend. There, the issuer website drives the user to collect data and executes issuer-specific logic to determine whether the credential can be issued, and its content.)
2.  The issuer web frontend calls the Microsoft Entra Verified ID service to generate a VC issuance request.
3.  The web frontend renders a link to the request as a QR code or a device-specific deep link (depending on the device).
4.  The holder scans the QR code or deep link from step 3 using a Wallet app such as Microsoft Authenticator
5.  The wallet downloads the request from the link. The request includes:
     -  DID of the issuer. The issuer's DID is used by the wallet app to resolve via the trust system to find the public keys and linked domains.
     -  URL with the VC manifest, which specifies the contract requirements to issue the VC. The contract requirement can include id\_token, self-attested attributes that must be provided, or the presentation of another VC.
     -  Look and feel of the VC (URL of the logo file, colors, etc.).
6.  The wallet validates the issuance requests and processes the contract requirements:
     -  Validates that the issuance request message is signed by the issuer’s keys found in the DID document resolved via the trust system. Validating the signature ensures that the message hasn't been tampered with.
     -  Validates that the issuer owns the DNS domain referenced in the issuer’s DID document.
     -  Depending on the VC contract requirements, the wallet might require the holder to collect additional information, for example asking for self-issued attributes, or navigating through an OIDC flow to obtain an id\_token.
7.  Submits the artifacts required by the contract to the Microsoft Entra Verified ID service. The Microsoft Entra Verified ID service returns the VC, signed with the issuer’s DID key and the wallet securely stores the VC.

### Flow 2: Verifiable credential presentation

:::image type="content" source="../media/dec-presentation-18a40e72.png" alt-text="Diagram showing an example of a verifiable credential presentation.":::


In this flow, a holder interacts with a relying party (RP) to present a VC as part of its authorization requirements.

1.  The holder starts the flow by using a browser or native application to access the relying party’s web frontend.
2.  The web frontend calls the Microsoft Entra Verified ID service to generate a VC presentation request.
3.  The web frontend renders a link to the request as a QR code or a device-specific deep link (depending on the device).
4.  The holder scans the QR code or deep link from step 3 using a wallet app such as Microsoft Authenticator
5.  The wallet downloads the request from the link. The request includes:
     -  A standards based request for credentials of a schema or credential type.
6.  The wallet validates that the presentation request and finds stored VC(s) that satisfy the request. Based on the required VCs, the wallet guides the subject to select and consent to use the VCs.
     -  After the subject consents to use of the VC, the wallet generates a unique pairwise DID between the subject and the RP.
    
    Then, the wallet sends a presentation response payload to the Microsoft Entra Verified ID service signed by the subject. It contains:
    
    
     -  The VC(s) the subject consented to.
     -  The pairwise DID generated as the “subject” of the payload.
     -  The RP DID as the “audience” of the payload.
7.  The Microsoft Entra Verified ID service validates the response sent by the wallet. In some cases, the VC issuer can revoke the VC. To make sure the VC is still valid, the verifier needs to check with the VC issuer. This depends on how the verifier asked for the VC in step 2.
8.  Upon validation, the Microsoft Entra Verified ID service calls back the RP with the result.

## Key takeaways

Decentralized architectures can be used to enhance existing solutions and provide new capabilities.

To deliver on the aspirations of the Decentralized Identity Foundation (DIF) and W3C Design goals, the following items should be considered when creating a verifiable credential solution:

 -  There are no central points of trust establishment between actors in the system. That is, trust boundaries aren't expanded through federation because actors trust specific VCs.
     -  The trust system enables the discovery of any actor’s decentralized identifier (DID).
     -  The solution enables verifiers to validate any verifiable credentials (VCs) from any issuer.
     -  The solution doesn't enable the issuer to control authorization of the subject or the verifier (relying party).
 -  The actors operate in a decoupled manner, each capable of completing the tasks for their roles.
     -  Issuers service every VC request and don't discriminate on the requests serviced.
     -  Subjects own their VC once issued and can present their VC to any verifier.
     -  Verifiers can validate any VC from any subject or issuer.
