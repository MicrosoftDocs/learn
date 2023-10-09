A Decentralized Identifier (DID), as defined by the [W3C recommendation for Decentralized Identifiers (DIDs) v1.0 Core architecture, data model, and representations](https://www.w3.org/TR/did-core/), is a globally unique persistent identifier that doesn't require a centralized registration authority and is often generated and/or registered cryptographically.

A decentralized identifier is also type of uniform resource identifier (URI). URIs are a string of characters that are used to identify resources, most commonly web resources, through various naming schemes and access methods.  If you've ever searched the web, then you've used a URI because a uniform resource locator (URL), the address you enter into the browser, is a class of URI.

A DID consists of three pieces of information and looks as follows.

:::image type="content" source="../media/did-structure.png" alt-text="Diagram that shows the three parts that make up a DID, the scheme, the DID method, and the DID method-specific identifier.":::

- Scheme –This identifies the URI scheme.  The scheme name, in this case “did”, refers to the specification for assigning identifiers within that scheme.
- DID method – The DID methods refer to the mechanism by which a DID is created, resolved, updated, and deactivated.  There are many different methods, and each method is defined by a specification. The list of available DID methods is available at the [W3C Group Note on DID Specification Registries:
The interoperability registry for Decentralized Identifiers](https://w3c.github.io/did-spec-registries/#did-methods).  The specifications for DIDs are based on open standards.  As such, all the methods support consistent basic functionality that ensures interoperability with the applications that use DIDs, even if those DID were generated using different methods.
- DID Method specific identifier – The DID method specific identifier is a unique identifier generated in accordance with the method specification.

As depicted by the syntax, a DID isn't designed as a user-friendly, readable string, nor does it need to be.  We mentioned earlier that DIDs are a new type of identifier that makes verifiable credentials, a type of digital identity, possible.  It's important to note, however, that a decentralized identifier isn't the same thing as your digital identity.  As an analogy, think about your passport or driver’s license, in the physical world.  Each of these credentials, or form of identity, have unique identifiers in the form of a passport number or driver’s license number. When you're asked to prove your identity, you show your license or passport, which is the credential.  You don’t recite the number or identifier on that credential. That said, the identifier is a key part of that credential.  The same is true of the relationship between DIDs and verifiable credentials.

From an end-user perspective, DIDs are mostly transparent.  It’s the applications such as digital wallets and the services like Microsoft Entra Verified ID that create, manage, and use DIDs.  But understanding what makes these identifiers special and how they work will provide a richer understanding of the services DIDs enable.
