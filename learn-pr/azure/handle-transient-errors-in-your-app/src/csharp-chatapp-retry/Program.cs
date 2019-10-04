using System;
using System.Security.Authentication;
using MongoDB.Driver;
using MongoDB.Driver.Core;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson.Serialization.IdGenerators;
using System.Collections.Generic;

namespace csharp_chatapp_retry
{
    class Program
    {
        private static MongoClientSettings settings;
        private static MongoClient mongoClient;
        private static IMongoDatabase database;
        private static IMongoCollection<ChatMessage> messages;
        private static string databaseName = "chat-app";
        private static string collectionName = "messages";
        private static string connectionString = 
            @"mongodb://learn-cosmos-db-16625:frbBzXfK3Qyr4jQXKHNJxeTKdof2BIFX8EYE4mHhH21JQg0WNGz7Khwd8TLlItWwpnsHSSSxvUa7LtZkNe1Baw==@learn-cosmos-db-16625.documents.azure.com:10255/?ssl=true";

        private static List<ChatMessage> allMessages = new List<ChatMessage>();

        static void Main(string[] args)
        {
            // Setup database connection
            connectionString += "&connectTimeoutMS=5000&socketTimeoutMS=5000&ServerSelectionTimeoutMS=5000";
            settings = MongoClientSettings.FromUrl( new MongoUrl(connectionString) );
            settings.SslSettings = new SslSettings() { EnabledSslProtocols = SslProtocols.Tls12 };

            // Errors connecting wont happen here
            mongoClient = new MongoClient(settings);
            database = mongoClient.GetDatabase(databaseName);

            Console.WriteLine("\n\nTeam Chat with .NET Core");
            Console.WriteLine("========================");
            Console.WriteLine("=     Message Board    =");
            Console.WriteLine("========================\n");

            getAllChats();

            Console.Write("(N)ew message, (R)ead all messages, or (Q)uit: ");
            char choice = Console.ReadKey().KeyChar;
            while(choice != 'Q' && choice != 'q')
            {
                Console.WriteLine();
                ChatMessage newChat = new ChatMessage();
                switch (choice)
                {
                    case 'N':
                    case 'n':
                        Console.Write("Enter name: ");
                        newChat.Name = Console.ReadLine();
                        Console.Write("Enter message: ");
                        newChat.Message = Console.ReadLine();
                        messages.InsertOne(newChat);
                        break;
                    case 'R':
                    case 'r':
                        getAllChats();
                        break;
                }
                Console.Write("(N)ew message, (R)ead all messages, or (Q)uit: ");
                choice = Console.ReadKey().KeyChar;
            }
        }

        private static void getAllChats()
        {
            messages = database.GetCollection<ChatMessage>(collectionName);
            try
            {
                allMessages = messages.Find(new BsonDocument()).ToList();
                foreach (ChatMessage chat in allMessages)
                {
                    Console.WriteLine($"{chat.Name}: {chat.Message}");
                }
                Console.WriteLine("\n");
            }
            catch (MongoDB.Driver.MongoConnectionException e)
            {
                diagnose(e);
            }
            catch (System.TimeoutException e)
            {
                diagnose(e);
            }
            catch (Exception e)
            {
                diagnose(e);
                throw e;
            }
        }

        private static void diagnose(Exception e)
        {
            Console.WriteLine($"Exception raised: {e.GetType()}\n");
        }
    }

    public class ChatMessage
    {
        [BsonElement("_id")]
        public ObjectId Id { get; set; }

        [BsonElement("name")]
        public string Name { get; set; }

        [BsonElement("message")]
        public string Message { get; set; }

        [BsonElement("__v")]
        public int Version { get; set; }
    }
}

/* Transient errors to handle

    MongoDB.Driver.MongoAuthenticationException
    MongoDB.Driver.MongoConnectionException
    Timeout issues System.TimeoutException
    System.Net.Sockets.SocketException

 */