The previous unit discussed the importance of securing your environment from malicious actors. The real-life cases highlighted some of the ways in which hackers can exploit systems. In this unit, you'll be introduced to GitHub Advanced Security. Let's focus on the various product features and the challenge or problem that these features address.

:::image type="content" source="../media/ghas-intro.png" alt-text="Diagram showing GitHub Advanced Security features." border="false":::

GitHub Advanced Security is a powerful suite of tools and features that give you the ability to identify security vulnerabilities in your codebase and environment. These features enable you to secure your code at every step of the software development lifecycle, not just in your production environment. You stay ahead of security threats and breaches, leverage the expertise of the security community, and continue to use open-source software securely. GitHub Advanced Security also includes implementing security best practices that help create a security-minded culture within your organization.

GitHub Advanced Security focuses on protecting your organization in three primary areas:

- Supply chain
- Code
- Environments

Let's look at these three categories to see how you can use advanced security to improve security within your GitHub organization.

## Secure your software supply chain

When you think about supply chains, you may think of manufacturing goods within an industrial warehouse. However, the concept of a supply chain also applies to what happens during your software development lifecycle. Your workflow produces chunks of code that are then reviewed for quality assurance before reaching the next stage. Protections and guidelines are enforced along the way to optimize production and make an acceptable end product.

In the context of software development, supply chain also refers to the integration of any third-party or open-sourced software. Your software is most likely more than the code you have written in-house. Up to 94% of active repositories rely on open-source, so you may rely on many components you didn't produce. These components are called _dependencies_. You need to actively review them for vulnerabilities.

In 2021, Log4j was a dependency included in many applications worldwide. The events surrounding the Log4j vulnerability show how crucial dependency management is to securing your codebase. If you use any third-party software with security vulnerabilities, your project inherits the same weaknesses.

Fortunately, GitHub has automated features that flag these dependency vulnerabilities. These warnings alert specific team members to potential dangers and enable them to act accordingly. These powerful features allow you to automate the process that monitors and secures your project dependencies and searches for vulnerabilities.

Let's look at the features you can use to monitor and secure your software supply chain.

### The security overview

:::image type="content" source="../media/security-overview.png" alt-text="Screenshot of security overview." border="true":::

Once you have an established supply chain, GitHub's security overview provides you with a central location to properly oversee it.  This makes it easier to monitor the state of your project's dependencies. The security overview enables you to identify problematic repositories and understand how your dependencies impact the security of your code. You can also enable security features from the security overview. View, filter, and sort automated security alerts generated for your organization or a specific team. The overview also enables you to filter alerts by their level of risk so you can prioritize your response.

The security overview includes icons for different types of alerts. These icons also display the quantity of each alert type. In the next section, you'll learn about the GitHub features that generate these alerts.

### Dependency graphs

Visualizations can simplify and summarize large amounts of data. Dependency graphs enable you to acquire important insights into your project's direct and indirect package dependencies and their current state. The graphs display a summary of manifest and lock files in the project's ecosystem, repository, and packages. You can also see if dependencies are up-to-date and secure.

:::image type="content" source="../media/dependency-graph.png" alt-text="Screenshot of dependency graph." border="true":::

The dependency graph enables you to monitor any known issues within dependencies that may affect the security of your application. Once you activate the dependency graph, you have access to dependency reviews for both private and public repositories belonging to your organization. These reviews help keep dependency vulnerabilities from being introduced into your environment.

### The GitHub Advisory Database

The GitHub Advisory Database provides information on the state of your dependencies. You can browse or search the GitHub Advisory Database for vulnerabilities in third-party solutions. This is useful because the packages that your project depends on also have other packages that they depend on. In this chain of package relation, you most likely will not be familiar with each piece of software that has been pulled in to your project. So, having an overarching database to track what is happening in the ecosystem is an important resource.

The GitHub Advisory Database is curated by a dedicated team. It lists security vulnerabilities mapped to packages tracked by dependency graphs. Security threats appear in the GitHub Advisory Database ranked from low to critical. GitHub automatically updates this list regularly, using  authoritative sources such as The National Vulnerability Database and the npm security advisories database.

Now, let's look at another component that relies on the GitHub Advisory Database.

### Dependabot for automated dependency management

:::image type="content" source="../media/dependabot-github.png" alt-text="Screenshot of Dependabot icon." border="false":::

Imagine a project that includes 20 to 30 third-party integrations. Manually monitoring so many dependencies and keeping them up to date is time-consuming and tedious. Dependabot is GitHub's answer to this challenge. The built-in mechanism detects vulnerable dependencies by first examining the project's manifest file (such as the `package.json` file used in NodeJS). Next, Dependabot consults the GitHub Advisory Database to see if the detected dependencies have a flag that indicates they are out-of-date or vulnerable. If there is an issue with any dependency or when a dependency graph related to a repository's changes, Dependabot alerts authorized team members.

This automated process helps avoid maintenance oversights and increases efficiency.

## Find and fix security issues as you code

After securing the supply chain, the next area of focus for GitHub Advanced Security is code analysis. Human error can introduce information into the codebase that puts your project at risk. You'll now learn about two features that address this risk, code scanning and secret scanning.

### Code scanning 
Even the best developers produce code with errors that their team must find, triage, and fix. GitHub's code scanning feature enables you to complete all of those tasks. Code scanning is a static analysis of every git push. The scan happens at the same time as development and checks for common misconfigurations, errors, and vulnerabilities. This ensures that you catch problems before they make it into production. GitHub alerts authorized developers in the affected repository if the system detects an issue. You will receive alerts about the state of your code and guidance with suggestions on how to fix any errors. Code scanning also enables members of your organization to learn how to write more secure code.

To use code scanning, you first have to enable it for your repository by completing these steps. 

1. Navigate to the **Security** tab.
2. Click **Code scanning alerts**.
3. Click **Set up this workflow for CodeQL Analysis**.

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

- when you push code to a specified branch
- when a pull request is created for a branch
- according to a schedule

You can monitor your code scanning workflow from the GitHub user interface.  This workflow returns the following results:

- the name of the file that contains the vulnerability
- highlighted code lines depicting the actual line on which to find the code in question
- an explanation of the problem
- a recommendation on how to fix the problem
- examples that model the corrected code
- references to consult

### Secret scanning

When applications communicate with external systems, they often need to authenticate to gain access. This authentication is performed using keys known as _secrets_. Since developers work with secrets during development, it is not uncommon for them to accidentally commit these sensitive pieces of data to repositories. However, these keys create a significant security risk if exposed. So, it is crucial that you remove secrets before you deploy your project. To prevent fraudulent use of secrets, GitHub scans your entire Git history on all branches present in your GitHub repository.

Secret scanning also takes place on a very granular level. You can use a regular expression to define a pattern that the system should use to search for secrets. Here is an example of pattern definition using a regular expression:

`github_token_[a-zA-Z0-0]{15}`

### Features behind the scenes

Some GitHub Advanced Security features are not accessible from the user interface. They work behind the scenes to improve the performance of your platform.

The following table highlights some of these features.

| Feature | Description |
|---|---|
| **CodeQL** | The engine behind code scanning that treats code like data. When code scanning is active on your repository, CodeQL analyzes it without you needing to write any queries. Templates make it easy to output code scanning results on your repository. |  
| **Third-party tool integration** | GitHub is flexible. Integrate optional third-party analysis tools that output SARIF data |

## Secure your automated workflow environment

Developers often use GitHub Actions or Microsoft Azure to automate or customize software development workflows. When defining a workflow, developers specify an environment in which their code should execute. These environments differ from repositories in that the environments are targets for workflow jobs. The target may be a runner that is similar to a virtual machine. For the runner to execute code received by the workflow, it may need to use an environment secret.

GitHub uses protection rules, environment secrets, and wait timers to keep environment access secure and give you control. Review these tools in the following table.

| Feature | Use | 
|---|---|
| **Protection rules** | Administrators can set protection rules that specify reviewers that must approve workflow runs on an environment. The reviewers have read-only access to the repository. So, that they can approve or reject workflow runs without having permission to edit the code. |
| **Environment secrets** | Systems such as GitHub Actions or Azure can execute a workflow on an environment. Workflow jobs can only access the environment that they reference using the secrets of the environment. A reviewer can approve access for the job if needed. |
|**Wait timers** | In situations where you want to delay code deployment, you can set a timer that can wait up to 30 days before deployment takes place. |

You should treat environment secrets with the same level of security as repository and organization secrets. Here are a few tips:

- **Do not use structured data as a secret.** Doing so can cause secret redaction within logs to fail.
- **Register the secrets you use in workflows.** This applies when a secret is used to generate another sensitive value. The value that the secret is to generate needs to be registered. 
- **Use required reviewers to protect environment secrets.** This means that a workflow job cannot access environment secrets until approval is granted by a reviewer.

Remember these tips to safely use runners:

- Use self-hosted runners only on private repositories.
- Be cautious when using self-hosted runners on private or internal repositories. Anyone with read access can compromise the runner environment and gain access to secrets.

## Licensing considerations

It is GitHub's mission to be the home for all developers. That is why GitHub makes advanced security features such as dependency review, code scanning, and secret scanning automatically available free of charge for public repositories on GitHub.com. Open-source projects can benefit from these features. Smaller teams and individual developers have the opportunity to secure their development.

To use GitHub Advanced Security features on private repositories, you'll need a GitHub Advanced Security license(GHAS). GHAS is available with GitHub Enterprise Cloud or GitHub Enterprise Server. Each license for GHAS specifies a maximum number of accounts or seats.

As you survey your security requirements, prioritize which repositories you would like to run GitHub Advanced Security. Consider which codebases have the highest frequency of commits and are most critical to your company's success.
