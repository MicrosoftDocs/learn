Firewall rules and connection security rules are different rules that can be combined to ensure secure communication between hosts.

| Rule type | Primary function |
|---|---|
| Firewall rule | Permit or block traffic that matches protocol, port, application, service, address, profile, or identity scope |
| Connection security rule | Negotiate peer authentication plus optional integrity or encryption |

A secure firewall rule can require authenticated traffic. It doesn't independently define the complete peer negotiation policy. A compatible connection security rule must create the required security association.

When determining how to use firewall rules and connection security rules together to ensure secure communication, use this ordered sequence:

1. Define the application traffic.
1. Create the firewall rule with **Allow the connection if it is secure**.
1. Define peer endpoints in a connection security rule.
1. Select request or require behavior.
1. Select authentication methods.
1. Select integrity or encryption requirements.
1. Deploy compatible policy to both peers.
1. Verify the security association.
1. Verify the application flow.

## Choose request before require

Request mode prefers authenticated traffic but can permit fallback when the peer can't negotiate protection. It's useful during discovery and testing. Require mode rejects matching traffic without a successful negotiation. Use it after:

- Both peer populations receive policy.
- Authentication dependencies are reliable.
- Monitoring confirms associations.
- Recovery access is tested.

## Interpret endpoints precisely

Endpoint definitions don't inherently mean client and server. Treat them as two traffic-selector sets.

Determine:

- Which set contains the protected server
- Which set contains permitted clients
- Which endpoint listens on the application port
- Which addresses are included
- Which protocols are selected

Reversing endpoint port scope can create policy that never matches.

## Select authentication order

A common design uses:

1. Computer authentication
1. Optional or required user authentication

Computer authentication establishes the managed peer. User authentication enables identity-based firewall authorization.

Use Kerberos where domain trust supports it. Use certificate authentication when trust boundaries or device types require it.

## Apply authenticated bypass narrowly

Authenticated bypass can permit authenticated traffic despite a broader block rule. It's useful for controlled exceptions during migration.

Restrict bypass by:

- Exact protocol
- Exact local port
- Approved user group
- Approved computer group
- Required profile
- Approved peer address

Don't create a general authenticated bypass for all domain traffic.

## Verify the complete chain

Successful secure access requires every layer:

- Network reachability
- Matching connection security selectors
- Compatible authentication
- Compatible cryptographic proposals
- Successful security association
- Matching secure firewall rule
- Authorized user and computer identity
- Listening application
