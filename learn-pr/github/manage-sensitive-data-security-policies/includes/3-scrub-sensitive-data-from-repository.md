<!--Manage sensitive data and security policies in GitHub-->

In this unit, you'll learn how to create and manage rulesets, and understand the advantages they offer over traditional protection rules. 

As an administrator responsible for managing security policies and settings in GitHub, you might face the challenge of controlling how collaborators interact with specific branches and tags in your repositories. This is where repository rulesets come into play.

Repository rulesets provide a powerful way to control how users can interact with certain branches and tags in a repository. By creating rulesets, you can define a named list of rules that govern various actions, such as pushing commits, deleting or renaming tags, and more. Rulesets work alongside branch-protection and tag-protection rules, allowing you to have fine-grained control over your repository's behavior.

By the end of this unit, you'll have a solid understanding of how to effectively use repository rulesets to control and protect key branches and tags in your repositories.

## What are repository rulesets?

A ruleset is a named list of rules that applies to a repository. You can create rulesets to control how collaborators can interact with specific branches and tags in a repository. You can control things like who can push commits to a certain branch or who can delete or rename a tag. For example, you could set up a ruleset for your repository's `feature` branch that requires signed commits and blocks force pushes for all users except repository administrators. There's a limit of 75 rulesets per repository.

## Comparing rulesets, branch protection, and protected tags

Rulesets work alongside any branch protection rules and tag protection rules in a repository. Many of the rules you can define in rulesets are similar to protection rules, and you can start using rulesets without overriding any of your existing protection rules. Additionally, you can import existing tag protection rules into repository rulesets. This will implement the same tag protections you currently have in place for your repository.

Rulesets have the following advantages over branch and tag protection rules:

- Unlike protection rules, multiple rulesets can apply at the same time, so you can be confident that every rule targeting a branch or tag in your repository will be evaluated when someone interacts with that branch or tag.
- Rulesets have statuses, so you can easily manage which rulesets are active in a repository without needing to delete rulesets.
- Anyone with read access to a repository can view the active rulesets for the repository. This means a developer can understand why they have hit a rule, or an auditor can check the security constraints for the repository, without requiring admin access to the repository.

## Create a ruleset

You can add rulesets to a repository to control how users can interact with selected branches and tags. When you create a ruleset, you can allow certain users to bypass the rules in the ruleset. This can be users with a certain role, such as repository administrator, or it can be specific teams or GitHub Apps.

To create a ruleset:

1. In your repository, go to **Settings > Code and automation > Rules > Rulesets**.
1. Select **New ruleset** to show options.
1. Select **New branch ruleset** or **New tag ruleset** option.
1. Enter values to configure the ruleset.
1. Select **Create**.

:::image type="content" source="../media/new-branch-ruleset.png" alt-text="Create a new branch ruleset page from the left hand navigation bar.":::

When creating a ruleset you can grant bypass permissions, choose which branches or tags to target, and select the rules to include.

## Manage a ruleset

You can edit, monitor, and delete existing rulesets in a repository to alter how people can interact with specific branches and tags. For example, you can add rules to better protect your branches or tags, or you can temporarily disable a ruleset to troubleshoot any unintended effects on the contributor experience for your repository.

Anyone with read access to a repository can view the rulesets targeting the repository. This can be useful if you want to know why you can't commit to a branch. On the *Rulesets* page, you can view the active rulesets targeting a certain branch or tag.

To edit a ruleset:

1. In your repository, go to **Settings > Code and automation > Rules > Rulesets**.
1. Select the name of the ruleset you want to edit.
1. Change the ruleset as needed.
1. Select **Save changes**.

## Available rules

There are many rules you can apply to a ruleset to protect targeted branches and tags in a repository. Here is the Rules section for a tag ruleset for reference.

:::image type="content" source="../media/tag-ruleset-rules.png" alt-text="Screenshot of the toggle option list of the rules, including Tag protection and Restriction options.":::

As an example, you might want to enforce CodeQL analysis and Dependency Review workflows on specific branches or tags. To enforce these with repository rulesets, you'd create a ruleset with **Require status checks to pass** and add these workflows to the rule. Then, these workflows must pass before allowing certain actions on a branch or tag. This could include actions like merging a pull request or pushing directly to a branch. This way, you can ensure that your code is always analyzed for vulnerabilities and that your dependencies are always reviewed for security risks before they're introduced into your codebase. The exact steps to configure this might vary based on your specific needs and the current configuration of your repository.

## Layering rules

A ruleset doesn't have a priority. Instead, if multiple rulesets target the same branch or tag in a repository, the rules in each of these rulesets are aggregated. If the same rule is defined in different ways across the aggregated rulesets, the most restrictive version of the rule applies. As well as layering with each other, rulesets also layer with protection rules targeting the same branch or tag.

For example, consider the following situation for the `my-feature` branch of the `octo-org/octo-repo` repository:

- A repository administrator has set up a ruleset targeting the `my-feature` branch. This ruleset requires signed commits, and three reviews on pull requests before they can be merged.
- An existing branch protection rule for the `my-feature` branch requires a linear commit history, and two reviews on pull requests before they can be merged.

The rules from each source are aggregated, and all rules apply. Where multiple different versions of the same rule exist, the result is that the most restrictive version of the rule applies. Therefore, the `my-feature` branch requires signed commits and a linear commit history, and pull requests targeting the branch will require three reviews before they can be merged.

## Using rulesets on an Enterprise plan

For organizations on a GitHub Enterprise plan, you can also do the following with rulesets:

- Quickly set up rulesets at the organization level to target multiple repositories in your organization.
- Create additional rules to control the metadata of commits entering a repository, such as the commit message and the author's email address.
- Use an *Evaluate* status to test a ruleset before making it active, and use an insights page to view which user actions are being affected by rules.
