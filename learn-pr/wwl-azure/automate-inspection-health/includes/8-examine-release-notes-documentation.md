Release communication strategies require comprehensive documentation frameworks that effectively convey feature updates, system modifications, and deployment changes to stakeholders through structured release notes.

Release notes generation employs multiple storage architectures and content management approaches designed to optimize information delivery and maintain traceability with release artifacts.

### Document Storage Systems

Centralized document repositories provide traditional release notes storage through structured file systems and content management platforms. Documentation consolidation enables organizational knowledge management while maintaining separation from release management workflows.

Implementation limitations include disconnected release management tool integration, requiring manual correlation between release artifacts and corresponding documentation assets.

### Wiki-Based Documentation

Collaborative wiki platforms deliver modern release notes management through hyperlinked content structures and integrated version control. Popular wiki implementations include:

- **Atlassian Confluence:** Enterprise-grade collaborative documentation platform.
- **SharePoint Wiki:** Microsoft-integrated organizational wiki system.
- **SlimWiki:** Lightweight wiki implementation for streamlined documentation.
- **Azure DevOps Wiki:** Integrated DevOps platform wiki solution.

Wiki architectures enable dynamic cross-referencing between build artifacts, release packages, and deployment documentation through hyperlink associations and automated content generation.

### Repository-Integrated Documentation

Source code repository integration provides optimal release notes management by maintaining strict alignment between feature implementations and corresponding documentation. Codebase-integrated documentation ensures synchronized version control and automated change tracking.

Development workflow integration enables feature completion documentation through collaborative authoring between development teams and product ownership, creating living documentation that evolves synchronously with code modifications.

### Work Item Documentation

Agile work item integration enables release notes management through structured work tracking systems including Bugs, Tasks, Product Backlog Items, and User Stories. Dedicated release notes fields within work items provide customer-facing communication content.

Automated release notes generation leverages build and release pipeline scripting to extract work item documentation, generating comprehensive release artifacts for internal knowledge management and external website publication.

:::image type="content" source="../media/release-notes-24b86315.png" alt-text="Screenshot of a release notes field in a feature work item.":::

- [Generate Release Notes Build Task](https://marketplace.visualstudio.com/items?itemName=richardfennellBM.BM-VSTS-XplatGenerateReleaseNotes).
- [Wiki Updater Tasks](https://marketplace.visualstudio.com/items?itemName=richardfennellBM.BM-VSTS-WIKIUpdater-Tasks).
- [Atlassian Confluence](https://www.atlassian.com/software/confluence).
- [Azure DevOps Wiki](https://azure.microsoft.com/services/devops/wiki/).

There's a difference between functional and technical documentation. Also, a difference between documentation designing the product, primarily written upfront, and documentation describing the product afterward, like manuals or help files.

Storing technical documentation about your products in the design phase is done on a document-sharing portal, like SharePoint or Confluence.

Creating a wiki is a better and more modern way to store your documentation. Wiki's don't contain Documents, Presentations, or Spreadsheets but text files called Markdown Files.

These markdowns can refer to pictures, hold code samples, and be part of your code repository. Code repositories can deal well with text files. Changes and history can be easily tracked by using the native code tools.

However, the most significant advantage of using a Wiki instead of documents is that a Wiki is accessible to everyone in your team. People can work together on the documentation instead of waiting for each other when working on the same document by giving all the team members the correct permissions.

Manuals or documentation you release together with the product should be treated as source code. When the product changes and new functionality are added, the documentation needs to change.

You can store the documentation as part of your code repository or create a new repository containing your documentation. In any case, the documentation should be treated the same way as your source code. Create a documentation artifact in your build pipeline and deliver this artifact to the release pipeline.

The release pipeline can then deploy the documentation to a site or include it in the boxed product.
