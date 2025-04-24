In this unit, you'll learn how to monitor and manage billing for GitHub’s metered products, including Actions minutes, storage, licenses, and advanced features like Copilot and GHAS.

GitHub provides detailed billing and consumption reports to track the usage of **metered products**. These reports help administrators monitor costs, allocate resources efficiently, and ensure compliance with organizational policies.

## GitHub Actions Minutes

GitHub Actions is a CI/CD automation tool where workflows run on virtual machines. The minutes consumed in these workflows are metered based on repository type, runner type, and usage.

### Tracking Consumption
- Navigate to **Settings → Billing** in your GitHub organization or account.
- Under the **GitHub Actions** section, you can see the number of minutes used.
- Usage is broken down by repository, runner type (Linux, macOS, Windows), and remaining quota.

### Billing Details
- **Free Allocation:**
    - Public repositories get **unlimited** free minutes.
    - Private repositories receive free minutes based on the plan:
        - **GitHub Free:** 2,000 minutes/month
        - **GitHub Pro:** 3,000 minutes/month
        - **GitHub Team:** 3,000 minutes/month
        - **GitHub Enterprise:** 50,000 minutes/month
- **Pricing per Runner Type (as of 2024):**
    - **Linux:** $0.008 per minute
    - **Windows:** $0.016 per minute
    - **macOS:** $0.08 per minute

### Optimization Strategies
- Use **self-hosted runners** for high-volume workflows to reduce costs.
- Optimize workflow scripts by caching dependencies and reducing redundant jobs.
- Limit workflows to **only trigger when necessary** (e.g., push to `main` branch only).

## Storage for GitHub Packages
GitHub Packages allows storing artifacts, container images, and dependencies. Storage is metered based on the volume of stored data and data transfer usage.

### Tracking Consumption

- Navigate to **Settings → Billing → GitHub Packages** to view storage usage.
- Breakdown includes **storage (GB) and data transfer (GB)** used per repository.

### Billing Details

- **Free Allocation:**
  - **Public repositories:** Free storage and bandwidth.  
  - **Private repositories:**
    - Storage up to 2GB  
    - Data transfer up to 1GB per month  

For details on storage limits and usage beyond the free allocation, see [GitHub’s pricing page](https://github.com/pricing).

### Optimization Strategies
- Regularly **delete unused packages** or enable retention policies.
- Store frequently accessed images in a **centralized registry** to reduce duplication.
- Use **compressed formats** to reduce storage consumption.

## GitHub Enterprise (GHE) Licenses
GitHub Enterprise provides advanced features for organizations, and the number of **active users** determines license consumption.

### Tracking Consumption
- Go to **Enterprise Settings → Billing** to view **license usage reports**.
- Monitor active users vs. allocated licenses.

### Billing Details
- **Pricing Model:**
    - Each user with access to private repositories consumes **one license**.
    - Organizations pay per user annually or monthly.
- **Inactive Users:**
    - If an admin **removes** a user, the license remains **assigned** for the billing period but can be reallocated.

### Optimization Strategies
- Audit **inactive users** and revoke access to free up licenses.
- Use **SSO and SCIM provisioning** to automate user management.

## GitHub Advanced Security (GHAS) Licenses
GitHub Advanced Security (GHAS) offers **code scanning, secret scanning, and dependency review** for enhanced security.

### Tracking Consumption
- View reports in **Settings → Billing → GHAS Usage** to see active committers.
    - Active committers are defined as anyone who pushed code to a GHAS-enabled repo within the billing period.
- The report shows **unique committers per billing period**.

### Billing Details
- **Pricing Model:**
    - Charged per **unique committer** per month.
    - If a committer contributes to multiple repositories, they **only count once**.
- **Free Tier:** Not available (only for public repositories).

### Optimization Strategies
- **Restrict GHAS** to repositories that **truly need advanced security**.
- Use **branch protections** to limit unnecessary scans on feature branches.

---

## GitHub Copilot
GitHub Copilot provides **AI-driven code completion** and suggestions, billed per user.

### Tracking Consumption
- Admins can track **Copilot usage** under **Billing → Copilot** in organization settings.
- The report shows **active users** and monthly billing estimates.

### Billing Details

- **Access Model:**
  - Available for individuals and businesses with different subscription options.
- **Free Access:**
  - Free for students and verified open-source maintainers.
  - Free for **select enterprise customers** (trial-based).

For current Copilot plans and subscription details, see [GitHub Copilot pricing](https://github.com/features/copilot#pricing).

### Optimization Strategies

- Regularly **review and deactivate Copilot** for users who don’t need it.
- Encourage developers to **disable Copilot** in projects where AI-generated code is unnecessary.

## Large File Storage (LFS)

GitHub LFS is used for storing large binary files separately from Git repositories.

### Tracking Consumption

- View LFS usage in **Billing → LFS Usage**.
- Report includes **storage (GB) and bandwidth usage (GB)**.

### Billing Details

- **Free Tier:**
  - 1GB of storage per account per month
  - 1GB of bandwidth usage per month

For more information on Git Large File Storage (LFS) usage and limits, see [GitHub's LFS documentation](https://docs.github.com/en/github/managing-large-files/about-git-large-file-storage#about-storage-and-bandwidth-usage).

### **Optimization Strategies**

- **Use external storage services** (e.g., AWS S3, Azure Blob Storage) for large files.
- **Delete unused large files** to optimize storage.
- **Enable Git LFS file pruning** to remove unreferenced objects.
