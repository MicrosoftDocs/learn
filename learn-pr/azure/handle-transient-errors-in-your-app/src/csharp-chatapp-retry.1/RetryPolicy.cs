using System;
using Microsoft.Extensions.Configuration;
using System.Threading;
using System.Diagnostics;
using System.IO;


namespace csharp_chatapp_retry
{
    public class RetryPolicy
    {
        private int currentTries = 0;
        static public IConfiguration configuration { get; set; }

        /// <summary>
        /// Constructor - reads config for number of retries and delay
        /// </summary>
        public RetryPolicy()
        {
            ConfigurationBuilder configurationBuilder = new ConfigurationBuilder();
            configurationBuilder.SetBasePath(Directory.GetCurrentDirectory());
            configurationBuilder.AddJsonFile("appsettings.json");
            configuration = configurationBuilder.Build();
        }

        /// <summary>
        /// Method to implement retry policy controlled by configuration
        /// </summary>
        /// <returns>Returns true if it's ok to retry</returns>
        public bool canRetry()
        {
            // Keep track of current retries
            currentTries++;
            Console.WriteLine($"Retrying: {currentTries}");

            // Use a delay if this isn't the first try
            if (currentTries != 1)
            {
                Thread.Sleep(int.Parse(configuration["delay"]));
            }

            if (currentTries < int.Parse(configuration["number-of-retries"])) {
                return true;
            } else {
                return false;
            }
        }

        public void reset()
        {
            currentTries = 0;
        }
    }
}