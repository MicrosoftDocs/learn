Notes:

* Re-introduce the fictitious team we introduced in the previous learning path and the previous module.
* Summarize where we're at:
  * The team identified 3 areas to start with:
    * **Issue 12**. Stabilize the build server.
    * **Issue 14**. Standardize handoffs to QA.
    * **Issue 16**. Increase visibility for all stakeholders.
  * Mention how Mara has been having  trouble convincing the team that DevOps is the right way to begin improving their processes. She went ahead and set up an Azure Pipelines project as a proof of concept. She's slowly showing the team how a DevOps workflow can benefit everyone.

In the previous module, you learned how to set up a Git-based workflow that enables everyone on the team to collaborate on the same project.

Branches and code reviews are just two ways to help ensure only quality code gets checked in to your repositories. But as you add features to your app, how do you _know_ whether that features works correctly given all inputs? How do you know that it works well with - and doesn't break - other features? How do you know that your code is maintainable and can be easily understood by others?

You _could_ run the app locally and try a few inputs. But that takes time and doesn't cover all cases. Plus, repeatedly testing existing features gets tedious as you add new features.

Here, you'll learn how to set up automated testing to help ensure that your latest feature will work, and to help make sure you didn't break anything along the way.

(Here a talk track. First read through the entire module and then find the right places for each part)

* The team's been working on the _Space Game_ web site.
* Amita (from QA) asks Andy (dev lead) and Mara (our hero) to sit down for a chat.
* Amita is being asked to help test some new game titles coming up. (This is in addition to testing the immediate team's web sites.)
* Amita is a bit stressed because she has some added responsibilities now. Plus, she's been reporting the same kinds of errors with the _Space Game_ web site over and over lately, and she's getting tired of it.
  * The errors are with the leaderboard functionality. She's been finding that the filtering feature keeps breaking.
  * Basically, these are regression bugs. As Andy and Mara add features, existing behavior keeps breaking.
  * Amita: (complains a bit about her added workload) "And to make matters worse, the leaderboard keeps breaking. Is there anything we can do to help stabilize this feature?"
  * Mara: "Perhaps we need to start adding unit tests to our projects."
  * Andy: "We tried that a while ago. But we had trouble keeping the tests up to date, so we gave up. I think that's partly because when the tests fail on the build server, there was no way to know about it. Plus, we're often in too much of a hurry to worry about failing tests - and there was nothing in place to keep us honest."
  * Mara: "Andy and I have been working on setting up automated build using Azure Pipelines."
  * Amita: "Oh yeah, you mentioned you were going to do that. I'm surprised you made progress already! But how does that help us with testing?"
  * Mara: "You can add unit tests that run automatically when the build runs. If any of the tests fail, the entire build fails. That should help keep us honest, right Andy?"
  * Andy: "Won't this delay Amita in getting new builds?"
  * Mara: "Unit tests are meant to run fast. They're not like other kinds of tests that can take hours to run. Running them shouldn't add more than a couple minutes to the overall process. Plus, there are other kinds of tests we can run as well, such as lint and code coverage tests."
  * Amita: "I'd take anything to make my life a bit easier. But won't all this automated testing replace my job?"
  * Mara: "There will still be plenty of opportunity for you to manually test things before we ship. This is just one piece of the puzzle. Plus, it sounds like you have a lot of game testing to do that can _only_ be done manually."
  * Andy: "Plus, it's our job to make sure we're handing off quality code as best we can. I say we at least try it."
  * Amita: "Great! I look forward to checking out the next build. We'll see if it helps stabilize things any better."

In this module, you will:

* Describe the benefits of automated testing and the kinds of testing you can use
* Run unit tests locally and then in your build pipeline
* Add dashboard widgets to visualize test runs over time
* Perform code coverage testing to see how much of your code is covered by unit tests
* See a test fail in the pipeline and then fix the failure