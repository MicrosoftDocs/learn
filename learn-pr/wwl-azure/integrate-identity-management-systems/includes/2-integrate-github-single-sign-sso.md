GitHub implements comprehensive authentication and authorization frameworks supporting diverse access patterns across interactive and programmatic scenarios.

- **Username and password (in combination with another authentication factor):** Traditional interactive authentication requiring GitHub username, password, and mandatory two-factor authentication (2FA) for all code contributors ensuring enhanced security posture.
- **SSH keys:** Asymmetric cryptographic key pairs provisioned by users and registered within GitHub accounts, enabling secure repository access via SSH protocol. SSH authentication accommodates automated scenarios including continuous integration workflows requiring non-interactive credential presentation.
- **Personal Access Tokens (PATs):** GitHub-generated bearer tokens functioning as password alternatives, providing scoped access to designated GitHub resources. PATs support web application integration, automation workflows, and GitHub API consumption, while offering firewall-friendly alternatives to SSH-based authentication in restricted network environments.
- **OAuth apps:** Third-party and custom-developed applications implementing OAuth 2.0 authorization flows enabling GitHub resource access without explicit credential exposure, facilitating secure third-party application integration.
- **GitHub Apps:** Enhanced application integration pattern extending OAuth app capabilities with granular permission models representing recommended practices for programmatic GitHub API access. GitHub Apps enable third-party application integration supporting workflow automation, policy enforcement, and custom tooling within GitHub organizational ecosystems.
- **GITHUB_TOKEN:** Built-in authentication token automatically provisioned by GitHub Actions during workflow execution, providing repository-scoped access for workflow automation scenarios without explicit credential management.

## Implementing username and password (including two-factor) authentication

GitHub account provisioning automatically initiates password creation workflows during registration. Authentication workflows require username and password presentation followed by email-delivered verification code validation. Two-factor authentication (2FA) enablement introduces additional verification layers requiring time-based one-time password (TOTP) application-generated codes or SMS-delivered authentication tokens following successful password validation.

GitHub organizational and enterprise accounts support SAML (Security Assertion Markup Language)-based single sign-on integration patterns. SAML-enabled environments redirect authentication requests to organizational SAML identity providers (IdP) for credential validation. Successful IdP authentication triggers automatic redirection to GitHub-hosted organizational resources, establishing authenticated sessions without direct credential presentation to GitHub infrastructure.

## Implementing SSH keys authentication

SSH key provisioning initiates with asymmetric key pair generation via ssh-keygen utility absent existing configurations. Key generation workflows produce public and private key components with user-designated storage locations. Public key registration requires clipboard-based content transfer to GitHub account settings interface, navigating SSH and GPG keys sections, selecting New SSH key operations, and associating public key content with descriptive identifiers. Private key availability on client systems enables SSH-based GitHub account access without interactive credential presentation.

GitHub CLI authentication workflows implement automated SSH key discovery identifying existing public keys for registration selection. Key discovery failures trigger optional key pair generation with automatic public key upload to authenticated GitHub accounts, streamlining SSH authentication configuration without manual key management operations.

## Implementing Personal Access Token (PAT) authentication

Personal Access Token provisioning initiates through GitHub account settings interfaces navigating Developer settings sections. Token generation workflows accessible via Personal access tokens interfaces require scope specification, validity duration configuration, and descriptive identifier assignment before token materialization.

Generated tokens enable programmatic GitHub API authentication within workflows, automation scripts, and application integrations. Personal Access Tokens provide GITHUB_TOKEN alternatives within GitHub Actions workflows requiring extended permissions or cross-repository access patterns. Security best practices mandate avoiding PAT hardcoding within public repositories and prohibiting exposure through unsecured environmental contexts preventing unauthorized credential access.

## Implementing GitHub Apps authentication

GitHub App provisioning initiates through Developer settings navigation within GitHub account configuration interfaces. Application creation workflows accessible via GitHub Apps sections require New GitHub App selection followed by comprehensive configuration including application nomenclature, descriptive metadata, permission specifications, and webhook endpoint definitions. Application provisioning generates associated private keys requiring secure storage protecting authentication credentials. Installation workflows distribute applications across designated repositories or organizational scopes, prompting permission grant confirmations establishing application access boundaries.

GitHub Apps implement dynamic access token generation for API authentication presenting scope-limited authorization aligned with application-granted permissions. Generated tokens support workflow integration, script automation, and programmatic API interactions enabling comprehensive GitHub platform engagement.

Fine-grained permission models distinguish GitHub Apps from OAuth alternatives, enabling precise access control through GitHub App settings interfaces supporting ongoing permission refinement aligned with evolving application requirements.

## Implementing GITHUB_TOKEN authentication

GitHub Actions automatically generates GITHUB_TOKEN credentials for each workflow execution cycle, provisioning tokens as repository environment secrets enabling seamless workflow-internal accessibility without explicit configuration requirements.

GITHUB_TOKEN provides repository-scoped read and write permissions supporting diverse workflow operations including repository cloning, issue management, and cascading workflow triggering capabilities within execution contexts.

Workflow token access leverages secrets context references enabling secure credential consumption. The following implementation demonstrates automated pull request comment generation utilizing GITHUB_TOKEN authentication:

```YAML
name: Comment on Issue

on:
  pull_request:
    types: [opened]

jobs:
  comment:
    runs-on: ubuntu-latest
    steps:
      - name: Comment on Issue
        uses: actions/github-script@v4
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          script: |
            const issueNumber = context.payload.pull_request.issue_url.split('/').pop();
            await github.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: issueNumber,
              body: 'We appreciate opening this pull request. We will review it shortly.'
            });
```
