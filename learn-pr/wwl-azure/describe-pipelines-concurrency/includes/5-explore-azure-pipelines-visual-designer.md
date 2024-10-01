You can create and configure your build and release pipelines in the Azure DevOps web portal with the visual designer. (Often referred to as "Classic Pipelines").

Configure Azure Pipelines to use your Git repo.

1.  Use the Azure Pipelines visual designer to create and configure your build and release pipelines.
2.  Push your code to your version control repository. This action triggers your pipeline and runs tasks such as building or testing code.
3.  The build creates an artifact used by the rest of your pipeline to run tasks such as deploying to staging or production.
4.  Your code is now updated, built, tested, and packaged. It can be deployed to any target.

:::image type="content" source="../media/flowchart-edit-code-94cc665f.png" alt-text="Screenshot of Flowchart with edit code, push to code repo, build tasks, and test tasks, create artifact, release tasks, and deploy to target.":::


## Benefits of using the Visual Designer

The visual designer is great for new users in continuous integration (CI) and continuous delivery (CD).

 -  The visual representation of the pipelines makes it easier to get started.
 -  The visual designer is in the same hub as the build results. This location makes it easier to switch back and forth and make changes.

If you think the designer workflow is best for you, create your first pipeline using the [visual designer](/azure/devops/pipelines/get-started-designer).
