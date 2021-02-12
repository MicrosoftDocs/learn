Some of the GitHub features discussed in the previous unit are either available or not, depending on the product.  Other features, however, are "rate based".  You get a certain number of execution minutes or storage capacity, and then you must pay for additional usage.

In this unit, we'll look at a few different ways that GitHub licenses and prices certain rate-based features.

## Licensing GitHub Actions and GitHub Packages

GitHub Actions usage is free for public repositories and self-hosted runners. For private repositories, each GitHub account receives a certain number of free minutes, depending on the product used with the account. 

By default, your account will have a spending limit of $0, which prevents additional usage of minutes after you reach your limit. If you increase your spending limit above the default of $0, you will be billed for any minutes beyond the limits, also called overages. GitHub charges usage to the account that owns the repository where the workflow is run.

Jobs that run on Windows and macOS runners that GitHub hosts consume minutes at 2 and 10 times the rate that jobs on Linux runners consume. For example, using 1,000 Windows minutes would consume 2,000 of the minutes included in your account. Using 1,000 macOS minutes, would consume 10,000 minutes included in your account.

The following table compares the minute multiplier for the different operating systems.

| Operating system | Minute multiplier |
|---|---:|
| Linux | 1 |
| macOS | 10 |
| Windows | 2 |

Finally, the free minutes reset each month.  You cannot "roll over" unused minutes from previous months.

If your account's usage surpasses these limits and you have set a spending limit above $0, you will pay per-minute usage depending on the operating system used by the GitHub-hosted runner. GitHub rounds the minutes each job uses up to the nearest minute.

> [!NOTE]
> For current prices, please refer to [GitHub's pricing page](https://github.com/pricing?azure-portal=true).

### Licensing GitHub Packages

Storage for GitHub Packages works in a similar way, except that GitHub Packages storage capacity does not reset every month.

The storage used by a repository is the total storage used by GitHub Actions artifacts and GitHub Packages. Your storage cost is the total usage for all repositories owned by your account.

GitHub calculates your storage usage for each month based on hourly usage during that month. For example, if you use 3 GB of storage for 10 days of March and 12 GB for 21 days of March, your storage usage would be:

3 GB x 10 days x (24 hours per day) = 720 GB-Hours
12 GB x 21 days x (24 hours per day) = 6,048 GB-Hours
720 GB-Hours + 6,048 GB-Hours = 6,768 GB-Hours
6,768 GB-Hours / (744 hours per month) = 9.0967 GB-Months

At the end of the month, GitHub rounds your storage to the nearest megabyte. Therefore, your storage usage for March would be 9.097 GB.

If your account's usage surpasses these limits and you have set a spending limit above $0, you incur a small additional fee per gigabyte of storage used per month.

At the end of the month, GitHub calculates the cost of minutes and storage used over the amount included in your account.

> [!NOTE]
> For a specific scenario that demonstrates how your bill is calculated with actual dollar amounts, see the following article in GitHub's Docs, titled ["Calculating minute and storage spending"](https://docs.github.com/free-pro-team@latest/github/setting-up-and-managing-billing-and-payments-on-github/about-billing-for-github-actions#calculating-minute-and-storage-spending?azure-portal=true).

### What are spending limits?

By default, your account will have a spending limit of $0 for GitHub Actions usage. To enable using minutes and storage for private repositories beyond the amounts included with your account, you can increase the spending limit or allow unlimited spending.

If you pay for your enterprise account by invoice, you cannot manage the spending limit for your enterprise account on GitHub. If you want to allow organizations owned by your enterprise account to use GitHub Actions beyond the storage or data transfer included in their accounts, you can prepay for overages. Because overages must prepaid, you cannot enable unlimited spending on accounts paid by invoice. Your spending limit will be 150% of the amount you prepaid.

If your account has outstanding unpaid charges:

- The storage or minutes included in your account for GitHub Actions and GitHub Packages will not be reset until the payment has been successfully processed.
- For accounts with storage or minutes remaining for the current billing period, GitHub Actions and GitHub Packages will continue to be available until any included usage has been reached.
- For accounts that have reached the included usage for the current billing period for GitHub Actions or GitHub Packages, both GitHub Actions and GitHub Packages will be disabled to prevent any further overages. If you pay your account by invoice, you must contact our account management team to process payment and reset your usage.

## Codespaces billing

As of this writing, Codespaces is beta and during this period it is free to use. When Codespaces becomes generally available, you will be billed for storage and compute usage.

Compute costs are incurred only when a codespace is active. When you're using a codespace, the codespace is active. After 30 minutes of inactivity, a codespace becomes suspended automatically.

Compute usage is billed per hour, at a rate that depends on your codespace's instance type. During the beta, Codespaces offers a single, Linux instance type. At general availability, GitHub will support three Linux instance types.

- Basic (2 cores, 4-GB RAM, 32 GB SSD)
- Standard (4 cores, 8-GB RAM, 32 GB SSD)
- Premium (8 cores, 16-GB RAM, 32 GB SSD)

Compute pricing may vary for additional instance types and operating systems supported in the future.

Each codespace also incurs monthly storage costs until you delete the codespace. Storage costs for all instance types incur a small additional fee per month per gigabyte of storage used.
