Here, we discuss how to remove workflow artifacts from GitHub and change the default retention period. Next, we show you how to create a workflow status badge and add it to your `README.md` file. Finally, we discuss some important workflow environment protections and how to enable them. 

## Removing workflow artifacts from GitHub

By default, GitHub will store any build log and uploaded artifacts for 90 days before they are deleted. This retention period can be customized based on the type of repository and the usage limits set for your specific GitHub product. There is a lot more information regarding usage limits and artifact retention than what makes sense to cover here, so check out [Usage limits, billing, and administration](https://docs.github.com/en/actions/reference/usage-limits-billing-and-administration) for more information.

But let's say you're reaching your organization’s storage limit for GitHub artifacts and packages and you want to remove old artifacts without increasing your usage limits and blocking your workflows. You can reclaim used GitHub Actions storage by deleting artifacts before they expire on GitHub. You can do this two ways as described in the following sections. Please note that both ways require write access to the repository.

> [!WARNING]
> Keep in mind that once you delete an artifact, it can not be restored.

### Manually delete artifacts from your repository

![run-name](https://user-images.githubusercontent.com/6351798/107467078-73c0b000-6b22-11eb-955e-66a46c1f8deb.png)

To manually delete an artifact using the UI you need to navigate to the **Actions** tab, select the workflow from the left sidebar, select the run you want to see, and then under **Artifacts**, delete the artifact you want to remove.

You can also use the Artifacts REST API to delete artifacts. This API will also allow you to download and retrieve information about work artifacts. For more information about the Artifacts API, check out [Artifacts REST API](https://docs.github.com/en/rest/reference/actions#artifacts).

### Change the default retention period

You can change the default artifact and log retention period for your repository, organization, or enterprise account. Keep in mind that changing the retention period will only apply to new artifacts and log files and does not apply to existing objects. The process to configure these settings is a bit different for a repository, organization, or enterprise. For more information on configuring the artifact and log retention for each option, check out [Artifact and log retention policy](https://docs.github.com/en/actions/reference/usage-limits-billing-and-administration#artifact-and-log-retention-policy).

In addition to configured settings across a repository, organization, or enterprise, you can define a custom retention period for individual artifacts right within the workflow file. This is good for individual use cases where you want a specific artifact's retention to be different than the default or configured setting. This can be done using `retention-days` and then a value within the step with the `upload-artifact` action.

The following example uploads an artifact that will persist for 10 days instead of the default 90 days.

```yml
- name: 'Upload Artifact'
  uses: actions/upload-artifact@v2
  with:
    name: my-artifact
    path: my_file.txt
    retention-days: 10
```

## Adding a workflow status badge to your repository

It's helpful to know the status of a workflow without having to visit the **Actions** tab to see if it successfully completed. Adding workflow status badges to your repository `README.md` file allows you to quickly see if your workflows are passing or failing. While it's common to add a status badge to a repository `README.md` file, it can also be added to any web page you want. By default, status badges display the workflow statuses on your default branch, but you can also display workflow status badges on other branches using the `branch` and `event` parameters.

```yml
![example branch parameter](https://github.com/mona/special-octo-eureka/actions/workflows/grading.yml/badge.svg?branch=my-workflow)
```

For example, adding the `branch` parameter along with the desired branch name at the end of the URL will show the workflow status badge for that branch instead of the default branch. This makes it easy to create a table-like view within your `README.md` file to display workflow statuses based on branches, events, services, or environments to name a few.

![Screen Shot 2021-02-10 at 2 36 01 PM](https://user-images.githubusercontent.com/6351798/107575668-5dac0180-6bad-11eb-91de-e2219c1f630b.png)

You also have the ability to create a status badge markdown using the GitHub UI. To do this, navigate to the workflows section within the **Actions** tab and select a specific workflow. The **Create status badge** option will allow you to generate the markdown for that workflow and set the `branch` and `event` parameters.

![Screen Shot 2021-02-10 at 2 44 35 PM](https://user-images.githubusercontent.com/6351798/107576585-939db580-6bae-11eb-9217-069c69d6f6cd.png)


For more information on adding workflow status badges, check out [Adding a workflow status badge](https://docs.github.com/en/actions/managing-workflow-runs/adding-a-workflow-status-badge).

## Adding workflow environment protections

Security is a big deal, so it makes sense to configure your workflow environment with protection rules and secrets. With these in place, a job won't start or access any defined secrets in the environment until all of the environment's protection rules pass. Currently, protection rules and environment secrets only apply to public repositories.

There are two environment protection rules that can be applied to workflows within public repositories, **required reviewers** and **wait timer**. 
- **Required reviewers** allow you to set a specific person or team to approve workflow jobs that reference the job's environment. 
- **Wait timer** can be used to delay a job for a specific amount of time after the job has been triggered. 

So, for example, let's say you need to create a workflow to a production environment that a dev team needs to approve before the deployment occurs. The steps would look like the following:

1. Create a production environment within the repository.
2. Configure the required reviewers environment protection to require an approval from the specific dev team.
3. Configure the specific job within the workflow to look for the production environment.

You can create and configure new repository environments from the repository's **Settings** tab under **Environments**. To learn more about creating and configuring repository environments, check out [Environments](https://docs.github.com/en/actions/reference/environments) from the GitHub documentation.
