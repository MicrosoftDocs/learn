You now have a working pipeline that can deploy your Bicep template to your Azure environment. Running your pipeline though is still a manual step. It would be great if you could automate that as well. 

## What are pipeline triggers?

Pipeline triggers can automatically run your pipeline. You can configure them in such a way so they run your pipeline for every git commit to your repository, or for every pull request, or you could configure them to run on a schedule. You use them because with every change that happens to the code, you want to make sure that all checks and deploys that need to happen actually get executed. 

Without an automatic trigger, someone can make changes to the Bicep template, commit and push that change to your git repository, but forget to run the pipeline. You now have a difference in what your Bicep template describes as resources that need to be present in your Azure environment and the resources that are actually present in your Azure environment. Suppose this happens for a couple of subsequent commits and pushes, where people forget to run the pipeline. If someone now introduces an error or misconfiguration in the Bicep template during one of these changes, it is a lot harder to track back where the error was introduced, since you have several commits to work through. 

In case you run your pipeline for every push that happens to your git repository, the moment the push happens, your pipeline will start running. This will give whoever made the push instant feedback on the validity of the change they made. This is the great value add of pipeline automation, your entire team will need to follow the same mandatory process. 

## Which types of pipeline triggers can you use

You have actually already been using a pipeline trigger in the previous sections, namely the manual pipeline trigger. When you add a trigger: none to the top of your YAML file, you can only manually trigger the pipeline execution.

```YAML
trigger: none
```

Another type of pipeline trigger, which is very commonly used, are CI or branch triggers. This trigger runs your pipeline with every change that is made to that specific branch. The most common type of branch trigger is a trigger for your main branch. You also define a branch trigger in your YAML file:

```YAML
trigger: 
- main
```

Once you put this trigger at the top of your YAML pipeline file, with each push that happens to your git repository a pipeline run will start. You will also still be able to trigger your pipeline manually even though the trigger: none statement is gone. 

Next to branch triggers, Azure DevOps also has scheduled triggers. These will run your pipeline based on a schedule. This can be handy when each morning for instance you want to run a pipeline that has a Bicep template which restores a certain environment to its original state with a Complete deployment mode. A scheduled trigger is defined based on a cron schedule: 

```YAML
# YAML file in the main branch
schedules:
- cron: "0 0 * * *"
  displayName: Daily environment restore
  branches:
    include:
    - main
```

As you can see in the example you also specify for a scheduled trigger to which branch it applies. 

You can also use both a branch and a scheduled trigger in the same pipeline. In that case the pipeline will run each time a changed is pushed to the indicated branch. Also will the pipeline run for the indicated schedule. 

If you leave out the trigger and schedule parts altogether from your YAML pipeline your pipeline will run by default with a CI trigger on all branches. This is not necessarily always the behavior you would like. Also, indicating for which branches you would like your pipeline to run, makes it a lot more explicit when the pipeline will run. 


## Filtering pipeline execution through triggers

You might want more fine-grained control over when your pipeline runs. Suppose you have a situation where collaborators on your project create feature branches where they try things out in Bicep template files. These deployments also need to happen, but to their own personal Azure subscription and not to your shared development environment. In that case you may want to exclude these feature branches from triggering your pipeline. For doing this you can use the exclude statement: 

```YAML
trigger:
  branches:
    include:
    - main
    - releases/*
    exclude:
    - feature/*
```

In the above example the pipeline will trigger for every change that is made in the main branch, but also for every change that happens in any of the release branches. In this case all release branches use a naming convention, so releases/v1 will trigger a run as will releases/v2.4. If someone uses releases-v5 the pipeline will not be triggered. 
On top of that any feature branch will not trigger a pipeline run in the above example. 

Apart from using branches to determine when your pipeline triggers, you can also make use of path filters. This is handy when for certain changes you do want your pipeline to trigger, but not for other changes. Suppose that in your current repository you have your Bicep templates in a deploy folder and you also have a docs folder that holds documentation files. You want to trigger your pipeline when anyone makes a change to any of the Bicep templates in the deploy folder, however a change to one of the files in the docs folder does not need to trigger your pipeline. To configure this you can use a path filter: 

```YAML
# specific path build
trigger:
  branches:
    include:
    - main
  paths:
    exclude:
    - docs
    include:
    - deploy
```

