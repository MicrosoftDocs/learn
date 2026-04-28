Your organization needed to ensure that different user groups see only the data they're authorized to access. Sales managers should see only their region's data, and sensitive employee information like salary should be restricted to authorized payroll staff.

You learned how to implement row-level security using dynamic DAX filter expressions with `USERPRINCIPALNAME()` and the security table pattern. You applied object-level security to hide sensitive tables and columns from unauthorized roles. You then tested security configurations in Power BI Desktop and the service, and managed role membership using Microsoft Entra security groups.

With these security configurations in place, your semantic models enforce data protection across all consumption paths. Reports, Copilot chat, and Fabric data agents all respect the same RLS and OLS rules you defined, ensuring consistent authorization regardless of how users access the data.

## Learn more

- [Row-level security (RLS) with Power BI](/power-bi/enterprise/service-admin-rls)
- [Object-level security (OLS)](/fabric/security/service-admin-object-level-security)
