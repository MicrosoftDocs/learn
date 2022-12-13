Organizations should shift from a 'Waterfall' development cycle to the
DevOps lifecycle of continuous integration, continuous delivery (CI/CD)
for applications, and API development as quickly as possible. DevOps is
the union of people, processes, and tools that enable continuous
delivery of value to end users. The contraction of Dev and Ops refers to
combining the development and operations disciplines into
multidisciplinary teams that work together with shared and efficient
practices and tools.

The DevOps model increases the organization's ability to rapidly
address security concerns without waiting for a waterfall model's
longer planning and testing cycle.

## Deploy the DevOps and the application lifecycle

![Diagram that shows the DevOps lifecycle.](../media/devops-application-lifecycle.png) 

DevOps influences the application and API lifecycle throughout
its plan, develop, deliver, and operate phases. Each phase relies on the
others, and the phases are not role-specific. In a true DevOps culture,
each role is involved in each phase to some extent.

| Phase | Activities |
| :--- | :--- |
| Plan | DevOps teams ideate, define and describe features and capabilities of the applications and systems they're building. They track progress at low and high levels of granularity from single-product tasks to tasks that span portfolios of multiple products. Some of the ways DevOps teams plan with agility and visibility are creating backlogs, tracking bugs, managing agile software development with Scrum, using Kanban boards, and visualizing progress with dashboards. |
| Develop | Includes all aspects of coding writing, testing, reviewing, and integrating code by team members as well as building that code into build artifacts that can be deployed into various environments. Teams uses version control, usually Git, to collaborate on code and work in parallel. They also seek to innovate rapidly without sacrificing quality, stability, and productivity. To do that, they use highly productive tools, automate mundane and manual steps, and iterate in small increments through automated testing and continuous integration |
| Deliver | The process of deploying applications into production environments consistently and reliably, ideally via continuous delivery. The deliver phase also includes deploying and configuring the fully governed foundational Infrastructure that makes up those environments. These environments often use technologies like Infrastructure as Code (IaC), containers, and microservices. |
| Operate | Involves maintaining, monitoring, and troubleshooting applications in production environments, usually hosted in public and hybrid clouds. In adopting DevOps practices, teams work to ensure system reliability, high availability and aim for zero downtime while reinforcing security and governance. |

## Enforcing Security for DevOps

Teams that don't have a formal DevSecOps strategy are encouraged to begin the planning as soon as possible. At first, there may be some resistance from team members who don't fully appreciate the existing threats. Others may not feel that the team is equipped to face the problem and that any special investment would be a wasteful distraction from shipping features. However, it's necessary to begin the conversation to build consensus on the nature of the risks, how the team can mitigate them, and whether the team needs resources, they don't currently have.

Expect skeptics to bring some common arguments, such as:

-   **How real is the threat?** Teams often doesn't appreciate the
    potential value of the services and data they're charged with
    protecting.

-   **Our team is good, right?** A security discussion may be perceived
    as doubt about the team's ability to build a secure system.

-   **I don't think that's possible.** This is a common argument from
    junior engineers. Those with experience usually know better.

-   **We've never been breached.** But how do you know? How *would* you
    know?

-   **Endless debates about value.** DevSecOps is a serious commitment
    that may be perceived as a distraction from core feature work. While
    the security investment should be balanced with other needs, it
    can't be ignored.

## Security strategy components

Many techniques can be applied in the quest for more secure systems.

| Preventing breaches | Assuming breaches |
|---|---|
| Threat models | War game exercises |
| Code reviews | Central security monitors |
| Security testing | Live site penetration tests |
| Security development lifecycle (SDL) |  |

Every team should already have at least some practices to prevent breaches. Writing secure code has become more of a default, and there are many free and commercial tools to aid in static analysis and other security testing features.

However, many teams lack a strategy for dealing with a world in which they assume they will be breached at some point. This can be hard to admit, especially when having difficult conversations with management. The most important thing to focus on is that practicing techniques that assume breaches helps the team answer questions about their security on their own time, so they don't have to figure it all out during a real security emergency.

Common questions the team needs to think through:

* How will we detect an attack?
* How will you respond if there is an attack or penetration?
* How will we recover from an attack, such as when data has been leaked or tampered with?

## Strategies for mitigating threats

The list of potential threats to a system is so substantial that it's not possible to enumerate everything. Some security holes are due to issues in dependencies like operating systems and libraries, so keeping them up-to-date is critical. Others are due to bugs in system code that require careful analysis to find and fix. Poor secret management is the cause of many breaches, as is social engineering. It's good to think about the different kinds of security holes and what they mean to the system.

## Securing APIs

Most modern web applications expose APIs that clients can use to interact with the application. A well-designed web API should aim to support:

* Platform independence. Any client should be able to call the API, regardless of how the API is implemented internally. This requires using standard protocols and having a mechanism whereby the client and the web service can agree on the format of the data to exchange.
* Service evolution. The web API should be able to evolve and add functionality independently from client applications. As the API evolves, existing client applications should continue to function without modification. All functionality should be discoverable so that client applications can fully use it.

Focus on the business entities that the web API exposes. For example, in an e-commerce system, the primary entities might be customers and orders. Creating an order can be achieved by sending an HTTP POST request that contains the order information. The HTTP response indicates whether the order was placed successfully or not. When possible, resource URIs should be based on nouns (the resource) and not verbs (the operations on the resource).

For a walkthrough of using Microsoft Defender for Cloud to unify DevOps security, view the following interactive guide.

[:::image type="content" source="../media/unify-devops-security-management-defender-cloud-interactive-guide.png" alt-text="Screenshot of an interactive guide with the title 'Manage your cloud security posture with Microsoft Defender for Cloud'." border="true":::](https://mslearn.cloudguides.com/guides/Unify%20DevOps%20security%20management%20with%20Microsoft%20Defender%20for%20Cloud)