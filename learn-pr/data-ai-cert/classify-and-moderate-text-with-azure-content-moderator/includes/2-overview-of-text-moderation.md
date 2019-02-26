You either block, approve or review the content based on your policies and thresholds. Use it to augment human moderation of environments where partners, employees, and consumers generate text content. These include chat rooms, discussion boards, chatbots, e-commerce catalogs, and documents. 

The service response includes the following information:

## Profanity

When you pass text to this API, any profane terms in the text are identified and returned in a JSON response.  The profane item is returned as a "Term" in the JSON response along with an index value of where the term is located in the supplied text.  You can also use custom term lists with this API as well and if a profane term is identified in the text, the ListId is also returned, showing where in your custom list the item is. An example of a JSON response is shown here:

```json
"Terms": [
{
    "Index": 118,
    "OriginalIndex": 118,
    "ListId": 0,
    "Term": "crap"
}
```

## Classification

This feature of the API can place text into specific categories based on the following specifications:

- Category 1 - potential presence of language that may be considered sexually explicit or adult in certain situations
- Category 2 - potential presence of language that may be considered sexually suggestive or mature in certain situations
- Category 3 - potential presence of language that may be considered offensive in certain situations

When the JSON response is returned, it will provide a Boolean value for a recommended review of the text.  If True, the suggestion is to review the content manually to determine the potential for any issues.  Each category will also be returned with a score between 0 and 1 to indicated the prediction of which category is most appropriate for the evaluated text.  An example of a JSON response:

```json
"Classification": {
    "ReviewRecommended": true,
    "Category1": {
        "Score": 1.5113095059859916E-06
        },
    "Category2": {
        "Score": 0.12747249007225037
        },
    "Category3": {
        "Score": 0.98799997568130493
    }
}
```

## Personally Identifiable Information

Personally Identifiable Information (PII) is of critical importance in many applications. This feature of the API can help you detect if any values in the text are considered PII before you release it publicly.  Key aspects that are detected include:

- Email addresses
- U.S. mail addresses
- IP addresses
- U.S. phone numbers
- UK phone numbers
- Social Security numbers

If values are found, the JSON response will include relevant information on the text and include the index location within the text.  An example response is shown here:

```json
"PII": {
    "Email": [{
        "Detected": "abcdef@abcd.com",
        "SubType": "Regular",
        "Text": "abcdef@abcd.com",
        "Index": 32
        }],
    "IPA": [{
        "SubType": "IPV4",
        "Text": "255.255.255.255",
        "Index": 72
        }],
    "Phone": [{
        "CountryCode": "US",
        "Text": "6657789887",
        "Index": 56
        }, {
        "CountryCode": "UK",
        "Text": "+44 870 608 4000",
        "Index": 208
        }],
    "Address": [{
        "Text": "1 Microsoft Way, Redmond, WA 98052",
        "Index": 89
        }],
    "SSN": [{
        "Text": "999-99-9999",
        "Index": 267
        }]
    }
```