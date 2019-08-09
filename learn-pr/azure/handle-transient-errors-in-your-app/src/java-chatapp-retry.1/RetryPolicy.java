package learn.javachatapp;

import java.io.*;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

/**
 * RetryPolicy
 */
public class RetryPolicy
{
    private int currentTries = 0;
    public Properties props = new Properties();

    public RetryPolicy() throws java.io.FileNotFoundException, java.io.IOException {
        File configFile = new File("config.properties");
        FileReader reader = new FileReader(configFile);
        props.load(reader);
        reader.close();
    }

    public boolean canRetry() throws InterruptedException {
        // Keep track of current retries
        currentTries++;
        System.out.printf("Retrying: %s\n", currentTries);

        // Use a delay if this isn't the first try
        if (currentTries != 1)
        {
            TimeUnit.MINUTES.sleep(Integer.parseInt(props.getProperty("delay")));
        }

        if (currentTries < Integer.parseInt(props.getProperty("number_of_retries"))) {
            return true;
        } else {
            return false;
        }
    }

    public void resetRetries() {
        currentTries = 0;
    }
}