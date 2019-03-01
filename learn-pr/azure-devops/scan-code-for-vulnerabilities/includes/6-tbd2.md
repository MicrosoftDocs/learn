So far, we used credscan to verify there are no secret files in the app sources.

But what about the application sources themselves?

As an idea:

1. Move the card from Backlog to Doing.
1. Run Roslyn Security Analyzers locally.
    * (As a requirement, the reference app should trigger some sort of error or warning.)
1. Iteratively fix the errors; rerun Roslyn Security Analyzers at each step.
1. Push up the fix. Watch it build.
1. Integrate Roslyn Security Analyzers as a build task. Trigger a build and watch it succeed. (you now have a process in place to catch further errors.)
1. Perhaps also add a widget to the dashboard.
1. Move the card from Doing to Done.

Alternatively, we could use SonarQube or OWASP here. You might argue it's good to show off 3rd party components. However, there may be licensing issues (would need to use the free version), we don't control the future of these products, and so on. So maybe stick with Roslyn Security Analyzers.