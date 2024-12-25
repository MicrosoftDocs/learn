Secrets aren't passed automatically to the runners when workflows are executed. To make a secret available to an action, you must set the secret as an input or environment variable in the workflow file. To accomplish this, you can use the secrets context as illustrated in following example:<br>

```YAML
steps:

  - name: Test Database Connectivity
    with:
      db_username: ${{ secrets.DBUserName }}
      db_password: ${{ secrets.DBPassword }}

```

## Referencing secrets from the command line

When referencing secrets from the command line, you can treat them like shell environment variables, as illustrated by the following example:

steps:

```YAML
- shell: pwsh
  env:
    DB_PASSWORD: ${{ secrets.DBPassword }}
  run: |
    db_test "$env:DB_PASSWORD"
```

It's important to follow this approach, which minimizes the risk of their accidental exposure. Secrets passed between processes from the command line can be viewed by using the PowerShell command and captured in security audit logs.

## Using secrets in if: conditionals

Since secrets can't be directly referenced in if: conditionals, as a workaround, consider setting secrets as job-level environment variables, then referencing the environment variables to conditionally run steps in the job, as in the following example:

```YAML
name: Run a step if a secret has been set
on: push
jobs:
  samplejob:
    runs-on: ubuntu-latest
    env:
      job_secret: ${{ secrets.JobSecret }}
    steps:
      - if: ${{ env.job_secret != '' }}
        run: echo 'the secret has a value set.'
      - if: ${{ env.job_secret == '' }}
        run: echo ' the secret does not have a value set.'
```

## Limitations

Workflows can use up to 100 secrets, regardless of their location. Secrets are limited to 48 KB in size. To use secrets that are larger than 48 KB, you can use a workaround to store secrets in your repository and save the decryption passphrase as a secret on GitHub. For details regarding this procedure, refer to [Storing large secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#storing-large-secrets) topic in GitHub documentation.

Note that with the exception of GITHUB\_TOKEN, secrets aren't passed to the runner when a workflow is triggered from a forked repository.<br>
