Before you create a project, evaluate whether Fabric Apps fits the Adventure Works dashboard scenario. This unit shows how to compare strengths, limits, licensing, and capacity cost before you commit to a design.

## Match the scenario to the platform

Fabric Apps fits workloads where the app is internal, signed-in users are known, and the data is in or near Fabric.

**Typically a good fit:**

- Internal tools and dashboards
- Data exploration and visualization
- Rapid prototypes
- Agent apps that need persistent state

**Typically a poor fit:**

- Apps that need stored procedures
- Complex multi-step transactions
- Custom identity providers
- An existing database schema you must keep as is

The Adventure Works dashboard is internal, used by signed-in managers, and reads Fabric data, so it's typically a good fit. If the same company wanted a public storefront with customer accounts from another identity provider, the scenario would be a poor fit, because after deployment sign-in uses Microsoft Entra ID only.

## Know the constraints that shape design

Some constraints apply to every Fabric app:

- TypeScript is the only supported language for data models and application logic.
- The backend database is SQL database in Fabric, and the schema comes from your code.
- You can't point an app at an existing schema. You reach existing Fabric data through connectors instead.
- You are responsible for secrets and for what the app exposes. Don't put secrets in frontend assets, regardless of hosting access.

## Choose a licensing option

A workspace's licensing option decides what the app can do.

- **Capacity-backed apps** run in a workspace assigned to Fabric capacity or an active Fabric trial. App services consume capacity units from that capacity.
- **Power BI Pro apps** run in a Pro workspace without Fabric capacity, with limits. A Pro app doesn't support Functions, Storage, anonymous access, or public sites. Connectors to Fabric data are supported.

If the scenario needs server-side logic or file storage, plan for a capacity-backed workspace. For the full comparison, see [Choose a licensing option for Fabric Apps](/fabric/apps/licensing).

## Understand capacity cost

Fabric Apps has no separate charge. The services behind your app consume capacity units, and Microsoft can change consumption rates, so don't plan around a quoted number. Instead, learn which services consume capacity and how to read actual usage.

- The SQL database in Fabric, the GraphQL API, Functions, and OneLake storage consume capacity units.
- A Fabric administrator or capacity owner reads real usage in the [Microsoft Fabric Capacity Metrics app](/fabric/enterprise/metrics-app). For the list of metered operations, see [Pricing for Fabric apps on capacity](/fabric/apps/pricing).

A Fabric trial helps you evaluate at no cost, with limits:

- It lasts 60 days and isn't for production.
- The number of trial capacities per tenant is limited, and an administrator can turn trials off.
- A trial capacity allows up to three SQL databases. Each Fabric app creates a SQL database child item, so reuse the same app throughout this module and delete test apps you no longer need.

## Evaluate the Adventure Works scenario

Apply the criteria to your own tenant and write down an answer to each question. The sales dashboard is a candidate if every answer is yes.

- Does the app serve signed-in users in your organization?
- Can the data be stored in a database defined by TypeScript code, or reached through a connector?
- Does the app avoid stored procedures and custom identity providers?
- Does the workspace have a trial or capacity in a region where Fabric Apps is available, with the tenant setting enabled?
- Can you accept that consumption depends on your capacity and usage?

When a check fails, note which one. You use that note in the final exercise to revisit the decision with evidence from a deployed prototype.

## Next step

In the next exercise, you confirm that your environment is ready, scaffold the Adventure Works dashboard app, and identify its key files. You then run and deploy the app to test these assumptions against a Fabric-hosted backend.
