TODO

## Pull requests

On a pull request you can configure how many people at least need to review the changes in the pull request and you can include specific people or a group of people who need to perform the review. You might for instance include the project leads or the project architects as reviewers for all pull requests.

You may also require that in pull requests at least 1 work item is linked for the pull request to be valid. In case you are using Azure Boards as well, this will give you full traceability from the work item containing the feature request, over the code that implements this feature all the way to the deploy of this feature in production.

### Actions you can perform on pull requests

When you create a pull request, you can provide a descriptive a name and a longer description. In the description it is possible to mention specific people or to refer to work items. You can also indicate which people you would like to review the pull request.

You can mark a pull request as draft. Reviewers will know that you're still working on the changes. Your reviewers can still provide feedback but it's clear that the changes aren't ready to merge yet. When you're satisfied with your changes, you can remove the draft status.

After a pull request is created, you can track comments the reviewers may have, any automated checks that may run, and you can link work items to the pull request.

Reviewers can easily see the files that were changed. They can comment on the entire pull request or comment on specific parts of the files that were changed. This makes collaborating on a pull request a very interactive experience.

Even after you've created a pull request, you can keep making changes to the code on you feature branch. These  changes become part of the pull request.

After the pull request is approved, it can be completed, which means the contents of the pull request are merged into the main branch.

## Reviewing Bicep code

Mention - try out deployment to make sure it works and deploys successfully; also mention that you'll look at automated approaches for this in the future

If this is a small part of a bigger change - will this deploy as-is without causing issues? Do you need to add a feature flag by using Bicep features like conditions?
