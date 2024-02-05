
Azure DevOps Projects includes an option to create a project wiki.

:::image type="content" source="../media/project-wiki-2fd9a459.png" alt-text="Screenshot of Azure DevOps wiki with title and description example.":::


The wiki to share information with your team to understand and contribute to your project.

Wikis are stored in a repository. No wiki is automatically provisioned.

## Prerequisites

You must have permission to **Create a Repository** to publish code as a wiki. While the **Project Administrators** group has this permission by default, it can be assigned to others.

To add or edit wiki pages, you should be a member of the **Contributors** group.

All team project members (including stakeholders) can view the wiki.

## Creation

The following article includes details on creating a wiki: [Create a Wiki for your project](/azure/devops/project/wiki/wiki-create-repo).

## Editing the wiki

The following article includes details on publishing a Git repository to a wiki: [Publish a Git repository to a wiki](/azure/devops/project/wiki/publish-repo-to-wiki).

## Markdown

Azure DevOps Wikis are written in Markdown and can also include file attachments and videos.

Markdown is a markup language. The plain text includes formatting syntax. It has become the de facto standard for writing projects and software documentation.

One key reason for this is that because it's made up of plain text, it's easier to merge in the same way that program code is merged.

It allows documents to be managed with the same tools used to create other code in a project.

## GitHub Flavored Markdown (GFM)

GFM is a formal specification released by GitHub that added extensions to a base format called CommonMark. GFM is widely used both within GitHub and externally. GFM is rendered in Azure DevOps Wikis.

## Mermaid

Mermaid has become an essential extension to Markdown because it allows diagrams to be included in the documentation.

It overcomes the difficulties of merging documentation, including diagrams represented as binary files.

:::image type="content" source="../media/mermaid-markup-dd1a8a0c.png" alt-text="Screenshot of Mermaid Markup showing the welcome to the project wiki Contoso text and graph showing A and B dependencies.":::


:::image type="content" source="../media/mermaid-rendering-f7d50b39.png" alt-text="Screenshot of Mermaid Rendering showing the welcome to the project wiki Contoso text and graph showing A and B dependencies.":::


Details on Mermaid syntax can be found here: [Mermaid Introduction](https://mermaid-js.github.io/mermaid/).
