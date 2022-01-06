Now you know how Dependabot alerts can help you identify vulnerable dependencies in your repository and you're ready to learn about security updates and version updates. Dependabot security updates help you to fix the vulnerabilities identified by Dependabot alerts. Version updates help manage different versions of dependent packages.

Once you have set up Dependabot alerts to notify you of vulnerabilities in your repository, you can enable two related features so that Dependabot automatically raises pull requests to try to help with your dependency management:

- **Dependabot security updates** are automated pull requests that help you update dependencies with known vulnerabilities.
- **Dependabot version updates** are automated pull requests that keep your dependencies updated, even when they don’t have any vulnerabilities.

:::image type="content" source="../media/dependabot-pull-requests.png" alt-text="screenshot of pull requests opened by dependabot.":::

## Supported repositories

GitHub automatically enables Dependabot security updates for  every repository that meets the following prerequisites:

- The repository isn't a fork.
- The repository isn't archived.
- The repository is public or it's private and you've enabled the read-only analysis by the dependency graph, and vulnerability alerts in the repository's settings.
- Dependabot security updates aren't disabled for the repository.

## Manually enable security updates

You can enable security updates manually on private repositories that don't meet the prerequisites mentioned in the section above. Make sure you've enabled the dependency graph and Dependabot alerts on your repository, and follow these steps to manually enable security updates for it:

1. Log in to your GitHub account and select your profile photo from the upper-right.
2. Click **Settings** > **Security & analysis**.
3. Click **Enable** for Dependabot security updates.

## View and resolve security updates 

View Dependabot pull requests the same way that you would view other pull requests on GitHub, within the **Pull requests** tab of the related repository. Dependabot pull requests will have dependabot as the author, this account is the bot account used by Dependabot. They'll also use the `dependencies` label.

Dependabot pull requests include all the information that you need to review and merge a proposed fix into your project like release notes, changelog entries, and commit details. Details of which vulnerability a pull request resolves are hidden from anyone who doesn't have access to Dependabot alerts for the repository. Merging a security update pull request automatically closes the related Dependabot alert. 

Despite all this information, it's still best practice to have automated processes in place so that checks are carried out before the pull request is merged. This approach is especially important if the update includes other functionality or potentially breaking changes. 

### View dependencies being monitored by Dependabot

After creating and checking your `dependabot.yml` file into your repository, you can view the dependencies being monitored by Dependabot to confirm everything is working properly by following the steps below: 

1.	Navigate to the main page of the repository. 
2.	Under your repository name, click **Insights**. 
3.	Click **Dependency graph** in the left sidebar.
4.	Click **Dependabot**. 
5.	Click the three dots next to a package manager to view the files being monitored.

:::image type="content" source="../media/view-dependencies.png" alt-text="screenshot showing dependencies view from dependency graph.":::

The **Last checked TIME ago** link in the **Dependabot** tab also enables you to see the log files that Dependabot generated during the last check for version updates. You can rerun the version check by clicking the **Check for updates** button.

## Version updates 

Version updates are another Dependabot feature that helps to manage your dependencies by automatically generating a pull request whenever there's a new version of a package or application that your project depends on.

Dependabot checks for new versions by looking at the semantic versioning of the dependency (`MAJOR.MINOR.PATCH` naming convention), which is included in a manifest or other type of package definition file stored in your repository. To enable version updates, you need to create a `dependabot.yml` file, which will essentially tell Dependabot where to find the manifest, or other package definition file. You'll learn how to create a `dependabot.yml` file in the next section.

### Enable version updates for private repositories

Users with write permissions can enable Dependabot version updates for their repository by checking a `dependabot.yml` file into the `.github` directory of their repository.

The `dependabot.yml` file should include the following information: 

- `version`: Should be set to 2.
- `registries`: Optional if you have dependencies in a private registry. This section contains authentication details.
- `updates`: Include an entry for each dependency you want Dependabot to monitor.

For each package manager, include:

- `package-ecosystem`: Specifies the package manager.
- `directory`: Specifies the location of the manifest or other definition files.
- `schedule.interval`: Specifies how often to check for new versions.

Below is an example of a `dependabot.yml` file: 

```
# Basic dependabot.yml file with
# minimum configuration for two package managers

version: 2
updates:
  # Enable version updates for npm
  - package-ecosystem: "npm"
    # Look for `package.json` and `lock` files in the `root` directory
    directory: "/"
    # Check the npm registry for updates every day (weekdays)
    schedule:
      interval: "daily"

  # Enable version updates for Docker
  - package-ecosystem: "docker"
    # Look for a `Dockerfile` in the `root` directory
    directory: "/"
    # Check for updates once a week
    schedule:
      interval: "weekly"
```

### Version updates on forks 

Dependabot version updates aren't automatically enabled on forks. This safeguard prevents fork owners from unintentionally enabling version updates when they pull changes including a `dependabot.yml` file from the original repository.

To enable version updates on the fork of a repository:
1.	Navigate to the main page of the repository where you want to enable version updates. 
2.	From the main page, select **Insights**. 
3.	Click **Dependency graph** from the left sidebar.
4.	Click **Dependabot**.
5.	Click **Enable Dependabot**.

## Allow Dependabot to access private repositories

To check for outdated dependencies and generate a security update, Dependabot must have access to the repository that contains the dependencies. Dependabot generally can't update dependencies that are located in private repositories or private package registries. However, if the dependency is in a private repository located in the same organization as the package that uses it, then you can grant Dependabot access.

To allow Dependabot to access a private GitHub repository:

1. Go to the security and analysis settings for your organization.
2. Under "Grant Dependabot access to private repository", click **Add private repositories** or **Add internal and private repositories**.
3. Start typing the name of the repository you want to allow.
4. Click the repository you want to allow.
5. Optionally, to remove a repository from the list, go to the right of the repository and click **X**.

## Security update compatibility scores

Dependabot security updates may include compatibility scores to let you know whether updating a dependency could cause breaking changes. This score is calculated from continuous integration (CI) tests in other public repositories where the same security update has been generated. The compatibility score is the percentage of CI runs that passed when updating between specific versions of the dependency.