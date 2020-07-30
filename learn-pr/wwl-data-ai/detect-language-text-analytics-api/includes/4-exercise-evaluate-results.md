The previous exercises have shown how to prepare text that will be sent to the Text Analytics service for language detection and how to call the service to extract the information.  The code samples have taken the values from the response and output them to the terminal or console window.  What if you want to make use of the response information for some other purpose, rather than just output to the terminal?

Regardless of the programming language you use, the response is returned in JSON format.  As such, it can be parsed by your code using the appropriate JSON parser, and then used in your application for your own needs.  The returned JSON format contains an array of documents, within which you will find an array of key phrases that were detected.  A sample response JSON file is included here.

```json
{
  "documents": [
    {
      "id": "1",
      "detectedLanguages": [
        {
          "name": "English",
          "iso6391Name": "en",
          "score": 1
        }
      ]
    },
    {
      "id": "2",
      "detectedLanguages": [
        {
          "name": "French",
          "iso6391Name": "fr",
          "score": 1
        }
      ]
    },
    {
      "id": "3",
      "detectedLanguages": [
        {
          "name": "Spanish",
          "iso6391Name": "es",
          "score": 1
        }
      ]
    },
    {
      "id": "4",
      "detectedLanguages": [
        {
          "name": "(Unknown)",
          "iso6391Name": "(Unknown)",
          "score": 0
        }
      ]
    }
  ],
  "errors": []
}
```

In this response, there are four documents items in the **documents** array.  They are identified by an ID value.  This ID value is used to map the results that are returned, to the appropriate text entry in the JSON that was submitted.  For example, the first text document in the JSON that was sent to the service for evaluation is shown here.

```json
{
  "documents": [
    {
      "countryHint": "US",
      "id": "1",
      "text": "Hello world"
    },
    {
      "countryHint": "US",
      "id": "2",
      "text": "Bonjour tout le monde"
    },
    {
      "countryHint": "US",
      "id": "3",
      "text": "La carretera estaba atascada. Había mucho tráfico el día de ayer."
    },
    {
      "countryHint": "US",
      "id": "4",
      "text": ":) :( :D"
    }
  ]
}
```

Within each document in the array, there is a country hint, an ID, and some text.  Comparing the IDs to the resulting JSON above, you can identify the detected language using the ID values.  Also note that the last entry does not contain "readable" text.  As such, the returned language value is listed as *unknown*.  Monitor for these results in your code and handle them accordingly.

There are various options for gaining access to the information in the results that are returned, depending on the programming language you are using.  Python and C# do a great job of providing functionality to access contents of a JSON file as demonstrated in the exercise on structuring and submitting the request.

If you decide that you need different access to the JSON contents, or that you need to work in an object-oriented way, you can create class files that represent the JSON content and access the information through the object property methodology.  Visual Studio has an option to generate a class file from JSON content and there are various "JSON to Class" options online as well.  In Visual Studio 2017 or Visual Studio 2019, select the **Edit** menu and choose **Paste Special**, the **Paste JSON as Classes**.

![Edit, Paste Special, Paste JSON as Classes menu option in Visual Studio](../media/create-json-class.png)

An example of a generated class from JSON is shown here with the JSON document posted first and the C# class files following the JSON. Python has some built-in aspects that make handling JSON fairly easy so we don't show a Python object in this example.

### JSON file

```json
{
  "documents": [
    {
      "id": "1",
      "detectedLanguages": [
        {
          "name": "English",
          "iso6391Name": "en",
          "score": 1
        }
      ]
    },
    {
      "id": "2",
      "detectedLanguages": [
        {
          "name": "French",
          "iso6391Name": "fr",
          "score": 1
        }
      ]
    },
    {
      "id": "3",
      "detectedLanguages": [
        {
          "name": "Spanish",
          "iso6391Name": "es",
          "score": 1
        }
      ]
    },
    {
      "id": "4",
      "detectedLanguages": [
        {
          "name": "(Unknown)",
          "iso6391Name": "(Unknown)",
          "score": 0
        }
      ]
    }
  ],
  "errors": []
}
```

### C# class file

```csharp
    public class DetectedLanguage
    {
        public string name { get; set; }
        public string iso6391Name { get; set; }
        public int score { get; set; }
    }

    public class Document
    {
        public string id { get; set; }
        public IList<DetectedLanguage> detectedLanguages { get; set; }
    }

    public class Example
    {
        public IList<Document> documents { get; set; }
        public IList<object> errors { get; set; }
    }
```

With the class files created, you can write your code in a way that takes advantage of object-oriented programming techniques in your applications.
