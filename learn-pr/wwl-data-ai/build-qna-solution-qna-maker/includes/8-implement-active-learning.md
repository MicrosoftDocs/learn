
After creating and testing a knowledge base, you can improve its performance with *active learning* and by defining *synonyms*.

## Use active learning

**Active learning** can help you make continuous improvements so that it gets better at answering user questions correctly over time.

Active learning helps improve the knowledge base in two ways:

- **Implicit feedback**: As incoming requests are processed, the service identifies user-provided questions that have multiple, similarly scored matches in the knowledge base. These are automatically clustered as alternate phrase suggestions for the possible answers that you can accept or reject in the **Suggestions** page for your knowledge base in Azure AI Language Studio.
- **Explicit feedback**. When developing a client application you can control the number of possible question matches returned for the user's input by specifying the **top** parameter, as shown here:

    ```JSON
    {
        "question": "I want to book a hotel.",
        "top": 3
    }
    ```

    The response from the service includes a **question** object for each possible match, up to the **top** value specified in the request:

    ```JSON
    {
        "answers":[
            {"questions":[
                "How do I book a hotel?"
            ],
            "answer":"Call 555-123-4567 to book.",
            "score":76.55,
            "id":2,
            ...
            },
            {"questions":[
                "Can I book multiple hotel rooms?"
            ],
            "answer":"Yes, you can reserve up to 3 rooms.",
            "score":76.15,
            "id":6,
            ...
            },
            {"questions":[
                "Is there a booking fee?"
            ],
            "answer":"No, we do not charge a booking fee.",
            "score":75.99,
            "id":11,
            ...
            }
        ]
    }
    ```

    You can implement logic in your client app to compare the **score** property values for the questions, and potentially present the questions to the user so they can positively identify the question closest to what they intended to ask.

    With the correct question identified, your app can use the REST API to send feedback containing suggested alternative phrasing based on the user's original input:

    ```JSON
    {
        "records": [
            {
                "userId": "1234",
                "userQuestion": "I want to book a hotel.",
                "qnaId": 2
            }
        ]
    }
    ```

    The **qnaId** in the feedback corresponds to the **id** of the question the user identified as the correct match. The **userId** parameter is an identifier for the user and can be any value you choose, such as an email address or numeric identifier.

    The feedback will be presented in the active learning **Suggestions** page for your knowledge base in Azure AI Language Studio for you to accept or reject.

> [!NOTE]
> To learn more about active learning, see the [Enrich your project with active learning](/azure/cognitive-services/language-service/question-answering/tutorials/active-learning).

## Define synonyms

Synonyms are useful when question submitted by users might include multiple different words to mean the same thing. For example, a travel agency customer might refer to a "reservation" or a "booking". By defining these as synonyms, the question answering service can find an appropriate answer regardless of which term an individual customer uses.

To define synonyms, you must use the REST API to submit synonyms in the following JSON format:

```JSON
{
    "synonyms": [
        {
            "alterations": [
                "reservation",
                "booking",,
                ]
        }
    ]
}
```

> [!NOTE]
> To learn more about synonyms, see the [Improve quality of response with synonyms](/azure/cognitive-services/language-service/question-answering/tutorials/adding-synonyms).
