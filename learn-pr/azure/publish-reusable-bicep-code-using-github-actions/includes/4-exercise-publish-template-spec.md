## Add a lint step to your workflow

TODO

## Add a publish step to your workflow

TODO Update the template spec workflow file to publish the template spec with a very simple versioning scheme (just use the workflow run number as the version number)

## Verify and commit your workflow definition

1. Verify that your *workflow.yml* file looks like the following:

   :::code language="yaml" source="code/4-workflow.yml" highlight="10, 14-36, 40, 50" :::

   If it doesn't, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and publish steps"
   git push
   ```

1. This is the first time you've pushed to this repository, so you might be prompted to sign in.

   On Windows, type <kbd>1</kbd> to authenticate using a web browser, and select <kbd>Enter</kbd>.

   On macOS, select **Authorize**.

1. A browser window appears. You may need to sign in to GitHub again. Select **Authorize**.

   Immediately after you push, GitHub Actions starts a new workflow run.

## View the workflow run

TODO

## Review the template spec in Azure

TODO
