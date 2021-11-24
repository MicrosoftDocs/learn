Workflows include several standard syntax elements.

 -  **Name:** is the name of the workflow. It's optional but is highly recommended. It appears in several places within the GitHub UI.
 -  **On:** is the event or list of events that will trigger the workflow.
 -  **Jobs:** is the list of jobs to be executed. Workflows can contain one or more jobs.
 -  **Runs-on:** tells Actions which runner to use.
 -  **Steps:** It's the list of steps for the job. Steps within a job execute on the same runner.
 -  **Uses:** tells Actions, which predefined action needs to be retrieved. For example, you might have an action that installs node.js.
 -  **Run:** tells the job to execute a command on the runner. For example, you might execute an NPM command.

You can see the allowable syntax for workflows here: [Workflow syntax for GitHub Actions](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions).
