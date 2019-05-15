package learn.javachatapp;

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
        new ConnectionString("mongodb://azure-learn-mongo:WBqJkUXSYZwJEPZuckaLokaTD4bJR6L1CZaAjHBUAgbUzXcvmZvWs7w6LsOW6mSu8excGmX2fQT2oUadj0IDWw==@azure-learn-mongo.documents.azure.com:10255/?ssl=true&replicaSet=globaldb");
    private static String dbName = "chat-app";
    private static String colName = "messages"; 
    private static RetryPolicy retries;
    public static void main(String[] args) throws FileNotFoundException, IOException, InterruptedException {

        try{
            retries = new RetryPolicy();
        } catch(FileNotFoundException e) {
            e.printStackTrace();
        }

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
                retries.resetRetries();
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

    private static void printAllMessages (MongoCollection<Document> collection) throws InterruptedException {
        try {
            // Return all messages
            collection.find().forEach((Consumer<Document>) document -> {
                System.out.printf("%s: %s\n", document.get("name"), document.get("message"));
            });
        }
        catch (com.mongodb.MongoCommandException e) {
            if (retries.canRetry())
            {
                diagnose(e);
                printAllMessages(collection); //retry
            } else {
                System.out.println("Maximum retries - need to close.");
                throw e;
            }
        }
        catch (com.mongodb.MongoSecurityException e) {
            if (retries.canRetry())
            {
                diagnose(e);
                printAllMessages(collection); //retry
            } else {
                System.out.println("Maximum retries - need to close.");
                throw e;
            }
        }
        catch (Exception e) {
            diagnose(e);
            throw e;
        }
    }

    private static void diagnose(Exception e)
    {
        System.out.printf("Exception raised: %s\n\n", e.toString());
    }
}

// Build with: javac -cp .:lib/* -d . javaChat.java RetryPolicy.java
// Exceute the app in shell with: java -cp .:lib/* learn.javachatapp.javaChat

/* Transient errors to handle

    com.mongodb.MongoCommandException
    com.mongodb.MongoSecurityException
*/