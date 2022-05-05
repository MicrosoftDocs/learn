When report consumers can see all model data there’s no need to take special steps. However, when they should see subsets of model data or be restricted from certain tables or columns, it’s critical that your model enforces appropriate security.

You typically restrict access to model data with RLS rules. However, when you develop a DirectQuery model for data sources that support SSO, Power BI can leverage the data source RLS. In this case, as a data modeler, you don’t need to create model roles.

There are many good development practices you should apply to ensure data permissions are enforced accurately and efficiently.