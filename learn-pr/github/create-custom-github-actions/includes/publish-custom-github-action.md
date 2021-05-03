Here, you'll learn about choosing the right visibility for your action, best practices for documenting and versioning your action, and how to publish your action to the GitHub Marketplace. 

## Choose a location for your action

:::image type="content" source="../media/public-private.png" alt-text="Image that displays the two visibility options for an action; public or private." border="false":::

When creating an action it's important to first decide where you want that action to live and the visibility of that action, whether it will be `public` or `private`. The visibility of the action will determine which recommendations and requirements are needed to release that action. Let's take a closer look into these two visibility options.

### Public

Public actions can be used by workflows in any repository. If you're developing an action with the intent to make it open source or make it publicly available through the GitHub Marketplace, we recommend, and in most cases a requirement, that the action has its own repository instead of bundling it with other application code. This enables you to version, track, and release the action just like any other piece of software. This makes it easier for the GitHub community to discover the action, narrows the scope of the code base for developers fixing issues and extending the action, and separates the action's versioning from the versioning of other application code.

### Private

When an action is in a private repository, the action can only be used in workflows in the same repository. With private actions, you can store the action's files in any location in your repository. If you plan to combine action, workflow, and application code in a single repository, we recommend to store the action in the `.github` directory. For example, `.github/actions/action-a` and `.github/actions/action-b`.

## Document your action

It can be very frustrating to use a new tool or application when the documentation is vague or even missing. It's important to include good documentation with your action so that others can see how it works, regardless of if you plan to make it public or private. The first thing to do is creating a good `README.md` file for your action.

The `README.md` file is often the first place developers will look at to see how the action works. This is a great place to include all of the important information for the action. Below is a non-exhaustive list of things to include:

- A detailed description of what the action does.
- Required input and output arguments.
- Optional input and output arguments.
- Secrets the action uses.
- Environment variables the action uses.
- An example of how to use your action in a workflow.

As a general rule, the `README.md` file should include everything a user should know to use the action. If you think it could be useful information, include it in the `README.md`.

## Release and version your action

If you're developing an action for other people to use, regardless of if it's public or private, you should define a release management strategy to control how updates are distributed. Major version updates including necessary critical fixes and security patches that affect compatibility need to be documented clearly.

### Good practices for release and version management

A good release management strategy should include versioning recommendations. Users should not be referencing an action's default branch with the action as the default branch which is likely to contain the latest code (which may or may not be stable) and could result in your workflow breaking. Instead, we recommend that users specify a major version when using the action, and to only direct them to a more specific version if they encounter issues. This can be done by configuring their GitHub Actions workflow to target a tag, a commit's SHA, or a specific branch named for a release. Let's take a closer look at these release options.

#### Tags

Tags can be a good way to manage releases for an action. By using tags, users can easily distinguish between major and minor versions. Below is a list of helpful practices to consider when creating releases:

- Create and validate a release on a release branch (such as `release/v1`) before creating the release tag (for example, `v1.0.2`).
- Use semantic versioning.
- Move the major version tag (such as `v1`, `v2`) to point to the Git ref of the current release.
- Introduce a new major version tag (`v2`) for changes that will break existing workflows.
- Release major versions with a beta tag to indicate their status, for example, `v2-beta`. You can remove the `-beta` tag when the release is ready.

Here are some examples of each option.

```yml
steps:
    - uses: actions/javascript-action@v1
    - uses: actions/javascript-action@v1.0.1
    - uses: actions/javascript-action@v1-beta
```

#### Use a commit's SHA

Tags are useful and widely used but one downside to using tags is that they can be deleted or moved. With Git, each commit receives a calculated SHA value, which is unique and cannot be modified. Using a commit SHA for versioning will give you the most reliable and secure way to version and use an action. However, often in Git you can abbreviate the SHA hash to the first several characters and Git will recognize the reference. If you are using the commit's SHA for release management, you need to use the full SHA value and not the abbreviated value.

```yml
steps:
    - uses: actions/javascript-action@2522385f6f7ba04fe7327647b213799853a8f55c
```

## Publish an action to the GitHub Marketplace

:::image type="content" source="../media/marketplace.png" alt-text="Image that says GitHub Marketplace, tools to build on and improve your workflow." border="false":::

When you're ready to share your action with the GitHub community, you can publish it to the GitHub Marketplace and reach out to millions of GitHub users. Actions published to the GitHub Marketplace are published immediately if all of the requirements are met. Actions that do not meet the requirements will need to be reviewed by GitHub before being published. You'll need to ensure that the repository only includes the metadata file, code, and files necessary for the action. Creating a single repository for the action enables you to tag, release, and package the code in a single unit. GitHub also uses the action's metadata on your GitHub Marketplace page.

Below are the requirements to publish an action to the GitHub Marketplace. They apply to both Docker container-based actions and JavaScript-based actions:

- The action must be in a public repository.
- Each repository must contain a single action.
- The action's metadata file (`action.yml` or `action.yaml`) must be in the root directory of the repository.
- The `name` in the action's metadata file must be unique on the GitHub Marketplace.
     - The name cannot match a user or organization on GitHub, unless the user or organization owner is publishing the action. For example, only the GitHub organization can publish an action named `github`.
     - The `name` cannot match an existing GitHub Marketplace category.
     - The `name` cannot match an existing GitHub feature.

You can add the action you've created to the GitHub Marketplace by tagging it as a new release and then publishing it. There are a few guided steps in GitHub that enable you to publish a release of your action. More information on these steps can be found in the summary section at the end of this module. 
