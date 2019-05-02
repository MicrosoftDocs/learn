using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNetCore.Mvc;
using BoardGamingApi.Models;

namespace BoardGamingApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuotesController : ControllerBase
    {

        [HttpGet("{ShippingCode}/{Game}")]
        public ActionResult<Quote> GetPriceEstimate(string ShippingCode, string Game, int Height, int Width)
        {
            Quote newQuote = new Quote(Height, Width, ShippingCode, Game);

            return newQuote;

        }

    }
}
