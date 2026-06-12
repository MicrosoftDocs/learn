Column-level security (CLS) lets you restrict access to specific columns in a table without changing its structure. Users without permission to a column receive an error if they try to select it — and the rest of the table remains accessible to them normally. This makes CLS a clean solution for protecting sensitive fields in shared tables.

## A practical scenario

Consider a healthcare database with a `Patients` table containing `PatientID`, `Name`, `Address`, `DateOfBirth`, and `MedicalHistory`. The `MedicalHistory` column contains protected health information that only clinical staff should access.

With column-level security, you define this access boundary directly in the warehouse:

1. **Identify sensitive columns** – Determine which columns contain data that requires restricted access.
2. **Define roles** – Create roles that reflect job functions: `Doctor`, `Nurse`, `Receptionist`, and `Patient`.
3. **Assign users to roles** – Map each user to the role that matches their job.
4. **Apply GRANT and DENY** – Grant broad table access, then explicitly deny access to the sensitive column for roles that shouldn't see it.

## Configure column-level security

The following T-SQL creates roles, grants table access, then denies access to `MedicalHistory` for roles that shouldn't see it:

```sql
-- Create roles
CREATE ROLE Doctor AUTHORIZATION dbo;
CREATE ROLE Nurse AUTHORIZATION dbo;
CREATE ROLE Receptionist AUTHORIZATION dbo;
CREATE ROLE Patient AUTHORIZATION dbo;
GO

-- Grant SELECT on all columns to all roles
GRANT SELECT ON dbo.Patients TO Doctor;
GRANT SELECT ON dbo.Patients TO Nurse;
GRANT SELECT ON dbo.Patients TO Receptionist;
GRANT SELECT ON dbo.Patients TO Patient;
GO

-- Deny SELECT on MedicalHistory to roles that shouldn't see it
DENY SELECT ON dbo.Patients (MedicalHistory) TO Receptionist;
DENY SELECT ON dbo.Patients (MedicalHistory) TO Patient;
GO
```

Users with the `Doctor` or `Nurse` role can read `MedicalHistory`. Users with the `Receptionist` or `Patient` role get a permission error if they try to select that column.

> [!NOTE]
> When Power BI accesses a warehouse in **Direct Lake** mode and a table has column-level security applied, queries automatically fall back to **Direct Query** mode. Security is still enforced, but query performance differs from the Direct Lake baseline.