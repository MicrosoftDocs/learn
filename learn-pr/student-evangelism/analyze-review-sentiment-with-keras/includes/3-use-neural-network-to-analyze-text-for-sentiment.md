The real test comes when you input text of your own into the model and see how it performs — that is, how adept it is at quantifying the sentiment expressed in that text. In this unit, you'll write a Python function that accepts a text string as input, passes it to the model, and returns a sentiment score. Then you'll use the function to analyze the sentiment expressed in various text strings.

1. Add the following code to a cell at the end of the notebook and run the cell:

    ```python
    import string
    import numpy as np

    def analyze(text):
        # Prepare the input by removing punctuation characters, converting
        # characters to lower case, and removing words containing numbers
        translator = str.maketrans('', '', string.punctuation)
        text = text.translate(translator)
        text = text.lower().split(' ')
        text = [word for word in text if word.isalpha()]

        # Generate an input tensor
        input = [1]
        for word in text:
            if word in word_dict and word_dict[word] < top_words:
                input.append(word_dict[word])
            else:
                input.append(2)
        padded_input = sequence.pad_sequences([input], maxlen=max_review_length)

        # Invoke the model and return the result
        result = model.predict(np.array([padded_input][0]))[0][0]
        return result
    ```

    These statements define a function named `analyze` that accepts a string as input and returns a number from 0.0 to 1.0 quantifying the sentiment expressed in that string. The higher the number, the more positive the sentiment. The function cleans the input string, converts it into a list of integers referencing words in the dictionary created by the `load_data` function, and finally calls the model's `predict` function to score the text for sentiment.

1. Use the notebook to execute the following statement:

    ```python
    analyze('Easily the most stellar experience I have ever had.')
    ```

    The output is the sentiment expressed in the input text as a number from 0.0 to 1.0. Would you agree with the model's assessment?

1. Now try this statement:

    ```python
    analyze('The long lines and poor customer service really turned me off.')
    ```

    How does the model quantify the sentiment expressed in this text?

Finish up by testing the model with input strings of your own. The results won't be perfect, but you should find that the model is reasonably adept at quantifying sentiment. Even though the model was trained with movie reviews, it isn't *limited* to analyzing movie reviews. That makes sense because there are inherent similarities between language expressing the like or dislike of a movie and words expressing feelings about other unrelated subjects.