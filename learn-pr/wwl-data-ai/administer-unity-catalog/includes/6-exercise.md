# Exercise - Configure isolation strategies

In this exercise, you'll practice implementing Unity Catalog isolation methods by configuring workspace bindings, exploring lineage capabilities, and setting up metastore separation strategies for GlobalTech Solutions' compliance requirements.

## Exercise scenario

You're implementing Unity Catalog isolation for GlobalTech Solutions, which has three divisions requiring different levels of data isolation:

- **Healthcare Division**: Requires HIPAA compliance with complete data isolation
- **Financial Services**: Needs SOX compliance with strict access controls  
- **Marketing & Sales**: Requires flexible collaboration with controlled access to customer insights

Your tasks involve configuring workspace-level separation, implementing lineage tracking, and planning metastore isolation strategies.

## Task 1: Configure workspace-catalog bindings

**Objective**: Set up workspace-level separation to isolate production and development environments while enabling controlled collaboration.

### Step 1: Create environment-specific catalogs

1. In the Unity Catalog interface, create three catalogs:
   - `prod_customer_data` (production customer information)
   - `staging_customer_data` (staging/testing environment)
   - `shared_reference_data` (shared lookup tables)

2. Configure catalog-level storage locations for data isolation:
   ```sql
   CREATE CATALOG prod_customer_data
   MANAGED LOCATION 'abfss://prod-data@globaltech.dfs.core.windows.net/customer/'
   COMMENT 'Production customer data with strict access controls';

   CREATE CATALOG staging_customer_data  
   MANAGED LOCATION 'abfss://staging-data@globaltech.dfs.core.windows.net/customer/'
   COMMENT 'Staging environment for testing and development';

   CREATE CATALOG shared_reference_data
   MANAGED LOCATION 'abfss://reference@globaltech.dfs.core.windows.net/lookup/'
   COMMENT 'Shared reference data accessible across environments';
   ```

### Step 2: Implement workspace bindings

1. Use the Databricks CLI to configure catalog bindings:
   ```bash
   # Bind production catalog only to production workspace
   databricks workspace-bindings update-bindings catalog prod_customer_data \
   --json '{
     "add": [{"workspace_id": 1001, "binding_type": "BINDING_TYPE_READ_WRITE"}]
   }'

   # Bind staging catalog to both staging and development workspaces
   databricks workspace-bindings update-bindings catalog staging_customer_data \
   --json '{
     "add": [
       {"workspace_id": 1002, "binding_type": "BINDING_TYPE_READ_WRITE"},
       {"workspace_id": 1003, "binding_type": "BINDING_TYPE_READ_ONLY"}
     ]
   }'
   ```

2. Verify bindings by checking workspace access:
   ```bash
   databricks workspace-bindings get-bindings catalog prod_customer_data
   databricks workspace-bindings get-bindings catalog staging_customer_data
   ```

### Step 3: Test access patterns

1. From the production workspace, verify you can access production data:
   ```sql
   USE CATALOG prod_customer_data;
   SHOW SCHEMAS;
   ```

2. From the development workspace, confirm you cannot access production data:
   ```sql
   -- This should fail with access denied
   SELECT * FROM prod_customer_data.customers.profiles LIMIT 10;
   ```

3. Verify read-only access to staging data from development workspace:
   ```sql
   -- This should work (read access)
   SELECT COUNT(*) FROM staging_customer_data.customers.profiles;
   
   -- This should fail (write access denied)
   INSERT INTO staging_customer_data.customers.profiles VALUES (...);
   ```

## Task 2: Explore data lineage tracking

**Objective**: Understand how Unity Catalog tracks data lineage across isolation boundaries and during legacy system integration.

### Step 1: Create data pipeline with lineage

1. Create a data transformation pipeline that shows lineage across catalogs:
   ```sql
   -- Source data in staging
   CREATE OR REPLACE TABLE staging_customer_data.raw.daily_transactions (
     transaction_id STRING,
     customer_id STRING, 
     amount DECIMAL(10,2),
     transaction_date DATE,
     created_at TIMESTAMP
   );

   -- Transform and move to production
   CREATE OR REPLACE TABLE prod_customer_data.analytics.customer_summary AS
   SELECT 
     customer_id,
     COUNT(*) as transaction_count,
     SUM(amount) as total_amount,
     MAX(transaction_date) as last_transaction_date,
     current_timestamp() as summary_created_at
   FROM staging_customer_data.raw.daily_transactions
   WHERE transaction_date >= current_date() - interval 30 days
   GROUP BY customer_id;
   ```

2. Create downstream analytics tables:
   ```sql
   -- Customer segmentation based on transaction patterns
   CREATE OR REPLACE TABLE prod_customer_data.analytics.customer_segments AS
   SELECT 
     customer_id,
     CASE 
       WHEN total_amount > 10000 THEN 'High Value'
       WHEN total_amount > 1000 THEN 'Medium Value' 
       ELSE 'Standard'
     END as segment,
     transaction_count,
     total_amount
   FROM prod_customer_data.analytics.customer_summary;
   ```

### Step 2: Examine lineage information

1. Query lineage metadata to understand data flow:
   ```sql
   -- View table lineage relationships
   SELECT 
     source_table_full_name,
     target_table_full_name,
     created_at as lineage_created
   FROM system.information_schema.table_lineage
   WHERE target_table_full_name LIKE '%customer_summary%'
   ORDER BY created_at DESC;
   ```

2. Examine column-level lineage:
   ```sql
   -- Check how specific columns flow through transformations
   SELECT 
     source_table_full_name,
     source_column_name,
     target_table_full_name, 
     target_column_name
   FROM system.information_schema.column_lineage
   WHERE target_table_full_name = 'prod_customer_data.analytics.customer_summary';
   ```

### Step 3: Legacy system integration simulation

1. Create a foreign catalog to simulate Hive metastore integration:
   ```sql
   -- Simulate creating connection to legacy Hive metastore
   -- (This would normally connect to an actual Hive metastore)
   CREATE CATALOG legacy_hive_simulation
   COMMENT 'Simulated legacy Hive metastore for migration exercise';

   CREATE SCHEMA legacy_hive_simulation.default;
   
   -- Create table to represent legacy data
   CREATE TABLE legacy_hive_simulation.default.legacy_customers (
     customer_id STRING,
     name STRING,
     email STRING,
     registration_date DATE,
     status STRING
   );
   ```

2. Create migration tracking with lineage:
   ```sql
   -- Migrate data from "legacy" system to Unity Catalog
   CREATE TABLE prod_customer_data.migrated.customer_profiles AS
   SELECT 
     customer_id,
     name,
     email, 
     registration_date,
     status,
     current_timestamp() as migrated_at,
     'legacy_hive_migration' as migration_source
   FROM legacy_hive_simulation.default.legacy_customers;
   ```

3. Verify migration lineage:
   ```sql
   -- Check lineage shows migration path
   SELECT 
     source_table_full_name,
     target_table_full_name,
     created_at
   FROM system.information_schema.table_lineage
   WHERE source_table_full_name LIKE '%legacy_customers%'
      OR target_table_full_name LIKE '%customer_profiles%';
   ```

## Task 3: Plan metastore separation strategy

**Objective**: Design a metastore separation strategy for complete compliance isolation.

### Step 1: Analyze separation requirements

1. Document the compliance requirements for each division:

   | Division | Compliance | Isolation Level | Data Types |
   |----------|------------|-----------------|------------|
   | Healthcare | HIPAA | Complete separation | Patient records, clinical data |
   | Financial | SOX | Audit-controlled separation | Customer financial data, transactions |
   | Marketing | Standard | Workspace-level | Customer behavior, campaign data |

2. Create a metastore architecture plan:
   ```text
   GlobalTech Solutions - Metastore Architecture
   
   Account: GlobalTech-Azure-Account
   Region: US East
   
   healthcare-metastore-us-east
   ├── patient_clinical_catalog
   ├── research_anonymized_catalog  
   └── compliance_audit_catalog
   
   finance-metastore-us-east
   ├── customer_financial_catalog
   ├── regulatory_reporting_catalog
   └── risk_management_catalog
   
   business-metastore-us-east (existing)
   ├── marketing_catalog
   ├── sales_catalog
   └── operations_catalog
   ```

### Step 2: Configure separation policies

1. Create compliance-specific access groups:
   ```sql
   -- Healthcare groups
   CREATE GROUP healthcare_admins;
   CREATE GROUP clinical_staff;
   CREATE GROUP hipaa_compliance_officers;

   -- Financial services groups  
   CREATE GROUP finance_admins;
   CREATE GROUP financial_analysts;
   CREATE GROUP sox_auditors;
   ```

2. Design storage isolation patterns:
   ```sql
   -- Healthcare metastore storage configuration
   -- (This would be done during metastore creation)
   
   -- Each catalog gets dedicated, compliant storage
   CREATE CATALOG patient_clinical_data
   MANAGED LOCATION 'abfss://hipaa-clinical@healthcareacct.dfs.core.windows.net/'
   COMMENT 'HIPAA-compliant patient clinical data storage';

   CREATE CATALOG research_anonymized_data
   MANAGED LOCATION 'abfss://research-data@healthcareacct.dfs.core.windows.net/'  
   COMMENT 'De-identified research data for analytics';
   ```

### Step 3: Create separation validation queries

1. Design monitoring queries for metastore separation:
   ```sql
   -- Query to validate no cross-metastore data access
   SELECT 
     metastore_name,
     catalog_name,
     COUNT(DISTINCT table_name) as table_count,
     MAX(last_accessed) as most_recent_access
   FROM system.information_schema.catalog_summary
   GROUP BY metastore_name, catalog_name
   ORDER BY metastore_name, catalog_name;
   ```

2. Create compliance audit queries:
   ```sql
   -- Audit query for healthcare metastore access
   SELECT 
     user_identity,
     action_name,
     object_name,
     request_timestamp,
     client_application
   FROM healthcare_metastore.system.access.audit
   WHERE date >= current_date() - interval 7 days
     AND action_name IN ('READ', 'WRITE', 'CREATE', 'DROP')
   ORDER BY request_timestamp DESC;
   ```

## Verification and results

After completing the exercise tasks:

1. **Workspace isolation verification**:
   - Production data is accessible only from production workspace
   - Staging data has appropriate read/write permissions by workspace
   - Development workspace cannot access production data

2. **Lineage tracking confirmation**:
   - Unity Catalog tracks data flow across catalog boundaries
   - Migration lineage shows legacy system integration path
   - Column-level transformations are captured and queryable

3. **Metastore separation planning**:
   - Architecture addresses compliance requirements for each division
   - Storage isolation prevents unauthorized cross-division data access
   - Administrative separation enables independent governance policies

This exercise demonstrates how Unity Catalog's isolation strategies work together to meet complex organizational and compliance requirements while maintaining operational efficiency and data governance visibility.