After you have defined a knowledge base, you can train its natural language model, and test it before publishing it for use in an application or bot.

## Testing a knowledge base

You can test your knowledge base interactively in the QnA Maker portal, submitting questions and reviewing the answers that are returned. You can inspect the results to view their confidence scores as well as other potential answers.

![The test pane in the QnA Maker portal](../media/test-qna.png)

You can also download the [batch testing tool](https://aka.ms/qnamakerbatchtestingtool) and submit a set of questions with known answers and compare the results.

## Publishing a knowledge base

When you are happy with the performance of your knowledge base, you can publish it to a REST endpoint with a **generateAnswer** function that client applications can use to submit questions and receive answers.
