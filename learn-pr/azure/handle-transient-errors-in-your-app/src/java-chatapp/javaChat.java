import org.bson.Document;
import org.bson.types.ObjectId;
import com.mongodb.*;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.MongoClientSettings;
import com.mongodb.ConnectionString;
import com.mongodb.ServerAddress;
import com.mongodb.MongoCredential;
import com.mongodb.MongoClientOptions;
import java.util.Scanner;
import java.util.function.Consumer;
import java.io.*;
import java.util.Arrays;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * javaChat
 */
public class javaChat {

    /*
    * Replace connection string from the Azure Cosmos DB Portal
    */
    private static ConnectionString connectionString = 
        new ConnectionString("Enter MongoDB String here");
    private static String dbName = "chat-app";
    private static String colName = "messages"; 

    public static void main(String[] args) throws FileNotFoundException, IOException, InterruptedException {


        Logger mongoLogger = Logger.getLogger( "org.mongodb.driver" );
        mongoLogger.setLevel(Level.SEVERE); 

        MongoClientSettings settings = MongoClientSettings.builder()
                .applyConnectionString(connectionString)
                .build();
    
        MongoClient mongoClient = MongoClients.create(settings);

        try {
            // Connect to the database      
            MongoDatabase database = mongoClient.getDatabase(dbName);
            MongoCollection<Document> collection = database.getCollection(colName);

            System.out.println("\n\n Team Chat with Java");
            System.out.println("====================");
            System.out.println("=  Message Board   =");
            System.out.println("====================\n");
            printAllMessages(collection);            
            
            char option;
            while (true) {

                System.out.print("\n(N)ew message, (R)ead all messages, or (Q)uit: ");
                option = (char) System.in.read();

                switch(option) {
                    case 'Q' :
                    case 'q' :
                        System.out.println("Exiting...");
                        return;
                    
                    case 'N' :
                    case 'n' :
                        System.out.print("Name: ");
                        String name = System.console().readLine();
                        System.out.print("Message: ");
                        String message = System.console().readLine();  

                        Document document = new Document("name", name)
                            .append("message", message);
                        collection.insertOne(document);
                        break; 

                    case 'R' :
                    case 'r' : 
                        printAllMessages(collection);
                        break;
                 }
            }
        } 
        catch(IOException e) {
            e.printStackTrace();
        }
        finally {
        	if (mongoClient != null) {
        		mongoClient.close();
        	}
        }
    }

    private static void printAllMessages (MongoCollection<Document> collection)
    {
        // Return all messages
        collection.find().forEach((Consumer<Document>) document -> {
            System.out.printf("%s: %s\n", document.get("name"), document.get("message"));
        });
    }

    private static void diagnose(Exception e)
    {
        System.out.printf("Exception raised: %s\n\n", e.toString());
        e.printStackTrace();
    }
}

// Build with: javac -cp .:lib/* javaChat.java
// Exceute the app in shell with: java -cp .:lib/* learn.javachatapp.javaChat

/* Transient errors to handle

    com.mongodb.MongoCommandException
    com.mongodb.MongoSecurityException
*/