using BlazingPizza.Server.Hubs;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace BlazingPizza.Server
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            // Omitted for brevity

            services.AddSignalR(options => options.EnableDetailedErrors = true)
                .AddMessagePackProtocol();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            // Omitted for brevity

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapHub<OrderStatusHub>("/orderstatus");
                endpoints.MapRazorPages();
                endpoints.MapControllers();
                endpoints.MapFallbackToFile("index.html");
            });
        }
    }
}
