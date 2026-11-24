Releasing an app to production is a controlled move between environments, not a single deploy command. For an app on Microsoft Fabric, a release also decides who can open the app, which data they reach, and how you know the app stays healthy afterward.

You finish an issue-reporting tool for store operations at Adventure Works Cycles. The tool must reach production for store managers. You deploy to a development workspace, promote the app to a production workspace, and share it with the managers. A day later, a report arrives: one manager opens the app but sees no inventory data.

In this module, you explore how Fabric Apps supports that lifecycle. You learn how the Rayfin CLI separates development and production deployments, and how that path compares with Fabric Git integration and deployment pipelines. You see how a GitHub Actions workflow protects production deployments, how sharing separates access to the app from access to the data behind it, and how App Metrics and a layered troubleshooting routine help you find where a failure occurs. Hands-on exercises in your own Fabric tenant let you deploy to two workspaces, build a protected workflow, review sharing, and make a release decision from evidence.

By the end of this module, you can release a Fabric app through development and production environments, share it with the right people, and diagnose problems after launch.
