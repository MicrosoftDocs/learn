using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

using Microsoft.Rest.Azure.Authentication;
using Microsoft.Azure.Management.Monitor;
using Microsoft.Azure.Management.Monitor.Models;

namespace AppForStorageMetrics
{
    class Program
    {
        private static MonitorClient readOnlyClient;

        public static void Main(string[] args)
        {

            string resourceGroupName = "";
            string subscriptionID = "";
            string storageAccountName = "";
            string resourceID = "/subscriptions/" + subscriptionID + "/resourceGroups/" + resourceGroupName + "/providers/Microsoft.Storage/storageAccounts/" + storageAccountName;

            Console.WriteLine("Resource ID: " + resourceID);

            string tenantID = "";
            string applicationID = "";
            string accessKey = "";

            readOnlyClient = AuthenticateWithReadOnlyClient(tenantID, applicationID, accessKey, subscriptionID).Result;
            
            GetMetricDefinitions(resourceID).Wait();
        }

        private static async Task<MonitorClient> AuthenticateWithReadOnlyClient(string tenantId, string clientId, string secret, string subscriptionId)
        {

            // Build the service credentials and Monitor client
            var serviceCreds = await ApplicationTokenProvider.LoginSilentAsync(tenantId, clientId, secret);
            var monitorClient = new MonitorClient(serviceCreds);
            monitorClient.SubscriptionId = subscriptionId;

            return monitorClient;
        }

        private static async Task GetMetricDefinitions(string resourceURI)
        {
            IEnumerable<MetricDefinition> metricDefinitions = await readOnlyClient.MetricDefinitions.ListAsync(resourceUri: resourceURI, cancellationToken: new CancellationToken());
            Console.WriteLine("Metric Definitions: ");
            foreach (MetricDefinition metricDef in metricDefinitions)
            {
                Console.WriteLine(metricDef.Name.Value);
            }
        }

    }
}
