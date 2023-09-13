
When you deploy a new release to a customer or install new software on your server, and you want to communicate what has been released to your customer, the usual way is to use release notes.

But where do the release notes come from? There are different ways to store your release notes.

### Document store

An often-used way of storing release notes is by creating text files or documents in some document store. This way, the release notes are stored together with other documents.

The downside of this approach is that there's no direct connection between the release in the release management tool and the release notes that belong to this release.

### Wiki

The most used way for customers is to store the release notes in a Wiki. For example:

 -  Confluence from Atlassian
 -  SharePoint Wiki
 -  SlimWiki
 -  Wiki in Azure DevOps

Release notes are created as a page in the wiki and by using hyperlinks. Relations can be associated with the build, the release, and the artifacts.

### In the codebase

When you look at it, release notes belong strictly to the release of the features you implemented and your code. In that case, the best option might be to store release notes as part of your code repository.

Once the team completes a feature, they or the product owner also write the release notes and save them alongside the code. This way, it becomes living documentation because the notes change with the rest of the code.

### In a work item

Another option is to store your release notes as part of your work items. Work items can be Bugs, Tasks, Product Backlog Items, or User Stories.

You can create or use a different field within the work item to save release notes in work items. In this field, you type the publicly available release notes that will be communicated to the customer.

With a script or specific task in your build and release pipeline, you can generate the release notes and store them as artifacts or publish them to an internal or external website.

:::image type="content" source="../media/release-notes-24b86315.png" alt-text="Screenshot of a release notes field in a feature work item.":::


 -  [Generate Release Notes Build Task](https://marketplace.visualstudio.com/items?itemName=richardfennellBM.BM-VSTS-XplatGenerateReleaseNotes).
 -  [Wiki Updater Tasks](https://marketplace.visualstudio.com/items?itemName=richardfennellBM.BM-VSTS-WIKIUpdater-Tasks).
 -  [Atlassian Confluence](https://www.atlassian.com/software/confluence).
 -  [Azure DevOps Wiki](https://azure.microsoft.com/services/devops/wiki/).

There's a difference between functional and technical documentation. Also, a difference between documentation designing the product, primarily written upfront, and documentation describing the product afterward, like manuals or help files.

Storing technical documentation about your products in the design phase is done on a document-sharing portal, like SharePoint or Confluence.

Creating a wiki is a better and more modern way to store your documentation. Wiki's don't contain Documents, Presentations, or Spreadsheets but text files called Markdown Files.

These markdowns can refer to pictures, hold code samples, and be part of your code repository. Code repositories can deal well with text files. Changes and history can be easily tracked by using the native code tools.

However, the most significant advantage of using a Wiki instead of documents is that a Wiki is accessible to everyone in your team. People can work together on the documentation instead of waiting for each other when working on the same document by giving all the team members the correct permissions.

Manuals or documentation you release together with the product should be treated as source code. When the product changes and new functionality are added, the documentation needs to change.

You can store the documentation as part of your code repository or create a new repository containing your documentation. In any case, the documentation should be treated the same way as your source code. Create a documentation artifact in your build pipeline and deliver this artifact to the release pipeline.

The release pipeline can then deploy the documentation to a site or include it in the boxed product.
