Events are implemented by the **on** clause in a workflow definition.

There are several types of events that can trigger workflows.

## Scheduled events

With this type of trigger, a cron schedule needs to be provided.

```YAML
on:
    schedule:

        - cron: '0 8-17 * * 1-5'

```

Cron schedules are based on five values:

 -  Minute (0 - 59)
 -  Hour (0 - 23)
 -  Day of the month (1 - 31)
 -  Month (1 - 12)
 -  Day of the week (0 - 6)

Aliases for the months are JAN-DEC and for days of the week are SUN-SAT.

A wild card means any. (\* is a special value in YAML, so the cron string will need to be quoted)

So, in the example above, the schedule would be 8 AM - 5 PM Monday to Friday.

## Code events

Code events will trigger most actions. It occurs when an event of interest occurs in the repository.

```YAML
on:
    pull_request

```

The above event would fire when a pull request occurs.

```YAML
on:
    [push, pull_request]

```

The above event would fire when either a push or a pull request occurs.

```YAML
on:
    pull_request:
        branches:

            - develop

```

The event shows how to be specific about the section of the code that is relevant.

In this case, it will fire when a pull request is made in the develop branch.

## Manual events

There's a unique event that is used to trigger workflow runs manually. You should use the **workflow\_dispatch** event.

Your workflow must be in the default branch for the repository.

## Webhook events

Workflows can be executed when a GitHub webhook is called.

```YAML
on:
    gollum

```

This event would fire when someone updates (or first creates) a Wiki page.

## External events

Events can be on **repository\_despatch**. That allows events to fire from external systems.

For more information on events, see [Events that trigger workflows](https://docs.github.com/actions/learn-github-actions/events-that-trigger-workflows).
