Cryptography has many applications in today's modern world. So far, you've seen how it can maintain the confidentiality and authenticity of ciphertext messages and can verify that the plaintext hasn't been modified using hashing. 

A digital certificate is, in essence, a key pair that has been issued by a **certificate authority**. A certificate authority guarantees that the key pair being used has come from a trusted source, who has vetted and verified the identity of the person requesting it. A good example is when you want to get a passport. The government passport agency must verify that you're who you say you are before they issue the passport.

Much like a passport, digital certificates are only issued for a short period, typically around one year, after which, the certificate expires. When that happens, you may encounter warning messages about expired certificates when visiting some websites. This means the authentication of the server can't be confirmed.

### Why do we need digital certificates?

Previously, we shared an example of Quincy and Monica wanting to share secure ciphertext messages in the encryption unit. While Asymmetric encryption supports this and creates confidence that the ciphertext is safe, there's another consideration.

Because the public key is easy to obtain and is in plaintext, anyone can encrypt a message and send it to Monica, pretending to be Quincy. Monica has no way of authenticating that the message came from Quincy.

Instead of using a key pair that Quincy originally used, he uses a certification authority (CA) to create a digital certificate that links his identity with the CA-generated key pair.

Now, when Quincy sends a message to Monica, he can encrypt the message and attach the certificate along with the message. When Monica receives the message, she can use the CA public key to decrypt it.
