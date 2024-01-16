
Secrets aren't passed automatically to the runners when workflows are executed.

Instead, when you include an action that requires access to a secret, you use the **secrets** context to provide it.

```YAML
steps:

  - name: Test Database Connectivity
    with:
      db_username: ${{ secrets.DBUserName }}
      db_password: ${{ secrets.DBPassword }}

```

## Command-line secrets

Secrets shouldn't be passed directly as command-line arguments as they may be visible to others. Instead, treat them like environment variables:

```YAML
steps:

  - shell: pwsh
    env:
      DB_PASSWORD: ${{ secrets.DBPassword }}
    run: |
      db_test "$env:DB_PASSWORD"

```

## Limitations

Workflows can use up to 100 secrets, and they're limited to 64 KB in size.

For more information on creating secrets, see [Encrypted secrets](https://docs.github.com/actions/security-guides/encrypted-secrets).
