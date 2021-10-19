
So far, you've seen how cryptography, through the use of encryption, can be used to keep messages safe from prying eyes. Cryptography can also be used to verify that data, like documents and images, have not been tampered with. This is done through a process called hashing.

### What is hashing?

Hashing uses an algorithm, also known as a **hashing function** to convert the original text to a unique fixed-length value. This fixed length value is called a hash value. Each time the same text is hashed using the same algorithm, the same hash value is produced. That hash can then be used as a unique identifier of its associated data.

:::image type="content" source="../media/hashing-function-example.png" alt-text="Diagram showing an example of a hashing function accepting a plaintext message and generating a hash value.":::

Hashing is different to encryption in that it doesn't use keys, and the hashed value can’t decrypt back to the original.

There are many different types of hash functions. One that is common and you may hear in discussions with security professionals is the Secure Hash Algorithm (SHA). SHA is a family of hash algorithm that each work differently. The details are beyond the scope of this content, but one of the more commonly used SHA algorithms is SHA-256 which produces a hash value that is 256 bits long.

## What is a digital signature?

A common application of hashing is in digital signing. Like a signature on a piece of paper, a digital signature validates the document that bears the signature actually comes from the person who signed it. Additionally, a digital signature is used to validate that the document that bears the signature has not been tampered with.

### How does a digital signature work?

A digital signature will always be unique to each person signing a document, much like a traditional handwritten signature.  All digital signatures make use of an asymmetric key pair: the private and public keys.

Using a digital signing service, Monica can assign a digital signature to the document to prove that it hasn’t changed. Signing the document creates a time-stamped hash for the document. This hash is then encrypted using Monica’s private key. Next, the signing service appends the hash to the original document, which is not encrypted. Finally, both the digitally signed document and Monica’s public key are sent to Victoria.

When Victoria receives the digitally signed document, she uses the same digital signing service to extract Monica’s hash from the document and generate a fresh hash for the original plaintext document. Then, using Monica’s public key, the encrypted hash is decrypted. If Monica’s decrypted hash matches the hash Victoria created for the document, then the digital signature is valid, and Victoria knows that the document hasn’t been tampered with.

The following 2-minute video demonstrates how digital signatures work and how they can show if a document has been tampered with.

 PLACE HOLDER FOR VIDEO: Showing how digital signing works

Digital signing requires making use of a digital signing service. There are many companies offering this capability. Two of the most popular are: DocuSign and Adobe Sign.
