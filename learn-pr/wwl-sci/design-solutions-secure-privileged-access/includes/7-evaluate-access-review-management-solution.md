Microsoft Entra access reviews support up to three review stages, in which multiple types of reviewers engage in determining who still needs access to company resources. These reviews could be for membership in groups or teams, access to applications, assignments to privileged roles, or access package assignments. When review administrators configure the review for automatic application of decisions, at the end of the review period, access is revoked for denied users.

## Use cases for multi-stage reviews

Multi-stage access reviews allow you and your organization to enable complex workflows to meet recertification and audit requirements calling for multiple reviewers to attest to access for users in a particular sequence. It also helps you design more efficient reviews for your resource owners and auditors by reducing the number of decisions each reviewer is accountable for. This approach allows for combining otherwise disjoint, separate reviews for the same resource, to be combined in one access review.

:::image type="content" source="media/using-multi-stage-reviews/new-access-reviews.png" alt-text="Screenshot of admin experience to configure multi-stage reviews." lightbox="media/using-multi-stage-reviews/new-access-reviews.png":::

Here are some scenarios you might want to consider:

- **Reach consensus across multiple sets of reviewers:** Let two audiences of reviewers independently review access to a resource. You can configure reviews such that both stages of reviewers must agree on *Approved* without seeing each other’s decisions.
- **Assign alternate reviewers to weigh in on unreviewed decisions:** Let the resource owner attest to access to their resource first. Then, users for which no decision is recorded, go to a second stage reviewer, such as the user’s manager or an auditing team, who review the undecided requests. 
- **Reduce burden on later-stage reviewers:** Reviews can be configured such that earlier-stage-denied users aren't reviewed by later stages, allowing for later stage reviewers to see a filtered-down list. Use this scenario to filter down on users to review, stage by stage.
- **Guest user reviews:** Guest user reviews help organizations that use Microsoft Entra B2B for collaboration. These guest users’ access should be reviewed regularly to check on whether these guest users have the right access still, and that collaboration is still desired, so revoking access or a cleanup of guest user accounts that are no longer needed is possible.

## Duration of review stages  

Review administrators define the duration of every review stage and therefore, how much time reviewers in their stage have to record their decisions. Each stage can be configured to have its own duration, to cater for availability and expectation of reviewers.

:::image type="content" source="media/using-multi-stage-reviews/using-multi-stage-reviews.png" alt-text="Screenshot of using multi-stage reviews." lightbox="media/using-multi-stage-reviews/using-multi-stage-reviews.png":::

Each review stage stays open for reviewers to add decisions for the length of the duration. Review administrators can stop a running stage and automatically progress the overall review to the next review stage on the reviewer overview page, by selecting **Stop current stage**.

## Application of results 

Microsoft Entra access reviews can apply decisions about access to a resource by removing no longer needed users from the resource. Decisions are always applied at the end of the review period or when a review administrator manually ends the review. Automatic application of results is defined by the review administrator with the **Auto apply results to resource** setting or manually through the **Apply results** button in the review overview page.

Decisions are collected by reviewers for every stage. The setting **Reviewees going to the next stage** defines, which reviewees later stage reviewers will see and asked to record decisions for. Only at the end of the overall review, decisions are applied to the resource.

For all decisions, the last decision recorded for a reviewee is applied at the end of the review. Decisions that were made for Jane in the first stage of the review, can in stage two and stage three be overwritten by later-stage reviewers.

If the **Reviewees going to the next stage** setting is set such that only a subset of reviewees progress to later stages, it can be that decisions made in the first stage are applied at the end of the review. If the review administrator configured a three-stage review, and wants only **Denied** and **Not reviewed** reviewees to progress to the next stages, if Jane was approved in the first stage, she won't progress to the later stages and her **Approve** decision is recorded and at the end of the review, applied.
