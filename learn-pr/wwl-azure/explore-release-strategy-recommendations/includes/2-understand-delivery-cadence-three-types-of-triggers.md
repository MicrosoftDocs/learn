
Release and stages make use of triggers. There are three types of triggers we recognize.

## Continuous deployment trigger

You can set up this trigger on your release pipeline. Once you do that, your release pipeline will trigger every time a build completes and creates a new release.

## Scheduled triggers

It allows you to set up a time-based manner to start a new release—for example, every night at 3:00 AM or 12:00 PM. You can have one or multiple daily schedules, but it will always run at this specific time.

## Manual trigger

With a manual trigger, a person or system triggers the release based on a specific event. When it's a person, it probably uses some UI to start a new release. When it's an automated process, some events will likely occur. You can trigger the release from another system using the automation engine, which is usually part of the release management tool.

For more information, see also:

 -  [Release and Stage triggers](/azure/devops/pipelines/release/triggers).
