[Repeat the format from the previous unit, this time focusing on technology choices.]

[Here, we break down technology into these categories:
* Flowing code into version control
* Building and deploying changes
* Infrastructure
* Testing
* Monitoring
]

[
Knowledge needed:
* What is version control?
]

[Again, we'll need to define how we approach/talk about the Q&A sessions the team's resident DevOps expert conducted, but here are some key questions they may have discussed:]

* How do developers flow code into source control?
  * Answer:
    * Developers write code on their local workstations.
    * They test things locally and then check in to trunk ("trunk" here being a more general term for Git's "master" branch.)
    * Some developers write tests for some features, but not everyone. Developers run tests locally only when they _think_ the tests might impact an incoming change.
    * Senior team members and leads try to make time for code reviews and coaching, but that's not always possible - especially during crunch periods.
  * Analysis:
    * Although developers test out their changes on their local workstation, they don't test the code on production-like systems before checking in (for example, let's say they develop on Windows (or maybe macOS to make it more "Linux-like") but production code runs on RHEL or CentOS.) This has caused deployment failures.
    * Because developers commit directly to trunk, they lose the ability to isolate, code review, and test changes before they get committed to the main codebase.
    * Because code reviews don't always happen, developers often repeat the same mistakes. More junior members of the team miss the opportunity to learn and grow.

* How do code changes get built? What happens next?
  * Answer:
    * Builds happen on a spare system lying around the office.
    * Builds run sequentially, one at a time.
    * Builds can happen on-demand by logging in to the build server and triggering one. Builds also happen at 6PM each evening.
    * Build artifacts go on a network file share.
    * The QA team picks up builds and runs some manual tests in their lab.
    * When QA identifies a good build, that build (the release candidate) gets embargoed for a week or so so they can continue to test.
  * Analysis:
    * Builds often fail because:
      * Changes weren't tested.
      * Changes conflict with one another.
      * => Developers often need to stay late to fix broken builds.
    * The feedback loop is slow because builds happen sequentially or in the evening.
    * Because RC builds are embargoed for a week or more, operations does not receive the handoff until late in the process.

* How are changes deployed? Where are they deployed to?
  * Answer:
    * The operations team deploys the latest RC the first and third Friday of each month - but only when everything goes smoothly.
    * Changes are deployed to an on-prem data center.
    * Although the QA team tests changes in their lab, deployments are done directly to production.
    * Operations has a number of runbooks that describe how to deploy the software to production.
    * Most deployment tasks are done manually, but operators share around some shell scripts they've built over time.
    * Software updates and other maintenance ("downtime") are done off peak hours so as to minimize disruption to users. Users are redirected to an "under maintenance" server during the update window.
  * Analysis:
    * Because RC builds are embargoed for a week or more (plus deployments happen twice a month), changes roll out slowly to users.
    * Being redirected to the "under maintenance" server is becoming unacceptable as the service is rolled out to more geographic areas.
    * Hard to scale data center resources to accommodate higher levels of load. (e.g. during the holiday season.)
    * Users located farther geographically from the data center experience high latency, and thus have a poor experience.
    * Not only are manual deployments tedious, they're also inconsistent and error-prone.
    * Deploying to production is risky. It's difficult to roll back to a good state in the case of an unexpected deployment error.

* How are applications tested? What's done with the results?
  * Answer:
    * (We stated earlier that some developers write tests, and only run them when they think it's relevant.)
    * (We also stated earlier that the QA team picks up builds and runs manual tests in their lab. When QA identifies a good build, that build (the release candidate) gets embargoed for a week or so so they can continue to test.)
    * Unit tests are not run during the build process because:
      * There wasn't a good way to track and act on test failures.
      * Many tests were flaky, so it was easier to stop running them than improve them.
    * The QA team mainly performs user acceptance testing - they maintain a series of procedures and test the app by running through various scenarios.
    * The QA team files bugs when expected behavior does not match what they see in the lab.
    * The development team occasionally looks for opportunities to refactor code to make it perform better and easier to maintain.
  * Analysis:
    * The QA team is often frustrated because they find regressions (new features break existing features in unexpected ways) way too often.
      * Also, when QA misses a regression, the bug makes its way to production.
    * Sometimes the app doesn't even start up (because no one tested on that OS before submitting the change.)
    * The team has no good way to report up on their quality environment. Rather, quality is measured by the number of bugs opened vs closed per release.
    * UAT, while valuable, does not always provide concise, repeatable test cases. Developers are frustrated when they cannot reproduce an issue reported by the QA team.

[Ideas welcome, but for knowledge check questions, perhaps we provide short scenarios and ask the learner to draw an analysis or conclusion. The challenge would be to keep them short. Or possibly extend some of the team's scenarios and ask follow-up questions. At the very least, don't rehash or have the learner memorize the team's workflow or analysis.]