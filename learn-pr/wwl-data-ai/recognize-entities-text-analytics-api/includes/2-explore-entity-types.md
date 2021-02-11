Many of the entity types that you encounter in this service, also come with a sub-type.  Not all entity types have a sub-type as they are typically used to clarify or further enhance the core type. The current supported list of entities and the classes (in version 2.1 of the API) is shown in Table 1. For those items with N/A, the sub-type may be omitted, depending on input and extracted entities.

**Table 1**

|Type|SubType|Example|
|---|---|---|
|Person|N/A|"Bill Gates", "John"|
|Location|N/A|"Paris", "New York"|
|Organization|N/A|"Microsoft"|
|Quantity|Number|"6" or "six"|
|Quantity|Percentage|"25%" or "fifty percent"|
|Quantity|Ordinal|"1st" or "first"|
|Quantity|Age|"90 days old" or "30 years old"|
|Quantity|Currency|"10.99"|
|Quantity|Dimension|"10 miles", "40 cm"|
|Quantity|Temperature|"45 degrees"|
|DateTime|N/A|"6:30PM February 4, 2012"|
|DateTime|Date|"May 2nd, 2017" or "05/02/2017"|
|DateTime|Time|"8am" or "8:00"|
|DateTime|DateRange|"May 2nd to May 5th"|
|DateTime|TimeRange|"6pm to 7pm"|
|DateTime|Duration|"1 minute and 45 seconds"|
|DateTime|Set|"every Tuesday"|
|URL|N/A|"https://www.bing.com"|
|Email|N/A|"support@microsoft.com"|
|US-based Phone Number|N/A|"(312) 555-0176"|
|IP Address|N/A|"10.0.1.125"|


## Example

A small example can help clarify some of these concepts.  Suppose you sent the following text to the service:

"I had a wonderful trip to Seattle last week."

The service would respond with the following JSON output:

```json

{
  "documents": [{
    "id": "1",
    "entities": [{
      "name": "Seattle",
      "matches": [{
        "wikipediaScore": 0.15046201222847677,
        "entityTypeScore": 0.80624294281005859,
        "text": "Seattle",
        "offset": 26,
        "length": 7
      }],
      "wikipediaLanguage": "en",
      "wikipediaId": "Seattle",
      "wikipediaUrl": "https://en.wikipedia.org/wiki/Seattle",
      "bingId": "5fbba6b8-85e1-4d41-9444-d9055436e473",
      "type": "Location"
    }, {
      "name": "last week",
      "matches": [{
        "entityTypeScore": 0.8,
        "text": "last week",
        "offset": 34,
        "length": 9
      }],
      "type": "DateTime",
      "subType": "DateRange"
    }]
  }],
  "errors": []
}

```

Some key takeaways from this JSON response. Seattle was identified as a location (type) a confidence score (entityTypeScore), and a link to Wikipedia for more information about Seattle.  It also identified a DateTime type with a subtype of DateRange and shows "last week".
