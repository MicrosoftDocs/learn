services.AddAntiforgery(options => options.HeaderName = "X-CSRF-TOKEN");
services.AddRazorPages(options =>
    options.Conventions.AuthorizePage("/Products/Edit", "Admin"));
services.AddControllers();
    