#region snippet_ConfigureAddDefaultIdentity
services.AddDefaultIdentity<ContosoPetsUser>()
    .AddDefaultUI()
    .AddEntityFrameworkStores<ContosoPetsAuth>();
#endregion
