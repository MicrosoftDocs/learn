You can use the predefined skills in Azure Cognitive Search to greatly enrich an index by extracting additional information from the source data. However, there may be occasions when you have specific data extraction needs that cannot be met with the predefined skills and require some custom functionality. To support these scenarios, you can implement custom skills as web-hosted services that support the required interface for integration into a skillset.

In this exercise, you'll create a basic custom skill that counts the frequency of each word in a document (excluding *stopwords* like "the", "a", "and", etc.) and returns a list of the top 10 most frequent words.

> [!NOTE]
> The example used here is fairly simple, and designed to enable you to focus on understanding the concept of custom skills, the technique of using an Azure Function to implement a custom skill, and the required JSON schema. In a real-world scenario, your skill could include practically any custom logic.
>
> Commonly, custom skills are used to create "wrappers" around cognitive services for which there are no built-in skills. For example, you could use custom skills to encapsulate logic that:
>
> - Extracts information from digitized forms by using the **Form Recognizer** service.
> - Transcribes audio files to text by using the **Speech** service.
> - Determines the objects that appear in an image by using the **Custom Vision** service.

## Create an Azure Function

To implement your custom skill, you'll create an Azure Function in your preferred language.

:::zone pivot="csharp"

1. In Visual Studio Code, view the Azure Extensions tab (**&boxplus;**), and verify that the **Azure Functions** extension is installed. This extension enables you to create and deploy Azure Functions from Visual Studio Code.
2. On Azure tab (**&Delta;**), in the **Azure Functions** pane, create new Azure Function project (&#128194;) with the following settings:
    - **Folder**: Browse to the **02-Create an enrichment pipeline/C-Sharp/custom-skill** folder
    - **Language**: C#
    - **Template**: HTTP trigger
    - **Function name**: wordcount
    - **Namespace**: margies.search
    - **Authorization level**: Function

    *If you are prompted to overwrite **launch.json**, do so!*

3. Switch back to the **Explorer** (**&#128461;**) tab and verify that the **02-Create an enrichment pipeline/C-Sharp/custom-skill** folder now contains the code files for your Azure Function.
4. Open the **wordcount.cs** file if it is not already open, and replace its entire contents with the following code:

    ```C#
    using System.IO;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Azure.WebJobs;
    using Microsoft.Azure.WebJobs.Extensions.Http;
    using Microsoft.AspNetCore.Http;
    using Newtonsoft.Json;
    using System.Collections.Generic;
    using Microsoft.Extensions.Logging;
    using System.Text.RegularExpressions;
    using System.Linq;

    namespace margies.search
    {
        public static class wordcount
        {

            //define classes for responses
            private class WebApiResponseError
            {
                public string message { get; set; }
            }

            private class WebApiResponseWarning
            {
                public string message { get; set; }
            }

            private class WebApiResponseRecord
            {
                public string recordId { get; set; }
                public Dictionary<string, object> data { get; set; }
                public List<WebApiResponseError> errors { get; set; }
                public List<WebApiResponseWarning> warnings { get; set; }
            }

            private class WebApiEnricherResponse
            {
                public List<WebApiResponseRecord> values { get; set; }
            }

            //function for custom skill
            [FunctionName("wordcount")]
            public static IActionResult Run(
                [HttpTrigger(AuthorizationLevel.Function, "post", Route = null)]HttpRequest req, ILogger log)
            {
                log.LogInformation("Function initiated.");

                string recordId = null;
                string originalText = null;

                string requestBody = new StreamReader(req.Body).ReadToEnd();
                dynamic data = JsonConvert.DeserializeObject(requestBody);

                // Validation
                if (data?.values == null)
                {
                    return new BadRequestObjectResult(" Could not find values array");
                }
                if (data?.values.HasValues == false || data?.values.First.HasValues == false)
                {
                    return new BadRequestObjectResult("Could not find valid records in values array");
                }

                WebApiEnricherResponse response = new WebApiEnricherResponse();
                response.values = new List<WebApiResponseRecord>();
                foreach (var record in data?.values)
                {
                    recordId = record.recordId?.Value as string;
                    originalText = record.data?.text?.Value as string;

                    if (recordId == null)
                    {
                        return new BadRequestObjectResult("recordId cannot be null");
                    }

                    // Put together response.
                    WebApiResponseRecord responseRecord = new WebApiResponseRecord();
                    responseRecord.data = new Dictionary<string, object>();
                    responseRecord.recordId = recordId;
                    responseRecord.data.Add("text", Count(originalText));

                    response.values.Add(responseRecord);
                }

                return (ActionResult)new OkObjectResult(response); 
            }


                public static string RemoveHtmlTags(string html)
            {
                string htmlRemoved = Regex.Replace(html, @"<script[^>]*>[\s\S]*?</script>|<[^>]+>| ", " ").Trim();
                string normalised = Regex.Replace(htmlRemoved, @"\s{2,}", " ");
                return normalised;
            }

            public static List<string> Count(string text)
            {
                
                //remove html elements
                text=text.ToLowerInvariant();
                string html = RemoveHtmlTags(text);
                
                //split into list of words
                List<string> list = html.Split(" ").ToList();
                
                //remove any non alphabet characters
                var onlyAlphabetRegEx = new Regex(@"^[A-z]+$");
                list = list.Where(f => onlyAlphabetRegEx.IsMatch(f)).ToList();

                //remove stop words
                string[] stopwords = { "", "i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", 
                        "you're", "you've", "you'll", "you'd", "your", "yours", "yourself", 
                        "yourselves", "he", "him", "his", "himself", "she", "she's", "her", 
                        "hers", "herself", "it", "it's", "its", "itself", "they", "them", 
                        "their", "theirs", "themselves", "what", "which", "who", "whom", 
                        "this", "that", "that'll", "these", "those", "am", "is", "are", "was",
                        "were", "be", "been", "being", "have", "has", "had", "having", "do", 
                        "does", "did", "doing", "a", "an", "the", "and", "but", "if", "or", 
                        "because", "as", "until", "while", "of", "at", "by", "for", "with", 
                        "about", "against", "between", "into", "through", "during", "before", 
                        "after", "above", "below", "to", "from", "up", "down", "in", "out", 
                        "on", "off", "over", "under", "again", "further", "then", "once", "here", 
                        "there", "when", "where", "why", "how", "all", "any", "both", "each", 
                        "few", "more", "most", "other", "some", "such", "no", "nor", "not", 
                        "only", "own", "same", "so", "than", "too", "very", "s", "t", "can", 
                        "will", "just", "don", "don't", "should", "should've", "now", "d", "ll",
                        "m", "o", "re", "ve", "y", "ain", "aren", "aren't", "couldn", "couldn't", 
                        "didn", "didn't", "doesn", "doesn't", "hadn", "hadn't", "hasn", "hasn't", 
                        "haven", "haven't", "isn", "isn't", "ma", "mightn", "mightn't", "mustn", 
                        "mustn't", "needn", "needn't", "shan", "shan't", "shouldn", "shouldn't", "wasn", 
                        "wasn't", "weren", "weren't", "won", "won't", "wouldn", "wouldn't"}; 
                list = list.Where(x => x.Length > 2).Where(x => !stopwords.Contains(x)).ToList();
                
                //get distict words by key and count, and then order by count.
                var keywords = list.GroupBy(x => x).OrderByDescending(x => x.Count());
                var klist = keywords.ToList();

                // return the top 10 words
                var numofWords = 10;
                if(klist.Count<10)
                    numofWords=klist.Count;
                List<string> resList = new List<string>();
                for (int i = 0; i < numofWords; i++)
                {
                    resList.Add(klist[i].Key);
                }
                return resList;
            }
        }
    }
    ```

5. Right-click (Ctrl+click on a Mac) the **custom-skill** folder and select **Deploy to Function App**. Then deploy the function with the following settings:
    - **Subscription** (if prompted): Select your Azure subscription.
    - **Function**: Create a new Function App in Azure (Advanced)
    - **Function App Name**: Enter a globally unique name.
    - **Runtime**: .NET Core 3.1
    - **OS**: Linux
    - **Hosting plane**: Consumption
    - **Resource group**: Select the existing resource group containing your Cognitive Search, Storage, and Cognitive Services resources (its name will be similar to *rg1234abcd5678efgh*).
    - **Storage account**: Select your existing storage account (its name will be similar to *store1234abcd5678efgh*).
    - **Application Insights**: Skip for now

    *Visual Studio Code will deploy the compiled version of the function (in the **bin** subfolder) based on the configuration settings in the **.vscode** folder that were saved when you created the function project.*

6. Wait for your function app to be created. You can view the **Output Window** to monitor its status.
7. Open the [Azure portal](https://portal.azure.com), and browse to the resource group where you created the function app. Then open the app service for your function app.
8. In the blade for your app service, on the **Functions** page, open the **wordcount** function.
9. On the **wordcount** function blade, view the **Code + Test** page and open the **Test/Run** pane.
10. In the **Test/Run** pane, replace the existing **Body** with the following JSON, which reflects the schema expected by an Azure Cognitive Search skill in which records containing data for one or more documents are submitted for processing:

    ```json
    {
        "values": [
            {
                "recordId": "a1",
                "data":
                {
                "text":  "Tiger, tiger burning bright in the darkness of the night.",
                "language": "en"
                }
            },
            {
                "recordId": "a2",
                "data":
                {
                "text":  "The rain in spain stays mainly in the plains! That's where you'll find the rain!",
                "language": "en"
                }
            }
        ]
    }
    ```

11. Click **Run** and view the HTTP response content that is returned by your function. This reflects the schema expected by Azure Cognitive Search when consuming a skill, in which a response for each document is returned. In this case, the response consists of up to 10 terms in each document in descending order of how frequently they appear:

    ```text
    {
    "values": [
        {
        "recordId": "a1",
        "data": {
            "text": [
            "tiger",
            "burning",
            "bright",
            "darkness",
            "night"
            ]
        },
        "errors": null,
        "warnings": null
        },
        {
        "recordId": "a2",
        "data": {
            "text": [
            "rain",
            "spain",
            "stays",
            "mainly",
            "plains",
            "thats",
            "youll",
            "find"
            ]
        },
        "errors": null,
        "warnings": null
        }
    ]
    }
    ```
12. Close the **Test/Run** pane and in the **wordcount** function blade, click **Get function URL**. Then copy the URL for the default key to the clipboard. You'll need this in the next unit.

:::zone-end

:::zone pivot="python"

1. In Visual Studio Code, view the Azure Extensions tab (**&boxplus;**), and verify that the **Azure Functions** extension is installed. This extension enables you to create and deploy Azure Functions from Visual Studio Code.
2. On Azure tab (**&Delta;**), in the **Azure Functions** pane, create new Azure Function project (&#128194;) with the following settings:
    - **Folder**: Browse to the **02-Create an enrichment pipeline/Python/custom-skill** folder
    - **Language**: Python
    - **Virtual environment**: Skip virtual environment
    - **Template**: HTTP trigger
    - **Function name**: wordcount
    - **Authorization level**: Function

    *If you are prompted to overwrite **launch.json**, do so!*

3. Switch back to the **Explorer** (**&#128461;**) tab and verify that the **02-Create an enrichment pipeline/Python/custom-skill** folder now contains the code files for your Azure Function.
4. Open the **\_\_init\_\_&#46;py** file if it is not already open, and replace its entire contents with the following code:

    ```Python
    import logging
    import os
    import sys
    import json
    from string import punctuation
    from collections import Counter
    import azure.functions as func


    def main(req: func.HttpRequest) -> func.HttpResponse:
        logging.info('Wordcount function initiated.')

        # The result will be a "values" bag
        result = {
            "values": []
        }
        statuscode = 200

        # We're going to exclude words from this list in the word counts
        stopwords = ['', 'i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', 
                    "you're", "you've", "you'll", "you'd", 'your', 'yours', 'yourself', 
                    'yourselves', 'he', 'him', 'his', 'himself', 'she', "she's", 'her', 
                    'hers', 'herself', 'it', "it's", 'its', 'itself', 'they', 'them', 
                    'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 
                    'this', 'that', "that'll", 'these', 'those', 'am', 'is', 'are', 'was',
                    'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 
                    'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or', 
                    'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 
                    'about', 'against', 'between', 'into', 'through', 'during', 'before', 
                    'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 
                    'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 
                    'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 
                    'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 
                    'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 
                    'will', 'just', 'don', "don't", 'should', "should've", 'now', 'd', 'll',
                    'm', 'o', 're', 've', 'y', 'ain', 'aren', "aren't", 'couldn', "couldn't", 
                    'didn', "didn't", 'doesn', "doesn't", 'hadn', "hadn't", 'hasn', "hasn't", 
                    'haven', "haven't", 'isn', "isn't", 'ma', 'mightn', "mightn't", 'mustn', 
                    "mustn't", 'needn', "needn't", 'shan', "shan't", 'shouldn', "shouldn't", 'wasn', 
                    "wasn't", 'weren', "weren't", 'won', "won't", 'wouldn', "wouldn't"]

        try:
            values = req.get_json().get('values')
            logging.info(values)

            for rec in values:
                # Construct the basic JSON response for this record
                val = {
                        "recordId": rec['recordId'],
                        "data": {
                            "text":None
                        },
                        "errors": None,
                        "warnings": None
                    }
                try:
                    # get the text to be processed from the input record
                    txt = rec['data']['text']
                    # remove numeric digits
                    txt = ''.join(c for c in txt if not c.isdigit())
                    # remove punctuation and make lower case
                    txt = ''.join(c for c in txt if c not in punctuation).lower()
                    # remove stopwords
                    txt = ' '.join(w for w in txt.split() if w not in stopwords)
                    # Count the words and get the most common 10
                    wordcount = Counter(txt.split()).most_common(10)
                    words = [w[0] for w in wordcount]
                    # Add the top 10 words to the output for this text record
                    val["data"]["text"] = words
                except:
                    # An error occured for this text record, so add lists of errors and warning
                    val["errors"] =[{"message": "An error occurred processing the text."}]
                    val["warnings"] = [{"message": "One or more inputs failed to process."}]
                finally:
                    # Add the value for this record to the response
                    result["values"].append(val)
        except Exception as ex:
            statuscode = 500
            # A global error occurred, so return an error response
            val = {
                    "recordId": None,
                    "data": {
                        "text":None
                    },
                    "errors": [{"message": ex.args}],
                    "warnings": [{"message": "The request failed to process."}]
                }
            result["values"].append(val)
        finally:
            # Return the response
            return func.HttpResponse(body=json.dumps(result), mimetype="application/json", status_code=statuscode)
    ```

5. After the page has refreshed, right-click (Ctrl+click on a Mac) the **custom-skill** folder and select **Deploy to Function App**. Then deploy the function with the following settings:
    - **Subscription** (if prompted): Select your Azure subscription.
    - **Function**: Create a new Function App in Azure (Advanced)
    - **Function App Name**: Enter a globally unique name.
    - **Runtime**: Python 3.7
    - **Hosting plane**: Consumption
    - **Resource group**: Select the existing resource group containing your Cognitive Search, Storage, and Cognitive Services resources (its name will be similar to *rg1234abcd5678efgh*).
    - **Storage account**: Select your existing storage account (its name will be similar to *store1234abcd5678efgh*).
    - **Application Insights**: Skip for now
6. Wait for your function app to be created. You can view the **Output Window** to monitor its status.
7. Open the [Azure portal](https://portal.azure.com), and browse to the resource group where you created the function app. Then open the app service for your function app.
8. In the blade for your app service, on the **Functions** page, open the **wordcount** function.
9. On the **wordcount** function blade, view the **Code + Test** page and open the **Test/Run** pane.
10. In the **Test/Run** pane, replace the existing **Body** with the following JSON, which reflects the schema expected by an Azure Cognitive Search skill in which records containing data for one or more documents are submitted for processing:

    ```json
    {
        "values": [
            {
                "recordId": "a1",
                "data":
                {
                "text":  "Tiger, tiger burning bright in the darkness of the night.",
                "language": "en"
                }
            },
            {
                "recordId": "a2",
                "data":
                {
                "text":  "The rain in spain stays mainly in the plains! That's where you'll find the rain!",
                "language": "en"
                }
            }
        ]
    }
    ```

11. Click **Run** and view the HTTP response content that is returned by your function. This reflects the schema expected by Azure Cognitive Search when consuming a skill, in which a response for each document is returned. In this case, the response consists of up to 10 terms in each document in descending order of how frequently they appear:

    ```text
    {
    "values": [
        {
        "recordId": "a1",
        "data": {
            "text": [
            "tiger",
            "burning",
            "bright",
            "darkness",
            "night"
            ]
        },
        "errors": null,
        "warnings": null
        },
        {
        "recordId": "a2",
        "data": {
            "text": [
            "rain",
            "spain",
            "stays",
            "mainly",
            "plains",
            "thats",
            "youll",
            "find"
            ]
        },
        "errors": null,
        "warnings": null
        }
    ]
    }
    ```
12. Close the **Test/Run** pane and in the **wordcount** function blade, click **Get function URL**. Then copy the URL for the default key to the clipboard. You'll need this in the next unit.

:::zone-end

> [!NOTE]
> To learn more about implementing custom skills for an Azure Cognitive Search enrichment pipeline, see [How to add a custom skill to an Azure Cognitive Search enrichment pipeline](https://docs.microsoft.com/azure/search/cognitive-search-custom-skill-interface) in the Azure Cognitive Search documentation.
