
<!-- markdownlint-disable MD041 -->
Authentication and authorization are two fundamental concepts in identity and access management. Together, they ensure that only the right people—and only what they need—can access organizational resources.

## Authentication

Authentication is the process of proving that you are who you say you are. Every time you sign in to an application, unlock your phone, or access a company system, authentication is happening. The system challenges you to provide proof of your identity, and then verifies that proof before deciding whether to allow access.

Authentication is sometimes shortened to *AuthN*. The goal of authentication is to answer the question: *Who are you?*

### How authentication works

Authentication requires *credentials*—evidence that verifies your identity. Common types of credentials include:

- A username and password
- A fingerprint or facial scan (biometrics)
- A one-time code sent to your phone
- A hardware security key

A username alone doesn't prove identity—it can be known or guessed by others. Adding a password (something only the legitimate user should know) gives a system confidence that the right person is signing in. Adding a biometric or physical device raises that confidence further.

Modern authentication systems also evaluate *contextual signals*: where the sign-in request originates, what device is being used, the time of day, and whether behavior matches typical patterns. These signals help systems detect suspicious sign-in attempts even when the correct credentials are presented.

### Passwordless authentication

*Passwordless* authentication removes the reliance on passwords by using stronger alternatives—such as biometrics, hardware security keys, or device-based credentials—to verify identity. Because there's no password to steal, reuse, or guess, passwordless methods reduce many of the risks associated with traditional password-based sign-in.

### Multifactor authentication

A username and password alone are often insufficient protection. Passwords are frequently stolen through phishing attacks, data breaches, and credential-stuffing attacks. *Multifactor authentication (MFA)* strengthens authentication by requiring more than one type of proof, drawn from different categories:

- **Something you know**—a password or PIN
- **Something you have**—a phone, a hardware security key, or a smart card
- **Something you are**—a biometric, such as a fingerprint or facial scan

When MFA is enabled, stealing a password alone isn't enough to compromise an account. An attacker would also need to physically possess the user's device or replicate their biometrics. This extra layer of verification dramatically reduces the risk of account takeover.

## Authorization

Once your identity is confirmed through authentication, the next question is: *What are you allowed to do?*

Authorization is the process of determining what an authenticated user has permission to access and what actions they can perform. Knowing who you are isn't enough—the system also needs to determine what you're entitled to.

Authorization is sometimes shortened to *AuthZ*.

### The hotel analogy

A useful way to think about authentication and authorization is to imagine checking into a hotel.

When you arrive, you go to the reception desk and present your passport or driver's license. The receptionist checks your identification against your reservation to confirm who you are. That's *authentication*.

Once verified, you're given a keycard programmed to open specific doors: your assigned room, the fitness center, or the pool—but not other guests' rooms, the staff areas, or the kitchen. When you use the keycard, the door sensor checks your permissions and grants or denies access accordingly. That's *authorization*.

In digital systems:
- The credentials you provide (username, password, biometrics) are like your passport—they prove who you are.
- The permissions assigned to your account—which applications, files, and actions you can access—are like the keycard.

### How authorization is managed

Authorization is typically managed through *roles* and *permissions*. Rather than assigning access rights individually to every user, systems group permissions into named roles, and then assign users to those roles.

For example:
- A *help desk technician* role might allow viewing user account status but not resetting passwords.
- A *security administrator* role might allow resetting passwords and reviewing sign-in logs.
- A *global administrator* role might have full control over all settings and users.

This model is called *role-based access control (RBAC)*. When the permissions of a role change, every user assigned to that role is automatically affected. RBAC makes managing access across large organizations scalable and consistent.

Authorization decisions can also be dynamic. A user might be authorized to access a sensitive application under normal circumstances—but if they sign in from an unexpected location or an unrecognized device, a risk-based policy might step up the authentication requirement or restrict access until the risk is resolved.

## Authentication and authorization work together

Authentication and authorization are distinct processes, but they work together to protect resources. They always occur in a specific order:

1. **Authentication**—the system verifies who you are.
2. **Authorization**—the system determines what you're allowed to do.

Authorization can only happen after successful authentication. You can't determine what someone is permitted to do without first confirming their identity. And confirming identity alone—without checking permissions—leaves resources exposed.

Together, authentication and authorization form the foundation of access management across all Microsoft security, compliance, and identity solutions.


