GitHub Actions workflows are triggered by **events** - specific activities that happen in your repository or on a schedule. Events are defined by the `on` clause in your workflow definition and determine when your automation runs.

## Scheduled events

Schedule workflows to run at specific times using cron syntax. This is perfect for maintenance tasks, regular reports, or nightly builds.

```yaml
on:
  schedule:
    # Runs every weekday at 8 AM UTC
    - cron: "0 8 * * 1-5"
    # Runs every Sunday at midnight UTC
    - cron: "0 0 * * 0"
```

**Cron syntax breakdown:**

- **Minute** (0-59) | **Hour** (0-23) | **Day** (1-31) | **Month** (1-12) | **Weekday** (0-6, Sunday=0)
- Use month names: `JAN-DEC` and day names: `SUN-SAT`
- Use `*` for "any" (quote cron strings in YAML)

**Examples:**

- `'0 9-17 * * 1-5'` - Every hour from 9 AM to 5 PM, Monday-Friday
- `'30 2 * * *'` - Daily at 2:30 AM
- `'0 0 1 * *'` - First day of every month at midnight

## Code repository events

The most common triggers respond to code changes in your repository:

### Basic push and pull request events

```yaml
on:
  # Single event
  push

  # Multiple events
  pull_request

# Or as a list
on: [push, pull_request]
```

### Filtered events with branches and paths

```yaml
on:
  push:
    branches: [main, develop]
    paths: ["src/**", "!docs/**"]
  pull_request:
    branches: [main]
    types: [opened, synchronize, reopened]
```

### Common repository events

| Event          | Trigger               | Use Case                 |
| -------------- | --------------------- | ------------------------ |
| `push`         | Code pushed to branch | CI/CD, automated testing |
| `pull_request` | PR opened/updated     | Code review automation   |
| `release`      | Release published     | Deploy to production     |
| `create`       | Branch/tag created    | Initialize environments  |
| `delete`       | Branch/tag deleted    | Cleanup resources        |

## Manual events

Trigger workflows manually from the GitHub Actions tab using `workflow_dispatch`:

```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: "Deployment environment"
        required: true
        default: "staging"
        type: choice
        options:
          - staging
          - production
      version:
        description: "Version to deploy"
        required: true
        type: string
```

**Note:** The workflow file must exist in the default branch to appear in the manual trigger UI.

## Webhook events

GitHub provides many webhook events for repository activities:

```yaml
on:
  # Wiki page created or updated
  gollum

  # Issues opened, closed, or edited
  issues:
    types: [opened, edited, closed]

  # New release published
  release:
    types: [published]
```

## External events

Use `repository_dispatch` to trigger workflows from external systems via GitHub's REST API:

```yaml
on:
  repository_dispatch:
    types: [deploy-staging, run-tests]
```

**Triggering externally:**

```bash
curl -X POST \
  -H "Authorization: token YOUR_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/OWNER/REPO/dispatches \
  -d '{"event_type":"deploy-staging","client_payload":{"environment":"staging"}}'
```

## Best practices for events

1. **Be specific**: Use branch and path filters to avoid unnecessary runs
2. **Combine related events**: Group similar triggers in one workflow
3. **Use appropriate event types**: Choose the most specific event type for your needs
4. **Test manually first**: Use `workflow_dispatch` during development
5. **Monitor usage**: Review workflow runs to optimize event configuration

For complete event documentation, see [Events that trigger workflows](https://docs.github.com/actions/learn-github-actions/events-that-trigger-workflows).
