
Continuous integration (CI) is the process of automating the build and testing of code every time a team member commits changes to version control.

CI encourages developers to share their code and unit tests by merging their changes into a shared version control repository after every small task completion.

Committing code triggers an automated build system to grab the latest code from the shared repository and build, test, and validate the entire main branch (also known as the trunk or main).

:::image type="content" source="../media/lifecycle-continuous-integration-25a3cae0.png" alt-text="Screenshot of continuous integration lifecycle.":::


The idea is to minimize the cost of integration by making it an early consideration.

Developers can discover conflicts at the boundaries between new and existing code early, while conflicts are still relatively easy to reconcile.

Once the conflict is resolved, work can continue with confidence that the new code honors the requirements of the existing codebase.

Integrating code frequently doesn't offer any guarantees about the quality of the new code or functionality.

In many organizations, integration is costly because manual processes ensure that the code meets standards, introduces bugs, and breaks existing functionality.

Frequent integration can create friction when the level of automation doesn't match the amount of quality assurance measures in place.

In practice, continuous integration relies on robust test suites and an automated system to run those tests to address this friction within the integration process.

When a developer merges code into the main repository, automated processes kick off a build of the new code.

Afterward, test suites are run against the new build to check whether any integration problems were introduced.

If either the build or the test phase fails, the team is alerted to work to fix the build.

The end goal of continuous integration is to make integration a simple, repeatable process part of the everyday development workflow to reduce integration costs and respond to early defects.

Working to make sure the system is robust, automated, and fast while cultivating a team culture that encourages frequent iteration and responsiveness to build issues is fundamental to the strategy's success.
