With increasing complexity of developed applications, you should not be making assumptions related to software updates, critical data, and CI/CD pipelines without verifying integrity.
After all, chances are your application relies upon plugins, libraries, or modules from untrusted sources or repositories.

> [!TIP]
> SBOM, which stands for **Software Bill of Materials**, is a software security and software supply chain risk management helping identify individual dependencies and components of a piece of software.

Software and data integrity failures relate to code and infrastructure that doesn't protect against integrity violations. An application that relies upon plugins, libraries, or modules from untrusted sources or repositories can be at risk. An insecure CI/CD pipeline can introduce the potential for unauthorized access, malicious code, or system compromise. Attackers could potentially upload their own updates to be distributed and run on all installations. Another example is where objects or data are encoded or serialized into a structure that an attacker can see and modify is vulnerable to insecure deserialization.

Perhaps you recall the high-profile SolarWinds cyber attack by Nation-state from 2020.
:::image type="content" source="../media/solarwind.png" alt-text="Solarwind Orion platform":::
The company that develops the software had secure build and update integrity processes. For several months the firm distributed a highly targeted malicious update to more than 18,000 organizations, of which around 100 or so were affected.

Many applications now include auto-update functionality, where updates are downloaded without sufficient integrity verification and applied to the previously trusted application.
Supply chain verification suggests depending only on vetted and verified libraries and components.

### Code Review Notes

As you and your team adopt secure CI/CD practices you want to make sure:

- Only depend on properly vetted and verified dependencies, components and repositories.
- Automate your CI/CI workflows (for example, [GitHub Dependabot Alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts#detection-of-insecure-dependencies)) to validate your supply chain security, review dependency graph.
- Enforce code reviews focusing on security aspects of the codebase.
