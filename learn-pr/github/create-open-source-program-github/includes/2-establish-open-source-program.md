Here, we discuss the key considerations for establishing an open-source program.

## What do we mean by "open-source"?

An open-source program is more than public access to a codebase. It's about opening up a living project for participation from anyone who wants to get involved. When executed properly for an appropriate project, an open-source program can help drive substantial improvements in the quality of your product.

One of the key reasons companies open-source projects is that they want the community to get involved. Popular projects receive significant contributions from the community, and they get it for free.

It's not necessarily out of altruism. People and organizations *consume* projects because they see a personal or business benefit. When the project doesn't meet their needs or expectations, they may use the opportunity to address bugs or add features. Rather than hold these improvements back in private forks, they're compelled to *contribute* those changes back into the source repository to become part of the project baseline. This virtuous cycle of improvement is why many businesses *produce* software using the open-source model.

### Open-source goals

To recap, there are three dimensions to participation in open-source software:

- **Consumers**, who study or use the repositories of others.
- **Contributors**, who are actively involved in the improvement of the repositories of others.
- **Producers**, who build and maintain their own repositories that are open to others.

As organizations think more deeply about what they want to get out of each dimension, it's a good practice to take stock of where they are today. There are five process levels within each dimension.

![Open-source process levels.](../media/2-process-levels.png)

- **Ad hoc**, which have no process in place. Success depends on individual efforts.
- **Managed**, which have a partially documented process. Success depends on discipline.
- **Defined**, which have a documented, standardized, and integrated process. Success depends on automation.
- **Measured**, which have a quantitatively managed process. Success depends on measuring metrics against business goals.
- **Optimized**, which have a process that is continually and reliably improving through both incremental and innovative changes. Success depends on reducing the risk of change.

To get a better understanding of where your organization stands, check out the [Open-source self assessments](https://githubtraining.github.io/oss-assessment/?azure-portal=true).

### What should you open-source?

Many projects aren't destined for open-source greatness. While your criteria may vary based on your company's goals and process level, here are some recommended criteria to consider before open-sourcing a project:

- Does your project contain intellectual property that you want to protect? If so, then opening its source would give away its value. Don't open-source those kinds of projects unless you feel the benefits outweigh the risks.

- Is the project in a stable state with good code quality? The project doesn't have to be perfect, but potential contributors may walk away if the project is in terrible shape to begin with.

- Is your project useful to people outside of your company? If not, then you probably aren't getting any participation.

- Are people outside your company able to contribute? They need access to all project dependencies, build processes, and whatever else is needed to run the project. If they can't run it, then they can't contribute.

- Does your team have the bandwidth to support an open-source program? If not, then wait until you do. If you open-source a project and then don't support it, you might lose your opportunity to build a trusting community.

These questions are just a few of the most common considerations. Your organization may have other business or compliance issues to keep in mind.

## Designing an open-source program

Running an open-source program is similar to running an InnerSource program, but for a public audience. As a result, there are a few more considerations.

### Setting community expectations

Files like `README.md` and `CONTRIBUTING.md` are even more important because they're being exposed to people who don't have your organizational context. They need to be evaluated from the perspective of someone outside the company to ensure clarity.

In addition, your **code of conduct** is an important policy to express. The standard is to add a `CODE_OF_CONDUCT.md` file to the root of your repository and use it to explain the behavior expected from participants in your community. Multiple groups in your organization should review this document, including your legal team. Fortunately, there are many standard codes of conduct available from which to start. Many projects use these codes as-is without modification. Learn more in the [Guide to open-source codes of conduct](https://opensource.guide/code-of-conduct/?azure-portal=true).

### Preparing employees to maintain a repository

Employees may not have experience working with the open-source community. To help them prepare, we recommend that the company offer a set of guides that cover the key things everyone should know before they get started. These guides should be posted to an internal repository or portal that is only accessible to company employees and regularly maintained. The following guides are a few of the most important.

- A **"Should we open-source this project?" guide** that provides a framework for deciding whether or not a candidate project should be open-sourced. This guide could be structured as a flowchart, set of questions, or list of considerations.

- A **setup checklist** that includes all of the work items a team needs to complete before and after the launch of an open-sourced project. This list should include acquiring approval to open-source the project, code reviews to ensure sensitive data is removed before the project goes live, a trademark or [open-source project search](https://opensource.google/projects/search) to ensure there isn't a naming conflict, and so on.

- A **contact list** for key people in your organization that may need to be contacted in case direct support from the maintainers is required. This list should include people from software security, site security, legal, public relations, and so on.

- A link to a **starter repository** that can be cloned as a starting point. It should contain a sample README, license, code of conduct, contributing guide, and any other supporting files every open-source project from your company needs to have. It shouldn't contain anything you wouldn't want accidentally pushed to a public audience.

- A **maintainer's guide** that explains the responsibilities a maintainer has in keeping the repository healthy. These responsibilities include keeping repository documentation up to date, ensuring issues and pull requests get the attention of the right people in a timely manner, and so on.

- A **communications guide** that offers repository maintainers guidance for some of the topics you would prefer not to include in public files like `README.md`, `CONTRIBUTING.md`, or `CODE_OF_CONDUCT.md`. These subjects may be sensitive business topics, such as not discussing competitors, or more general conduct topics, like how to appropriately recognize top contributors.

- An **internal FAQ** that provides approved answers to common questions. This list is especially useful if there are legal subtleties to the topics your company may discuss in the course of maintaining an open-source program.

- A **license policy** that lists which licenses have been approved or rejected by the legal department for open-source consuming or contributing.
