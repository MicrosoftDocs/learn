Continuous integration (CI) is one of the most fundamental DevOps elements. It promotes collaboration, contributes to early detection of code quality issues, and benefits the streamlined development process. It also serves as the foundation of continuous delivery and deployment. By employing the CI practices, the organization described in our sample scenario will be able to eliminate the manual effort involved in building and testing its applications, effectively expediting their delivery to their users. To help you gain full appreciation of CI benefits, we'll describe them in this unit.

## What is Continuous Integration?

Continuous integration is the process of automatically building and testing updated versions of software following individual updates to the software repository. In general, the integration pattern involves developers submitting their changes in separate branches via pull requests. The changes are subject to a collective review and, assuming its successful outcome, are merged into the main branch. Individual commit or merge events might be used to trigger code build and testing in order to ensure that proposed or resulting changes don't have adverse effects. With continuous integration in place, the build and tests are fully automated.

:::image type="content" source="../media/5-continuous-integration.png" alt-text="Diagram of the continuous integration flow.":::

This automation is based on build and test definitions created by developers and implemented in the repository hosting platform. For example, GitHub offers for this purpose GitHub Actions workflow, while Azure DevOps relies on Azure Pipelines.

---
> [!VIDEO https://www.youtube.com/embed/URmeTqglS58?si=bSYm2OPSdWLEdxXI?cc_load_policy=1&cc_lang_pref=auto]
---

## What are the benefits of Continuous Integration?

The primary benefits associated with continuous integration are based on the general shift-left strategy, which (as you'll find out later in this module) also influences many other DevOps practices. The basic premise is that the longer it takes to detect an issue introduced through a code change, the more expensive and effort consuming it's to fix it. With continuous integration, code build and testing take place as soon as possible. They're also implemented in an automated manner, which increases their speed and reliability.
Continuous integration improves consistency, ensuring that builds and tests are conducted in a reproducible manner. That consistency, in turn, helps enforce programming standards, resulting in cleaner and easier to maintain code.
Last, but not least, continuous integration is typically part of continuous delivery, streamlining entire application lifecycle management. Minimizing the overhead associated with maintaining the build, test, and deployment activities increase overall productivity of development and operation teams, reducing time-to-market for software products.
