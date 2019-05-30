using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace ProductDetailsFunc
{
    public static class ProductDetails
    {
        [FunctionName("ProductDetails")]
        public static async Task<HttpResponseMessage> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            // Get the product ID from the query string or the request body
            string requestedProductID = req.Query["ID"];
            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            requestedProductID = requestedProductID ?? data?.id;

            Product requestedProduct = getProduct(requestedProductID);

            if (requestedProduct != null)
            {
                string productJson = JsonConvert.SerializeObject(requestedProduct);
                return new HttpResponseMessage(HttpStatusCode.OK){
                    Content = new StringContent(productJson, Encoding.UTF8, "application/json")
                };
            }
            else
            {
                return new HttpResponseMessage(HttpStatusCode.NotFound);
            }
        }

        private static Product getProduct(string id)
        {

            //This method simulates returning a product,
            //e.g. from a database
            Product returnedProduct = new Product();

            switch (id)
            {
                case "1":
                    returnedProduct.ID = 1;
                    returnedProduct.Name = "Smart Speaker";
                    returnedProduct.PartNumber = "SM562";
                    returnedProduct.Price = 130.00;
                    break;
                case "2":
                    returnedProduct.ID = 2;
                    returnedProduct.Name = "Home Security Camera";
                    returnedProduct.PartNumber = "SC967";
                    returnedProduct.Price = 105.99;
                    break;
                case "3":
                    returnedProduct.ID = 3;
                    returnedProduct.Name = "Smart Dimmer Switch";
                    returnedProduct.PartNumber = "DS728";
                    returnedProduct.Price = 59.99;
                    break;
                default:
                    returnedProduct = null;
                    break;
            }

            return returnedProduct;

        }

    }

    public class Product
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public string PartNumber { get; set; }
    }
}
