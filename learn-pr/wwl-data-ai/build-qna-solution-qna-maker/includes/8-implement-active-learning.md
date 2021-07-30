Enabling **Active Learning** for your knowledge base can help you make continuous improvements so that it gets better at answering user questions correctly over time. To enable active learning, view the **Service Settings** page in the QnA Maker portal and select the toggle.

Active Learning helps improve the knowledge base in two ways:

- **Implicit feedback**: As incoming requests are processed, QnA Maker identifies user-provided questions that have multiple, similarly scored matches in the knowledge base. These are automatically clustered as alternate phrase suggestions for the possible answers that you can view in the portal and choose to accept or reject.
- **Explicit feedback**. When developing a client application you can control the number of possible question matches returned for the user's input by specifying the **top** parameter, as shown here:

    ```JSON
    {
        "question": "I want to book a hotel.",
        "isTest": false,
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
        ],
        "activeLearningEnabled":true
    }
    ```

    You can implement logic in your client app to compare the **score** property values for the questions, and potentially present the questions to the user so they can positively identify the question closest to what they intended to ask.

    With the correct question identified, your app can use the **Train** API to send feedback containing suggested alternative phrasing based on the user's original input:

    ```JSON
    {
        "feedbackRecords": [
            {
                "userId": "1234",
                "userQuestion": "I want to book a hotel.",
                "qnaId": 2
            }
        ]
    }
    ```

    The **qnaId** in the feedback corresponds to the **id** of the question the user identified as the correct match. The **userId** parameter is an identifier for the user and can be any value you choose, such as an email address or numeric identifier.

    The feedback will be presented in the active learning suggestions in the QnA Maker portal for you to accept or reject.
