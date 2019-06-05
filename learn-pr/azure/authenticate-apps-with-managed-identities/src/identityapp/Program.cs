using Microsoft.Azure.Management.ResourceManager;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Rest;
using System;
using System.Threading.Tasks;

namespace identityapp
{
    class Program
    {
        static void Main()
        {
            AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();
            GetResourceGroups(azureServiceTokenProvider).Wait();

            if (azureServiceTokenProvider.PrincipalUsed != null)
            {
                Console.WriteLine($"{Environment.NewLine}Principal used: {azureServiceTokenProvider.PrincipalUsed}");
            }
        }

        private static async Task GetResourceGroups(AzureServiceTokenProvider azureServiceTokenProvider)
        {
            Console.WriteLine($"{Environment.NewLine}{Environment.NewLine}Please enter the subscription Id");

            var subscriptionId = Console.ReadLine();

            try
            {
                var serviceCreds = new TokenCredentials(await azureServiceTokenProvider.GetAccessTokenAsync("https://management.azure.com/").ConfigureAwait(false));

                var resourceManagementClient =
                    new ResourceManagementClient(serviceCreds) { SubscriptionId = subscriptionId };

                var resourceGroups = await resourceManagementClient.ResourceGroups.ListAsync();

                foreach (var resourceGroup in resourceGroups)
                {
                    Console.WriteLine($"Resource group {resourceGroup.Name}");
                }

            }
            catch (Exception exp)
            {
                Console.WriteLine($"Something went wrong: {exp.Message}");
            }
        }
    }
}
