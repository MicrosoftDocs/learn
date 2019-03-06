Here we discuss some strategies teams use to flow up changes. Think: choosing a merging and branching strategy.

Summarize how the team currently uses source control. (We suggest a naive strategy in the first LP.)

The JTA calls for "Recommend a repository structure and creation strategy".

Discuss various branching strategies & policies. The JTA mentions:

* feature flag
* hotfix
* release

Discuss Git's PR, approval & integration process.
Discuss how this fits in with a CI pipeline.

-----

Notes:

* What are triggers?
  * [Reference](https://docs.microsoft.com/azure/devops/pipelines/build/triggers?view=azure-devops&tabs=yaml)
  * CI trigger vs PR trigger
* What are approvals and gates? (TODO: This is likely more about _release_ pipelines. Move it somewhere else.)
  * [Reference](https://docs.microsoft.com/azure/devops/pipelines/release/approvals/?view=azure-devops)
* Talk about the Triggers tab from the UI