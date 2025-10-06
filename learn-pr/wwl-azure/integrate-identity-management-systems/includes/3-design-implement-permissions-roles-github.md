GitHub role-based ## GitHub Enterprise organizations

GitHub Enterprise architectures introduce elevated role classifications transcending standard personal account and organizational capabilities, delivering enterprise-scale functionality:

- **Enterprise owners:** Exercise comprehensive enterprise control encompassing administrator management, organizational membership administration, policy enforcement, and billing configuration governance.
- **Enterprise members:** Automatically inherit organizational membership across enterprise-owned organizations enabling intra-organizational collaboration. Enterprise members lack enterprise configuration access with repository visibility constrained to internal classification within enterprise boundaries.
- **Guest collaborators:** Facilitate restricted organizational internal repository access for external vendors and contractors, implementing access constraints aligned with organizational permission policies.control architectures across personal accounts, organizations, and enterprise tiers implement hierarchical permission models governing repository, project, and configuration access patterns. Role structures enable collaborative workflows and governance enforcement, with personal accounts providing single-user repository control while organizational and enterprise models facilitate granular responsibility delegation aligned with information technology departmental structures.

## Personal GitHub accounts

Personal GitHub accounts implement binary role architectures encompassing owner and collaborator designations. Account owners maintain comprehensive repository control including collaborator invitation capabilities granting private repository access. Collaboration invitations confer combined read and write permissions enabling complete pull and push operation execution. Collaborator privileges extend beyond basic repository operations encompassing commit comment management (creation, editing, deletion), pull request lifecycle management (submission, merging, closure), and release artifact administration. Personal account architecture constraints prevent read-only permission assignment to private repository collaborators.

## GitHub organizations

GitHub organizational architectures implement comprehensive built-in role taxonomies facilitating operational responsibility delegation across individuals and teams. Organization owners assign role-based permissions determining action authorization levels within organizational GitHub ecosystems:

- **Organization owners:** Maintain comprehensive administrative authority governing organizational infrastructure including repository management, team orchestration, configuration administration, and member permission assignment. Best practices recommend owner role limitation with minimum dual-owner requirements ensuring redundancy and operational continuity.
- **Organization members:** Constitute default non-administrative organizational participation tier providing baseline permissions including repository and project creation capabilities without organization-wide administrative privileges.
- **Organization moderators:** Extend member permissions enabling contributor management operations including non-member blocking/unblocking, interaction limitation configuration, and public repository comment moderation facilitating community governance and repository order maintenance.
- **Billing managers:** Designate users authorized to manage organizational billing configurations including payment instrument administration, supporting scenarios segregating financial access from organizational membership privileges.
- **Security managers:** Organization-level role conferring security alert visibility, code security configuration management, and universal repository read access supporting dedicated security team operations. (Note: As of March 2024, Security Managers role remains in public beta subject to modification.)
- **GitHub app managers:** Typically organization owners managing GitHub App registration settings, capable of delegating GitHub App manager permissions for specific registration administration. This role excludes organizational GitHub App installation/uninstallation privileges.
- **Outside collaborators:** Non-member individuals granted access to specific organizational repositories supporting consultant, temporary employee, or external contributor scenarios. Outside collaborators receive limited organizational resource access maintaining data security while enabling necessary collaborative workflows.

## GitHub Enterprise organizations

GitHub Enterprise introduces additional roles beyond those available in standard GitHub personal accounts and organizations. These roles are geared within enterprise-level functionality:

- **Enterprise owners**: Have full control over the enterprise, including managing administrators, adding or removing organizations, enforcing policies, and managing billing settings.
- **Enterprise members**: Are automatically included in organizations owned by the enterprise and can collaborate within these organizations. However, they lack access to enterprise settings and are limited to accessing repositories with the internal visibility within the enterprise.
- **Guest collaborators**: Are intended to provide restricted access to the organization’s internal repositories by external vendors and contractors. The restrictions are based on the organization's permission policy.<br>
