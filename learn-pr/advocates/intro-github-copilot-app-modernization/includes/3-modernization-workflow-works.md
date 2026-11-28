GitHub Copilot modernization follows a structured workflow, but its entry point, artifacts, and validation options depend on the language and scenario. A runtime upgrade doesn't automatically include cloud migration or deployment.

You interact with the modernization agent differently depending on your environment:

- **Visual Studio Code (Java).** Open the **GitHub Copilot modernization** sidebar and select **Upgrade Java Runtime & Frameworks**, or select a predefined task or authored skill. The task opens Copilot Chat in agent mode.
- **Visual Studio (.NET).** Select a project or solution in **Solution Explorer**, open its context menu, and select **Modernize**, or type `@Modernize` in Copilot Chat. The .NET upgrade workflow records state under `.github\upgrades\<scenarioId>\`, including `assessment.md`, `upgrade-options.md`, `plan.md`, and `tasks.md`.
- **Visual Studio Code (.NET upgrades).** With the upgrade integration installed, type `@upgrade` in Copilot Chat. Azure dependency migration is a separate integration and workflow; don't assume its artifact paths or commands are the same as a framework upgrade.
- **Copilot CLI.** Install the relevant plugin and select its modernization agent before entering a request.
- **Copilot cloud agent.** Before delegation, a repository administrator must configure the documented language-specific MCP server and merge the custom-agent profile into the default branch. Provide compatible source/target build tooling and eligible cloud-agent access. The .NET Azure migration MCP server itself requires the .NET 10 SDK; that doesn't make every source project buildable in the same environment. Select the configured agent when assigning the task. An arbitrary issue or pull request doesn't install these tools.

Choose **Actions** when the integration relies on `.github\workflows\copilot-setup-steps.yml`, a Windows build environment, or a larger/self-hosted runner. **Cloud** sandbox sessions don't run that setup workflow and can't use its runner settings. Select the execution environment before starting the session; changing it requires a new session. For a Windows-only source project, configure a compatible Windows Actions runner under your organization's network policy before delegating the upgrade.

For example, the general Java modernization integration for Copilot CLI requires Copilot access and Node.js 22 or later. After installing Copilot CLI and signing in, install the plugin:

```powershell
copilot plugin marketplace add microsoft/github-copilot-modernization
copilot plugin install github-copilot-modernization@github-copilot-modernization
```

From the application repository, start its specialized agent:

```powershell
copilot --agent=github-copilot-modernization:modernize
```

You can then request, "Assess this Java application for migration from S3 to Azure Blob Storage. Produce an assessment report only; don't modify application code or execute the migration." Review the proposed scope and tool actions. The dedicated Java-upgrade quickstart uses a different plugin, `modernize-java`, with agent `modernize-java:modernize-java`; don't mix those identifiers with the general plugin.

For .NET upgrades, the current CLI installation uses the `microsoft/upgrade-agent-plugins` marketplace and `upgrade-agent@upgrade-agent-plugins` plugin. Confirm its availability with `/agent`. .NET Azure migration uses the general modernization plugin illustrated above, not the dedicated .NET upgrade plugin.

The separate **Modernize CLI**, invoked as `modernize`, can orchestrate assessments and plans across applications and supports execution and upgrade commands. It isn't another spelling of `copilot` or a plugin installation command.

The general modernization plugin in Copilot CLI orchestrates assessment, planning, and execution. Approval prompts depend on the host, execution mode, and configuration; don't assume either mandatory stage-by-stage pauses or prompt-free execution. A specific migration request can bypass assessment and, for a single task, the planning coordinator. An execute-existing-plan request selects and runs an existing plan without generating a new assessment or plan. An assessment-only prompt communicates intent, but isn't a technical permission boundary.

For separate assessment and execution commands, use the separately installed Modernize CLI. Authenticate with `gh auth login` and run the commands from the application's repository. Run `modernize assess` and review the report, then create a plan with `modernize plan create "<modernization goal>" --assess-file-path "<assessment-report-path>" --plan-name "migration-review"`. Replace the placeholders with your goal and the generated report's actual path, and choose a fresh plan name for independent work. Inspect the generated plan and task list before invoking `modernize plan execute --plan-name "migration-review"` with that same name. Naming the plan makes the intended selection explicit; it isn't a required CLI option. Keep normal tool permissions and code-review controls; a tool-approval prompt isn't the same as approval of an entire migration stage.

The following stages describe the work involved, not mandatory stops in every integration:

1. **Assessment.** Analyze code, configuration, and dependencies. Review compatibility issues and scope. For Azure migration, assess cloud readiness and candidate services; for a framework upgrade, focus on source/target compatibility.
1. **Planning.** Review the target versions, dependencies, application-specific constraints, branching strategy, and validation criteria. Select guided execution where the integration provides it, or separate planning from execution as described above. Decide whether optional technology changes belong in the current upgrade.
1. **Code transformation.** Apply the approved changes using the selected language's tools. Java workflows can use OpenRewrite recipes; .NET workflows apply their documented upgrade skills. Review configuration and business-logic changes, not just package versions.
1. **Build, CVE, and test validation.** Review actual build results and dependency vulnerability findings. In Java upgrades, test execution depends on the plan's test option. Ensure appropriate tests run, inspect any generated or modified tests, and resolve or explicitly track remaining failures.
1. **Optional containerization and deployment.** If requested, generate deployment assets for a compatible Azure host, such as App Service, Container Apps, or AKS. Confirm Azure access, resource configuration, cost, and operational readiness before provisioning or deployment.

Read the completion artifacts for the workflow you ran. Java upgrades produce a summary of changes, build/test results, limitations, and next steps. .NET upgrades also record individual task status. Unresolved issues aren't necessarily minor: a failing business-critical test or an unaddressed vulnerability can block release. Retain the reviewed results for code review and operational handover.

## Predefined tasks

Predefined tasks encode common Azure migration patterns. They help update application code and configuration; validate their suitability for your architecture rather than treating them as automatic service or data cutovers.

Java predefined tasks include:

- Switch from password-based authentication to managed identities.
- Migrate from Amazon S3 to Azure Blob Storage.
- Migrate supported RabbitMQ, ActiveMQ, or Amazon SQS integrations to Azure Service Bus.
- Migrate supported cache implementations to Azure Managed Redis.

Azure App Configuration can be an application design choice, but the cited Java task catalog doesn't document a predefined task for it. Confirm an exact task in your installed version or use a reviewed custom skill rather than assuming built-in coverage.

.NET predefined tasks include:

- Update database-access code for Azure SQL Database, Azure SQL Managed Instance, or Azure Database for PostgreSQL with managed-identity authentication.
- Migrate file I/O to Azure Files or Azure Blob Storage, according to the required access semantics.
- Transition authentication to Microsoft Entra ID.
- Replace plaintext credentials with managed identities and Azure Key Vault where applicable.
- Move from legacy message queues (MSMQ, RabbitMQ, Amazon SQS) to Azure Service Bus.
- Add OpenTelemetry instrumentation and export telemetry to Azure Monitor.
- Migrate to Confluent Cloud or Azure Event Hubs for Apache Kafka.

For cache modernization, target **Azure Managed Redis**. The Java catalog explicitly documents that destination; this doesn't establish equivalent .NET task support. Use an installed task only if it targets Azure Managed Redis and supports your source/client; otherwise author a reviewed custom skill or migration plan. Updating the destination's name in a prompt isn't sufficient: review client endpoints, TLS, clustering compatibility, identity permissions, and token renewal.

For email modernization, first select a supported destination that matches the recipients and message volume. Microsoft 365 High Volume Email (HVE) covers within-tenant operational mail in Microsoft 365 Worldwide environments. It requires a dedicated HVE account and a valid Microsoft 365 pay-as-you-go billing policy connected to the HVE service and assigned to that account. Tenant billing setup requires at least one SharePoint license or a license that includes SharePoint, plus an Azure subscription in the same tenant. The HVE account itself doesn't need a mailbox license. Mailbox-based mail and external transactional/bulk delivery require different choices. Use a reviewed migration plan or custom skill; don't assume an older email task targets a suitable replacement service.

## Custom skills

Enterprises often have organization-specific migration patterns. You can explicitly capture a successful migration in a custom skill and reuse its instructions and resources. This is authored knowledge reuse, not automatic model training after each migration.

For this Java custom-skill procedure, use VS Code 1.113 or later with Copilot and the modernization extension enabled, sign in with Copilot access, and confirm `chat.extensionTools.enabled` is `true` under your organization's policy. Install Java 21 or later for the workflow and the JDK needed to build the source project. Use a Git-managed project with Maven or Gradle Wrapper 5 or later; Kotlin DSL builds aren't supported. Establish a baseline build and provide access to the required package repositories.

To author and apply the skill:

1. Open the modernization sidebar, hover over **TASKS**, and select **Create a Custom Skill**.
1. In `SKILL.md`, enter a name, description, and instructions that explain the transformation and its constraints.
1. Select **Add Resources**, then **Files** or **Folders**. For a previous migration, add a reviewed diff file from the relevant commit. The resources are copied alongside the skill file under `.github\skills\<skill-name>\`. Reference the required resources by name in the skill's instructions so the agent knows how to use them.
1. Select **Save**. The skill appears under **My Skills**.
1. Select **Run** in the editor, or **Run Skill** under **My Skills**. Review the plan and changes for the new application's context.
1. To share the skill, copy its complete folder into the recipient project's `.github\skills\` directory and select **Refresh** in the modernization pane.

For example, a RabbitMQ-to-Service-Bus migration diff can document how your team maps message handling and configuration. Remove secrets and project-specific values before reuse. The illustrated **My Skills** authoring experience is in VS Code; it isn't currently supported in IntelliJ.

For .NET upgrades, use the upgrade agent's separate customization workflow. You can request, "I want to generate a custom upgrade instruction," describe the scenario, and review the resulting instruction and examples. For the current upgrade, record decisions in `.github\upgrades\<scenarioId>\scenario-instructions.md` or refine individual task files. Don't edit `tasks.md`: it's an agent-managed progress dashboard. Test reusable instructions or skills in isolation before applying them across projects.

## Unit test generation

Java has a documented standalone test-generation task, independent of a complete upgrade. In VS Code, use version 1.113 or later with Copilot the modernization extension configured, a Git-managed Java project, its JDK, and a supported Maven or Gradle build. For Maven projects, provide Maven Central access. In Copilot Chat, enter `Generate unit tests for this Java project using #appmod-generate-tests-for-java`. The task records progress and before/after test results in `generate_tests.md`.

In a codebase with low coverage, ask for characterization tests that capture important existing behavior. Review the assertions against requirements, run the tests on the original application, and record the baseline. Configure the runner and dependencies required by the selected language/workflow rather than assuming every test-generation task installs them automatically.

Run the reviewed tests after modernization and add integration and end-to-end coverage for affected dependencies. Matching test results increase confidence only for the behaviors those tests exercise; they don't prove that the applications are identical. Don't weaken assertions simply to make an upgrade pass.