You want to know what a Fabric app actually is before building the sales dashboard. This unit explains what runs where, so the later evaluation of fit rests on a clear picture of the platform.

## A Fabric app is a managed Fabric item

A Fabric app runs as a managed service in Microsoft Fabric. You define the backend in TypeScript, and Fabric hosts, secures, and scales it. After deployment, sign-in uses Fabric single sign-on (Microsoft Entra ID) only. No other identity provider is available.

A Fabric app brings together the services your application needs, such as a database, authentication, and frontend hosting. Fabric manages these as child services of the app.

| Child service | What it provides |
|:--------------|:-----------------|
| SQL database in Fabric | A managed database whose schema comes from your TypeScript data model. |
| Authentication | Fabric-brokered sign-in with Microsoft Entra ID. |
| Static content | Your built frontend (HTML, CSS, and JavaScript) served from a Fabric hosting URL. |
| Functions | An optional service you enable when the app needs server-side logic. |
| Storage | An optional service you enable when the app needs file storage. |

:::image type="content" source="../media/fabric-app-managed-services.png" alt-text="Diagram of a Fabric app with static content, authentication, a SQL database, optional Functions and Storage, and Microsoft Entra ID sign-in.":::

Each app has one backend API URL that serves its backend services, and one app URL for the hosted frontend. After deployment, `rayfin up status` lists these as **Endpoint** and **Static app**, respectively. The backend API URL is also stored in `RAYFIN_PUBLIC_API_URL` in `rayfin/.env`.

## Roles of the Rayfin CLI and SDK

The Rayfin CLI and the SDK divide the work between development time and runtime.

- **The CLI** scaffolds projects, signs you in, runs the development loop, and deploys. The commands you use most are `rayfin login`, `rayfin dev`, `rayfin up`, and `rayfin up status`. Run the CLI with `npx rayfin` so it matches the packages installed in your project.
- **The SDK** runs in your application code. A typed client built from your data model reads and writes data, and it carries the signed-in session on each request.

> [!NOTE]
> In the scaffolding exercise, you create a project and install its dependencies, including the Rayfin CLI and SDK packages.

Your own code stays in TypeScript for data models and application logic. The frontend can use frameworks such as React, Vue, or Angular to communicate with the backend over HTTP.

## Project structure

The default `blankapp` template creates a Universal App, which is an npm workspace. The layout keeps backend configuration, runtime code, and shared contracts in separate places.

```text
my-app/
├── rayfin/
│   ├── rayfin.yml        # service declaration that dev and up sync to Fabric
│   └── .env              # values the CLI writes after deployment
└── packages/
    ├── frontend/         # React, Vite, sign-in wiring, browser UI
    ├── data/             # entity registration and schema exports
    └── shared/           # types shared across browser, data, and Functions code
```

The `rayfin/rayfin.yml` file is the checked-in declaration of which services the app uses. In a new Universal App, the data service is off. You turn on capabilities with capability packs, which patch `rayfin.yml`, add dependencies, and copy starter files:

```bash
npm run pack:add -- <pack>
```

| Pack | What it adds |
|:-----|:-------------|
| `data-modeling` | The data service and a starter `Item` entity with owner-scoped access. |
| `storage` | Storage and the data service it requires. |
| `functions` | A `packages/functions` package for server-side functions. |
| `connectors` | The frontend connector SDK for existing Fabric sources. |
| `analytics` | A semantic model connector and a query hook. |
| `visuals` | Chart and table components for query results. |

## Development loop and release status

The development loop runs the frontend on your machine while the backend runs in Fabric. `npm run dev` runs `rayfin dev`, which provisions or reuses the backend, applies your settings, and starts the local frontend. `rayfin up` publishes the app.

Fabric Apps and Rayfin 2.0 are generally available. Individual features carry their own status: for example, anonymous data access is Preview, and application telemetry is Experimental. The [Rayfin changelog](https://rayfin.ai/docs/reference/changelog) keeps a feature status table that you can use as the per-feature reference.

> [!NOTE]
> A separate, new tool named `rayfin-local` runs a Rayfin app on your machine without a Fabric workspace and uses SQLite instead of the Fabric database. This module uses `rayfin dev` against a Fabric-hosted backend, and the exercises don't require `rayfin-local`.

## Next step

In the next unit, you evaluate whether Fabric Apps fits the Adventure Works dashboard scenario by comparing capabilities, constraints, licensing options, and capacity cost. Then you scaffold a project and identify these files in a real Universal App.
