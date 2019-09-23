Tim and Andy are happy with the pipeline and the manual approval of schema changes but they still need to try it with the actual changes that they are working on. Tim has gone to get the database administrator to show her the process and get the actual approval they need.

## Fetch the branch from GitHub

Here, you fetch the `database-changes` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project with the changes to the web site code that expects the Profile table to have a `favoriteMap` column. This is a new column's data will be displayed on the Profile page. It also has the Azure Pipelines configuration you created in the last unit.

In the Tailspin.SpaceGame.Database project, a change has been made to the Profile table. The `favoriteMap` column has been added. If you are on a Windows machine and open the solution in Visual Studio, you will see a `dbo` folder. This will have the scripts for each of the tables. Open the **Profiles.sql** and see that the new column is there.

1. In Visual Studio Code, open the integrated terminal.
1. Run the following `git` commands to fetch a branch named `database-changes` from Microsoft's repository and switch to that branch.

    ```bash
    git fetch upstream database-change
    git checkout database-change
    ```

1. Add the new data to the table. Insert sql script. - in pipeline
1. Run the pipeline
1. approve the change
1. watch it deploy
1. navigate to the site and see the new data on the profile
