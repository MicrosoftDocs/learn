Decentralized identifiers are a key component in the process used to issue, present, and verify a verifiable credential and are the reason that users can control how and when it's presented and shared.  In other words, DIDs enable verifiable credentials.

## Entities involved in a Verifiable credential ecosystem
It’s important to first describe some of the parties involved in the verifiable credential ecosystem, as defined by the [W3C Recommendation on Verifiable Credentials Data Model v1.1](https://www.w3.org/TR/vc-data-model/).
- Issuer – The issuer creates the verifiable credential. Examples of issuers include corporations, government entities, trade organizations, and more. The issuer asserts claims about you, as the subject of the credential.
- Subject – The subject is the entity about which the claims in the credential are made.  The subject of a verifiable credential is commonly a person but can be a thing or animal.  An example where the subject could be a thing is a verifiable credential that asserts that your vehicle is registered in your state.  Similarly, an animal could be a subject as would be the case with a credential that asserts that your pet is licensed and vaccinated against rabies. For our scenario, we'll assume the subject is a person and we may refer to the subject as the user in our scenario. 
- Holder – A holder is an entity that possesses one or more verifiable credentials.  Examples of holders include students, employees, customers, etc.  A holder may be different than the subject, as would be the case of a pet owner who holds the credential that asserts that their pet (the subject) is licensed and vaccinated.  In our example and for simplicity, the holder and the subject will be the same and will be referred to as either the user or the holder, in our scenario.
- Verifier – The verifier is an entity that receives the verifiable credential for processing.  Examples, of entities that can serve as verifiers include employers, security personnel, websites, universities, etc.
- Verifiable data registry – Verifiable data registries are the systems involved in creating and recording DIDs, public keys, and other data that are used with verifiable credentials. These systems are usually distributed networks, such as distributed ledgers, blockchains, distributed file systems, or other trusted data storage. The type of registry used is dependent on the DID method.  Within the verifiable credential ecosystem, there can be many registries. You can think of the collection of these registries as an underlying network that represents a trust system.

All the parties involved in the transaction of the verifiable credential (issuer, user, verifier) have their own unique DID that is resolvable to its associated DID document.

:::image type="content" source="../media/verifiable-credentials-players.png" alt-text="Diagram that shows the main actors in a verifiable credential scenario. These include the issuer, the user, the verifier, the verifiable data registry that represents the trust system.":::

## Digital Wallet
One other important component in the verifiable credential ecosystem is the digital wallet. Simply stated, a digital wallet is representation of our physical wallet, as a software application.  Just like our physical wallets, we use it to hold credentials, such as a boarding pass, library card, money, passes, and many other types of credentials and private data.  

In reality, a digital wallet is more than that.  A digital wallet has two parts to it, the wallet itself and a digital agent. The wallet serves as a container for all the stuff you put in it - all the credentials, passes, private data, etc.  The digital agent is the software that manages the interactions with the wallet.  The agent is a bit like the user who puts credentials in the physical wallet and takes them out to present to someone who needs to verify your identity. In the context of a verifiable credential ecosystem, the agent does more.  The agent, on behalf of the end user (the holder of the digital wallet), generates the public/private key pairs and DIDs, makes requests for and presents credentials (typically through the user of QR codes), digitally signs the communications with issuers and verifiers of credentials, and more.  Some of these things, like the creation of cryptographic keys, DIDs, digital signatures, etc. are transparent to the user, but are important components used in the process of issuing and validating verifiable credentials.  

From an end-user perspective the function of the digital agent is indistinguishable from the wallet itself, because the agent is generally built into the wallet.  For this document, we treat the wallet and digital agent as one and refer to it as the digital wallet.

## Scenario and verifiable credential flow
Alice, the user, is an employee of Woodgrove, Inc. (the issuer) seeking an employee discount from an affiliate organization, Proseware (the verifier).  

:::image type="content" source="../media/verifiable-credential-flow.png" alt-text="Diagram that shows the flow for the issuance and verification of a verifiable credential..":::

1. As mentioned earlier, all parties have their public keys and DID that get recorded in a verifiable data registry, such as a decentralized ledger.  To minimize clutter, the image shown depicts the recording of this information, in the registry, only for Woodgrove.
1. Alice logs into the employee portal at Woodgrove and requests a proof of employment credential. At this point Woodgrove may display a QR code on the employee portal site. Alice scans with the QR code with digital wallet on her mobile device (this could be the Microsoft Authenticator app) that initiates Woodgrove’s attestation model for validating that Alice is an actual employee.  The attestation could take different forms. For example, Woodgrove may require Alice to authenticate against its own directory, Woodgrove may require Alice to go through an identity proofing journey that involves a third party that does the identity verification and proofing or may simply require Alice to enter a pin.  For this scenario, assume Alice only needs to enter a pin, using the digital wallet on her mobile device.
1. Once Woodgrove has validated that Alice is an employee, Woodgrove responds with the credential.  When Woodgrove issues the credential, it includes:
    - Woodgrove’s DID (issuer’s DID)
    - The subject’s DID (Alice is the subject).  
    - The claims that Woodgrove is attesting to. In this case, Woodgrove is attesting that Alice holds the title of program manager since 2011.
    - Woodgrove’s signature (issuer’s signature). Woodgrove signs the credential with its private key.
1. Alice accepts that credential, which then gets added to her digital wallet. Now that Alice has her credential, she goes to Proseware’s website to purchase a computer.
1. Before she can receive the discount, Proseware requires that Alice present proof of her employment.
1. Alice can now look in her digital wallet and authorize the wallet, on her behalf, to present that credential to Proseware. The presentation includes:
    - The credential, as issued by Woodgrove
        - Woodgrove’s DID (issuer’s DID)
        - Alice’s DID (subject’s DID).  
        - The claims that Woodgrove is attesting to. In this case, Woodgrove is attesting that Alice holds the title of program manager since 2011.
        - Woodgrove’s signature (issuer’s signature). Woodgrove signs the credential with its private key.
    - Alice’s signature (subject’s signature).  Alice signs the credential with her private key.
1. Proseware received the proof of employment and now does some lookups to verify that the credential was issued by Woodgrove and that the subject of the credential is Alice.
    - Verify the subject:
        - Since the credential includes Alice’s DID, Proseware can resolve the DID and obtain the DID document that contains the public key.
        - Since the credential was signed by Alice, Proseware can use the public key to verify that the signature on the credential really did come from Alice, as the subject.
    - Verify the issuer:
        - Since the credential includes Woodgrove’s DID, Proseware can resolve the DID to obtain Woodgrove’s DID document that contains the public key.
        - Since the credential also includes Woodgrove’s signature, Proseware can use the public key to verify that the signature on the credential really did come from Woodgrove, as the issuer.
        - In the process of verifying the issuer, Proseware never had to connect directly with Woodgrove.  Proseware only needs to connect with the distributed data registry
        - Now that Proseware has received and validated Alice’s credential, then Proseware’s business logic kicks-in to allow Alice to purchase a computer at a discounted price.  

In the transaction of issuing, presenting, and verifying the transaction there are few points worth calling out that help highlight the value of verifiable credentials:
- When issuing a credential, the claims presented are the minimum set of claims needed to meet the objective. In this case, the credential only needs to include a claim for employee’s title and the year the employment started.  This limits the amount of personal information that is shared.
- The user is in control of the credential and determines with whom they will share the credential.  In addition, the user’s wallet maintains a log of the entities with whom the credential was shared, along with other information.
- When the verifier validates the credential, they do so without having to connect with the issuer.  The verifier resolves the issuer’s DID to obtain the public keys and with the public key, is able to validate the issuer’s signature that appears on the credential.

A common scenario with any credential is that the credential may expire or the issuer may need to revoke that credential.  The W3C Recommendation for Verifiable Credentials Data Model v1.1 includes property fields in the credential to account for these scenarios.

In Alice’s digital wallet, the credential is depicted as a card like the type of credential we would have in our physical wallet.  In reality, however, a verifiable credential is a machine-readable JSON data structure consisting of a series of key/value pairs and would include the issuer’s DID, claims being asserted in the credential, digital signatures, and more.  

Visit [https://aka.ms/vcdemo](https://aka/ms/vcdemo) for a more complete demonstration of an onboarding verifiable credential scenario.
