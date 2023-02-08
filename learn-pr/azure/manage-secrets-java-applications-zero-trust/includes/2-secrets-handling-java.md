Secrets are strings of characters that shouldn't be shared with the outside world:
they could be database passwords, private encryption keys, personal access tokens, and so on.
For enhanced security, many people also consider that anything that could help an attacker should be considered a secret: for example, the URL to your production database could be seen as a secret. Your database shouldn't be publicly accessible. The rationale is that this kind of information is sensitive by nature, and the less information is available in your code, the better.

## What is Zero Trust and Zero Secrets?

The concept of Zero Trust is that no one should be blindly trusted, and allowed to access company resources without being validated and authorized.

This concept applies to Web applications too: they shouldn't have secrets stored in their
code or in their final binaries. It's what we call Zero Secrets.

Secrets should be managed by an external system, with strict access rules and validation, to reduce the attack risk.

## Don't put secrets into Git repositories

Even if your Git repository is private, putting any secret in your source code is a bad practice:

- Anybody having access to your repository will know your sensitive data
- Anybody having access to your application binary will be able to extract secrets from it

Also, once a secret has been stored into Git, attackers can always find it by looking in the repository's history, where it
can be forgotten for a long time.

Even if that seems practical, you should never store any secrets in your source code repository. To avoid this issue, you can use automatic tools that regularly check your repository and will send warnings if they find a password or database URL stored by mistake.

## Using environment variables

The easiest solution for managing secrets is to use environment variables. They have several benefits:

- They're easy to use,
- They work on all systems (even non-cloud systems),
- Everyone knows them and understands how they work.

However, they're not secure enough: all processes on your system can read them, and they'll be easily exposed
using JMX on a Java system.

As a result, environment variables are often seen as a first step towards Zero Trust: they're more secure than storing secrets
directly into the source code, but they lack management capabilities and
are easy to access for attackers.

## Using Kubernetes secrets

Kubernetes has a notion of `secrets`, which is another good solution. Those secrets can be loaded as a file on the application's
filesystem: a Java program can then read that file at startup time, to access those secrets. Tools like the Spring Frameworks even
have standard support for this mechanism, allowing them to use those secrets in an easy and efficient way.

This mechanism is more secure than environment variables, as those files can be read only by the process that will require them. They
also benefit from the rich Kubernetes ecosystem, and they can be managed by various management tools, including the tools provided by
your cloud provider.

While Kubernetes secrets are a good solution for Kubernetes, they're also limited to Kubernetes, and lack advanced management capabilities, depending
on the tools used to manage the Kubernetes infrastructure.

## Using a Secrets store

A Secrets store, like Hashicorp Vault or Azure Key Vault, is a specialized software for managing secrets. It offers a rich management
system to authorize users, rotate security keys, and validates which application can access which secret.

They also provide an external API, so they can be used on any system. For example, you can use Azure Key Vault on all Azure services,
including Virtual Machines, Azure App Services, Azure Kubernetes Services, or Azure Spring Apps.

A Secrets store is the most secure and advanced solution for managing secrets, but they require the use of a dedicated tool.
