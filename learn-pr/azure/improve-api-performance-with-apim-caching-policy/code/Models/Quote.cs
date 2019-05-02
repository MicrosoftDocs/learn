using System;

namespace BoardGamingApi.Models
{
    public class Quote
    {
        public string BoardType { get; set; }
        public decimal EstimatedPrice { get; set; }
        public string ShippingCode { get; set; }
        public DateTime QuotePreparedTime { get; set; }

        public Quote (int height, int width, string shippingCode, string boardType)
        {
            this.BoardType = boardType;
            this.ShippingCode = shippingCode;
            this.EstimatedPrice = CalculatePrice(height, width);
            this.QuotePreparedTime = DateTime.Now;
        }

        private decimal CalculatePrice(double ht, double wd)
        {
            double area;
            area = ht * wd;
            if (area == 0)
            {
                return 0;
            }
            if ((area > 0) && (area <= 200.00))
            {
                return 20;
            }
            if ((area > 200.00) && (area <= 1000.00))
            {
                return 50;
            }
            else 
            {
                return 100;
            }
        }

    }
}