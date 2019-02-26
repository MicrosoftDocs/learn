[We'll need to define how we approach/talk about the Q&A sessions the team's resident DevOps expert conducted, but here are some key questions they may have discussed:]

* How do you plan and schedule work?
  * Answer: We take a mainly waterfall approach. Management sets priorities, developers write code, QA tests builds, operations deploys approved builds.
  * Analysis: It takes a long time to release new features or updates. This approach limits our ability to course-correct. If something's not working or the result wasn't what the customer wanted, it's hard to go back to management and ask for time to iterate.

* Who decides priorities?
  * Answer:
    * Management decides priorities.
    * Engineering takes on bug fixes and other minor improvements when they think necessary and have time.
  * Analysis:
    * Management can often see the "big picture", but often lacks context around the details (bugs, deployment failures, minor but important product and process improvements).
    * Engineering doesn't always feel empowered to control their schedule or make the right decisions. There never seems to be time to take on quality improvements and similar work. Processes can only improve when management approves time.
    * Work sometimes feels random because teams don't understand the rationale behind various decisions.

* How do teams communicate?
  * Answer:
    * Mostly verbal/email communications.
    * Decisions sometimes go in a shared document/spreadsheet.
  * Analysis:
    * Because commitments are often made in "hallway conversations" or email, the teams don't have full visibility over what's been agreed upon or how those decisions were made. Lack of visibility limits team members from offering different perspectives or potential pitfalls.
    * Lack of transparency also results in duplicate work (two teams trying to accomplish the same goal.) Duplicate work hurts morale because handoffs are then thrown away or otherwise go unused.

* When do you consider work "done"?
  * Answer:
    * Each team considers work done upon handoff. For example, engineering considers work done once they check in their code. QA considers things done once they've identified a release candidate. Operations considers things done when the service is live.
  * Analysis:
    * Teams that were earlier in the process miss out on insights they can use to improve processes. In other words, the feedback loop often goes missing. For example, although operations performs some rudimentary monitoring on live services, they don't involve engineering during live site incidents or report back metrics such as resource (CPU, memory, network) utilization. Engineering could use that information to better tune their products or prevent failures.

* What's our release process?
  * Answer:
    * The QA team picks up builds and runs manual tests in their lab.
    * When the QA identifies a good build, that build (the release candidate) gets embargoed for a week or so so they can continue to test.
    * The operations team deploys the latest RC the first and third Friday of each month - but only when everything goes smoothly.
    * Operations has a number of runbooks that describe how to deploy the software to production.
      * Most things are done manually, but operators share around some shell scripts they've built over time.
      * Software updates and other maintenance ("downtime") are done off peak hours so as to minimize disruption to users.
  * Analysis:
    * Releases feel slow. It can take weeks or even months to get new features or fixes in front of users.
    * Issues found late in the cycle cause the process to start over when the development team publishes a new build.
    * Manual deployments are tedious and error-prone. Every deployment feels like a new experience.
    * Downtime is becoming unacceptable, especially as the product moves to a more global audience.

* How does our security and compliance process work?
  * Answer:
    * (_ABC_ and _XYZ_ are placeholders for standard compliance frameworks we'll later identify.)
    * The operations team takes the role of security engineering during security reviews.
    * The team's software is required to be _ABC_ compliant.
    * The team has also defined a number of security features, such as which ports can be open through the firewall, who can access production servers, where log files are stored, and so on.
    * The security team has built a shared document that defines these requirements.
    * The security officer comes around every 6 months or so. During each security review, the security team needs to provide a report that explains what was tested, what failed, and what was done to remediate any failures.
    * To perform compliance & security testing, the security team logs in to each production system and runs a series of commands. The team has some scripts that they run as well. However, they're not located in any central location and they often need to change to adapt to newer operating systems (for example, RHEL 6 to RHEL 7).
    * When a security test fails, a security engineer fixes it by running a manual command (for example, running a `firewalld` command to close a port) and then reruns the test. In the end, the team assembles a report that they hand off to the security officer.
    * The entire process takes 4-6 weeks.
    * There's also talk of moving to _XYZ_ compliance so that other companies can integrate with the team's software.
  * Analysis:
    * Although the team can anticipate when the security officer will come around, security feels "bolted on". Compliance and security feel like an afterthought.
    * And because it's a largely manual process, the team has found that it's difficult to scale.
      * For example, as you add additional production systems, you now introduce more systems the team needs to manually log into, test, and remediate.
    * The team dreads the bi-yearly audit from the security officer. The team can't put their normal jobs on hold, so they often need to stay late for weeks at a time to complete their security passes.
    * Patching can be tricky, because there are no tests that look for unwanted side-effects.
      * For example, when they close off a port or limit a user's access to certain directories, or change some other configuration, the team doesn't know what other part of the system that could affect.
    * Some companies aren't able to integrate with the team's software because it's not _XYZ_ compliant. The team is worried this will become a mandate, and they're not sure how they'll deal with the extra work.
    * These processes mainly cover infrastructure, but there's no process in place to cover application security.
    * The development team uses a number of open source packages.
    * Security issues are sometimes undiscovered or discovered after updates are deployed.
    * Luckily, production systems have not yet been breached. (Perhaps mention that vulnerabilities such as Heartbleed (pick a newer one) have been discovered and patched in time?

* How do development and operations teams collaborate during a production issue? Who has access to your production environments?
  * Answer:
    * Feedback comes in two ways:
      1. User feedback gets routed to the development team. Feedback typically comes through email (maybe through a link on the website or in the product?). Feedback also comes through folks in the field (sales or even the CEO).
      1. Operations handles site monitoring. Operations mainly monitors for the site being up and accepting user requests.
    * Developers handle customer feedback when they can. Operations resolves site incidents as they happen. Both dev and ops teams communicate very little with the other about what they're doing.
    * Only the operations team has visibility into the health of deployments. And only operations can access production systems.
  * Analysis:
    * Because developers have little insight into production issues, they therefore don't feel much concern or empathy for them.
    * There's also a missed opportunity for the development team to improve product quality as a result of live site issues.
    * Conversely, operations is not made aware of how changes, even minor ones in response to customer feedback, might impact production.

[Ideas welcome, but for knowledge check questions, perhaps we provide short scenarios and ask the learner to draw an analysis or conclusion. The challenge would be to keep them short. Or possibly extend some of the team's scenarios and ask follow-up questions. At the very least, don't rehash or have the learner memorize the team's workflow or analysis.]
