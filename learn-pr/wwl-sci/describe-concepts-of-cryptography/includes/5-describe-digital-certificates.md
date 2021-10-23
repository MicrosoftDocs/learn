Cryptography has many applications in today's modern world. So far, you've seen how it can maintain the confidentiality and authenticity of ciphertext messages. Through hashing, cryptography also verifies that a plaintext message hasn't changed.

Essentially, a digital certificate is a key pair that's been issued by a **certificate authority**. A certificate authority guarantees that the key pair being used has come from a trusted source, who has vetted and verified the identity of the person requesting it. A good example is when you want to get a passport. The government passport agency must verify that you're who you say you are before they issue the new document.

Much like a passport, digital certificates have a short lifespan, which tends to be one year, after which the certificate expires. When that happens, you'll see a warning message about expired certificates when visiting some websites. This indicates that authentication of the server can't be confirmed.

### Why do we need digital certificates?

Previously, we showed an example of Quincy and Monica wanting to share secure ciphertext messages in the encryption unit. While asymmetric encryption supports this and creates confidence that the ciphertext is safe, there's another consideration.

Because the public key is easy to obtain and is in plaintext, anyone can encrypt a message and send it to Monica, by impersonating Quincy. Monica has no way of authenticating that the message came from Quincy.

Instead of his original key pair, Quincy uses a certification authority (CA) to create a digital certificate that links his identity with the CA-generated key pair.

Now, when Quincy sends a message to Monica, he can encrypt it and attach the certificate. When Monica receives the message, she can use the CA public key to decrypt it.
