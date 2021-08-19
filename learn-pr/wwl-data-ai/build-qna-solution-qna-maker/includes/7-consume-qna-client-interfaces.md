To consume the published knowledge base, you can use the REST interface or one of the programming language-specific SDKs, which provide classes with methods to call the **generateAnswer** REST function.

The request body for the function contains a question, like this:

```JSON
{
  "question": "I want to book a hotel."
}
```

The response includes the closest question match that was found in the knowledge base, along with the associated answer, the confidence score, and other metadata about the question and answer pair.

```JSON
{
  "answers":[
    {"questions":[
      "How do I book a hotel?"
      ],
     "answer":"Call 555-123-4567 to book.",
     "score":76.55,
     "id":2,
     "source":"https://...source.docx",
     "isDocumentText":false,
     "metadata":[],
     "context":{
       "isContextOnly":false,
       "prompts":[]
      }
    },
  ],
  "activeLearningEnabled":true
}
```
