Some problems may require us to look at recent data to help perform current analysis - such as analysis of connected handwriting.

A recurrent neural network (RNN) is a class of neural network that excels when your data can be treated as a sequence - such as text, music, speech recognition, connected handwriting, or data over a time period.

![Three layers, aligned horizontally, describe the RNN architecture. The bottom layer is labeled input sequence, where the data enters the RNN. The middle layer is the RNN cells, with the layer labeled 'states' and the cells labeled 'RNN'. The top layer is the output, labeled 'output sequence'. The input and output nodes are circles, and are labeled 'i' for input, and 'o' for output. Each cell for every layer has a position, indicated by the letter 'N' and a number - with the first cells on the left labeled 'n-1', the middle cells 'n' and the cells on the right labeled 'n+1'. Each input node is joined to the RNN cell directly above it with a green arrow, which indicates the flow of data from the input to the RNN cell. Each RNN cell is joined to the RNN cell directly to the right of itself with a blue arrow, and also joined to the output layer directly above it with a red arrow.](../media/65-rnn.png)

An RNN can analyze or predict a word based on the previous words in a sentence - they allow a connection between previous information and current information. RNNs are neural networks with loops, allowing data to be temporarily stored to help with later analysis.

![three circular nodes are aligned horizontally, with each joined to the node to its right with a black arrow. The left-hand node is labeled 'input' with an 'i' in the center of the circle, and an 'n'. The middle node is labeled 'RNN layer' with an 'h', and an 'n' in the center of the circle. The right-hand node is labeled 'output' with an 'o' and an 'n' in the center of the circle. The 'n' in each cell indicates that these three cells are all on the same position in the RNN. There is also an arrow, which loops back from the right-hand side of the center 'RNN layer' node, around to the left'hand side of the RNN node. This arrow is labeled 'loop'.](../media/65-l-1.png)

RNNs contain cells - where additional state is stored. This additional state is useful because the RNN can remember important information used for predictions - such as past tense. If early on in a sentence a user has written “We '__were__' going to”, an RNN can remember that the word 'were' is in the past tense inside a unit, so it may output “We were going to __fly__ to Canada” instead of “We were going to __flew__ to Canada.”

Standard RNNs struggle when there is a large gap between previous data that is relevant and current data. To solve this problem, AI practitioners commonly use two similar types of RNNs - __long short-term memory__ networks (__LSTM__), and __gated recurrent unit__ networks (__GRU__).

### LSTM

LSTMs are a special type of RNN that dramatically improves the model’s ability to connect previous data to current data where there is a long gap. For example, a standard RNN may struggle to accurately predict the sentence “For musical composition and just overall good style, my favorite artist would have to be Mozart” because there may be a large gap between information about the context of the word artist - the context may have previously been about a painter.

LSTMs are quite complex behind the scenes so we won’t worry about the in-depth details for now. Where a normal RNN contains a single layer per cell, LSTMs contain four interacting layers.

![There are two horizontal arrows from left to right, which encapsulate the image. The top arrow is labeled 'C' with a subscript 'n-1' on the left-hand side, and with a 'C' with a subscript 'n' on the right-hand side. The bottom arrow is labeled 'O' with a subscript 'n-1' on the left-hand side, and with a 'O' with a subscript 'n' on the right-hand side. There is also a line coming from the bottom-right hand corner of the image joining into the bottom arrow, which is labeled 'i' with a subscript 'n'. There are three circular nodes in the middle of the image, aligned horizontally, in between the top and bottom arrows. The left-hand node and the middle node are both green, and labeled with the 'sigma' symbol. The right-hand node is blue, and labeled 'tanh'. The bottom arrow is joined to all three nodes by a line. The  left-hand node is joined to the top arrow by a line. The middle 'sigma' node and right-hand 'tanh' node are joined to the top arrow by the same line. There is also a forth circular node, labeled 'sigma' which is to the right of the 'tanh' node, but is placed directly on the bottom arrow. There is also a line which joins the top arrow and the bottom arrow to the right of this. Yes, this is complicated, no you don't have to worry about knowing any of the details.](../media/65-lstm.png)

### GRU

![There is a top horizontal arrow, traveling from left to right across the image. This arrow is labeled on the left-hand side with an 'O' with a subscript 'n-1', and on the right-hand side it is labeled with an 'O' and a subscript 'n'. There is a line on the bottom of the image, which goes from the left-hand side of the image to three quarters of the way across the image, where the line then travels vertically to join to the top arrow, with a circular node labeled 'tanh' in the middle of the image, between the lines. There are also two circular nodes in the middle of the image, both labeled with the symbol 'sigma'. They are both joined to the top arrow, by the same line. One of the sigma nodes is joined to the vertical line, just after the tanh node, and also joined to the top arrow. The other sigma node is joined to the bottom line, before the tanh node. There is also a vertical line on the left hand-side of the image which joins the top arrow and bottom line.](../media/65-gru.png)

With GRUs, what you need to know for now is that they hold some advantages over LSTM networks for sequence problems because they are simpler. Training time decreases with simplification, allowing better results in some circumstances because training is more effective overall.

## Summary

In this section we covered:

* __Recurrent neural network__ (RNN) - a class of neural network that excels at analyzing and predicting data in a sequence.
* __LSTM__ - a variation of RNNs that is very good at connecting previous data to current data where there is a long gap.
* __GRU__ - a variation of LSTM that is simpler - meaning a decrease in training time, which can be quite beneficial sometimes.

Next up we'll build an RNN model in Azure Notebooks.
