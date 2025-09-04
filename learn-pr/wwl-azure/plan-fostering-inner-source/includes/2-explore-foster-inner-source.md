The fork-based pull request workflow is popular with open-source projects because it allows anyone to contribute to a project. You don't need to be an existing contributor or have write access to a project to offer your changes.

This workflow isn't just for open source: forks also help support inner source workflows within your company.

## Traditional team workflow

Before forks, you could contribute to a project using Pull Requests. The workflow is simple:

1. Push a new branch to your repository
1. Open a pull request to get a code review from your team
1. Have Azure Repos check your branch policies
1. Click one button to merge your pull request into main and deploy when your code is approved

This workflow is great for working on your projects with your team. But what if you notice a simple bug in a different project within your company and you want to fix it yourself? What if you want to add a feature to a project that you use, but another team develops?

This is where forks come in; forks are at the heart of inner source practices.

## What is inner source?

Inner source – sometimes called "internal open source" – brings all the benefits of open-source software development inside your company firewall.

Inner source opens your software development processes so that your developers can easily collaborate on projects across your company. It uses the same processes that are popular throughout the open-source software communities, but it keeps your code safe and secure within your organization.

### Benefits of inner source

**Cross-Team Collaboration**: Teams can work together on projects even if they don't normally collaborate.
**Knowledge Sharing**: Developers can learn from code written by other teams and apply those lessons to their own work.
**Code Reuse**: Instead of building the same functionality multiple times, teams can build on existing work.
**Quality Improvement**: More people reviewing and contributing to code typically leads to better quality software.
**Faster Innovation**: Teams can move faster by building on existing solutions rather than starting from scratch.

## Microsoft's inner source journey

Microsoft uses the inner source approach heavily. As part of efforts to create one engineering system throughout the company – backed by Azure Repos – Microsoft has opened the source code of all projects to everyone within the company.

### Before inner source

Before moving to inner source, Microsoft was "siloed":

- Only engineers working on Windows could read the Windows source code
- Only developers working on Office could look at the Office source code
- If you were an engineer working on Visual Studio and found a bug in Windows or Office – or wanted to add a new feature – you were out of luck

### After inner source

By moving to inner source throughout the company, powered by Azure Repos, it's easy to fork a repository to contribute back. As an individual making the change, you don't need write access to the original repository, just the ability to read it and create a fork.

This approach has enabled:

- Better collaboration across teams
- Faster bug fixes and feature development
- Improved code quality through broader review
- Reduced duplication of effort across projects
