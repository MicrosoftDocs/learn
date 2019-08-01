1. DEPLOY TO TEST - SCHEDULE (rename titles e.g. "by using scheduled trigger")
    1. What are cron jobs
    1. cron format
    1. 3 AM example
    1. We'll use a more basic example

1. CONFIG YML
    1. Schedule
    1. Test Stage
1. GIT PUSH
1. WATCH IT BUILD

TODO: Roberta, ignore this page.

References:
* Release Strategy Recommendations > Demo - Setting up Manual Approval
* Release Strategy Recommendations > Demo - Setting up a Release Gate

Scenario:
* Amita does some manual testing (will automate things further in the next module).
* Amita sets up a release gate that uses a work item query to check for 0 open bugs (see release gate demo).
* Idea: Create a bug on Azure Boards and have the learner resolve it and see the gate pass, just like the release gate demo.

[!code-yml[](code/6-azure-pipelines.yml)]