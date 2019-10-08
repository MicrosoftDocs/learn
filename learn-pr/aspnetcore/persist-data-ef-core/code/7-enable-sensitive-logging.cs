services.AddDbContext<ContosoPetsContext>(options =>
    options.UseSqlServer(builder.ConnectionString)
           .EnableSensitiveDataLogging(Configuration.GetValue<bool>("Logging:EnableSqlParameterLogging")));