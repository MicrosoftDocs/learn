namespace Coupon.API.Controllers
{
    using System;
    using System.Data;
    using System.Net;
    using System.Threading.Tasks;
    using Coupon.API.Dtos;
    using Coupon.API.Infrastructure.Models;
    using Coupon.API.Infrastructure.Repositories;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Logging;

    [Authorize]
    [ApiController]
    [Route("api/v1/[controller]")]
    public class CouponController : ControllerBase
    {
        private readonly ILogger<CouponController> _logger;
        private readonly ICouponRepository _couponRepository;
        private readonly IMapper<CouponDto, Coupon> _mapper;
        private readonly ExceptionTrigger _exceptionTrigger;

        public CouponController(
            ILogger<CouponController> logger,
            ICouponRepository couponRepository,
            IMapper<CouponDto, Coupon> mapper,
            ExceptionTrigger exceptionTrigger)
        {
            _logger = logger;
            _couponRepository = couponRepository;
            _mapper = mapper;
            _exceptionTrigger = exceptionTrigger;
        }

        #region snippet_GetCouponByCodeAsync
        [HttpGet("{code}")]
        [ProducesResponseType((int)HttpStatusCode.NotFound)]
        [ProducesResponseType((int)HttpStatusCode.BadRequest)]
        [ProducesResponseType(typeof(CouponDto), (int)HttpStatusCode.OK)]
        public async Task<ActionResult<CouponDto>> GetCouponByCodeAsync(string code)
        {
            // code omitted for brevity
            
            var coupon = await _couponRepository.FindCouponByCodeAsync(code);

            if (coupon is null || coupon.Consumed)
            {
                return NotFound(coupon == null
                    ? "ERROR: The coupon doesn't exist"
                    : "ERROR: The coupon has been redeemed already");
            }
            #endregion
            var couponDto = _mapper.Translate(coupon);

            return Ok(couponDto);
        }
    }
}