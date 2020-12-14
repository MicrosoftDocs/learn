using System;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.eShopOnContainers.Web.Shopping.HttpAggregator.Config;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace Microsoft.eShopOnContainers.Web.Shopping.HttpAggregator.Services
{
    public class CouponService : ICouponService
    {
        public readonly HttpClient _httpClient;
        private readonly UrlsConfig _urls;
        private readonly ILogger<CouponService> _logger;

        public CouponService(HttpClient httpClient, IOptions<UrlsConfig> config, ILogger<CouponService> logger)
        {
            _urls = config.Value;
            _httpClient = httpClient;
            _logger = logger;
        }

        #region snippet_CheckCouponByCodeNumberAsync
        public async Task<HttpResponseMessage> CheckCouponByCodeNumberAsync(string codeNumber)
        {
            _logger.LogInformation("----- WebAggregator --> Coupon-API: {codeNumber}", codeNumber);

            var url = new Uri($"{_urls.Coupon}/api/v1/coupon/{codeNumber.Trim().ToUpper()}");
        #endregion snippet_CheckCouponByCodeNumberAsync
        #region snippet_CheckCouponByCodeNumberAsync2
            var response = await _httpClient.GetAsync(url);

            _logger.LogInformation("----- WebAggregator <-- Coupon-API: {@response}", response);

            return response;
        }
        #endregion snippet_CheckCouponByCodeNumberAsync2
    }
}
