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

namespace OrderShippingFunc
{
    public static class OrderDetails
    {
        [FunctionName("OrderDetails")]
        public static async Task<HttpResponseMessage> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            // Get the customer's last name from the query string or the request body
            string name = req.Query["name"];
            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            Order requestedOrder = getOrder(name);

            if (requestedOrder != null)
            {
                string orderJson = JsonConvert.SerializeObject(requestedOrder);
                return new HttpResponseMessage(HttpStatusCode.OK){
                    Content = new StringContent(orderJson, Encoding.UTF8, "application/json")
                };
            }
            else
            {
                return new HttpResponseMessage(HttpStatusCode.NotFound){
                    Content = new StringContent("No order for that has been found for your request.")
                };
            }
        }

        private static Order getOrder(string customerLastName)
        {
            //This method simulates returning an order,
            //e.g. from a database
            Order returnedOrder = new Order();

            switch (customerLastName)
            {
                case "Henri":
                    returnedOrder.ID = 56224;
                    returnedOrder.CustomerFirstName = "Pascale";
                    returnedOrder.CustomerLastName = "Henri";
                    returnedOrder.Total = 307.98;
                    returnedOrder.Shipped = true;
                    break;
                case "Chiba":
                    returnedOrder.ID = 72945;
                    returnedOrder.CustomerFirstName = "Yuki";
                    returnedOrder.CustomerLastName = "Chiba";
                    returnedOrder.Total = 442.50;
                    returnedOrder.Shipped = false;
                    break;
                case "Barriclough":
                    returnedOrder.ID = 34723;
                    returnedOrder.CustomerFirstName = "Alison";
                    returnedOrder.CustomerLastName = "Barriclough";
                    returnedOrder.Total = 150.99;
                    returnedOrder.Shipped = true;
                    break;
                default:
                    returnedOrder = null;
                    break;
            }

            return returnedOrder;
        }
    }

    public class Order 
    {
        public int ID { get; set; }
        public string CustomerFirstName { get; set; }
        public string CustomerLastName { get; set; }
        public double Total { get; set; }
        public bool Shipped { get; set; }
    }
}
