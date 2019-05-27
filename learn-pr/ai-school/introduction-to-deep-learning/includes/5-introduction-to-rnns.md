Some problems may require us to look at recent data to help perform current analysis - such as analysis of connected handwriting.

A recurrent neural network (RNN) is a class of neural network that excels when your data can be treated as a sequence - such as text, music, speech recognition, connected handwriting, or data over a time period.

![6.5 RNN](../media/6.5_RNN.png)

An RNN can analyze or predict a word based on the previous words in a sentence - they allow a connection between previous information and current information. RNNs are neural networks with loops, allowing data to be temporarily stored to help with later analysis.

![6.5 loop (1)](../media/6.5_loop__1_.png)

RNNs contain cells - where additional state is stored. This additional state is useful because the RNN can remember important information used for predictions - such as past tense. If early on in a sentence a user has written “We '__were__' going to”, an RNN can remember that the word 'were' is in the past tense inside a unit, so it may output “We were going to __fly__ to Canada” instead of “We were going to __flew__ to Canada.”

Standard RNNs struggle when there is a large gap between previous data that is relevant and current data. To solve this problem, AI practitioners commonly use two similar types of RNNs - __long short-term memory__ networks (__LSTM__), and __gated recurrent unit__ networks (__GRU__). 

### LSTM

LSTMs are a special type of RNN which dramatically improves the model’s ability to connect previous data to current data where there is a long gap. For example, a standard RNN may struggle to accurately predict the sentence “My favourite artist is Mozart” because there may be a large gap between information about the context of the word artist - the context may have previously been about a painter.

LSTMs are quite complex behind the scenes so we won’t worry about the in-depth details for now. Where a normal RNN contains a single layer per cell, LSTMs contain four interacting layers.

![6.5 LSTM](../media/6.5_LSTM.png)

### GRU

![6.5 GRU](../media/6.5_GRU.png)

With GRUs, what you need to know for now is that they hold some advantages over LSTM networks for sequence problems because they are simpler. Training time decreases with simplification, allowing better results in some circumstances because training is more effective overall.

### Programming exercise
 
> Let's try out RNNs in Azure Notebooks.  
>  
> **Python users** click __[here](https://notebooks.azure.com/home/libraries/Python "here")__ to go to your library.  
> Select the exercise `11. Recurrent Neural Networks - Python.ipynb`.  
> Then click then click __'Run on Free Compute'__.  
>  
> **R users** click __[here](https://notebooks.azure.com/home/libraries/R-Exercises "here")__ to go to your library.  
> Select the exercise `11. Recurrent Neural Networks - R.ipynb`.  
> Then click then click __'Run on Free Compute'__.  
>  
> If you haven’t set up your library and Azure Notebooks account the links above won't work. For instructions to get started click [__here__](https://aischool.microsoft.com/en-us/machine-learning/learning-paths/ml-crash-course/introduction-to-ai/introduction-to-azure-notebooks).

## Summary 

That’s that! Congratulations for finishing this module. You're almost finished.

In this section we covered:

* __Recurrent neural network__ (RNN) - a class of neural network that excels at analyzing and predicting data in a sequence.
* __LSTM__ - a variation of RNNs that is very good at connecting previous data to current data where there is a long gap.
* __GRU__ - a variation of LSTM that is simpler - meaning a decrease in training time, which can be quite beneficial sometimes.

Let’s recap on what we’ve learned in this module.

- __Deep learning__ simply means using neural networks with many layers
* By having many layers, these networks have more room to learn abstract information, like what a nose or dog looks like.
* Deep learning can have very long training times.
* There are different ways these can be organised.
 - Convolutional neural networks are often used for image processing.
  - __Recurrent neural networks__ are often used for data like text or music
 * RNNs have a special kind of memory for things seen recently. 
 * There are many different variants of RNNs, each with different advantages.

Those of us who read the optional information will have learned that:

* there are a wide variety of ways to organize a neural network
      - Which you choose depends on what you want to achieve and some degree of experimentation.
* To build a deep network one needs to pick tools to do so. There are many tools available, including TensorFlow and Keras.bb


Deep learning is an immensely deep field that is constantly improving. The next module is a short one - unsupervised learning. Let's get to it!