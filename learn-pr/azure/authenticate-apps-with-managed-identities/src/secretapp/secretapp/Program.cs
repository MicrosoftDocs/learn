using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Azure.KeyVault;
using System;
using System.Threading.Tasks;

namespace secretapp
{
    class Program
    {
        static void Main(string[] args)
        {
            AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();
            GetSecretFromKeyVault(azureServiceTokenProvider).Wait();
        }

        private static async Task GetSecretFromKeyVault(AzureServiceTokenProvider azureServiceTokenProvider)
        {
            KeyVaultClient keyVaultClient =
                new KeyVaultClient(
                    new KeyVaultClient.AuthenticationCallback(azureServiceTokenProvider.KeyVaultTokenCallback));

            var keyVaultName = "<key vault name>";
            var keyVaultSecretName = "<secret name>";

            try
            {
                var secret = await keyVaultClient
                    .GetSecretAsync($"https://{keyVaultName}.vault.azure.net/secrets/{keyVaultSecretName}")
                    .ConfigureAwait(false);

                Console.WriteLine($"Secret: {secret.Value}");

            }
            catch (Exception exp)
            {
                Console.WriteLine($"Something went wrong: {exp.Message}");
            }
        }
    }
}
