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
            string connection = args[0];
            string container = args[1];
            
            CloudStorageAccount account = CloudStorageAccount.Parse(connection);
            CloudBlobClient blobClient = account.CreateCloudBlobClient();
            Console.WriteLine("Running");

            UploadBlobAsync(blobClient, container).Wait();
            DownloadBlobAsync(blobClient, container).Wait();
        }
                     
        static async Task UploadBlobAsync(CloudBlobClient client, string container)
        {
            byte[] data = new UnicodeEncoding().GetBytes("dummy data");
            CloudBlobContainer blobContainer = client.GetContainerReference(container);
            
            for (int numiterations = 0; numiterations < 100; numiterations++)
            {
                CloudBlockBlob blockBlob = blobContainer.GetBlockBlobReference($"testblob{numiterations}.dat");
                Console.WriteLine($"Uploading blob {numiterations}");
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

            for (int numiterations = 0; numiterations < 100; numiterations++)
            {
                CloudBlockBlob blockBlob = blobContainer.GetBlockBlobReference($"testblob{numiterations}.dat");
                Console.WriteLine($"Downloading blob {numiterations}");
                using (MemoryStream stream = new MemoryStream(100000))
                {
                    await blockBlob.DownloadToStreamAsync(stream);
                }
            }
        }
    }
}
