Mirroring the rise of interest in infrastructure as code, there has been considerable interest in defining pipelines as code. However, pipeline as code doesn't mean executing a script that's stored in source control.

Codified pipelines use their programming model to simplify the setup and maximize reuse.

A typical microservice architecture will require many deployment pipelines that are identical. It's tedious to craft these pipelines via a user interface or SDK.

The ability to define the pipeline and the code helps apply all principles of code sharing, reuse, templatization, and code reviews. Azure DevOps offers you both experiences. You can either use YAML to define your pipelines or use the visual designer to do the same. You will, however, find that more product-level investments are being made to enhance the YAML pipeline experience.

When you use YAML, you define your pipeline mostly in code (a YAML file) alongside the rest of the code for your app. When using the visual designer, you define a build pipeline to build and test your code and publish artifacts.

You also specify a release pipeline to consume and deploy those artifacts to deployment targets.

## Use Azure Pipelines with YAML

You can configure your pipelines in a YAML file that exists alongside your code.

1.  Configure Azure Pipelines to use your Git repo.
2.  Edit your azure-pipelines.yml file to define your build.
3.  Push your code to your version control repository. This action kicks off the default trigger to build and deploy and then monitor the results.
4.  Your code is now updated, built, tested, and packaged. It can be deployed to any target.

    :::image type="content" source="../media/flowchart-edit-code-yaml-1e1c3048.png" alt-text="Screenshot of Flowchart with edit code, edit YAML file, push to code repo, Azure Pipelines, and deploy to target.":::


## Benefits of using YAML

 -  The pipeline is versioned with your code and follows the same branching structure. You get validation of your changes through code reviews in pull requests and branch build policies.
 -  Every branch you use can modify the build policy by adjusting the azure-pipelines.yml file.
 -  A change to the build process might cause a break or result in an unexpected outcome. Because the change is in version control with the rest of your codebase, you can more easily identify the issue.

If you think the YAML workflow is best for you, create your first pipeline by using [YAML](/azure/devops/pipelines/get-started-yaml).

While there's a slightly higher learning curve and a higher degree of code orientation when defining pipelines with YAML, it's now the preferred method.
