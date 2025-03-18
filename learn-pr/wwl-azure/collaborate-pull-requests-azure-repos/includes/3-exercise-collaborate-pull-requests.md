Code issues that are found sooner are both easier and cheaper to fix. So development teams strive to push code quality checks as far left into the development process as possible.

As the name suggests, branch policies give you a set of out-of-the-box policies that can be applied to the branches on the server.

Any changes being pushed to the server branches need to follow these policies before the changes can be accepted.

Policies are a great way to enforce your team's code quality and change-management standards. In this recipe, you'll learn how to configure branch policies on your main branch.

## Getting ready

The out-of-the-box branch policies include several policies, such as build validation and enforcing a merge strategy. We'll only focus on the branch policies needed to set up a code-review workflow in this recipe.

## How to do it

1.  Open the branches view for the myWebApp Git repository in the parts-unlimited team portal. Select the main branch, and from the pull-down, context menu choose Branch policies:

    :::image type="content" source="../media/open-branches-9ad34c7c.png" alt-text="Open branches.":::


2.  In the policies view, It presents out-of-the-box policies. Set the minimum number of reviewers to 1:

    :::image type="content" source="../media/require-minimum-number-reviewers-4e4d2d64.png" alt-text="Require a minimum number of reviewers.":::


    The Allow requestors to approve their own changes option allows the submitter to self-approve their changes.

    While this might be acceptable for mature teams, in general, it should be avoided.<br>

3.  Use the review policy with the comment-resolution policy. It allows you to enforce that the code review comments are resolved before the changes are accepted. The requester can take the feedback from the comment and create a new work item and resolve the changes. It at least guarantees that code review comments aren't lost with the acceptance of the code into the main branch:

    :::image type="content" source="../media/check-comment-resolution-f4bb058c.png" alt-text="Check for comment resolution.":::


4.  A requirement instigates a code change in the team project. If the work item triggered the work isn't linked to the change, it becomes hard to understand why it was made over time. It's especially useful when reviewing the history of changes. Configure the Check for linked work items policy to block changes that don't have a work item linked to them:

    :::image type="content" source="../media/check-linked-work-items-9f9a5589.png" alt-text="Check for linked work items.":::


5.  Select the option to automatically include reviewers when a pull request is raised automatically. You can map which reviewers are added based on the area of the code being changed:

    :::image type="content" source="../media/add-automatic-reviewers-528e31d0.png" alt-text="Add automatic reviewers.":::


## How it works

With the branch policies in place, the main branch is now fully protected.

The only way to push changes to the main branch is by first making the changes in another branch and then raising a pull request to trigger the change-acceptance workflow.

Choose to create a new branch from one of the existing user stories in the work item hub.

By creating a new branch from a work item, that work item automatically gets linked to the branch.

You can optionally include more than one work item with a branch as part of the create workflow:

:::image type="content" source="../media/create-branch-8f64a7d3.png" alt-text="Create a branch.":::


Prefix in the name when creating the branch to make a folder for the branch to go in.

In the preceding example, the branch will go in the folder. It is a great way to organize branches in busy environments.

With the newly created branch selected in the web portal, edit the HomeController.cs file to include the following code snippet and commit the changes to the branch.

In the image below, you'll see that you can directly commit the changes after editing the file by clicking the commit button.

The file path control in the team portal supports search.

Start typing the file path to see all files in your Git repository under that directory, starting with these letters showing up in the file path search results dropdown.

:::image type="content" source="../media/change-code-commit-84502261.png" alt-text="Change code and commit.":::


The code editor in the web portal has several new features in Azure DevOps Server, such as support for bracket matching and toggle white space.

You can load the command palette by pressing it. Among many other new options, you can now toggle the file using a file mini-map, collapse, and expand, and other standard operations.

To push these changes from the new branch into the main branch, create a pull request from the pull request view.

Select the new branch as the source and the main as the target branch.

The new pull request form supports markdown, so you can add the description using the markdown syntax.

The description window also supports @ mentions and \# to link work items:

:::image type="content" source="../media/create-pull-request-af53d7fb.png" alt-text="Create pull request.":::


The pull request is created; the overview page summarizes the changes and the status of the policies.

The Files tab shows you a list of changes and the difference between the previous and the current versions.

Any updates pushed to the code files will show up in the Updates tab, and a list of all the commits is shown under the Commits tab:

:::image type="content" source="../media/pull-request-comments-438950c3.png" alt-text="Pull request comments.":::


Open the Files tab: this view supports code comments at the line level, file level, and overall.

The comments support both @ for mentions and \# to link work items, and the text supports markdown syntax:

The code comments are persisted in the pull request workflow; the code comments support multiple iterations of reviews and work well with nested responses.

The reviewer policy allows for a code review workflow as part of the change acceptance.

It's an excellent way for the team to collaborate on any code changes pushed into the main branch.

When the required number of reviewers approves the pull request, it can be completed.

You can also mark the pull request to autocomplete after your review. It autocompletes the pull requests once all the policies have been successfully compiled.

## There's more

Have you ever been in a state where a branch has been accidentally deleted? It can't be easy to figure out what happened.

Azure DevOps Server now supports searching for deleted branches. It helps you understand who deleted it and when. The interface also allows you to recreate the branch.

Deleted branches are only shown if you search for them by their exact name to cut out the noise from the search results.

To search for a deleted branch, enter the full branch name into the branch search box. It will return any existing branches that match that text.

You'll also see an option to search for an exact match in the list of deleted branches.

If a match is found, you'll see who deleted it and when. You can also restore the branch. Restoring the branch will re-create it at the commit to which is last pointed.

However, it won't restore policies and permissions.
