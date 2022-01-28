Now that you're familiar with the features of GitHub Advanced Security, let's look at how your organization can think and plan with prevention and structure in mind. Here, you'll learn what it means for an organization to "shift left." You'll understand how shifting left helps secure your Software Development Life Cycle (SDLC). You'll also review both faulty and ideal security workflow models. This review gives you an idea of best practices as well as what to avoid.

At the end of this unit, you'll understand how the right tools, combined with organizational culture, increase the security of your environments and codebases. This begins with adopting a security-focused mindset.

## Adopt a security mindset

Why should you care about creating a culture centered around security in your organization? The more security-centric your organizational culture is, the more team members remember to view their actions, work, and decisions through the lens of security. Operating from this point of view means better outcomes for your software development and planning. However, a sound security strategy involves more than simply putting protective tools in place. You may have tools to protect your assets and systems but that don't account for human error. There are many situations in which tools aren't enough. A user could accidentally enable an attack or a developer could write insecure code. Think of how many attacks begin with deceiving or coercing people inside an organization to perform some task that gives access to bad actors.

## Shift left

:::image type="content" source="../media/shift-left3.png" alt-text="Screenshot of shift left icon." border="false":::

You may have heard that a company or development team is beginning to "shift left." To understand this phrase, you must first realize that security has commonly been an isolated topic in many software development paradigms. The development lifecycle has figuratively begun "on the left" with design and development. Then the lifecycle ends to the right, bringing in quality control and deployment tasks. Workflows often include security only after the development stage. At that point, only a specific group of team members would perform a security review.

In the SDLC, shifting left refers to adopting security practices early in the process. When development shifts left, every team member involved in application development considers security when they contribute to the code. They integrate security into the design phase, making it easier to write secure code and policies.

### Faulty security models

Developers that view security as an isolated consideration can struggle when quality assurance or security teams discover errors in the project's code. The development team has to fix the code. At this point, they may have already begun a new project. Passing code back to be repaired results in two open work streams. This is an inefficient use of time and resources. Although some elements of a defective security model may be common, you should still work to avoid them.

This table outlines traits regularly found in faulty organizational security models.

| Facet  | Comment |
|---|---|
| Scope of team involvement |  Only a limited number of team members are responsible for security. The persons building the application aren't the same involved in ensuring security. Security experts are outside of the development workflow. |
| Prioritization | Security reviews and quality control are separate steps at the end of the development stage.|
| Documentation | Security documentation is non-existent. Written standards and guidelines haven't been established to granularly regulate what type of information enters the codebase and by whom. Subsequently, team members lack a common understanding of expectations and directives.|
| Platform configuration | The development environment isn't configured to align with and enforce established security guidelines.|

### The ideal security model

In the ideal scenario, each member involved in the development process is responsible for securing the project within their scope of work. The team that writes the code is the same team performing tests and dealing with the results of those tests in real time. Policies exist for each phase of the operation to ensure code quality. Automation plays a significant role in creating an efficient workflow.

This table shows key elements of the ideal security model:

| Facet  |  Comment |
|---|---|
| Scope of team involvement | Teams shift left. Each role from design to deployment is concerned with security. |
| Prioritization | Throughout all stages of development, measures are in place to protect assets|
| Documentation | Standards and guidelines are in writing. Teams know the process to report bugs.| 
| Tooling | The development platform enforces standards and keeps code and environments secure.

### Security policies

A security-centric culture needs written documentation that defines which persons or roles have the right to perform specific actions within a repository or branch. In GitHub, these documents are _policies_. Policies may require a code review before merging. They ensure that the code passes certain status checks. For example, you may want to specify who can delete a branch or push code to it. In GitHub, you store policy details in your repository, in the `SECURITY.md` file. This file will also include instructions on reporting any bugs or vulnerabilities found in the project.

#### Enforce policies

GitHub Advanced Security includes compliance and policy management features. You can use policies to stipulate standards and procedures that keep your code healthy. Policies also identify which team members to contact when an error is found.

On their own, Policies don't enforce your organization's requirements. Policies are organizational measures, administrators ensure user adherence by setting up protected branches. The configuration of a branch allows you to force specific requirements. For example, tests such as code scanning must pass before merging changes. Another example is requiring a reviewer to approve a pull request before reviews release it for merging.
