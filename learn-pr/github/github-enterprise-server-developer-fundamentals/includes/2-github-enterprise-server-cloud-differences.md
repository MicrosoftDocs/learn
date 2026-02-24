GitHub offers two enterprise-grade offerings: GitHub Enterprise Cloud (GHEC) and GitHub Enterprise Server (GHES). While they share many core concepts, they differ significantly in how they are operated, updated, and secured.

Understanding these differences helps developers avoid incorrect assumptions when switching between platforms.

### In this unit, you'll learn

- How GHES and GHEC differ in architecture and operations

- What features may behave differently or arrive later on GHES

- How privacy and visibility are handled across offerings

- What Enterprise Managed Users (EMUs) change in cloud environments

| **Feature**           | **GitHub Enterprise Cloud (GHEC)**                         | **GitHub Enterprise Server (GHES)**                 |
| --------------------- | ---------------------------------------------------------- | --------------------------------------------------- |
| Hosting model         | SaaS offering hosted by GitHub                             | Self-hosted on customer infrastructure              |
| Feature delivery      | Continuous feature delivery                                | Quarterly release cadence                           |
| Operational overhead  | Lower operational overhead                                 | Infrastructure and upgrades managed by the customer |
| Repository visibility | Public and private repositories supported                  | All repositories are private by default             |
| Privacy and isolation | Privacy controlled at enterprise, org, team, or repo level | Full network and security isolation                 |

Both offerings are highly secure. However, customers with strict data residency requirements typically choose GHES when they require self-hosting and network isolation, or when enterprise policy limits the use of public cloud services.

### Enterprise managed users (Cloud Only)

When using GitHub Enterprise Cloud with Enterprise Managed Users (EMUs):

- Users are provisioned and managed via the customer's identity provider

- Users cannot move code from private repositories to personal accounts

- All activity is centrally logged in GitHub audit logs

It is important to distinguish between **GitHub Enterprise Cloud (GHEC)** and **GitHub Enterprise Cloud with Enterprise Managed Users (GHEC-EMU)**.

GHEC-EMU does not allow interaction with GitHub.com personal accounts or any public repositories. Users are fully managed within the enterprise boundary, and code cannot be transferred outside of that managed environment.

Standard GHEC, by contrast, allows interaction with GitHub.com, including collaboration with personal accounts and public repositories, subject to enterprise policy.

GHES achieves similar control by default because all users and data exist only within the GHES instance, and access is governed by the organization's chosen identity and network controls.

### Feature availability considerations

Although GHES aims for near parity with GitHub Enterprise Cloud, some differences remain:

- New features typically appear on GHES one or more quarters later

- Some cloud-native features may never arrive on GHES

- Certain integrations require outbound internet access

From a developer perspective, the key is to treat feature availability as environment-specific. If you learned a workflow on GitHub.com, verify it is supported and enabled on your GHES instance before relying on it.

Key takeaway: GHES and GHEC use similar GitHub concepts, but they differ in who operates the platform, how quickly features arrive, and which cloud-native capabilities are available.

Now that you can compare the platforms at a high level, the next unit focuses on GHES release cadence and version awareness-one of the most important practical differences for developers.