using System;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.eShopOnContainers.Web.Shopping.HttpAggregator.Models;
using Microsoft.eShopOnContainers.Web.Shopping.HttpAggregator.Services;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Microsoft.eShopOnContainers.Web.Shopping.HttpAggregator.Controllers
{
    [Route("api/v1/[controller]")]
    [Authorize]
    [ApiController]
    public class CouponController : ControllerBase
    {
        private static readonly Regex ExceptionRegex = new Regex(@"^.*?Exception: (.*)$", RegexOptions.IgnoreCase | RegexOptions.Multiline);
        private readonly ICouponService _coupon;
        private readonly ILogger<CouponController> _logger;

        public CouponController(
            ICouponService couponService,
            ILogger<CouponController> logger)
        {
            _coupon = couponService;
            _logger = logger;
        }

        #region snippet_CheckCouponAsync
        [HttpGet]
        [Route("{code}")]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        [ProducesResponseType(typeof(CouponData), (int)HttpStatusCode.OK)]
        public async Task<ActionResult<CouponData>> CheckCouponAsync(string code)
        {
            _logger.LogInformation("----- Getting discount coupon: {Code}", code);

            var response = await _coupon.CheckCouponByCodeNumberAsync(code);

            if (!response.IsSuccessStatusCode)
            {
        #endregion snippet_CheckCouponAsync                
                var content = await response.Content.ReadAsStringAsync();

                if (string.IsNullOrWhiteSpace(content)) return StatusCode((int)response.StatusCode);

                if ((int)response.StatusCode == 404)
                {
                    _logger.LogWarning("----- Coupon not found: {StatusCode} - Content: {Message}", (int)response.StatusCode, content);

                    return StatusCode((int)response.StatusCode, content);
                }

                if (content.IndexOf('\n') > -1)
                {
                    var line = content.Substring(0, content.IndexOf('\n')).Trim();
                    _logger.LogWarning("----- Error getting discount coupon: {StatusCode} ({ReasonPhrase}) - Content: {Message}", (int)response.StatusCode, response.ReasonPhrase, line);

                    if (ExceptionRegex.IsMatch(line))
                    {
                        var message = ExceptionRegex.Match(content).Groups[1];
                        return StatusCode((int)response.StatusCode, message);
                    }
                    else
                    {
                        return StatusCode((int)response.StatusCode, line);
                    }
                }


            }

            var couponResponse = await response.Content.ReadAsStringAsync();
            var data = JsonConvert.DeserializeObject<CouponData>(couponResponse);

            _logger.LogInformation("----- Received discount coupon: {Code} ({@Coupon})", code, data);

            return Ok(data);
        }
    }
}
