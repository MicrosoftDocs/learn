[Data API Builder (DAB)](/azure/data-api-builder/overview?azure-portal=true) is a cross-platform, open-source engine that creates modern REST and GraphQL endpoints for your database without requiring you to write custom code. With a single configuration file, you can expose your database objects through secure, scalable APIs that support authentication, authorization, and caching.

If you work with Azure SQL or SQL databases in Microsoft Fabric, you've likely faced requests to make your data accessible to application developers. Building custom API layers takes time and adds maintenance overhead. Data API Builder eliminates that work by generating APIs directly from your database schema.

## Understand the Data API Builder configuration file

Everything in Data API Builder starts with a configuration file. This JSON file tells DAB how to connect to your database, which objects to expose, how to handle authentication, and how to behave at runtime. When DAB starts, it reads this configuration and generates your REST and GraphQL endpoints automatically.

A typical configuration file has four main sections:

- **$schema** - References the JSON schema for validation and IntelliSense support
- **data-source** - Defines the database connection string and type
- **runtime** - Controls runtime behavior like host settings, authentication, and caching
- **entities** - Specifies which database objects to expose and how to configure them

Here's a basic configuration file structure:

```json
{
  "$schema": "https://github.com/Azure/data-api-builder/releases/download/v1.1.7/dab.draft.schema.json",
  "data-source": {
    "database-type": "mssql",
    "connection-string": "@env('DATABASE_CONNECTION_STRING')"
  },
  "runtime": {
    "rest": {
      "enabled": true,
      "path": "/api"
    },
    "graphql": {
      "enabled": true,
      "path": "/graphql"
    },
    "host": {
      "cors": {
        "origins": ["http://localhost:3000"],
        "allow-credentials": false
      },
      "authentication": {
        "provider": "StaticWebApps"
      }
    }
  },
  "entities": {}
}
```

Notice the `$schema` property at the top? That gives your editor autocompletion and validation as you type. Always use the schema version that matches your DAB installation.

## Configure the data source connection

The `data-source` section tells DAB how to connect to your database. For SQL Server, Azure SQL Database, and SQL databases in Microsoft Fabric, you use `mssql` as the database type.

```json
"data-source": {
  "database-type": "mssql",
  "connection-string": "@env('DATABASE_CONNECTION_STRING')",
  "options": {
    "set-session-context": true
  }
}
```

You could put your connection string directly in the configuration file, but don't. Use the `@env()` syntax instead to reference environment variables. This keeps credentials out of your configuration files and source control.

The `set-session-context` option is worth noting. When enabled, DAB passes user identity information to SQL Server through session context. Your stored procedures and functions can then read this information using `SESSION_CONTEXT()`, which is helpful for implementing row-level security or audit logging.

> [!TIP]
> For local development, you can use the `dab init` command with the `--connection-string` parameter to set up your initial configuration file quickly.

## Set up runtime options

The `runtime` section controls how DAB operates when serving requests. Here you configure REST and GraphQL endpoints separately, along with global host settings like CORS and caching.

```json
"runtime": {
  "rest": {
    "enabled": true,
    "path": "/api",
    "request-body-strict": true
  },
  "graphql": {
    "enabled": true,
    "path": "/graphql",
    "allow-introspection": true
  },
  "host": {
    "cors": {
      "origins": ["https://myapp.azurewebsites.net"],
      "allow-credentials": true
    },
    "mode": "production"
  },
  "cache": {
    "enabled": true,
    "ttl-seconds": 5
  }
}
```

The `path` properties define the base URL path for each API type. REST endpoints appear under `/api/EntityName`, while GraphQL queries go to `/graphql`. The `allow-introspection` setting for GraphQL determines whether clients can query the schema itself, which is helpful during development but should often be disabled in production for security.

CORS (Cross-Origin Resource Sharing) settings in the `host` section specify which domains can call your API from browser-based applications. The `mode` property switches between `development` and `production` behavior, affecting features like detailed error messages.

## Use the DAB CLI for configuration management

The [Data API Builder CLI](/azure/data-api-builder/reference-command-line-interface?azure-portal=true) provides commands for creating and modifying configuration files without manual JSON editing. This approach reduces errors and ensures valid configuration syntax.

To create a new configuration file:

```bash
dab init --database-type mssql --connection-string "@env('DATABASE_CONNECTION_STRING')" --host-mode development
```

This command creates a `dab-config.json` file in your current directory with baseline settings. From there, you can add entities using CLI commands or edit the file directly.

To add an entity for a table:

```bash
dab add Product --source dbo.Products --permissions "anonymous:read"
```

The CLI handles JSON formatting and validates your configuration against the schema automatically. If you work in a team, using CLI commands also makes pull request reviews easier since the formatting stays consistent.

> [!IMPORTANT]
> Always store your configuration files in source control, but never commit actual connection strings. Use environment variable references and manage credentials through secure mechanisms like Azure Key Vault or deployment pipeline secrets.

## Organize configuration for multiple environments

Most projects need different settings for development, staging, and production. You might want introspection enabled during development but disabled in production, or different CORS origins for each environment.

DAB supports this through configuration merging. Start with a base `dab-config.json` file containing shared settings, then create environment-specific overrides:

- `dab-config.development.json` - Development-specific settings
- `dab-config.staging.json` - Staging environment settings  
- `dab-config.production.json` - Production settings

When you start DAB with the `--config` parameter, it merges that file's settings with your base configuration:

```bash
dab start --config dab-config.production.json
```

Environment-specific files only need to contain settings that differ from the base. DAB handles the merge automatically, with environment-specific values taking precedence over base settings.
