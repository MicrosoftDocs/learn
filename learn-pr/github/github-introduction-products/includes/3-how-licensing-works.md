The availability of some of the GitHub features discussed in the previous unit depends on the product type.  Other features, however, are "rate-based". A rate-based feature gives you a certain number of execution minutes or storage capacity, and then requires you to pay for additional usage.

In this unit, we'll look at a few different ways that GitHub licenses and prices certain rate-based features.

## Licensing for metered products

GitHub Actions is free for public repositories and self-hosted runners. For private repositories, each GitHub account receives a certain number of free minutes, depending on the product used with the account.

By default, your account will have a spending limit of `$0`, which prevents additional usage of minutes after you reach your limit. If you increase your spending limit above the default of `$0`, you'll be billed for any minutes beyond the limits, also called overages. GitHub charges usage to the account that owns the repository where the workflow is run.

Jobs that run on GitHub-hosted Windows and macOS runners consume minutes at 2 and 10 times the rate that jobs on Linux runners consume. For example, using 1,000 Windows minutes would consume 2,000 of the minutes included in your account. Using 1,000 macOS minutes, would consume 10,000 minutes included in your account.

The following table compares the minute multiplier for the different operating systems.

| Operating system | Minute multiplier |
|---|---:|
| Linux | 1 |
| macOS | 10 |
| Windows | 2 |

Finally, the free minutes reset each month. You can't "roll over" unused minutes from previous months.

If your account's usage surpasses these limits and you've set a spending limit higher than `$0`, you'll pay per-minute usage based on the operating system used by the GitHub-hosted runner. GitHub rounds the minutes each job uses up to the nearest minute.

> [!NOTE]
> For current prices, refer to [GitHub's pricing page](https://github.com/pricing?azure-portal=true).

### Licensing GitHub Packages

Storage for GitHub Packages works in a similar way, except that GitHub Packages storage capacity doesn't reset every month.

The storage used by a repository is the total storage used by GitHub Actions artifacts and GitHub Packages. Your storage cost is the total usage for all repositories owned by your account.

GitHub calculates your storage usage for each month based on hourly usage during that month. For example, if you use 3 GB of storage for 10 days of March and 12 GB for 21 days of March, your storage usage would be:

3 GB x 10 days x (24 hours per day) = 720 GB-Hours  
12 GB x 21 days x (24 hours per day) = 6,048 GB-Hours  
720 GB-Hours + 6,048 GB-Hours = 6,768 GB-Hours  
6,768 GB-Hours / (744 hours per month) = 9.0967 GB-Months

At the end of the month, GitHub rounds your storage to the nearest megabyte. Therefore, your storage usage for March would be 9.097 GB.

If your account's usage surpasses these limits and you've set a spending limit higher than $0, you incur an additional fee per gigabyte of storage used per month.

At the end of the month, GitHub calculates the cost of minutes and storage used over the amount included in your account.

> [!NOTE]
> For a specific scenario that demonstrates how your bill is calculated with actual dollar amounts, see [calculating minute and storage spending](https://docs.github.com/billing/managing-billing-for-github-actions/about-billing-for-github-actions#calculating-minute-and-storage-spending) in GitHub Docs.

### What are spending limits?

By default, your account will have a spending limit of $0 for GitHub Actions usage. To allow you to use minutes and storage for private repositories beyond the amounts included with your account, you can increase the spending limit or allow unlimited spending.

If you pay for your enterprise account by invoice, your account will have an unlimited default spending limit and you'll be billed for overages. You can set a specific spending limit.

If your account has outstanding unpaid charges:

- The storage or minutes included in your account for GitHub Actions and GitHub Packages won't reset until the payment has been successfully processed.
- For accounts with storage or minutes remaining for the current billing period, GitHub Actions and GitHub Packages will continue to be available until any included usage has been reached.
- For accounts that have reached the included usage for the current billing period for GitHub Actions or GitHub Packages, both GitHub Actions and GitHub Packages will be disabled to prevent any further overages. If you pay your account by invoice, you must contact the account management team to process payment and reset your usage.

## Codespaces billing

GitHub Codespaces usage is billed monthly for all organization and enterprise accounts on GitHub Team and GitHub Enterprise, which don't include any free minutes or storage. 

Personal accounts include free use of GitHub Codespaces up to a fixed amount of usage every month.

Compute costs are incurred when a codespace is active. When you're using a codespace, the codespace is active. After 30 minutes of inactivity, a codespace becomes suspended automatically.

The unit of measure for compute usage is one hour, at a rate that depends on your codespace's instance type. Compute pricing may vary for additional instance types and operating systems supported in the future.

Storage is billed for all of your existing codespaces, regardless of whether they're active or inactive, unless your storage quota is used up or you've reached your spending limit. The storage billing for a codespace ends when it's deleted.

## How can I view my usage of products and services?

The GitHub user interface makes it easy for you to find statistics of license usage for a specific organization, across organizations, for enterprise accounts, or for instances. Also, you can view details about your license usage for machine accounts and peripheral services. 

Licenses for paid products are available to an organization on a per user basis. Each of these licenses is referred to as a *seat*. It's possible to set up a machine user: a GitHub account that's attached to an SSH key and used exclusively for automation. A machine user also consumes a license.

### Context switching for organization or enterprise owners

Organization or enterprise owners who are responsible for multiple accounts need easy access to those accounts. The GitHub user interface enables context switch, which is the flexibility to sign in to more than one account and move between the accounts. 

As an owner, you can select your profile photo and choose the option to switch to a different account.

:::image type="content" source="../media/multiple-accounts.png" alt-text="Screenshot of the dropdown menu showing multiple accounts.":::

Context switching demonstrates GitHub's capability to enable usage management across accounts.

### Manage licenses across organizations

An organization owner who wants to manage and monitor the number of seats licensed to their organization can select their profile photo and then navigate to **Billing and plans**.

If the owner manages multiple organizations, they'll need to select the organization they want to view.

:::image type="content" source="../media/select-org.png" alt-text="Screenshot of the settings option for an organization.":::

They can then view their current plan and add or remove seats.

:::image type="content" source="../media/remove-seats.png" alt-text="Screenshot of the add and remove seats options for an organization.":::

### Manage licenses across enterprises and instances

Enterprise owners that manage multiple enterprises or enterprise instances can also easily view and manage licensing for one or more enterprises, by selecting **Your Enterprises** from the **Settings** dropdown menu in the owner's profile.

GitHub Enterprise Server licenses can be viewed and managed at the server instance level.

### Monitoring consumption of metered products

As you've learned, metered products are billed by the number of minutes or gigabytes consumed beyond the allotted, basic amount. GitHub Actions and GitHub Packages are examples of metered products. The GitHub user interface also enables you to monitor statistics for metered products.

**Billing & plans** provides an overview of your current plans, up-to-date minute usage for GitHub Actions, and storage usage for GitHub Packages.

In addition to viewing data in the GitHub user interface, you can also have CSV reports sent to your email address.

:::image type="content" source="../media/actions.png" alt-text="Screenshot of actions usage overview.":::

:::image type="content" source="../media/storage.png" alt-text="Screenshot of storage usage overview.":::

### Set spending limits

You can set limits that control your spending for actions and packages usage. Adjust the limit at any time and according to the growth of your operations. 

The safety and control offered by this feature is also noteworthy. Enabled spending limits safeguard you in the event that a configuration error causes your organization to be billed. The billing is capped and the damage is kept to a minimum. This could be thought of as maximum risk.

When misconfiguration isn't the case, a spending limit simply assists you in budgeting your IT expenses.

### Monitor Git LFS data

The GitHub user interface enables management of Git LFS (Large File Storage) Data providing feedback on the amount of storage and bandwidth used. Every account using Git Large File Storage receives 1 GB of free storage and 1 GB a month of free bandwidth. If that's not enough, you can purchase extra. You pay when assets are pushed to or downloaded from your account. 

:::image type="content" source="../media/lfs.png" alt-text="Screenshot of Git LFS usage overview.":::

## Further reading

[Switching between settings for your different accounts](https://docs.github.com/en/billing/managing-your-github-billing-settings/about-billing-on-github#switching-between-settings-for-your-different-accounts)

[Managing your license for GitHub Enterprise Server](https://docs.github.com/enterprise-server@3.8/billing/managing-your-license-for-github-enterprise?azure-portal=true)

[Managing your license for GitHub Enterprise Cloud](https://docs.github.com/enterprise-cloud@latest/billing/managing-your-license-for-github-enterprise?azure-portal=true)

[Viewing your GitHub Actions usage](https://docs.github.com/en/billing/managing-billing-for-github-actions/viewing-your-github-actions-usage?azure-portal=true)

[Viewing your GitHub Packages usage](https://docs.github.com/en/billing/managing-billing-for-github-packages/viewing-your-github-packages-usage?azure-portal=true)

[Viewing your Git Large File Storage usage](https://docs.github.com/en/billing/managing-billing-for-git-large-file-storage/viewing-your-git-large-file-storage-usage?azure-portal=true)
