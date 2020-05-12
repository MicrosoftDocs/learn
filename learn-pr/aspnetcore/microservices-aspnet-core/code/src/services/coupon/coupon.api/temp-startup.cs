namespace Coupon.API
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        #region snippet_configureServices
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers(options => options.Filters.Add<ValidateModelAttribute>());

            services.AddCustomSettings(Configuration)
                .AddCouponRegister(Configuration)
                .AddCustomPolicies()
                .AddAppInsights(Configuration)
                .AddEventBus(Configuration)
                .AddCustomAuthentication(Configuration)
                .AddCustomAuthorization()
                .AddSwagger(Configuration)
                .AddCustomHealthCheck(Configuration);

            services.AddTransient<IIntegrationEventHandler<OrderStatusChangedToAwaitingCouponValidationIntegrationEvent>, OrderStatusChangedToAwaitingCouponValidationIntegrationEventHandler>();
            services.AddTransient<IIntegrationEventHandler<OrderStatusChangedToCancelledIntegrationEvent>, OrderStatusChangedToCancelledIntegrationEventHandler>();
        }
        #endregion
        
        #region snippet_configure
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            var pathBase = Configuration["PATH_BASE"];

            if (!string.IsNullOrEmpty(pathBase))
            {
                app.UsePathBase(pathBase);
            }

            app.UseSwagger()
                .UseSwaggerUI(options =>
                {
                    options.SwaggerEndpoint($"{ (!string.IsNullOrEmpty(pathBase) ? pathBase : string.Empty) }/swagger/v1/swagger.json", "Coupon.API V1");
                    options.OAuthClientId("couponswaggerui");
                    options.OAuthAppName("eShop-Learn.Coupon.API Swagger UI");
                })
                //.UseSerilogRequestLogging()
                .UseCors("CorsPolicy")
                .UseRouting()
                .UseAuthentication()
                .UseAuthorization()
                .UseEndpoints(endpoints =>
                {
                    endpoints.MapControllers();
                    endpoints.MapHealthChecks("/hc", new HealthCheckOptions()
                    {
                        Predicate = _ => true,
                        ResponseWriter = UIResponseWriter.WriteHealthCheckUIResponse
                    });
                    endpoints.MapHealthChecks("/liveness", new HealthCheckOptions
                    {
                        Predicate = r => r.Name.Contains("self")
                    });
                });

            ConfigureEventBus(app);
        }
        #endregion
        private void ConfigureEventBus(IApplicationBuilder app)
        {
            var eventBus = app.ApplicationServices.GetRequiredService<IEventBus>();

            eventBus.Subscribe<OrderStatusChangedToAwaitingCouponValidationIntegrationEvent, IIntegrationEventHandler<OrderStatusChangedToAwaitingCouponValidationIntegrationEvent>>();
            eventBus.Subscribe<OrderStatusChangedToCancelledIntegrationEvent, IIntegrationEventHandler<OrderStatusChangedToCancelledIntegrationEvent>>();
        }
    }
}
