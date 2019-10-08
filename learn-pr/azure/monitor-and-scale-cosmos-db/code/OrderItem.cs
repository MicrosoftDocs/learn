using System;
using System.Configuration;

namespace MsLearnCosmosDB
{
    public class OrderItem
    {
        public Guid id { get; set;}
        public string Title { get; set; }
        public string Category { get; set; }
        public string UPC { get; set; }
        public string Website { get; set; }
        public DateTime ReleaseDate { get; set; }
        public string Condition { get; set; }
        public string Merchant { get; set; }
        public double ListPricePerItem { get; set; }
        public double PurchasePrice { get; set; }
        public string Currency { get; set; }
        public static string[] Categories =
        {
              "Books",
              "Electronics",
              "Cosmetics",
              "Tools",
              "Kitchenware",
              "Office Supplies",
              "Whiteware"
        };
        public static float[] CategoryWeights = { 0.7F, 0.05F, 0.05F, 0.05F, 0.05F, 0.05F, 0.05F };
        static OrderItem[] Items;
        static Random RandomIndex = new Random();

        /// <summary>
        /// Allocate this instance.
        /// </summary>
        public static void Allocate(int numItems)
        {
            Items = new OrderItem[numItems];
            for (int i = 0; i < numItems; i++)
            {
                Items[i] = NewItem();
            }
        }

        public static OrderItem NewItem()
        {
            Bogus.Faker<OrderItem> itemGenerator = new Bogus.Faker<OrderItem>().Rules(
            (faker, item) =>
            {
                item.id = faker.Random.Guid();
                item.Title = faker.Random.AlphaNumeric(15);
                item.Category = faker.Random.WeightedRandom(Categories, CategoryWeights);
                item.Merchant = faker.Random.Word();
                item.UPC = faker.Random.Replace("##:####:###");
                item.Website = faker.Random.Replace("https://???.???????.com").ToLower();

                item.ReleaseDate = DateTime.Now;
                item.Condition = "NEW";
                item.ListPricePerItem = Math.Round((faker.Random.Double() * 100),2);
                item.PurchasePrice = Math.Round(item.ListPricePerItem * faker.Random.Double(0.8),2);
                item.Currency = "USD";
            });

            return itemGenerator.Generate();
        }

        public static OrderItem GetRandomItem()
        {
            // Assumes that customers are being allocated in a single thread.
            return Items[RandomIndex.Next(0, Items.Length)];
        }


    }
}