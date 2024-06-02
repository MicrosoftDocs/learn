
To consume the published knowledge base, you can use the REST interface.

The minimal request body for the function contains a question, like this:

```JSON
{
  "question": "What do I need to do to cancel a reservation?",
  "top": 2,
  "scoreThreshold": 20,
  "strictFilters": [
    {
      "name": "category",
      "value": "api"
    }
  ]
}
```

|Property  |Description  |
|---------|---------|
|question|Question to send to the knowledge base.|
|top|Maximum number of answers to be returned.|
|scoreThreshold|Score threshold for answers returned.|
|strictFilters|Limit to only answers that contain the specified metadata.|

The response includes the closest question match that was found in the knowledge base, along with the associated answer, the confidence score, and other metadata about the question and answer pair:

```JSON

{
  "answers": [
    {
      "score": 27.74823341616769,
      "id": 20,
      "answer": "Call us on 555 123 4567 to cancel a reservation.",
      "questions": [
        "How can I cancel a reservation?"
      ],
      "metadata": [
        {
          "name": "category",
          "value": "api"
        }
      ]
    }
  ]
}
```
