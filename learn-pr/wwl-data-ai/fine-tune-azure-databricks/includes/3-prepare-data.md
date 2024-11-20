To fine-tune a Large Language Model (LLM) with Azure Databricks, you first need to collect and prepare the dataset you want to use.

Let's explore how to prepare your data when you want to fine-tune an Azure OpenAI model.

> [!Tip]
> For a different approach, learn more about how to [prepare data for fine-tuning Hugging Face models](/azure/databricks/machine-learning/train-model/huggingface/load-data?azure-portal=true).

## Identify your data requirements

The training data can be in JSON Lines (JSONL), CSV, or TSV format. The requirements of your data vary based on the specific task you intend to fine-tune your model for.

| Task | Dataset requirements |
| --- | --- |
| Text classification | Two columns: `Sentence` (string) and `Label` (integer/string) |
| Token classification | Two columns: `Token` (string) and `Tag` (string) |
| Question answering | Five columns: `Question` (string), `Context` (string), `Answers` (string), `Answers_start` (int), and `Answers_text` (string) |
| Summarization | Two columns: `Document` (string) and `Summary` (string) |
| Translation | Two columns: `Source_language` (string) and `Target_language` (string) |

## Prepare you data

To fine-tune a model for chat or question answering, your training dataset should consist of conversational exchanges that reflect the type of interactions you want the model to handle.

Here are some key elements to include in your dataset:

- **Prompts and responses**: Each entry in your dataset should have a prompt (the question or statement) and a corresponding response (the answer or reply). For example, a prompt could be a user's question, and the response would be the model's answer.
- **Contextual information**: If your chat involves multi-turn conversations, it's important to include context from previous turns. Including context helps the model understand the flow of the conversation and generate more coherent responses.
- **Diverse examples**: Include various questions and answers to cover different topics and scenarios. More diverse examples help the model generalize better and handle a wide range of queries.
- **Human-generated responses**: Use human-generated responses to train the model. Using human-generated responses to fine-tune the model ensures that the model learns to generate natural and accurate replies.
- **Formatting**: Ensure that each prompt and response pair is properly formatted. For example, you can use a fixed separator to indicate the end of a prompt and the beginning of a response. A common separator is \n\n###\n\n, which shouldn't appear elsewhere in the prompts.

> [!Tip]
> Though your training dataset can be stored as JSONL, CSV, or TSV, JSONL is often preferred because it allows for easier handling of nested data structures and is more flexible for storing complex data. JSONL (JSON Lines) format stores each record as a separate JSON object on a single line, making it easier to process large datasets line-by-line without loading the entire dataset into memory. The JSONL format is particularly useful for training language models, as it can efficiently handle large volumes of text data and maintain the structure needed for fine-tuning tasks.
