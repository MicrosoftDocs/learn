

Continuous Integration is one of the eight capabilities in the DevOps taxonomy.

### Discover why Continuous Integration is necessary

On September 23, 1999, the Mars Climate Orbiter stowed its solar arrays to protect them from a temporary descent into the upper Martian atmosphere.

After having successfully entered orbit, the satellite was supposed to relay photos of Mars to Earth for several years. But unfortunately, the craft burned up in the Martian atmosphere.

A bug in the ground control software, which was supplied by a third party, calculated the value in an imperial unit, pound-seconds. The software built by NASA expected the value to be in a metric unit, newton-seconds. Because these values were not correctly converted, small discrepancies in the position of the spacecraft were compounded over a course of millions of miles.

Quality assurance had not noticed the use of an imperial unit in external software, even though NASA’s coding standards at the time mandated use of metric units. Calculations were also done manually rather than using the supplied software, because of file format errors and miscellaneous bugs. This situation is an example of the need for Continuous Integration.

### Explore Continuous Integration

Continuous Integration is a **mindset** and a **team strategy**. In addition to that, author and speaker Martin Fowler says that Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily – leading to multiple integrations per day.

Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible.

When done right, this approach leads to reduced integration problems by catching them earlier in the process.

![Diagram shows the difference between continuous delivery and continuous deployment. The stages are the same in both cases: code done - unit tests - integrate - acceptance test - deploy to production. For continuous delivery, deployment to production happens manually. For continuous deployment, it's automatic. Continuous integration spans the first three stages for both continuous delivery and continuous deployment.](../media/3-3-explore.png)

The **goals** of Continuous Integration are to:

- Harness [collaboration](https://docs.microsoft.com/learn/modules/characterize-devops-continous-collaboration-improvement/2-explore-continuous-collaboration)
- Enable parallel development
- Minimize integration debt
- Act as a [quality gate](https://docs.microsoft.com/learn/modules/explain-devops-continous-delivery-quality/3-explore-continuous-quality)
- [Automate everything!](https://docs.microsoft.com/learn/modules/explain-devops-continous-delivery-quality/2-use-continuous-delivery-release-faster)

> [!NOTE]
> Note how the goals of Continuous Integration include Continuous Collaboration, Continuous Delivery and Continuous Quality!

But what happens when there’s no Continuous Integration? A lack of continuous integration efforts can often result in:

- Long development cycles
  - Non-compiling code
  - At any point in time, source code may not be functional
  - Code freezes
- High build failures / Bug counts
  - Long living branches, causing multi-day merge efforts
  - Code missing from source control
  - Security flaws found late in development cycle
  - Large amount of technical debt
  - No or low code coverage numbers
  - Overall reduced quality
- Limited communication and collaboration
  - Code not following coding standards
  - No or few code reviews
  - Testing done late in development cycle
  - In many cases manual, if at all

Integration points are the quick feedback loop used to improve the system. When timing of integration points slips, the project is in trouble. Here's what Dantar Oosterwal says about them in the book *The Lean Machine*:

>*The epiphany of integration points is that they control product development. They are the leverage points to improve the system. When timing of integration points slips, the project is in trouble.*
>
>Dantar Oosterwal, The Lean Machine
>
>© Scaled Agile, Inc.

If you wonder whether your team is really doing Continuous Integration, these questions can help you determine the answer.

- Are all developers doing trunk-based development?
- Does every change to a trunk kick off a build process?
- When build and test fail, does the team fix the build within a few minutes?

Performance is also influenced by the presence or absence of Continuous Integration. Data collected and analyzed for the book *The Science Of DevOps – Accelerate – Building and scaling high performing technology organizations* by  Nicole Forsgren, Jez Humble, and Gene Kim shows that when low performers’ speed to market increases, their quality decreases.

But high performers can maintain quality while increasing speed to market. They have shorter (and less complex) deployment cycles, and use Continuous Integration to remediate issues immediately, increasing flow and efficiency.

|         2017         |  High performers | Medium performers |  Low performers  |
|:--------------------:|:----------------:|:-----------------:|:----------------:|
| Deployment frequency | Multiple per day | 1 week - 1 month  | 1 week - 1 month |
| Lead time for change | < 1 hour         | 1 week - 1 month  | 1 week - 1 month |
| MTTR                 | < 1 hour         | < 1 day           | 1 day - 1 week   |
| Change failure rate  | 0-15%            | 0-15%             | 31-45%           |
