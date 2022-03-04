using System;
using System.IO;
using Azure;
using Azure.Data.Tables;
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
            string tableConnectionString = configuration.GetConnectionString("LensesDatabase");
            TableClient tableClient = new TableClient(tableConnectionString, "lensestable");

            // Find out what the user wants to do.
            if (args[0] == "PopulateTable")
            {
                // Create and populate the table
                Console.WriteLine("Creating the Lenses table...");
                tableClient.CreateIfNotExists();
                Console.WriteLine("Table created. Populating...");
                insertEntity(tableClient, new Lens() { LensType = "Prime", PartNumber = "X5018", FocalLength = "50mm", Aperture = "f1.8" } ); 
                insertEntity(tableClient, new Lens() { LensType = "Zoom", PartNumber = "X357035", FocalLength = "35-70mm", Aperture = "f3.5" } ); 
                insertEntity(tableClient, new Lens() { LensType = "Macro", PartNumber = "X10028", FocalLength = "100mm", Aperture = "f2.8" }); 
                Console.WriteLine("Tables created and populated.");
                return;
            }
            else if (args[0] == "DisplayTable")
            {
                // Read the table and display it here.
                Console.WriteLine("Reading the contents of the Lenses table...");
                Console.WriteLine("| {0, 10} | {1, 30} | {2, 10} | {3, 10} |", "Lens Type", "Part Number", "Focal Length", "Aperture");

                Pageable<TableEntity> results = tableClient.Query<TableEntity>();
                foreach (TableEntity entity in results)
                {
                    string lensType = entity.PartitionKey;
                    string partNumber = entity.RowKey;
                    object focalLength = entity["FocalLength"];
                    object aperture = entity["Aperture"];
                    
                    Console.WriteLine("| {0, 10} | {1, 30} | {2, 10} | {3, 10} |", lensType, partNumber, focalLength, aperture);
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
                Lens newLens = new Lens() { LensType = args[1], PartNumber = args[2], FocalLength = args[3], Aperture = args[4] };
                Console.WriteLine("Adding your {0} lens...", newLens.FocalLength);
                insertEntity(tableClient, newLens); 
                Console.WriteLine("Lens added.");
                return;
            }

        }

        private static void insertEntity(TableClient tableClient, Lens lens)
        {
            // Map the Lens object to a TableEntity to insert it
            TableEntity entity = new TableEntity();
            entity.PartitionKey = lens.LensType;
            entity.RowKey = lens.PartNumber;
            entity["FocalLength"] = lens.FocalLength;
            entity["Aperture"] = lens.Aperture;

            // Add the entity
            tableClient.UpsertEntity(entity);
        }


    }

    public class Lens
    {
        public string LensType{ get; set; }
        public string PartNumber{ get; set; }
        public string Aperture{ get; set; }
        public string FocalLength{ get; set; }
    }
}
