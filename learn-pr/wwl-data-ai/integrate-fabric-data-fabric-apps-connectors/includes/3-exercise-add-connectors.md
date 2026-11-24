In this exercise, you prepare sample inventory and sales data, add a connector for each source with an explicit identity, and verify that both return data. The connector commands follow three steps: `search` finds a source, `add` declares it in `rayfin/rayfin.yml`, and `inspect` and `invoke` verify access from the command line.

## Prepare your environment

You need the following items:

- A Fabric Apps project that you can sign in to. Reuse an existing development project or create one in a workspace that has a trial or paid capacity, and then change to its folder. Accept the default `blankapp` template.

    ```bash
    npm create @microsoft/rayfin@latest -- adventure-connectors --workspace <workspace-name>
    cd adventure-connectors
    ```

- A development workspace on a trial or paid capacity, with permission to create a warehouse and a semantic model. The following sections create both sources with small sample datasets. No file upload or desktop application is required.
- The **Semantic Model Execute Queries REST API** tenant setting enabled by an administrator. Your account also needs Read and Build permissions on the semantic model when you query it.
- Permission to read the warehouse through its SQL endpoint, because schema discovery runs as you.

## Create the sample warehouse

The sample uses two tables in one warehouse: inventory for the warehouse connector and sales for the semantic model connector. If you already have a development warehouse and model with these tables and fields, skip the source setup sections.

1. In the Fabric portal, open your development workspace. Select **New item**, search for **Warehouse**, and create a warehouse named `AdventureWorksConnectors`.
1. Open the warehouse and select **New SQL query**. Paste the following script and select **Run**. Run it once in the new warehouse. It creates the tables and inserts the sample rows without deleting existing data.

    ```sql
    CREATE TABLE dbo.ProductInventory (
        ProductID INT NOT NULL,
        productName VARCHAR(100) NOT NULL,
        warehouseLocation VARCHAR(50) NOT NULL,
        quantityOnHand INT NOT NULL
    );

    ALTER TABLE dbo.ProductInventory
        ADD CONSTRAINT PK_ProductInventory
        PRIMARY KEY NONCLUSTERED (ProductID) NOT ENFORCED;

    INSERT INTO dbo.ProductInventory
        (ProductID, productName, warehouseLocation, quantityOnHand)
    VALUES
        (1, 'Road bike', 'Seattle', 12),
        (2, 'Mountain bike', 'Portland', 8),
        (3, 'Touring bike', 'Seattle', 25),
        (4, 'Helmet', 'Portland', 40),
        (5, 'Brake lever', 'Seattle', 6);

    CREATE TABLE dbo.Sales (
        SaleID INT NOT NULL,
        Region VARCHAR(50) NOT NULL,
        Amount DECIMAL(12, 2) NOT NULL
    );

    INSERT INTO dbo.Sales (SaleID, Region, Amount)
    VALUES
        (1, 'North', 1200.00),
        (2, 'North', 800.00),
        (3, 'South', 950.00),
        (4, 'South', 650.00),
        (5, 'West', 1500.00),
        (6, 'West', 500.00);

    SELECT * FROM dbo.ProductInventory;
    SELECT * FROM dbo.Sales;
    ```

    The inventory table uses the column names expected by the later inventory view. Its primary key is declared for metadata discovery, but Fabric Warehouse doesn't enforce uniqueness. The sample supplies unique product IDs. For details, see [Warehouse table constraints](/fabric/data-warehouse/table-constraints).

1. Confirm that the query results contain five inventory rows and six sales rows. If the tables don't appear in the warehouse explorer, refresh it.

## Create the sales semantic model

The semantic model is a separate Fabric item backed by the warehouse's `Sales` table. A new warehouse doesn't create a semantic model automatically.

1. In the warehouse ribbon, select **New semantic model**.

    :::image type="content" source="../media/semantic-model-new.png" alt-text="Screenshot of the AdventureWorksConnectors warehouse ribbon with the New semantic model button highlighted." lightbox="../media/semantic-model-new.png":::

1. In the **New semantic model** dialog, enter `AdventureWorksSales`, choose your development workspace, and select **Direct Lake on SQL**. Expand **dbo**, select only the **Sales** table, and select **Confirm**.

    :::image type="content" source="../media/semantic-model-dialog.png" alt-text="Screenshot of the New semantic model dialog with AdventureWorksSales entered, Direct Lake on SQL selected, and only the Sales table checked." lightbox="../media/semantic-model-dialog.png":::

1. Open the new semantic model and select **Open data model**. Confirm that the table is named `Sales` and contains `SaleID`, `Region`, and `Amount`.
1. Select the **Sales** table, select **New measure**, and enter the following definition:

    ```dax
    Total Sales = SUM('Sales'[Amount])
    ```

    :::image type="content" source="../media/semantic-mode-measure.png" alt-text="Screenshot of the AdventureWorksSales model with New measure highlighted, the Total Sales formula summing Amount, and the measure listed under Sales." lightbox="../media/semantic-mode-measure.png":::

    The measure sums `Amount` under the current filter context. The later sales view groups it by `Region`, producing totals of 2,000 for North, 1,600 for South, and 2,000 for West.

1. Confirm that **Total Sales** appears under **Sales** and that the model changes are saved before you continue. Your account needs Read and Build permissions on this model. For the current creation workflow, see [Create a Power BI semantic model](/fabric/data-warehouse/create-semantic-model).

## Add the connectors capability

1. In the project root, add the `connectors` capability pack. It adds the frontend connector SDK and the client wiring.

    ```bash
    npm run pack:add -- connectors
    ```

## Find the sources

1. Search for the warehouse.

    ```bash
    npx rayfin connector search --all-workspaces --type fabric-warehouse --json
    ```

    Example output follows. The workspace name is a generic lab name, and the GUIDs are replaced with placeholders. Use the actual IDs from your own command output when you add the connectors.

    ```json
    {
        "status": "ok",
        "query": "",
        "scope": {
            "allWorkspaces": true
        },
        "count": 1,
        "sources": [
            {
                "connectorType": "fabric-warehouse",
                "itemType": "Warehouse",
                "workspaceId": "<workspace-id>",
                "workspaceName": "LabWorkspace",
                "itemId": "<warehouse-item-id>",
                "displayName": "AdventureWorksConnectors",
                "capabilities": {
                    "operations": [
                        "read"
                    ],
                    "defaultAuth": "application",
                    "requiresVersion": false
                },
                "suggestedName": "adventureworksconnectors",
                "addCommand": "rayfin connector add --type fabric-warehouse --workspace-id <workspace-id> --item-id <warehouse-item-id> --name adventureworksconnectors"
            }
        ]
    }
    ```

1. Search for the semantic model.

    ```bash
    npx rayfin connector search --all-workspaces --type fabric-semanticmodel --json
    ```

    Example output uses the same workspace placeholder and a separate item placeholder for the semantic model:

    ```json
    {
        "status": "ok",
        "query": "",
        "scope": {
            "allWorkspaces": true
        },
        "count": 1,
        "sources": [
            {
                "connectorType": "fabric-semanticmodel",
                "itemType": "SemanticModel",
                "workspaceId": "<workspace-id>",
                "workspaceName": "LabWorkspace",
                "itemId": "<model-item-id>",
                "displayName": "AdventureWorksSales",
                "capabilities": {
                    "operations": [
                        "executeQuery"
                    ],
                    "defaultAuth": "delegated",
                    "requiresVersion": true
                },
                "suggestedName": "adventureworkssales",
                "addCommand": "rayfin connector add --type fabric-semanticmodel --workspace-id <workspace-id> --item-id <model-item-id> --name adventureworkssales"
            }
        ]
    }
    ```

1. Find `AdventureWorksConnectors` and `AdventureWorksSales` in your development workspace. Each result includes an `addCommand` containing its workspace and item GUIDs. Use those GUIDs for `<workspace-id>`, `<warehouse-item-id>`, and `<model-item-id>` in the next section. Don't run the returned `addCommand` unchanged: the following commands set the connector names, identities, and operations required by the exercises.

## Add the connectors with explicit identities

1. Add the warehouse with application access and read-only operations, as you decided in the previous unit.

    ```bash
    npx rayfin connector add --type fabric-warehouse --workspace-id <workspace-id> --item-id <warehouse-item-id> --name adventureworksconnectors --operations read --auth application
    ```

1. Add the semantic model with delegated access, which is its only option.

    ```bash
    npx rayfin connector add --type fabric-semanticmodel --workspace-id <workspace-id> --item-id <model-item-id> --name adventureworkssales --auth delegated
    ```

1. Each command prints a version-pinned `npm install` command. Run each printed command exactly as shown, and don't drop the version. An unpinned install can leave two Rayfin version lines in one app.
1. Open `rayfin/rayfin.yml`. Under `connectors:`, confirm each entry's `auth.type` and the `operations` list. The warehouse lists only `read`, and the semantic model lists `executeQuery`.

## Prove each connector returns data

1. Inspect the warehouse, which runs read-only queries under your identity. The first command lists the tables, and the second samples one table.

    ```bash
    npx rayfin connector inspect --name adventureworksconnectors
    npx rayfin connector inspect --name adventureworksconnectors --entity dbo.ProductInventory --rows 5
    ```

    The first command lists tables and views. Example output follows. The reported row count can exceed the displayed rows, and system views and query timings can vary.

    ```text
    ✔ Querying connector:adventureworksconnectors complete (5.7s)

    Inspect result for connector:adventureworksconnectors
    connector type: fabric-warehouse
    rows: 15
    query mode: entities
    Columns: TABLE_SCHEMA (text), TABLE_NAME (text), TABLE_TYPE (text)
    | TABLE_SCHEMA  | TABLE_NAME                       | TABLE_TYPE |
    |---------------|----------------------------------|------------|
    | dbo           | ProductInventory                 | BASE TABLE |
    | dbo           | Sales                            | BASE TABLE |
    | queryinsights | exec_requests_history            | VIEW       |
    | queryinsights | exec_sessions_history            | VIEW       |
    | queryinsights | external_api_call_stats          | VIEW       |
    | queryinsights | frequently_run_queries           | VIEW       |
    | queryinsights | long_running_queries             | VIEW       |
    | queryinsights | sql_pool_insights                | VIEW       |
    | sys           | dm_db_external_tables_log_status | VIEW       |
    | sys           | external_delta_tables            | VIEW       |

    Sample one of these with: rayfin connector inspect --name 'adventureworksconnectors' --entity <name>
    ```

    The second command returns the five sample inventory records:

    ```text
    ✔ Querying connector:adventureworksconnectors complete (4.6s)

    Inspect result for connector:adventureworksconnectors
    connector type: fabric-warehouse
    rows: 5
    query mode: structured
    entity: dbo.ProductInventory
    Columns: ProductID (integer), productName (text), warehouseLocation (text), quantityOnHand (integer)
    | ProductID | productName   | warehouseLocation | quantityOnHand |
    |-----------|---------------|-------------------|----------------|
    | 1         | Road bike     | Seattle           | 12             |
    | 2         | Mountain bike | Portland          | 8              |
    | 3         | Touring bike  | Seattle           | 25             |
    | 4         | Helmet        | Portland          | 40             |
    | 5         | Brake lever   | Seattle           | 6              |
    ```

1. Inspect the semantic model's `Sales` table to verify that it returns sample rows.

    ```bash
    npx rayfin connector inspect --name adventureworkssales --entity Sales --rows 5
    ```

    Example output follows. The sample has six sales records, but `--rows 5` limits this inspection to five, as indicated by `truncated to cap`. Query timings can vary.

    ```text
    ✔ Querying connector:adventureworkssales complete (915ms)

    Inspect result for connector:adventureworkssales
    connector type: fabric-semanticmodel
    rows: 5 (truncated to cap)
    query mode: structured
    entity: Sales
    Columns: Sales[SaleID] (unknown), Sales[Region] (unknown), Sales[Amount] (unknown)
    | Sales[SaleID] | Sales[Region] | Sales[Amount] |
    |---------------|---------------|---------------|
    | 1             | North         | 1200          |
    | 2             | North         | 800           |
    | 3             | South         | 950           |
    | 4             | South         | 650           |
    | 5             | West          | 1500          |
    ```

1. Create the file `rayfin/queries/top-sales.json` with a DAX query for a table in your model. Keeping the payload in a file prevents shell quoting from changing the DAX.

    ```json
    {
      "query": "EVALUATE TOPN(5, 'Sales')",
      "resultSetRowCountLimit": 500
    }
    ```

1. Invoke the semantic model connector with the payload file.

    ```bash
    npx rayfin connector invoke adventureworkssales executeQuery --file rayfin/queries/top-sales.json
    ```

    If the CLI prompts you to consent to Power BI access, complete the prompt. Signing in with `rayfin login` consents to the Fabric scope, and the direct semantic model path also needs the Power BI scope.

Both connectors return rows from the command line, and you proved the connections before building any user interface.

## Check your understanding

Answer these questions before you continue:

- Whose identity ran the `inspect` and `invoke` commands?
- Does a successful `invoke` prove that the deployed app can query the semantic model for every manager?

The CLI commands ran under your developer identity, so they prove that you can reach the sources. They don't prove what the deployed connector can do. The warehouse connector runs as the app identity and the semantic model connector runs as each signed-in manager, so both need testing in the deployed app, which you do in later units.
