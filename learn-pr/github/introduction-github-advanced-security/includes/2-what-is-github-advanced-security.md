The previous unit discussed the importance of securing your environment from malicious actors. The real-life cases highlighted some of the ways in which hackers can exploit systems. In this unit, you'll be introduced to GitHub Advanced Security. Let's focus on the various product features and the challenge or problem that these features address.

:::image type="content" source="../media/ghas-intro.png" alt-text="Diagram showing GitHub Advanced Security features." border="false":::

GitHub Advanced Security is a powerful suite of tools and features that gives you the ability to identify security vulnerabilities in your codebase and environment. These features allow you to secure your code at every step of the software-development lifecycle, not just in your production environment. You stay ahead of security threats and breaches, leverage the expertise of the security community, and continue to use open-source software securely. GitHub Advanced Security also includes implementing security best practices that help create a security-minded culture within your organization.

GitHub Advanced Security focuses on protecting your organization in three primary areas:

- Supply chain
- Code
- Environments

Let's look at these three categories to learn how you can use GitHub Advanced Security to improve security within your GitHub organization.

## Secure your software supply chain

When you think about supply chains, you might think of manufacturing goods within an industrial warehouse. However, the concept of a supply chain also applies to what happens during your software-development lifecycle. Your workflow produces chunks of code that are then reviewed for quality assurance before reaching the next stage. Protections and guidelines are enforced along the way to optimize production and make an acceptable end product.

In the context of software development, supply chain also refers to the integration of any third-party or open-source software. Your software is most likely more than the code you've written in-house. Up to 94% of active repositories rely on open-source code, so you might rely on many components you didn't produce. These components are called *dependencies*. You need to actively review them for vulnerabilities.

In 2021, Log4j was a dependency included in many applications worldwide. The events surrounding the Log4j vulnerability show how crucial dependency management is to securing your codebase. If you use any third-party software with security vulnerabilities, your project inherits the same weaknesses.

Fortunately, GitHub has automated features that flag these dependency vulnerabilities. These warnings alert specific team members to potential dangers and help them to act accordingly. These powerful features allow you to automate the process that monitors and secures your project dependencies and searches for vulnerabilities.

Let's look at the features you can use to monitor and secure your software supply chain.

### The security overview

:::image type="content" source="../media/security-overview.png" alt-text="Screenshot of security overview." border="true":::

Once you have an established supply chain, GitHub's *security overview* provides you with a central location to properly oversee it. This makes it easier to monitor the state of your project's dependencies. The security overview allows you to identify problematic repositories and understand how your dependencies impact your code's security. You can also enable security features from the security overview. You can view, filter, and sort automated security alerts generated for your organization or a specific team. The overview also lets you filter alerts by their risk level so you can prioritize your response.

The security overview includes icons for different types of alerts. These icons also display the quantity of each alert type. In the next section, you'll learn about the GitHub features that generate these alerts.

### Dependency graphs

Visualizations can simplify and summarize large amounts of data. Dependency graphs provide important insights into your project's direct and indirect package dependencies and their current state. The graphs display a summary of manifest and lock files in the project's ecosystem, repository, and packages. You can also find out if dependencies are up to date and secure.

:::image type="content" source="../media/dependency-graph.png" alt-text="Screenshot of dependency graph." border="true":::

The dependency graph lets you monitor any known issues within dependencies that might affect the security of your application. Once you activate the dependency graph, you have access to dependency reviews for both private and public repositories belonging to your organization. These reviews help keep dependency vulnerabilities from being introduced into your environment.

### The GitHub Advisory Database

The GitHub Advisory Database provides information on the state of your dependencies. You can browse or search the GitHub Advisory Database for vulnerabilities in third-party solutions. This is useful because the packages on which your project depends also have other packages on which they depend. In this chain of package relation, you most likely won't be familiar with each piece of software that's been pulled into your project. Having an overarching database to track what's happening in the ecosystem is an important resource.

The GitHub Advisory Database is curated by a dedicated team. It lists security vulnerabilities mapped to packages tracked by dependency graphs. Security threats appear in the GitHub Advisory Database ranked from low to critical. GitHub automatically updates this list regularly, using  authoritative sources such as The National Vulnerability Database and the npm security advisories database.

Now, let's look at another component that relies on the GitHub Advisory Database.

### Dependabot for automated dependency management

:::image type="content" source="../media/dependabot-github.png" alt-text="Screenshot of the Dependabot icon." border="false":::

Imagine a project that includes 20 to 30 third-party integrations. Manually monitoring so many dependencies and keeping them up to date is time consuming and tedious. Dependabot is GitHub's answer to this challenge. This built-in mechanism detects vulnerable dependencies by first examining the project's manifest file (such as the `package.json` file used in NodeJS). Next, Dependabot consults the GitHub Advisory Database to see if the detected dependencies have flags that indicate they're out of date or vulnerable. Dependabot alerts authorized team members if there's an issue with any dependency or when a dependency graph related to a repository changes.

This automated process helps avoid maintenance oversights and increases efficiency.

## Find and fix security issues as you code

After securing the supply chain, the next area of focus for GitHub Advanced Security is code analysis. Human error can introduce information into the codebase that puts your project at risk. You'll now learn about the features that address this risk: code scanning, secret scanning, and push protection.

### Code scanning

Even the best developers produce code with errors that their team must find, triage, and fix. GitHub's code-scanning feature allows you to complete all of those tasks. Code scanning is a static analysis of every git push. The scan happens at the same time as development, and checks for common misconfigurations, errors, and vulnerabilities. This ensures that you catch problems before they make it into production. GitHub alerts authorized developers in the affected repository if the system detects an issue. You'll receive alerts about the state of your code and guidance with suggestions on how to fix any errors. Code scanning also allows members of your organization to learn how to write more secure code.

To use code scanning, you'll first have to enable it for your repository by completing these steps:

1. Navigate to the **Security** tab.
2. In **Code scanning alerts**, select **Set up code scanning**.
3. Select **Set up this workflow for CodeQL Analysis**.

GitHub code scanning supports the following languages:

- C
- C++
- C#
- Java
- JavaScript
- TypeScript
- Python
- Go

Once you enable code scanning, the default workflow triggers scans:

- When you push code to a specified branch
- When a pull request is created for a branch
- According to a schedule

You can monitor your code-scanning workflow from the GitHub user interface. This workflow returns the following results:

- The name of the file that contains the vulnerability
- Highlighted code lines with the actual line on which to find the code in question
- An explanation of the problem
- A recommendation on how to fix the problem
- Examples that model the corrected code
- References to consult

### Secret scanning and push protection

When applications communicate with external systems, they often need to authenticate to gain access. This authentication is performed using keys known as *secrets*. Because developers work with secrets as they build code, it's not uncommon for them to accidentally commit these sensitive pieces of data to repositories. However, these keys create significant security risks if exposed. GitHub Advanced Security offers the following capabilities to prevent exposing secrets:

- **Secret scanning.** When you enable secret scanning, GitHub searches existing code on all branches present in your GitHub repository for keys. You can configure alerts to notify certain users if a secret is found. Users can then take the appropriate remediation actions. For example, they can remove the key from the code, then revoke and reissue the key that was compromised. Or in some cases, the users may choose to ignore the alert (for example, if the scan identified a false positive).

- **Push protection.** For an additional layer of security, you can enable the push-protection option of secret scanning. Push protection lets you find and remove secrets proactively before code is even added to your GitHub repositories, so instead of having to clean up leaked secrets, you can prevent secrets from being exposed in your repository in the first place.

    Push protection integrates seamlessly with the command-line or web-UI tools your developers use. When a developer issues a `git push` command, GitHub scans the code to be added to your repository for secrets. If the code contains a secret, GitHub blocks the code from being committed and prompts the developer to take action. The developer can remove the secret, identify the detected secret as a false positive or a test key, or bypass the alert. As an additional security measure, administrators can configure GitHub push protection to send alert notifications if a developer bypasses a block.

### Features behind the scenes

Some GitHub Advanced Security features are not accessible from the user interface. They work behind the scenes to improve the performance of your platform.

The following table highlights some of these features:

| Feature | Description |
|---|---|
| **CodeQL** | CodeQL is the engine behind code scanning that treats code like data. When code scanning is active on your repository, CodeQL analyzes it without you writing any queries. Templates make it easy to output code scanning results on your repository. |  
| **Third-party tool integration** | GitHub is flexible. You can integrate optional third-party analysis tools that output SARIF data. |

## Secure your automated workflow environment

Developers often use GitHub Actions or Microsoft Azure to automate or customize software-development workflows. When defining a workflow, developers specify an environment in which their code should execute. These environments differ from repositories in that the environments are targets for workflow jobs. The target might be a runner that's similar to a virtual machine. For the runner to execute code received by the workflow, it might need to use an environment secret.

GitHub uses protection rules, environment secrets, and wait timers to keep environment access secure and give you control. Review the tools in the following table:

| Feature | Use |
|---|---|
| **Protection rules** | Administrators can set protection rules that specify reviewers that must approve workflow runs on an environment. The reviewers have read-only access to the repository so that they can approve or reject workflow runs without having permission to edit the code. |
| **Environment secrets** | Systems such as GitHub Actions or Azure can execute a workflow on an environment. Workflow jobs can only access the environment that they reference using that environment's secrets. A reviewer can approve access for the job if needed. |
|**Wait timers** | In situations where you want to delay code deployment, you can set a timer that can wait up to 30 days before deployment takes place. |

You should treat environment secrets with the same level of security as repository and organization secrets. Here are a few tips:

- **Don't use structured data as a secret**: Doing so can cause secret redaction within logs to fail.
- **Register the secrets you use in workflows**: This applies when a secret is used to generate another sensitive value. The value that the secret is to generate needs to be registered.
- **Use required reviewers to protect environment secrets**: This means that a workflow job can't access environment secrets until a reviewer grants approval.

Remember these tips to safely use runners:

- Use self-hosted runners only on private repositories.
- Be cautious when using self-hosted runners on private or internal repositories. Anyone with read access can compromise the runner environment and gain access to secrets.

## Licensing considerations

It's GitHub's mission to be the home for all developers. That's why GitHub makes advanced security features such as dependency review, code scanning, and secret scanning automatically available free of charge for public repositories on GitHub.com. Open-source projects can benefit from these features. Smaller teams and individual developers have the opportunity to secure their development.

To use GitHub Advanced Security features on private repositories, you'll need a GitHub Advanced Security license (GHAS). GHAS is available with GitHub Enterprise Cloud or GitHub Enterprise Server. Each license for GHAS specifies a maximum number of accounts or seats.

As you survey your security requirements, prioritize in which repositories you'd like to run GitHub Advanced Security. Consider which codebases have the highest frequency of commits and are most critical to your company's success.
