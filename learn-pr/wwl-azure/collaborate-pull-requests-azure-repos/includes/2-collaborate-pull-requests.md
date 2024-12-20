Pull requests let you tell others about changes you've pushed to a GitHub repository.

Once a pull request is sent, interested parties can review the set of changes, discuss potential modifications, and even push follow-up commits if necessary.

Pull requests are commonly used by teams and organizations collaborating using the Shared Repository Model.

Everyone shares a single repository, and topic branches are used to develop features and isolate changes.

Many open-source projects on GitHub use pull requests to manage changes from contributors.

They help provide a way to notify project maintainers about changes one has made.

Also, start code review and general discussion about a set of changes before being merged into the main branch.

Pull requests combine the review and merge of your code into a single collaborative process.

Once you're done fixing a bug or new feature in a branch, create a new pull request.

Add the team members to the pull request so they can review and vote on your changes.

Use pull requests to review works in progress and get early feedback on changes.

There's no commitment to merge the changes as the owner can abandon the pull request at any time.

:::image type="content" source="../media/branch-discuss-merge-0838a336.png" alt-text="Branch, discuss, and merge.":::


## Get your code reviewed

The code review done in a pull request isn't just to find bugs—that's what your tests are concerning.

A good code review catches less obvious problems that could lead to costly issues later.

Code reviews help protect your team from bad merges and broken builds that sap your team's productivity.

The review catches these problems before the merge, protecting your essential branches from unwanted changes.

Cross-pollinate expertise and spread problem-solving strategies by using a wide range of reviewers in your code reviews.

Diffusing skills and knowledge makes your team more robust and more resilient.

## Give great feedback

High-quality reviews start with high-quality feedback. The keys to great feedback in a pull request are:

 -  Have the right people review the pull request.
 -  Make sure that reviewers know what the code does.
 -  Give actionable, constructive feedback.
 -  Reply to comments promptly.

When assigning reviewers to your pull request, make sure you select the right set of reviewers.

You want reviewers who know how your code works and try to include developers working in other areas to share their ideas.

Also, who can provide a clear description of your changes and build your code that has your fix or feature running in it.

Reviewers should try to provide feedback on changes they disagree with. Identify the issue and give a specific suggestion on what you would do differently.

This feedback has clear intent and is easy for the owner of the pull request to understand.

The pull request owner should reply to the comments, accept the suggestion, or explain why the suggested change isn't ideal.

Sometimes a suggestion is good, but the changes are outside the scope of the pull request.

Take these suggestions and create new work items and feature branches separate from the pull request to make those changes.

## Protect branches with policies

Your repos will typically contain one or more branches, including main, which require extra protection due to their criticality. Azure Repos offer several policy-based mechanisms which you should consider implementing to help you reach this goal.

The basic premise of these mechanisms is to apply constraints to pull requests. For example, you may include enforcing specific code review policies, such as requiring a minimum number of approvals from designated reviewers before a pull request can be merged. Leveraging collective expertise is bound to enhance the quality and reliability of code changes.

In addition, consider implementing the Check for linked work items policy. This verifies that every pull request is linked to a work item, providing context and promoting traceability. The Check for comment resolution policy helps ensure that all code review comments are addressed before merging the pull request.

Policies related to automated code analysis, testing, and compliance checks confirm that changes meet predefined standards before integration. Limiting merge types help maintain control branch history. For example, you have the option to permit only fast-forward and squash merges.

It is also possible to mandate clean builds of new code versions before allowing them to be merged into the critical branches. This will ensure that the merged changes do not introduce build failures or regression issues. Status checks can be used to make completion of pull requests contingent on signals generated by external services. For example, such signals can be generated by Azure Pipelines running automated tests and code analysis.

Any branches that have required policies configured automatically block direct push, effectively enforcing pull requests for all changes. In addition, such branches cannot be deleted.<br>
