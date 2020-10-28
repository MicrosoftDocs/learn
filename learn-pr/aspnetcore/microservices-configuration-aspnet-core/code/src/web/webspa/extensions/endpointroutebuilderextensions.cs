using System;
using Microsoft.AspNetCore.Routing;
using WebSPA.Infrastructure.Middlewares;

namespace Microsoft.AspNetCore.Builder
{
    public static class EndpointRouteBuilderExtensions
    {
        #region snippet_MapFeatureManagement
        public static IEndpointConventionBuilder MapFeatureManagement(
            this IEndpointRouteBuilder endpoints,
            string pattern = "features")
        {
            if (endpoints == null)
                throw new ArgumentNullException(nameof(endpoints));

            var pipeline = endpoints.CreateApplicationBuilder()
                .UseMiddleware<FeatureManagementMiddleware>()
                .Build();

            return endpoints.MapGet(pattern, pipeline);
        }           
        #endregion snippet_MapFeatureManagement      
    }
}