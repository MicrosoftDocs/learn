[Repeat the format from the previous unit, this time focusing on measurement.]

[Again, we'll need to define how we approach/talk about the Q&A sessions the team's resident DevOps expert conducted, but here are some key questions they may have discussed:]

* How do you measure code quality?
  * Answer:
    * The QA and development teams report to management the number of bugs filed vs. fixed each month.
    * The QA team doesn't look at the source code very often.
    * The development team lead and senior members do occasional code reviews and look for ways to improve code quality, but it's mostly through inspection.
  * Analysis:
    * Discovering/resolving bugs is one way to measure, but manual testing is tedious and regressions happen often.
    * By not looking at the source code, the QA team misses opportunities to test larger number of inputs. Not all code paths are tested.
    * Code review and inspection are good, but they occur infrequently. It's also requires fresh inspection as the codebase changes. Inspection goes only so far - it's almost impossible to understand the app's overall performance profile just from inspecting the sources.

* How do you gather and measure feedback from users?
  * Answer:
    * Feedback typically comes through email (maybe through a link on the website or in the product?)
    * Feedback also comes through folks in the field (sales or even the CEO).
    * Applications are not tuned to report back on usage telemetry.
    * Infrastructure is not tuned to report back on usage either. (For example, hits/second, geographic origin, and so on.)
    * Feedback is stored in a shared document.
    * The measurement is the general sense of how "hot" customer issues are at any given time.
  * Analysis:
    * A bad day is when the CEO or other executive needs to report an issue to the team.
    * Because feedback is held in a shared document, the team doesn't have a good sense of severity or priority, or even which issues have been handled or are being handled.
    * Because little to no telemetry comes back, it's hard to discern whether customers are happy with the service. Business functions have trouble driving conversions or understanding where their users sit in the funnel.

* How do you measure the performance of systems in production?
  * Answer:
    * Operations uses health checks (pings) to ensure production systems are available. If a health check begins to fail, an alert is sent to the on-call operations staff.
    * The QA team occasionally tests the applications in production. For example, they might enter fictitious credit card information to ensure the billing functionality is performing correctly.
  * Analysis:
    * If a health check or transaction fails, the system is already broken. The team must assemble quickly to resolve the incident. (think "pager duty hell".)
    * The team is missing out on opportunities to better understand and measure applications in production. For example:
      * Resource utilization (CPU, memory, network)
      * User behavior (weekday vs. weekend traffic trends, where users are located, and so on.)
      * A/B testing
      * ...
      * => in essence, how deployments impact the overall business and bottom line.

[Ideas welcome, but for knowledge check questions, perhaps we provide short scenarios and ask the learner to draw an analysis or conclusion. The challenge would be to keep them short. Or possibly extend some of the team's scenarios and ask follow-up questions. At the very least, don't rehash or have the learner memorize the team's workflow or analysis.]
