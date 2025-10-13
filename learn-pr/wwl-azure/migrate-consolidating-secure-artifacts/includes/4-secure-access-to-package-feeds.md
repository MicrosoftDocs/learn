**Securing access** to package feeds is critical for maintaining the integrity and safety of your software supply chain. Package feeds must be protected against unauthorized access, malicious packages, and other security threats.

## Package feeds as trusted sources

**Package feeds** are a trusted source of packages. The offered packages will be consumed by other codebases and used to build software that needs to be secure.

### The risk of compromised feeds

Imagine what would happen if a package feed would offer **malicious components** in its packages.

**Impact of malicious packages:**

- **Development machines:** Each consumer would be affected when installing the packages onto its development machine.
- **Build servers:** Malicious code could compromise build infrastructure.
- **Production systems:** It also happens at any other device that will run the end product, as the malicious components will be executed as part of the code.
- **Privilege escalation:** Usually, the code runs with high privileges, giving a large security risk if any packages cannot be trusted and might contain unsafe code.

**Real-world examples:**

- **Supply chain attacks:** Attackers compromise package repositories to distribute malware.
- **Typosquatting:** Malicious packages with names similar to popular packages.
- **Dependency confusion:** Packages that exploit package manager resolution to inject malicious code.

## Securing access control

Package feeds must be secured for access by **authorized accounts** only, so only verified and trusted packages are stored there.

### Preventing unauthorized publishing

**None should push packages to a feed without the proper role and permissions.**

**Access control benefits:**

- **Prevents malicious packages:** It prevents others from pushing malicious packages.
- **Trust assumption:** It still assumes that the persons who can push packages will only add safe and secure packages.
- **Accountability:** Track who published each package version.

### Community verification

Especially in the **open-source world**, it's done by the community. A package source can further guard its feed with the use of **security and vulnerability scan tooling**.

**Additional security measures:**

- **Automated scanning:** Vulnerability and malware scanning of packages.
- **Code signing:** Verify package authenticity with digital signatures.
- **Review processes:** Manual or automated reviews before publishing.

**Consumer-side security:**

Additionally, consumers of packages can use similar tooling to do the scans themselves.

- **Local scanning:** Scan packages before installation.
- **Dependency analysis:** Check for known vulnerabilities in dependencies.
- **License compliance:** Verify package licenses.

## Securing feed visibility

Another aspect of security for package feeds is about the **public or private availability** of the packages.

### Public versus private feeds

**Public feeds:**

- **Open access:** Available for anonymous consumption.
- **No authentication required:** Anyone can download packages.
- **Visibility:** Packages are discoverable through search.

**Private feeds:**

- **Restricted access:** Have restricted access most of the time.
- **Authentication required:** Users must authenticate to access.
- **Controlled visibility:** Only authorized users can see packages exist.

### Feed visibility in Azure Artifacts

When creating a feed in Azure Artifacts, you can choose the **visibility**:

- **Organization:** Visible to everyone in your Azure DevOps organization.
- **Project:** Visible only to members of specific project.
- **Private:** Visible only to users, teams, and groups you explicitly grant access.

## Access control requirements

Package feeds need to have **secure access** for different kinds of reasons. The access should involve allowing:

### 1. Restricted access for consumption

**Whenever a particular audience should only consume a package feed and its packages, it's required to restrict its access.**

**Why restrict consumption:**

- **Proprietary code:** Internal libraries containing business logic.
- **Licensed software:** Packages with licensing restrictions.
- **Pre-release versions:** Beta or unstable packages not ready for general use.
- **Security through obscurity:** Prevent knowledge of package existence.

**Implementation:**

Only those allowed access will consume the packages from the feed.

- **Role assignment:** Assign Reader role to authorized users.
- **Team-based access:** Grant access to entire teams.
- **Organization boundaries:** Restrict to organization members.

### 2. Restricted access for publishing

**Secure access is required to restrict who can publish so feeds and unauthorized or untrusted persons and accounts can't modify their packages.**

**Why restrict publishing:**

- **Quality control:** Ensure only tested, approved packages are published.
- **Security:** Prevent injection of malicious packages.
- **Compliance:** Maintain audit trail of package publishers.
- **Version control:** Prevent accidental overwriting of versions.

**Implementation:**

- **Role assignment:** Assign Contributor or Owner role to authorized publishers.
- **Service principals:** Use service principals for automated publishing from CI/CD.
- **Approval workflows:** Require reviews before publishing to production feeds.

## Security best practices

### Feed-level security

**Principle of least privilege:**

- **Minimal permissions:** Grant only the permissions necessary for each user or service.
- **Regular review:** Periodically review and revoke unnecessary access.
- **Separate feeds:** Use different feeds for different trust levels (development, staging, production).

**Authentication:**

- **Strong credentials:** Require strong passwords or multi-factor authentication.
- **Personal Access Tokens:** Use PATs with appropriate scopes and expiration.
- **Rotate credentials:** Regularly rotate tokens and credentials.

### Package-level security

**Vulnerability scanning:**

- **Automated scanning:** Integrate vulnerability scanning in CI/CD pipelines.
- **Regular updates:** Keep packages updated with security patches.
- **Deprecation:** Mark vulnerable package versions as deprecated.

**Package signing:**

- **Digital signatures:** Sign packages to verify authenticity.
- **Signature verification:** Verify signatures before consumption.

**Metadata validation:**

- **License checking:** Validate licenses are appropriate.
- **Dependency analysis:** Review transitive dependencies for security issues.

### Network security

**Private endpoints:**

- **VNet integration:** Use Azure Private Link for Azure Artifacts in private networks.
- **Firewall rules:** Configure firewall rules to restrict access.

**TLS/SSL:**

- **Encryption in transit:** All communication uses HTTPS.
- **Certificate validation:** Verify SSL certificates.

## Monitoring and auditing

**Activity logging:**

- **Feed operations:** Log all package publish, update, and delete operations.
- **Access logs:** Track who accessed which packages and when.
- **Audit trails:** Maintain comprehensive audit trails for compliance.

**Alerts:**

- **Unauthorized access attempts:** Alert on failed authentication.
- **Unusual activity:** Detect anomalous package downloads or publishes.
- **Vulnerability detection:** Alert when vulnerabilities are found in packages.
