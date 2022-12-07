## A08: Software and Data Integrity Failures

Happens when an application relies upon plugins, libraries, or modules from untrusted sources, repositories
New category for 2021, focusing on making assumptions related to software updates, critical data, and CI/CD pipelines without verifying integrity.

Perform supply chain verification - depend only on vetted and verified libraries and components.

Verify and update
many applications now include auto-update functionality, where updates are downloaded without sufficient integrity verification and applied to the previously trusted application.

> [!TIP]
> SBOM, which stands for **Software Bill of Materials**, is a software security and software supply chain risk management helping identify individual dependencies and components of a piece of software.

Software and data integrity failures relate to code and infrastructure that does not protect against integrity violations. An example of this is where an application relies upon plugins, libraries, or modules from untrusted sources, repositories, and content delivery networks (CDNs). An insecure CI/CD pipeline can introduce the potential for unauthorized access, malicious code, or system compromise. Attackers could potentially upload their own updates to be distributed and run on all installations. Another example is where objects or data are encoded or serialized into a structure that an attacker can see and modify is vulnerable to insecure deserialization.
NPM package
Dev corrupts NPM libs 'colors’ ~20k and 'faker ~2.5k ' breaking thousands of apps. The reason behind this mischief on the developer's part appears to be retaliation—against mega-corporations and commercial consumers of open-source projects who extensively rely on cost-free and community-powered software but do not, according to the developer, give back to the community

Perhaps the most high-profile example of this would be the SolarWinds cyber attack in 2020.
:::image type="content" source="../media/solarwind.png" alt-text="Solarwind Orion platform":::
SolarWinds malicious update: Nation-states have been known to attack update mechanisms, with a recent notable attack being the SolarWinds Orion attack. The company that develops the software had secure build and update integrity processes. Still, these were able to be subverted, and for several months, the firm distributed a highly targeted malicious update to more than 18,000 organizations, of which around 100 or so were affected. This is one of the most far-reaching and most significant breaches of this nature in history.

A few best practices may include:

* Only depend on properly vetted and verified dependencies, components and repositories.
* Leverage CI/CI automation (e.g. [GitHub Dependabot Alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts#detection-of-insecure-dependencies)) to validate your supply chain security, review dependency graph.
* Enforce code reviews focusing on security aspects of the codebase.
