Build and train a convolutional neural network (CNN)
State-of-the-art image classification typically isn't done with traditional neural networks, but with deep convolutional neural networks (CNNs) that use convolution kernels to extract features from images and pooling layers to subsample images so features can be detected at various resolutions. Let's use keras to build a CNN and train it with the Labeled Faces in the Wild dataset and see how its performance compares to the other networks. Note that training will take longer, and generally speaking, a CNN performs best when trained with tens (or hundreds) of thousands of images rather than just a few hundred.



In [17]:
from keras.layers import Conv2D
from keras.layers import MaxPooling2D
from keras.layers import Flatten

model = Sequential()
model.add(Conv2D(32, (3, 3), activation='relu', input_shape=(image_width, image_height, 1)))
model.add(MaxPooling2D(2, 2))
model.add(Conv2D(128, (3, 3), activation='relu'))
model.add(MaxPooling2D(2, 2))
model.add(Conv2D(128, (3, 3), activation='relu'))
model.add(MaxPooling2D(2, 2))
model.add(Dropout(0.1))
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dense(class_count, activation='softmax'))
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
model.summary()
Model: "sequential_6"
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
conv2d_1 (Conv2D)            (None, 45, 60, 32)        320       
_________________________________________________________________
max_pooling2d_1 (MaxPooling2 (None, 22, 30, 32)        0         
_________________________________________________________________
conv2d_2 (Conv2D)            (None, 20, 28, 128)       36992     
_________________________________________________________________
max_pooling2d_2 (MaxPooling2 (None, 10, 14, 128)       0         
_________________________________________________________________
conv2d_3 (Conv2D)            (None, 8, 12, 128)        147584    
_________________________________________________________________
max_pooling2d_3 (MaxPooling2 (None, 4, 6, 128)         0         
_________________________________________________________________
dropout_2 (Dropout)          (None, 4, 6, 128)         0         
_________________________________________________________________
flatten_1 (Flatten)          (None, 3072)              0         
_________________________________________________________________
dense_15 (Dense)             (None, 128)               393344    
_________________________________________________________________
dense_16 (Dense)             (None, 5)                 645       
=================================================================
Total params: 578,885
Trainable params: 578,885
Non-trainable params: 0
_________________________________________________________________
Now let's reshape the data to the format that the input layer expects, split it for training and testing, and call fit to train the model.

In [18]:
face_images = faces.images.reshape(image_count, image_width, image_height, 1).astype('float32') / 255
x_train, x_test, y_train, y_test = train_test_split(face_images, face_labels, train_size=0.8, random_state=42)

hist = model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=50, batch_size=25)
/home/nbuser/anaconda3_501/lib/python3.6/site-packages/sklearn/model_selection/_split.py:2179: FutureWarning: From version 0.21, test_size will always complement train_size unless both are specified.
  FutureWarning)
Train on 912 samples, validate on 228 samples
Epoch 1/50
912/912 [==============================] - 8s 9ms/step - loss: 1.4465 - accuracy: 0.4068 - val_loss: 1.4124 - val_accuracy: 0.4649
Epoch 2/50
912/912 [==============================] - 6s 7ms/step - loss: 1.4255 - accuracy: 0.4649 - val_loss: 1.4018 - val_accuracy: 0.4649
Epoch 3/50
912/912 [==============================] - 7s 8ms/step - loss: 1.4133 - accuracy: 0.4649 - val_loss: 1.3933 - val_accuracy: 0.4649
Epoch 4/50
912/912 [==============================] - 6s 7ms/step - loss: 1.4050 - accuracy: 0.4649 - val_loss: 1.3934 - val_accuracy: 0.4649
Epoch 5/50
912/912 [==============================] - 6s 7ms/step - loss: 1.3702 - accuracy: 0.4660 - val_loss: 1.3189 - val_accuracy: 0.4649
Epoch 6/50
912/912 [==============================] - 6s 7ms/step - loss: 1.2717 - accuracy: 0.4890 - val_loss: 1.3302 - val_accuracy: 0.5395
Epoch 7/50
912/912 [==============================] - 6s 7ms/step - loss: 1.1796 - accuracy: 0.5186 - val_loss: 1.0593 - val_accuracy: 0.5833
Epoch 8/50
912/912 [==============================] - 7s 7ms/step - loss: 1.0353 - accuracy: 0.5910 - val_loss: 1.0158 - val_accuracy: 0.5746
Epoch 9/50
912/912 [==============================] - 8s 8ms/step - loss: 0.9081 - accuracy: 0.6502 - val_loss: 0.7700 - val_accuracy: 0.7018
Epoch 10/50
912/912 [==============================] - 7s 8ms/step - loss: 0.7659 - accuracy: 0.6897 - val_loss: 0.6805 - val_accuracy: 0.7456
Epoch 11/50
912/912 [==============================] - 9s 9ms/step - loss: 0.7008 - accuracy: 0.7357 - val_loss: 0.7273 - val_accuracy: 0.6930
Epoch 12/50
912/912 [==============================] - 9s 10ms/step - loss: 0.6021 - accuracy: 0.7643 - val_loss: 0.6242 - val_accuracy: 0.7456
Epoch 13/50
912/912 [==============================] - 7s 8ms/step - loss: 0.5838 - accuracy: 0.7807 - val_loss: 0.6184 - val_accuracy: 0.7675
Epoch 14/50
912/912 [==============================] - 7s 8ms/step - loss: 0.5203 - accuracy: 0.8092 - val_loss: 0.5285 - val_accuracy: 0.8114
Epoch 15/50
912/912 [==============================] - 7s 7ms/step - loss: 0.4432 - accuracy: 0.8377 - val_loss: 0.6123 - val_accuracy: 0.7675
Epoch 16/50
912/912 [==============================] - 7s 8ms/step - loss: 0.3947 - accuracy: 0.8553 - val_loss: 0.4872 - val_accuracy: 0.8509
Epoch 17/50
912/912 [==============================] - 6s 7ms/step - loss: 0.3492 - accuracy: 0.8739 - val_loss: 0.5885 - val_accuracy: 0.8246
Epoch 18/50
912/912 [==============================] - 7s 8ms/step - loss: 0.3125 - accuracy: 0.8816 - val_loss: 0.4732 - val_accuracy: 0.8421
Epoch 19/50
912/912 [==============================] - 7s 8ms/step - loss: 0.2863 - accuracy: 0.9013 - val_loss: 0.5369 - val_accuracy: 0.8377
Epoch 20/50
912/912 [==============================] - 7s 7ms/step - loss: 0.2224 - accuracy: 0.9276 - val_loss: 0.4665 - val_accuracy: 0.8509
Epoch 21/50
912/912 [==============================] - 7s 8ms/step - loss: 0.2182 - accuracy: 0.9309 - val_loss: 0.5307 - val_accuracy: 0.8421
Epoch 22/50
912/912 [==============================] - 8s 8ms/step - loss: 0.2020 - accuracy: 0.9232 - val_loss: 0.5253 - val_accuracy: 0.8333
Epoch 23/50
912/912 [==============================] - 7s 8ms/step - loss: 0.1577 - accuracy: 0.9474 - val_loss: 0.4935 - val_accuracy: 0.8553
Epoch 24/50
912/912 [==============================] - 6s 7ms/step - loss: 0.1750 - accuracy: 0.9386 - val_loss: 0.5176 - val_accuracy: 0.8465
Epoch 25/50
912/912 [==============================] - 6s 7ms/step - loss: 0.1472 - accuracy: 0.9496 - val_loss: 0.4912 - val_accuracy: 0.8596
Epoch 26/50
912/912 [==============================] - 7s 8ms/step - loss: 0.1310 - accuracy: 0.9572 - val_loss: 0.4656 - val_accuracy: 0.8772
Epoch 27/50
912/912 [==============================] - 9s 10ms/step - loss: 0.1019 - accuracy: 0.9704 - val_loss: 0.4905 - val_accuracy: 0.8684
Epoch 28/50
912/912 [==============================] - 6s 7ms/step - loss: 0.0834 - accuracy: 0.9825 - val_loss: 0.4737 - val_accuracy: 0.8772
Epoch 29/50
912/912 [==============================] - 7s 8ms/step - loss: 0.0684 - accuracy: 0.9814 - val_loss: 0.5458 - val_accuracy: 0.8728
Epoch 30/50
912/912 [==============================] - 7s 7ms/step - loss: 0.0621 - accuracy: 0.9825 - val_loss: 0.4969 - val_accuracy: 0.8772
Epoch 31/50
912/912 [==============================] - 8s 9ms/step - loss: 0.0563 - accuracy: 0.9857 - val_loss: 0.5123 - val_accuracy: 0.8816
Epoch 32/50
912/912 [==============================] - 6s 7ms/step - loss: 0.0499 - accuracy: 0.9857 - val_loss: 0.5939 - val_accuracy: 0.8728
Epoch 33/50
912/912 [==============================] - 7s 8ms/step - loss: 0.0404 - accuracy: 0.9901 - val_loss: 0.5563 - val_accuracy: 0.8684
Epoch 34/50
912/912 [==============================] - 7s 8ms/step - loss: 0.0433 - accuracy: 0.9879 - val_loss: 0.5685 - val_accuracy: 0.8684
Epoch 35/50
912/912 [==============================] - 8s 9ms/step - loss: 0.0723 - accuracy: 0.9715 - val_loss: 0.5825 - val_accuracy: 0.8728
Epoch 36/50
912/912 [==============================] - 6s 6ms/step - loss: 0.0363 - accuracy: 0.9945 - val_loss: 0.5675 - val_accuracy: 0.8640
Epoch 37/50
912/912 [==============================] - 6s 6ms/step - loss: 0.0356 - accuracy: 0.9901 - val_loss: 0.6053 - val_accuracy: 0.8553
Epoch 38/50
912/912 [==============================] - 7s 8ms/step - loss: 0.0293 - accuracy: 0.9945 - val_loss: 0.6382 - val_accuracy: 0.8728
Epoch 39/50
912/912 [==============================] - 7s 7ms/step - loss: 0.0234 - accuracy: 0.9967 - val_loss: 0.6495 - val_accuracy: 0.8553
Epoch 40/50
912/912 [==============================] - 9s 9ms/step - loss: 0.0202 - accuracy: 0.9978 - val_loss: 0.7016 - val_accuracy: 0.8509
Epoch 41/50
912/912 [==============================] - 6s 6ms/step - loss: 0.0148 - accuracy: 0.9978 - val_loss: 0.6373 - val_accuracy: 0.8728
Epoch 42/50
912/912 [==============================] - 6s 6ms/step - loss: 0.0406 - accuracy: 0.9901 - val_loss: 0.6345 - val_accuracy: 0.8640
Epoch 43/50
912/912 [==============================] - 7s 7ms/step - loss: 0.0288 - accuracy: 0.9912 - val_loss: 0.8446 - val_accuracy: 0.8421
Epoch 44/50
912/912 [==============================] - 7s 8ms/step - loss: 0.0139 - accuracy: 0.9989 - val_loss: 0.6446 - val_accuracy: 0.8728
Epoch 45/50
912/912 [==============================] - 6s 7ms/step - loss: 0.0191 - accuracy: 0.9956 - val_loss: 0.6494 - val_accuracy: 0.8816
Epoch 46/50
912/912 [==============================] - 6s 7ms/step - loss: 0.0660 - accuracy: 0.9781 - val_loss: 0.6224 - val_accuracy: 0.8816
Epoch 47/50
912/912 [==============================] - 7s 8ms/step - loss: 0.0272 - accuracy: 0.9934 - val_loss: 0.7013 - val_accuracy: 0.8640
Epoch 48/50
912/912 [==============================] - 7s 7ms/step - loss: 0.0248 - accuracy: 0.9879 - val_loss: 0.5960 - val_accuracy: 0.8860
Epoch 49/50
912/912 [==============================] - 10s 11ms/step - loss: 0.0151 - accuracy: 0.9978 - val_loss: 0.6580 - val_accuracy: 0.8640
Epoch 50/50
912/912 [==============================] - 8s 8ms/step - loss: 0.0087 - accuracy: 0.9989 - val_loss: 0.6222 - val_accuracy: 0.8816
With training complete, let's plot the training and validation accuracy to see how well the network performed.

In [19]:
show_history(hist)

As before, we'll run some test data through the network and use a confusion matrix to see how it fared.

In [20]:
y_predicted = model.predict(x_test)
mat = confusion_matrix(y_test.argmax(axis=1), y_predicted.argmax(axis=1))

sns.heatmap(mat.T, square=True, annot=True, fmt='d', cbar=False, cmap='Blues',
            xticklabels=faces.target_names,
            yticklabels=faces.target_names)

plt.xlabel('Actual label')
plt.ylabel('Predicted label')
Out[20]:
Text(89.18, 0.5, 'Predicted label')

In all likelihood, the CNN exhibited about the same accuracy as a traditional neural network. This isn't surprising given that the dataset we trained it with is relatively small. State-of-the-art CNNs can sometimes execeed a human's ability to classify images. They also require vast amounts of compute power to train and are sometimes 100 or more layers deep.