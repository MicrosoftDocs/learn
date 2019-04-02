using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace PictureFraming.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
       
       

        [HttpGet("{Height}/{Width}/{ShippingCode}")]

        public string GetQuery(string Height, string Width,string ShippingCode)

        {
            string price;
            string shipping;
            price = CalculatePrice(Double.Parse(Height), Double.Parse(Width));
            shipping = AddShipping(ShippingCode);
            return price + " Plus " + shipping + DateTime.Now;

        }

        private string CalculatePrice(double ht,double wd)

        {
            
            
            double area;

            
            
            area = ht * wd;

            

            if ((area > 20.00 ) &&  (area < 200.00))
            {
                return "20.00";
            }
            if ((area > 200.00) && (area < 1000.00))
            {
                return "50.00";
            }
            if ((area > 1000.00) && (area < 5000.00))
            {
                return "100.00";
            }
            return "not valid";
        }

        private string AddShipping(string scode)
        {
            if((scode == "uk")|| (scode == "UK"))
            {
                return "UK shipping 100 ";

            }

            return "Global shipping 200 ";
        }
    }
}
