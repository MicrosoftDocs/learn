services.AddMvc()
    .AddRazorPagesOptions(options =>
        options.Conventions.AuthorizePage("/Products/Edit", "Admin"))
    .SetCompatibilityVersion(CompatibilityVersion.Version_2_2);
    