To use GitHub Copilot for your enterprise organization, you must have a GitHub Enterprise Cloud account and an existing Copilot for Business subscription. Here are the general steps:

- Set up a Copilot business account.
- Set up an Enterprise account: You need a GitHub Enterprise Cloud account. If you don't have one, you can start a free trial.
- Once GitHub Copilot Enterprise is enabled at the enterprise level, you can configure GitHub Copilot settings for each organization in your enterprise.

## Enable GitHub Copilot Enterprise for your enterprise

Your enterprise owner can enable GitHub Copilot Enterprise for the organizations in the enterprise by first establishing the policy and then assigning users.

### Enforce a policy

Follow these steps to enforce a policy to manage the use of GitHub Copilot Enterprise:

1. In the enterprise sidebar, select **Policies**.
1. Under **Policies**, select Copilot.
1. Under **Manage organization access to GitHub Copilot**, configure the access for your GitHub Copilot subscription.

### Enable access to GitHub Copilot for all current and future users in your organization

1. Select your profile photo, then select **Your organizations**.
1. Next to the organization, select **Settings**.
1. In the **Code planning and automation** section of the sidebar, select **Copilot**, then select **Access**.
1. To enable GitHub Copilot for all users in your organization, select **Allow for all members** under **User permissions**.
1. In the **Confirm seat assignment** dialog, confirm that you want to enable GitHub Copilot for all current and future users in your organization, then select **Confirm**.
1. To save your changes, select **Save**.

### Enable access to GitHub Copilot for selected users in your organization

First, complete steps 1-2 in the preceding enforce a policy steps. Then follow steps 1-3 below.

1. To enable GitHub Copilot for select users in your organization, select **Selected teams/users** under **User permissions**.
1. In the **Confirm seat assignment** dialog, confirm that you want to enable GitHub Copilot for selected teams/users in your organization, then select **Confirm**.
1. To save your changes, select **Save**.

### Disable access to GitHub Copilot for your whole organization

First, complete steps 1-2 in the preceding enabling steps. Then follow steps 1-3 below.

1. To disable GitHub Copilot for all users in your organization, select **Disabled** under the **User permissions** section.
1. In the **Confirm seat assignment** dialog, confirm that you want to disable GitHub Copilot for selected teams/users in your organization, then select **Confirm**.
1. To save your changes, select **Save**.

## Use Copilot chat in Copilot Enterprise

To start collaborating and using Copilot within pull requests, follow these steps:

### Create Copilot pull request summaries in Copilot Enterprise

Copilot's pull request summaries automatically generate concise overviews of pull requests based on the code changes. Here's how to use them:

While viewing a pull request on GitHub.com, navigate to the description field.

:::image type="content" source="../media/3-open-pull-request.png" alt-text="Screenshot of opening a pull request.":::

Select the Copilot icon above the description field, then select **Summary**.

:::image type="content" source="../media/3-create-pull-request.png" alt-text="Screenshot of creating a pull request.":::

- Copilot goes through the file changes in your pull request and generate a summary for you.

Review the generated text and ensure it accurately reflects the main changes and impacts of the pull request. You can manually edit the summary to add more details or clarify specific points.

## Manage docsets in Copilot Enterprise

Copilot docset management allows organizations to create and manage custom docsets from their internal code and documentation, tailoring Copilot's suggestions to their specific projects and domains. Here's how to use it:

### Create docsets

To create a docset, you need to have admin rights in the repository.

:::image type="content" source="../media/3-github-copilot-docsets-list.png" alt-text="Screenshot of GitHub Copilot Docsets list.":::

Navigate to [github.com/copilot/](https://github.com/copilot/), scroll down, and select **Create a new docset**.

:::image type="content" source="../media/3-create-new-docset-with-github-copilot-enterprise.png" alt-text="Screenshot of creating a new docset for organization with GitHub Copilot for Enterprise.":::

On the **Create Docset** page, select the owner organization, enter the docset name, the docset description, and select the repositories under the docset scope.

:::image type="content" source="../media/3-enter-docset-information.png" alt-text="Screenshot of filling the docset information.":::

After entering all the required information, you can then select the **Create Docset** button to create your docset.

:::image type="content" source="../media/3-index-docset-information.png" alt-text="Screenshot of indexing the docset information with GitHub Copilot Enterprise.":::

Finally, select the **Index org-docset** button to index this docset data into Copilot to improve its understanding and response quality. The docset is ready for use by all members of your organization.

### Use docsets

Once created, developers can use docsets. Here's how:

- You don't need special permissions to access existing docsets created by administrators. While you're working on your code, Copilot automatically draws upon all relevant docsets your team or organization has access to.
- If you want to directly explore the contents of a specific docset, you can navigate to [github.com/copilot/](https://github.com/copilot/).

:::image type="content" source="../media/3-select-docset-in-organization.png" alt-text="Screenshot of selecting a docset in an organization.":::

Select a docset or repository from your organization's list of docsets.

:::image type="content"source="../media/3-create-github-copilot-prompt-in-org-docset.png"alt-text="Screenshot of using a creating a GitHub Copilot prompt within an org docset.":::

In your selected docset page, you can use Copilot Chat to create prompts and receive responses customized to the specific docset. Here's an example of a prompt within the GitHub Advanced Security docset.

:::image type="content" source="../media/3-github-copilot-response-to-docset-prompt.png" alt-text="Screenshot of GitHub Copilot response for docset prompt.":::

- You don't always have to visit this page separately after the first time. Copilot Chat with docsets is available on your GitHub pages.

:::image type="content" source="../media/3-ask-copilot-window.png" alt-text="Screenshot of the Ask Copilot windows on GitHub.":::

Select the up arrow to expand the Copilot Chat window.

:::image type="content" source="../media/3-expanded-view-ask-copilot-window.png" alt-text="Screenshot of an expanded view of the Ask Copilot window containing org docsets.":::

You're able to create prompts freely within and outside organization docsets.

Next up, we'll test your knowledge on the content we just learned.
