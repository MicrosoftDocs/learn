Now we have an understanding of the components of a prompt and how to use the components to construct a prompt to generate high-quality completions. 

Let's update the application we started in the previous exercise to incorporate some of those techniques.

## Update the sentiment classification

When classifying a product review, we only want the model to tell us if the review is positive, neutral, or negative. Let's update the prompt the model receives so it has the best chance of providing a high-quality response.

### Add a cue

1. Open up the **PetReviewAI** project you created earlier.
1. In the **Program.cs** file, locate where you created the first prompt that asks the model to classify the sentiment of a review.
1. We want to add a cue to this prompt, or text that helps direct the model to the desired output. Update the `propmpt` variable to look like the following:

    ```csharp
    string prompt = $"""
        Product reviews are a key component in how our online business decides 
        whether to include stock products in the future. You will help us make 
        those decisions by classifying a product review as positive, neutral, 
        or negative.
        """;
    ```

    _We haven't included the `exampleReview` variable yet, we'll still build upon this prompt in the next section._

### Add examples

Next add some examples to help the model give us the output we want to see in a technique called few-shot learning.

1. Update the prompt to include an example for a positive, neutral, and negative review.

    ```csharp
    string prompt = $"""
    Product reviews are a key component in how our online business decides whether to include stock products in the future. You will help us make those decisions by classifying a product review as positive, neutral, or negative.

    Here are a few examples you can use:

    Review: My dog absolutely loved this food. He eats every last crumb and can't wait for dinner time.
    Sentiment: Positive

    Review: This aquarium is does the job but it is not anything special. Sometimes algae forms on the sides, but sometimes not. I would probably buy again but would first do some more research.
    Sentiment: Neutral

    Review: I seriously cannot believe this store stocks this doggy bed. My dog ripped it up and there was stuffing all over the place. I think there's stuffing stuck to my ceiling.
    Sentiment: Negative

    """;
    ```

1. Now finally at the very end of the `prompt` string, add the `exampleReview` variable in as the last review and put a placeholder in for the **Sentiment:**. This lets the model know you want it to complete with what it thinks should come next.

    ```csharp
    string prompt = $"""
    
    ...

    Review: {exampleReview}
    Sentiment:
    ```

1. Run the application, if you used the example review of `"The cat never got into the catio-tent"`, the sentiment _should_ be **Negative**.
1. You can play around with the `exampleReview` variable to see how other text affects the returned sentiment.

## Update the translation

Here we want to give the model an out or let it know it's OK if it doesn't know how to do something.

In the case, there isn't a direct translation of _catio-tent_ from English to Spanish. So let's create a prompt that lets the model tell us that.

### Provide an alternative output

1. Make sure the `exampleReview` variable is initialized to `"The cat never got into the catio-tent."`.
1. Find the `promptForTranslation` variable and update it so that the model has a chance to say if the review to translate doesn't make sense.

    ```csharp
    string promptForTranslation = $"""
    You are going to translate a product review from English into Spanish.
    If the review is not a well-formed English sentence respond with the text in Spanish: 'Not a well-formed sentence'. Otherwise, respond with the translation.
    The review to translate is: {exampleReview}
    """;
    ```

1. Run the application. It should give you a translation.
1. Change `exampleReview` to be `"The tent ate the cat`.
1. Run the application again, and it should output: `No es una buena forma de hablar español.`.
