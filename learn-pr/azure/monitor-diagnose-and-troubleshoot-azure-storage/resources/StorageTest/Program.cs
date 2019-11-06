using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using System;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace StorageTest
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length == 2)
            {
                try
                {
                    string connection = args[0];
                    string container = args[1];

                    CloudStorageAccount account = CloudStorageAccount.Parse(connection);
                    CloudBlobClient blobClient = account.CreateCloudBlobClient();
                    Console.WriteLine("Running");

                    UploadBlobAsync(blobClient, container).Wait();
                    DownloadBlobAsync(blobClient, container).Wait();
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error executing storage test. {ex.Message}");
                }
            }
            else
            {
                Console.WriteLine("Please provide two arguments.");
            }
        }
                     
        static async Task UploadBlobAsync(CloudBlobClient client, string container)
        {
            byte[] data = new UnicodeEncoding().GetBytes("dummy data");
            CloudBlobContainer blobContainer = client.GetContainerReference(container);
            
            for (int iterations = 0; iterations < 100; iterations++)
            {
                CloudBlockBlob blockBlob = blobContainer.GetBlockBlobReference($"testblob{iterations}.dat");
                Console.WriteLine($"Uploading blob {iterations}");
                using (MemoryStream stream = new MemoryStream())
                {
                    for (int i = 1; i < 100000; i++)
                    {
                        stream.Write(data, 0, data.Length);
                    }
                    stream.Position = 0;
                    await blockBlob.UploadFromStreamAsync(stream);
                }
            }
        }

        static async Task DownloadBlobAsync(CloudBlobClient client, string container)
        {
            CloudBlobContainer blobContainer = client.GetContainerReference(container);

            for (int iterations = 0; iterations < 100; iterations++)
            {
                CloudBlockBlob blockBlob = blobContainer.GetBlockBlobReference($"testblob{iterations}.dat");
                Console.WriteLine($"Downloading blob {iterations}");
                using (MemoryStream stream = new MemoryStream(100000))
                {
                    await blockBlob.DownloadToStreamAsync(stream);
                }
            }
        }
    }
}
