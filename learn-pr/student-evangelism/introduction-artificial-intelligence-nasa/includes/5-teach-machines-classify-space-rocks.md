The AI scientist's job in creating an AI model is to *teach* the computer how to accomplish the goal. For space-rock research, the goal is 100% accuracy in the classification system. 100% seems impossible to humans, but when scientists integrate computers and AI with their other research techniques, the goal comes within reach.

An AI model often implements the same or similar steps from the human process to achieve the goal. The scientist *teaches* by creating the model. The computer *learns* by repeating the model process. Each model iteration yields more data. The more data that's gathered and analyzed, the more accurately the computer can predict.

For our AI model, we'll start with the human steps for examining and classifying rocks. We'll teach the computer to follow these steps. After the computer runs the model and generates analysis data, it can accurately predict the rock type from new data.

### Step 0: Get data

A preparatory step is to import image data. We also need to get the libraries to help process the data on the computer that we'll train. The computer transforms the images into matrices of numbers so the images are in a format the computer can read.

### Step 1: Extract features

From the rock photos (data) that we provide, the computer extracts features like texture, size, color, and edges. Scientists use intuition and experience to specify the features to look for.

### Step 2: Find associations

The computer makes associations between image features and types of rock. Computers can be better than humans at the task of detecting minute details, because there are so many associations to make.

The computer builds a network that can keep track of millions of associations.

### Step 3: Predict types

The computer extracts defined rock features from a new photo. It uses associations between existing data and data from the new photo to predict the rock type.
