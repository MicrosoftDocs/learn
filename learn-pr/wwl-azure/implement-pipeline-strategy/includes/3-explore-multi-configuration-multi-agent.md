You might need to run the tasks of a pipeline multiple times but with a slightly different configuration or split a large batch of work among various agents.

There are three different types of jobs you can run.

 -  **None**: Tasks will run on a single agent.
 -  **Multi-configuration**: Run the same set of tasks on multiple configurations as specified in the multipliers. Configurations will run in parallel, and each configuration will use a single agent. For example
     -  Run the release once with configuration setting A on WebApp A and setting B for WebApp B.
     -  Deploy to different geographic regions.

:::image type="content" source="../media/multi-configuration-job-1-277f163a.png" alt-text="Screenshot of Multi-configuration.":::


 -  **Multi-agent**: Run the same set of tasks on multiple agents using the specified number of agents. For example, you can run a broad suite of 1000 tests on a single agent. Or you can use two agents and run 500 tests on each one in parallel.

For more information, see [Specify jobs in your pipeline](/azure/devops/pipelines/process/phases).

### Do you see a purpose for Release Jobs in your pipeline? How would you set it up?

Topics you might want to consider are:

 -  Do you have artifacts from multiple sources?
 -  Do you want to run deployments on different servers simultaneously?
 -  Do you need multiple platforms?
 -  How long does your release take?
 -  Can you run your deployment in parallel, or does it need to run in sequence?
