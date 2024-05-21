GitHub Advanced Security is a suite of security features and capabilities offered by GitHub to help organizations identify and mitigate security vulnerabilities, secure their code, and protect their software supply chain. It consists of the following key components:

 -  **Code Scanning** automatically scans code in repositories for security vulnerabilities and coding errors by using static analysis techniques provided by CodeQL or third party tools. It identifies potential security vulnerabilities, including those related to out-of-date dependencies and weak ciphers.
 -  **Secret Scanning** detects and helps remediate the presence of secrets, such as API tokens and cryptographic keys in repositories and commits. It automatically scans the content of repositories and generates alerts based on its discoveries.
 -  **Dependency reviews** assists with identifying and managing dependencies in software projects, based on direct and transitive dependencies retrieved from package manifests and other configuration files. They allow you to assess the full impact of changes to dependencies including details of any vulnerable versions before merging a pull request.
 -  **Custom auto-triage rules** help you manage Dependabot alerts at scale. With custom auto-triage rules you control which alerts could be ignored and which require applying a security update.
 -  **Security advisories** provides curated security advisories and alerts about vulnerabilities discovered in open-source dependencies.

GitHub Advanced Security integrates natively with both GitHub and Azure DevOps.

## GitHub

GitHub makes its Advanced Security features available in private repositories based on the Advanced Security licensing. Once you purchased GitHub Advanced Security licensing for your organization, you can enable and disable these features at the organization or repository level. These features are also permanently enabled in public repositories on GitHub.com without any licensing prerequisites and can only be disabled if you change the project visibility.

To configure GitHub Advanced Security for your organization, in the upper-right corner of GitHub.com, select your profile icon and then select Your organizations. Next, select Settings and, in the Security section of the sidebar, select Code security and analysis. This will display the page that allows you to enable or disable all security and analysis features for the repositories in your organization.

The impact of configuration changes is determined by the visibility of repositories in your organization:

 -  Private vulnerability reporting - public repositories only.
 -  Dependency graph - only private repositories because the feature is always enabled for public repositories.
 -  Dependabot alerts - all repositories.
 -  Dependabot security updates - all repositories.
 -  GitHub Advanced Security - only private repositories because GitHub Advanced Security and the related features are always enabled for public repositories.
 -  Secret scanning - public and private repositories where GitHub Advanced Security is enabled. This option controls whether or not secret scanning alerts for users are enabled.
 -  Code scanning - public and private repositories where GitHub Advanced Security is enabled.

You can also manage the security and analysis features for individual private repositories. To do so, from GitHub.com, navigate to the main page of the repository and select Settings. In the Security section of the sidebar, select Code security and analysis. In the Code security and analysis pane, disable or enable individual features. The control for GitHub Advanced Security is disabled if your enterprise has not purchased required licenses.

Note that if you disable GitHub Advanced Security, dependency review, secret scanning alerts for users and code scanning are effectively disabled. As the result, any workflows that include code scanning will fail.

Once enabled, the security features are integrated directly into the GitHub platform, providing continuous security monitoring and alerts directly within the GitHub interface. Repository administrators and developers can access security insights, recommendations, and actionable steps to address identified security vulnerabilities and strengthen the overall security posture of their software projects. Additionally, organizations can customize security policies, configure automated workflows, and integrate GitHub Advanced Security with other security tools and services to meet their specific security requirements and compliance needs.

## Azure DevOps

GitHub Advanced Security for Azure DevOps target Azure Repos and includes:

 -  **Secret Scanning push protection** checks if code pushes include commits that expose secrets.
 -  **Secret Scanning repo scanning** searches repositories for exposed secrets.
 -  **Dependency Scanning** identifies direct and transitive vulnerabilities in open source dependencies.
 -  **Code Scanning** uses CodeQL static analysis to identify code-level application vulnerabilities such as SQL injection and authentication bypass.

Advanced Security can be turned on the organization, project, or repository level. This automatically enables secret scanning push protection and repository scanning. Effectively, any future pushes containing secrets are automatically blocked while secret scanning runs in the background.

Dependency scanning is a pipeline-based scanning tool. Results are aggregated per repository. It's recommended that you add the dependency scanning task to all the pipelines you'd like to be scanned. For the most accurate scanning results, be sure to add the dependency scanning task following the build steps of a pipeline that builds the code you wish to scan. You can add the Advanced Security Dependency Scanning task (AdvancedSecurity-Dependency-Scanning@1) directly to your YAML pipeline file or select it from the task assistant.

Code scanning is also a pipeline-based scanning tool where results are aggregated per repository. It tends to be a time-consuming build task, so consider adding the code scanning task to a separate, cloned pipeline of your main production pipeline or create a new pipeline. Within the pipeline, add the tasks in the following order:

 -  Advanced Security Initialize CodeQL (AdvancedSecurity-Codeql-Init@1)
 -  Your custom build steps
 -  Advanced Security Perform CodeQL Analysis (AdvancedSecurity-Codeql-Analyze@1)

Additionally, you'll need to include a comma separated list of the languages you're analyzing by using the Advanced Security Initialize CodeQL task. The supported languages include csharp, cpp, go, java, JavaScript, python, ruby, and swift.
