LLMs are trained neural networks based on a transformer architecture – which is designed to predict the next word in a sequence based on the preceding text. 

Common transformer based LLMs include the BERT model (which is used to power Google search) and Generative Pre Trained (GPT) models from OpenAI. 

High-level conceptual description of how GPT models are trained and how they work: 

Neural networks are trained by passing huge volumes of data through multiple layers of “neurons” that apply calculations to data using “weights”. The output from the final layer is compared to a known true value and the level of error is used to iteratively adjust the weights so the model predicts more accurately. 

Generative Pre-trained (GPT) models are transformer neural networks that interpret words (more accurately, linguistic tokens) as numeric vectors and predict the next in sequence. By using millions of token sequences, the model is trained to apply weights that result in correct predictions of completions (i.e. from a few words, the rest of the sentence can be predicted). 

Transformer models use attention (particularly self-attention) to predict words from context (e.g. “Use machine leaning to train a model” vs “Catch a train to London”) – in other words, the model learns to identify these two different types of “train” as different words with different semantic meaning. 

The huge volume of data used to train the model means that in addition to predicting completion of text, it can predict appropriate responses – essentially, it has “learned” a language model that enables it to “interpret” natural language prompts and respond appropriately. 