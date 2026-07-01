After uncovering how attackers exploited stolen credentials, the IT team recognizes a core issue: as long as passwords are used, those same attacks remain possible.

To reduce this risk, the team explores passwordless authentication for [Microsoft Entra ID](/entra/fundamentals/what-is-entra), its cloud-based identity and access management service.

## What passwordless authentication means

Passwordless authentication allows users to sign in without entering a password. Instead of relying on something a user knows, it verifies identity using:

- Something a user has, such as a trusted device
- Something a user is, such as a fingerprint or facial recognition

These methods provide stronger assurance because they:

- Are harder to steal or reproduce
- Are tied to a specific user or device
- Reduce reliance on shared secrets

For the IT team, this approach directly addresses the vulnerabilities uncovered in its investigation.

## How passwordless authentication improves security

Passwordless authentication changes how identity is verified:

- **No shared secrets:** There's no password to capture, reuse, or guess
- **Stronger identity proof:** Authentication is tied to a user's physical device or biometric data
- **Reduced phishing risk:** Attackers can't use stolen credentials if no password exists, though overall security posture still depends on policy

In the organization's case, this means common attack vectors such as phishing or credential stuffing are less effective, because compromised credentials alone are no longer enough to sign in.

## Common passwordless authentication methods

As the IT team evaluates options, it identifies three primary passwordless approaches:

| **Method** | **What it uses** | **Best for** |
| :---: | :---: | :---: |
| **Windows Hello for Business** | Biometrics/PIN | Single device users |
| **Authenticator** | Mobile approval | Remote/multi-device |
| **Security keys** | Hardware token | High-risk users |

## Choosing the right approach

Each method solves a different part of the organization's challenge:

- Office-based employees need fast, seamless access
- Remote workers need flexible authentication across devices
- Administrators need strong protection against targeted attacks

Because of this, passwordless authentication isn't a single solution. Instead, it's a set of approaches that must be matched to user needs.

## What's next

In the following units, you'll learn how to:

- Implement each passwordless method
- Understand how it works in practice
- Determine when to use it based on real-world scenarios

## Key takeaway

Passwordless authentication replaces shared secrets with stronger verification that's based on device or identity.

For the IT team, it provides a path to reduce risk while supporting different user scenarios across the organization.
