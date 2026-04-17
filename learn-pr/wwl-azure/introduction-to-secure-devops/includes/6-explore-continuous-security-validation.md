Modern developers routinely use components available in public package sources like npm, NuGet, PyPI, Maven Central, and RubyGems. This practice has become standard across the software industry as organizations embrace open-source software (OSS) components for faster delivery and better productivity.

## The double-edged sword of third-party components

**Benefits of third-party components:**

- **Faster development:** Developers don't need to build common functionality from scratch.
- **Proven solutions:** Popular packages have been tested by thousands of users.
- **Community support:** Active communities provide documentation, updates, and assistance.
- **Cost savings:** Free OSS components reduce development costs significantly.
- **Innovation acceleration:** Teams can focus on unique business logic rather than reinventing standard functionality.

**Growing security and compliance risks:** However, as dependency on third-party OSS components increases, so do risks:

**Security vulnerabilities:**

- Third-party packages may contain known security vulnerabilities that attackers can exploit.
- Vulnerabilities are discovered continuously in existing packages.
- Transitive dependencies (dependencies of your dependencies) introduce vulnerabilities you might not be aware of.
- Supply chain attacks target popular packages to compromise many downstream applications.

**License compliance issues:**

- Hidden license requirements can create legal obligations.
- Some OSS licenses require you to open-source your own code if you use their components.
- License violations can result in lawsuits, financial penalties, and forced code releases.
- Different licenses may be incompatible with each other, creating compliance conflicts.

**Business criticality:** For a business, these issues are critical. Problems related to compliance, liabilities, and customer personal data can cause severe privacy and security concerns:

- **Legal liability:** License violations expose organizations to legal action.
- **Data breaches:** Vulnerable components can lead to data breaches affecting customer personal data.
- **Regulatory compliance:** Violations of regulations like GDPR, CCPA, or HIPAA can result in significant fines.
- **Reputation damage:** Security incidents and license violations damage customer trust and brand reputation.
- **Customer contracts:** Enterprise customers often require security and compliance guarantees that vulnerable components violate.

## The value of early detection

**Advanced warning:** Identifying security and compliance issues early in the release cycle provides advanced warning and enough time to fix problems before they reach production.

**Cost of remediation:** The cost of rectifying issues is dramatically lower the earlier in the project the problem is discovered:

- **During development:** Changing a dependency costs hours of developer time.
- **During testing:** Fixing issues requires retesting the entire application.
- **In production:** Remediation requires emergency patching, security incident response, customer notifications, and potential regulatory reporting.

**Economic impact:** Studies show that security issues found in production cost 10-100 times more to fix than those found during development.

## Continuous integration security validation

Once code merges into the main branch, comprehensive security validation should execute as part of the continuous integration (CI) build process.

### CI build vs. PR-CI build

**Pull request CI (PR-CI):** Runs during pull request validation before code is merged. Provides fast feedback to prevent vulnerable code from entering the codebase.

**Full CI build:** Runs after code is merged into the main branch. Includes more comprehensive checks and prepares artifacts for deployment.

**Typical differences:** The primary difference between PR-CI and full CI builds is that PR-CI doesn't need packaging or staging artifacts that the full CI build produces. This keeps PR-CI fast while maintaining security validation.

**Both should include security checks:** Both build types should run core security validations, but full CI builds may include additional time-consuming checks.

### Static code analysis in CI builds

**Purpose:** CI builds should run static code analysis tests to ensure that code follows all rules for both maintainability and security.

**Common static analysis tools:**

**SonarQube:**

- Comprehensive code quality and security platform.
- Detects bugs, code smells, and security vulnerabilities.
- Tracks code quality metrics over time.
- Integrates quality gates that fail builds when quality thresholds aren't met.
- Supports multiple programming languages.

**Visual Studio Code Analysis and Roslyn Security Analyzers:**

- Built-in analysis for .NET applications.
- Roslyn Security Analyzers detect security vulnerabilities in C# code.
- Runs during compilation providing immediate feedback.
- No additional infrastructure required for .NET projects.

**Checkmarx:**

- Static Application Security Testing (SAST) tool.
- Deep security analysis of source code.
- Identifies vulnerabilities like SQL injection, XSS, and authentication issues.
- Provides detailed remediation guidance.
- Supports many programming languages and frameworks.

**BinSkim:**

- Binary static analysis tool from Microsoft.
- Provides security and correctness results for Windows portable executables (PE files).
- Analyzes compiled binaries rather than source code.
- Identifies security issues in compilation settings and binary structure.
- Useful for analyzing third-party compiled components.

**Additional tools:**

- **ESLint with security plugins:** JavaScript/TypeScript security analysis.
- **Bandit:** Python security analysis.
- **Brakeman:** Ruby on Rails security scanner.
- **gosec:** Go security checker.

**Azure Pipelines integration:** Many security tools seamlessly integrate into Azure Pipelines and other CI/CD platforms. The Visual Studio Marketplace provides extensions for various security tools, making integration straightforward:

- Tools appear as pipeline tasks you can add to your pipeline definition.
- Results display in pipeline logs and can fail builds when issues are detected.
- Security findings integrate with Azure DevOps work item tracking.

### Third-party package vulnerability scanning

**Critical but often overlooked:** Beyond verifying code quality, two other critical validations are often ignored or performed inadequately:

1. Scanning third-party packages for known security vulnerabilities.
2. Verifying OSS license compliance.

**Common organizational response:** When asked about third-party package vulnerabilities and licenses, many organizations respond with fear or uncertainty. They don't have clear processes for managing these risks.

**Manual process problems:** Organizations attempting to manage third-party package vulnerabilities or OSS licenses often explain that their process is tedious and manual:

- Developers manually search vulnerability databases.
- Security teams maintain spreadsheets of approved packages.
- License reviews require legal team involvement for each package.
- Updates are tracked manually, leading to outdated dependency information.
- The process takes weeks, slowing development significantly.

**Automated solutions:** Modern software composition analysis (SCA) tools automate this identification process, making it nearly instantaneous:

**Mend (formerly WhiteSource):**

- Automatically detects all OSS components in your applications.
- Identifies known security vulnerabilities in dependencies.
- Checks license compliance against organizational policies.
- Provides remediation guidance including available fixed versions.
- Continuously monitors for new vulnerabilities in used packages.

**GitHub Dependabot:**

- Automatically scans dependencies for known vulnerabilities.
- Creates pull requests to update vulnerable dependencies.
- Supports many package ecosystems (npm, Maven, pip, etc.).
- Free for public and private GitHub repositories.

**Snyk:**

- Developer-first security tool for finding and fixing vulnerabilities.
- Scans dependencies, container images, and infrastructure as code.
- Provides remediation advice and automated pull requests.
- Integrates into IDEs, source control, and CI/CD pipelines.

**Azure Artifacts upstream sources:**

- Can be configured to scan packages from upstream sources.
- Blocks packages with known vulnerabilities.
- Provides visibility into all packages used across the organization.

### Software composition analysis benefits

**Comprehensive visibility:** SCA tools provide complete visibility into your software supply chain:

- Inventory all direct and transitive dependencies.
- Track versions and update status.
- Identify components that are no longer maintained.
- Map dependencies to specific applications and teams.

**Risk prioritization:** Not all vulnerabilities are equally critical. SCA tools help prioritize:

- Severity scores (CVSS ratings) indicating vulnerability severity.
- Exploitability ratings showing if attacks are known to exist.
- Reachability analysis determining if vulnerable code is actually used in your application.
- Business context about which applications are most critical.

**Continuous monitoring:** Security vulnerabilities are discovered constantly. SCA tools provide continuous monitoring:

- Alerts when new vulnerabilities are discovered in packages you use.
- Regular reports on security posture trends.
- Integration with issue tracking systems to manage remediation work.

**Compliance documentation:** SCA tools generate compliance reports:

- License obligations for all used components.
- Attribution requirements that must be met.
- Evidence that security reviews have been performed.
- Audit trails for regulatory compliance.

## Integration in the pipeline

Continuous security validation integrates into your CI/CD pipeline as automated tasks:

1. **Code merge:** Pull request is approved and code merges into main branch.
2. **CI build triggers:** Merge automatically triggers full CI build.
3. **Static analysis runs:** SAST tools analyze source code for vulnerabilities.
4. **Dependency scan:** SCA tools scan all dependencies for vulnerabilities and license issues.
5. **Quality gates:** Build fails if security issues exceed acceptable thresholds.
6. **Results available:** Security findings are available to developers and security teams.
7. **Artifact creation:** If security checks pass, build artifacts are created for deployment.

In later modules, we'll discuss integrating several helpful and commonly used security and compliance tools into your specific pipeline configuration.
