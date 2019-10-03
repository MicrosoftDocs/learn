using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Analytics;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Shared.Protocol;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace StorageAnalytics
{
    class Program
    {
        static void Main(string[] args)
        {
            StorageUri blobStorageUri = new StorageUri(new Uri($"https://{args[0]}.blob.core.windows.net"));
            StorageUri tableStorageUri = new StorageUri(new Uri($"https://{args[0]}.table.core.windows.net"));
            StorageCredentials credentials = new StorageCredentials(args[0], args[1]);
            CloudAnalyticsClient client = new CloudAnalyticsClient(blobStorageUri, tableStorageUri, credentials);

            PrintMinuteMetrics(client);
        }

        private static void PrintMinuteMetrics(CloudAnalyticsClient analyticsClient)
        {
            var services = Enum.GetValues(typeof(StorageService));
            foreach (StorageService service in services)
            {
                Console.WriteLine($"Minute Metrics for Service {service}");
                var metricsQuery = analyticsClient.CreateMinuteMetricsQuery(service, StorageLocation.Primary);
                var t = analyticsClient.GetMinuteMetricsTable(service);
                var opContext = new OperationContext();
                var query =
                        from entity in metricsQuery
                        select entity;

                var results = query.ToList().Where(m => m.RowKey.StartsWith("user"));
                var resultString = results.Aggregate(new StringBuilder(), (builder, metrics) => builder.AppendLine(MetricsString(metrics, opContext))).ToString();
                Console.WriteLine($"{resultString}");
            }
        }

        private static string MetricsString(MetricsEntity entity, OperationContext opContext)
        {
            var entityProperties = entity.WriteEntity(opContext);
            var entityString =
                    string.Format("Time: {0}, ", entity.Time) +
                    string.Format("AccessType: {0}, ", entity.AccessType) +
                    string.Format("TransactionType: {0}, ", entity.TransactionType) +
                    string.Join(",", entityProperties.Select(e => new KeyValuePair<string, string>(e.Key.ToString(), e.Value.PropertyAsObject.ToString())));
            return entityString;
        }
    }
}
