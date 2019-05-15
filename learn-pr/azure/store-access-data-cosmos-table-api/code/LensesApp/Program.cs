using System;
using System.IO;
using Microsoft.Azure.Cosmos.Table;
using Microsoft.Extensions.Configuration;

namespace LensesApp
{
    class Program
    {
        static void Main(string[] args)
        {
            // Configure the app to use the appsettings.json file
            // That's where the connection string is
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
            IConfigurationRoot configuration = builder.Build();

            // Check the syntax
            if (args.Length < 1)
            {
                System.Console.WriteLine("Usage: LensesApp <Operation>");
                return;
            }

            Console.WriteLine(args[0]);

            // Connect to the service, using the connection string in the appsettings.json file
            CloudStorageAccount storageAccount = CloudStorageAccount.Parse(configuration.GetConnectionString("LensesDatabase"));
            CloudTableClient tableClient = storageAccount.CreateCloudTableClient();
            CloudTable lensesTable = tableClient.GetTableReference("lensestable");

            // Find out what the user wants to do.
            if (args[0] == "PopulateTable")
            {
                // Create and populate the table
                Console.WriteLine("Creating the Lenses table...");
                lensesTable.CreateIfNotExists();
                Console.WriteLine("Table created. Populating...");
                insertEntity(lensesTable, "Prime", "X5018", "50mm", "f1.8"); 
                insertEntity(lensesTable, "Zoom", "X357035", "35-70mm", "f3.5"); 
                insertEntity(lensesTable, "Macro", "X10028", "100mm", "f2.8"); 
                Console.WriteLine("Tables created and populated.");
                return;
            }
            else if (args[0] == "DisplayTable")
            {
                // Read the table and display it here.
                Console.WriteLine("Reading the contents of the Lenses table...");
                TableQuery<LensEntity> allLensesQuery = new TableQuery<LensEntity>();
                Console.WriteLine("| {0, 10} | {1, 30} | {2, 10} | {3, 10} |", "Lens Type", "Part Number", "Focal Length", "Aperture");
                foreach (LensEntity lens in lensesTable.ExecuteQuery(allLensesQuery))
                {
                    Console.WriteLine("| {0, 10} | {1, 30} | {2, 10} | {3, 10} |", lens.LensType, lens.PartNumber, lens.FocalLength, lens.Aperture);
                }
                return;
            }
            else if (args[0] == "AddLens")
            {
                // Check the syntax.
                if (args.Length != 5)
                {
                    System.Console.WriteLine("Usage: LensesApp AddLens <LensType> <PartNumber> <FocalLength> <Aperture>");
                    return;
                }
                // Add a lens
                Console.WriteLine("Adding your {0} lens...", args[3]);
                insertEntity(lensesTable, args[1], args[2], args[3], args[4]); 
                Console.WriteLine("Lens added.");
                return;
            }

        }

        private static void insertEntity(CloudTable table, 
            string lensType, 
            string partNumber, 
            string focalLength, 
            string aperture)
        {
            // Create an entity and set properties
            LensEntity lens = new LensEntity(lensType, partNumber)
            {
                LensType = lensType,
                PartNumber = partNumber,
                FocalLength = focalLength,
                Aperture = aperture
            };
            // Add the entity
            TableOperation insertOrMerge = TableOperation.InsertOrMerge(lens);
            TableResult result = table.Execute(insertOrMerge);
        }


    }

    public class LensEntity : TableEntity
    {
        public LensEntity()
        {

        }

        public LensEntity(string lensType, string partNumber)
        {
            PartitionKey = lensType;
            LensType = lensType;
            RowKey = partNumber;
            PartNumber = partNumber;
        }

        public string LensType{ get; set; }
        public string PartNumber{ get; set; }
        public string Aperture{ get; set; }
        public string FocalLength{ get; set; }

    }
}
