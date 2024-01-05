
To consume the published knowledge base, you can use the REST interface.

The minimal request body for the function contains a question, like this:

```JSON
{
  "question": "What do I need to do to cancel a reservation?"
}
```

The response includes the closest question match that was found in the knowledge base, along with the associated answer, the confidence score, and other metadata about the question and answer pair.

```JSON
{
  "answers": [
    {
      "questions": [
        "How can I cancel a reservation?"
      ],
      "answer": "Call us on 555 123 4567 to cancel a reservation.",
      "confidenceScore": 1.0,
      "id": 6,
      "source": "https://margies-travel.com/faq",
      "metadata": {},
      "dialog": {
        "isContextOnly": false,
        "prompts": []
      }
    }
  ]
}
```
