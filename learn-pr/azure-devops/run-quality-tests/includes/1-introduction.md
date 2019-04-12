Mara, the newest member of the _Space Game_ team, is slowly introducing her teammates to DevOps and Azure DevOps services. In particular, she's using Azure Boards and Azure Pipelines to get everyone started.

So far, her efforts have been one-sided. The entire team identified three issues to start with:


    * **Issue 12**. Stabilize the build server.
    * **Issue 14**. Standardize handoffs to QA.
    * **Issue 16**. Increase visibility for all stakeholders.
  
But Mara's the only one on the team who's done any work. Amita, the tester, is busy helping other teams. Andy, the lead dev seems to spend all his time in meetings. Tim, from ops, hasn't seen any good reason to get involved at all.
  
In fact, things are about to change. Amita is stressed and frustrated. She's stressed because she's helping out other teams as well as working on _Space Game_. She's frustrated because she's seeing the same errors with the _Space Game_ web site over and over again, particularly with the leaderboard. They're all regression bugs. As Andy and Mara add features to the leaderboard, the existing features break.

She's asked if Andy and Mara can work with her to improve the code quality and eliminate the those bugs.

Mara: Thanks for meeting with me. I wanted to see if we can come up with a way to stop breaking the filtering feature on the leaderboard. Is there any way we can get more stability? I'm pulled in all kinds of directions right now and reporting the same broken functionality over and over on something that should work is driving me crazy!

Mara: I have an idea. Let me just show you the automated build server I put together with Azure Pipelines. 

She runs through the Azure Pipelines build process, just as you did in the last module. The build completes and Amita gets an email letting her know the build is ready for her.

Amita: That's great and I do appreciate how it fixes my problem of never knowing when to pick up a build but how does this help me now? That's not why I called the meeting.

Mara: I thought we could add unit tests to the automated build. Unit testing is about testing a single piece of functionality in isolation, like the filtering feature. We'd catch regression errors before they ever got to you.

Andy: We tried unit testing a while ago but we had trouble keeping the tests up to date so we gave up. Part of the problem was that, when the tests failed on the build server, there was no way to know about it. Plus, we're pressured for time, too. We'd ignore failed tests and there was nothing in place to keep us honest.

Mara: If we add tests to the Azure Pipelines build, the build will fail and that should certainly keep us honest! This is something Andy and I could do and it will make life better for you, Amita.

Amita: I'm all for an easier life but you're not going to put me out of a job, are you?

Mara: There's still plenty of manual testing to do. This is just one piece of the puzzle.

Andy: I agree. It's our job job to make sure we're handing off quality code to you. I say we at least try it. Unit tests run fast. They should add only a few minutes to the build process. Plus, there are other kinds of tests we can run as well, such as lint and code coverage tests.

Honestly, I've wanted to do this for a long time. Mara's given us a good start with the automated build pipeline. I think it's time for me to get involved.

Amita: Thank you both! I can't wait to see the results.

As you add a feature to your app, how do you _know_ whether those features work correctly, given all possible inputs? How do you know that the feature works well with - and doesn't break - other features? How do you know that your code is maintainable and can be easily understood by others?

You _could_ run the app locally and try a few inputs. But that takes time and doesn't cover all cases. Plus, repeatedly testing existing features gets tedious as you add new features.

In this module, you'll learn how to set up automated testing to help ensure that your latest feature will work, and to help make sure you didn't break anything along the way.

Once you finish this module, you will be able to:

* Run unit tests locally and then in your build pipeline
* Add dashboard widgets to visualize test runs over time
* Perform code coverage testing to see how much of your code is covered by unit tests
* See a test fail in the pipeline and then fix the failure
* Describe the benefits of automated testing and the kinds of testing you can use