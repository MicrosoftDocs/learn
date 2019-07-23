Mara and Amita are talking in the break room. Amita says, "I really like the way the pipeline is shaping up and I feel a lot more comfortable with automation. I can see how it speeds up the release process but also makes it easier to have repeatable results. I also like having tests in the pipeline. 

"I remember that Andy mentioned quality gates and I thought they sounded interesting. Do you know much about them?"

Mara answers, "A quality gate is a good way to check the quality of a release. It's like having an automatic approval instead of a manual one. There are a lot of possibilities for quality gates. You could add a gate that checks to see if everything is healthy on the deployment targets. There could be security or compliance checks. You would locate the gate before the stage that depends on the outcome of the previous stage. We could put a quality gate between the test stage and the pre-production stage if you want. They're not hard to add to the pipeline. What were you thinking about?"

"I'd like to add a release gate that makes sure there aren't any open bugs. Could we do that?"

"That's a great idea! We can certainly do it," Mara says. We can use a work item query to check to see if there are open bugs. If there aren't, we can deploy to pre-production."


* Building a High Quality Release Pipeline > Release Notes and Documentation --**NOTE--I don't understand why this belongs here**

