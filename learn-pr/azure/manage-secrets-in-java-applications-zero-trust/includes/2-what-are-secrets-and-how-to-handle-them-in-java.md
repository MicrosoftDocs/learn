Secrets are strings of characters that should not be shared with the outside world:
they could be database passwords, private encryption keys, personal access tokens, etc.
For enhanced security, many people also consider that anything that could help an attacker should be considered a secret: for example, the URL to your production database could be seen as a secret. Your database shouldn't be publicly accessible, but the rationale here is that this kind of information is sensitive by nature, and the less information is available in your code, the better.

## What is Zero Trust and Zero Secrets?

The concept of Zero Trust is that no one should be blindly trusted, and allowed to access company resources without being validated and authorized.

This applies to Web applications too: they shouldn't have secrets stored in their
code or in their final binaries. This is what we call Zero Secrets.

Secrets should be managed by an external system, with strict access rules and validation, to reduce the attack risk.

