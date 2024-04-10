
As we've described in the introduction, Continuous Delivery is all about delivering on-demand.

But, as we discussed in the differences between release and deployment, delivery, or deployment, it's only the technical part of the Continuous Delivery process.

It's all about how you can technically install the software on an environment, but it doesn't say anything about the process that needs to be in place for a release.

Release approvals don't control *how* but control *if* you want to deliver multiple times a day.

Manual approvals also suit a significant need. Organizations that start with Continuous Delivery often lack a certain amount of trust.

They don't dare to release without manual approval. After a while, when they find that the approval doesn't add value and the release always succeeds, the manual approval is often replaced by an automatic check.

Things to consider when you're setting up a release approval are:

 -  What do we want to achieve with the approval? Is it an approval that we need for compliance reasons? For example, we need to adhere to the four-eyes principle to get out SOX compliance. Or Is it an approval that we need to manage our dependencies? Or is it an approval that needs to be in place purely because we need a sign-out from an authority like Security Officers or Product Owners.
 -  Who needs to approve? We need to know who needs to approve the release. Is it a product owner, Security officer, or just someone that isn't the one that wrote the code? It's essential because the approver is part of the process. They're the ones that can delay the process if not available. So be aware of it.
 -  When do you want to approve? Another essential thing to consider is when to approve. It's a direct relationship with what happens after approval. Can you continue without approval? Or is everything on hold until approval is given. By using scheduled deployments, you can separate approval from deployment.

Although manual approval is a great mechanism to control the release, it isn't always helpful.

On many occasions, the check can be done at an earlier stage.

For example, it's approving a change that has been made in Source Control.

Scheduled deployments have already solved the dependency issue.

You don't have to wait for a person in the middle of the night. But there's still a manual action involved.

If you want to eliminate manual activities but still want control, you start talking about automatic approvals or release gates.

 -  [Release approvals and gates overview](/azure/devops/pipelines/release/approvals/approvals).
