TODO

> [!div class="checklist"]
> * Create a branch and switch to it.
> * Make some changes to your Bicep code on the branch.
> * Switch back to your main branch.
> * Merge your branch.

## Create a branch in your repository

1. Create a branch using the CLI: `git branch add-database`

## Update a file on your branch

1. Check out the branch by using VS Code
1. Add another Bicep module
1. Update *main.bicep* again
1. Inspect the diff
1. Commit the change using VS Code

## Switch branches

1. Check out the main branch by running `git checkout main`
1. Look at the *main.bicep* file and see the change isn't there

## Merge your branch

1. From the main branch, run `git merge add-database`

1. Look at the *main.bicep* file again and see the change is now merged