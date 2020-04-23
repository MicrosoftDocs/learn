We'll start by using keras to build and train a neural network containing one working layer with 128 neurons. We'll use categorical_crossentropy as the loss function and a softmax output layer, both of which are appropriate for muticlass classification problems. We will also use adam as the optimization algorithm. Rather than use a fixed learning rate, adam varies the learning rate as training proceeds so the network learns faster in the early stages of training and (hopefully) converges more accurately toward a solution in later stages.

```python
from keras.layers import Dense
from keras.models import Sequential

model = Sequential()
model.add(Dense(128, activation='relu', input_shape=(image_width * image_height,)))
model.add(Dense(class_count, activation='softmax'))
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
model.summary()
Model: "sequential_1"
```
_________________________________________________________________
Layer (type)                 Output Shape              Param #   
=================================================================
dense_1 (Dense)              (None, 128)               373120    
_________________________________________________________________
dense_2 (Dense)              (None, 5)                 645       
=================================================================
Total params: 373,765
Trainable params: 373,765
Non-trainable params: 0
_________________________________________________________________
Now let's train the neural network. We'll let it run for 100 epochs and then check the result to see if it required more (or less) training.

```python
hist = model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=100, batch_size=25)
```

Train on 912 samples, validate on 228 samples
Epoch 1/100
912/912 [==============================] - 1s 630us/step - loss: 1.5704 - accuracy: 0.4463 - val_loss: 1.3317 - val_accuracy: 0.6272
Epoch 2/100
912/912 [==============================] - 0s 310us/step - loss: 1.3158 - accuracy: 0.4868 - val_loss: 1.2791 - val_accuracy: 0.4868
Epoch 3/100
912/912 [==============================] - 0s 440us/step - loss: 1.1423 - accuracy: 0.5504 - val_loss: 1.1087 - val_accuracy: 0.6053
Epoch 4/100
912/912 [==============================] - 0s 431us/step - loss: 1.0718 - accuracy: 0.5811 - val_loss: 1.0204 - val_accuracy: 0.6316
Epoch 5/100
912/912 [==============================] - 0s 410us/step - loss: 0.9756 - accuracy: 0.6404 - val_loss: 0.9519 - val_accuracy: 0.6754
Epoch 6/100
912/912 [==============================] - 0s 260us/step - loss: 0.9474 - accuracy: 0.6491 - val_loss: 0.9016 - val_accuracy: 0.7588
Epoch 7/100
912/912 [==============================] - 0s 330us/step - loss: 0.8638 - accuracy: 0.6743 - val_loss: 0.9177 - val_accuracy: 0.6053
Epoch 8/100
912/912 [==============================] - 0s 367us/step - loss: 0.8192 - accuracy: 0.6996 - val_loss: 0.8371 - val_accuracy: 0.7412
Epoch 9/100
912/912 [==============================] - 0s 336us/step - loss: 0.8198 - accuracy: 0.7007 - val_loss: 0.8223 - val_accuracy: 0.7018
Epoch 10/100
912/912 [==============================] - 0s 350us/step - loss: 0.7319 - accuracy: 0.7434 - val_loss: 0.9206 - val_accuracy: 0.6711
Epoch 11/100
912/912 [==============================] - 0s 270us/step - loss: 0.7437 - accuracy: 0.7226 - val_loss: 0.7119 - val_accuracy: 0.7807
Epoch 12/100
912/912 [==============================] - 0s 262us/step - loss: 0.6789 - accuracy: 0.7610 - val_loss: 0.6684 - val_accuracy: 0.7588
Epoch 13/100
912/912 [==============================] - 0s 329us/step - loss: 0.6222 - accuracy: 0.7982 - val_loss: 0.6119 - val_accuracy: 0.8070
Epoch 14/100
912/912 [==============================] - 0s 294us/step - loss: 0.5938 - accuracy: 0.7950 - val_loss: 0.6056 - val_accuracy: 0.8246
Epoch 15/100
912/912 [==============================] - 0s 297us/step - loss: 0.5685 - accuracy: 0.8081 - val_loss: 0.6007 - val_accuracy: 0.8202
Epoch 16/100
912/912 [==============================] - 0s 273us/step - loss: 0.5403 - accuracy: 0.8246 - val_loss: 0.5810 - val_accuracy: 0.8246
Epoch 17/100
912/912 [==============================] - 0s 285us/step - loss: 0.5582 - accuracy: 0.8059 - val_loss: 0.5780 - val_accuracy: 0.8509
Epoch 18/100
912/912 [==============================] - 0s 279us/step - loss: 0.5163 - accuracy: 0.8399 - val_loss: 0.7409 - val_accuracy: 0.7939
Epoch 19/100
912/912 [==============================] - 0s 275us/step - loss: 0.5562 - accuracy: 0.8026 - val_loss: 0.6927 - val_accuracy: 0.7500
Epoch 20/100
912/912 [==============================] - 0s 258us/step - loss: 0.5027 - accuracy: 0.8136 - val_loss: 0.4945 - val_accuracy: 0.8465
Epoch 21/100
912/912 [==============================] - 0s 245us/step - loss: 0.4585 - accuracy: 0.8596 - val_loss: 0.4988 - val_accuracy: 0.8333
Epoch 22/100
912/912 [==============================] - 0s 349us/step - loss: 0.4490 - accuracy: 0.8651 - val_loss: 0.4743 - val_accuracy: 0.8509
Epoch 23/100
912/912 [==============================] - 0s 269us/step - loss: 0.4202 - accuracy: 0.8651 - val_loss: 0.6104 - val_accuracy: 0.7632
Epoch 24/100
912/912 [==============================] - 0s 398us/step - loss: 0.4560 - accuracy: 0.8476 - val_loss: 0.5161 - val_accuracy: 0.8158
Epoch 25/100
912/912 [==============================] - 0s 363us/step - loss: 0.4251 - accuracy: 0.8520 - val_loss: 0.5097 - val_accuracy: 0.8202
Epoch 26/100
912/912 [==============================] - 0s 422us/step - loss: 0.4264 - accuracy: 0.8618 - val_loss: 0.4471 - val_accuracy: 0.8860
Epoch 27/100
912/912 [==============================] - 0s 307us/step - loss: 0.4295 - accuracy: 0.8520 - val_loss: 0.5040 - val_accuracy: 0.8421
Epoch 28/100
912/912 [==============================] - 0s 385us/step - loss: 0.4032 - accuracy: 0.8596 - val_loss: 0.4897 - val_accuracy: 0.8553
Epoch 29/100
912/912 [==============================] - 0s 449us/step - loss: 0.3584 - accuracy: 0.8958 - val_loss: 0.5101 - val_accuracy: 0.8377
Epoch 30/100
912/912 [==============================] - 0s 498us/step - loss: 0.4514 - accuracy: 0.8366 - val_loss: 0.4793 - val_accuracy: 0.8246
Epoch 31/100
912/912 [==============================] - 0s 508us/step - loss: 0.3450 - accuracy: 0.8794 - val_loss: 0.4502 - val_accuracy: 0.8509
Epoch 32/100
912/912 [==============================] - 1s 649us/step - loss: 0.3412 - accuracy: 0.8936 - val_loss: 0.5672 - val_accuracy: 0.8289
Epoch 33/100
912/912 [==============================] - 0s 471us/step - loss: 0.3720 - accuracy: 0.8706 - val_loss: 0.6147 - val_accuracy: 0.8114
Epoch 34/100
912/912 [==============================] - 0s 371us/step - loss: 0.3350 - accuracy: 0.8958 - val_loss: 0.3994 - val_accuracy: 0.8684
Epoch 35/100
912/912 [==============================] - 0s 426us/step - loss: 0.3302 - accuracy: 0.8936 - val_loss: 0.5187 - val_accuracy: 0.8114
Epoch 36/100
912/912 [==============================] - 0s 388us/step - loss: 0.3315 - accuracy: 0.8925 - val_loss: 0.5444 - val_accuracy: 0.8026
Epoch 37/100
912/912 [==============================] - 1s 584us/step - loss: 0.3849 - accuracy: 0.8750 - val_loss: 0.4985 - val_accuracy: 0.8158
Epoch 38/100
912/912 [==============================] - 0s 346us/step - loss: 0.2931 - accuracy: 0.9046 - val_loss: 0.4193 - val_accuracy: 0.8596
Epoch 39/100
912/912 [==============================] - 0s 371us/step - loss: 0.2934 - accuracy: 0.9167 - val_loss: 0.4957 - val_accuracy: 0.8289
Epoch 40/100
912/912 [==============================] - 0s 394us/step - loss: 0.3075 - accuracy: 0.9035 - val_loss: 0.5969 - val_accuracy: 0.8114
Epoch 41/100
912/912 [==============================] - 0s 344us/step - loss: 0.3097 - accuracy: 0.8980 - val_loss: 0.4194 - val_accuracy: 0.8596
Epoch 42/100
912/912 [==============================] - 0s 403us/step - loss: 0.3195 - accuracy: 0.8871 - val_loss: 0.4852 - val_accuracy: 0.8377
Epoch 43/100
912/912 [==============================] - 0s 499us/step - loss: 0.2788 - accuracy: 0.9101 - val_loss: 0.4200 - val_accuracy: 0.8465
Epoch 44/100
912/912 [==============================] - 0s 410us/step - loss: 0.2570 - accuracy: 0.9265 - val_loss: 0.3989 - val_accuracy: 0.8596
Epoch 45/100
912/912 [==============================] - 0s 378us/step - loss: 0.2705 - accuracy: 0.9079 - val_loss: 0.5573 - val_accuracy: 0.8070
Epoch 46/100
912/912 [==============================] - 0s 458us/step - loss: 0.2779 - accuracy: 0.9178 - val_loss: 0.4164 - val_accuracy: 0.8596
Epoch 47/100
912/912 [==============================] - 0s 526us/step - loss: 0.2495 - accuracy: 0.9221 - val_loss: 0.3790 - val_accuracy: 0.8728
Epoch 48/100
912/912 [==============================] - 1s 678us/step - loss: 0.3003 - accuracy: 0.8914 - val_loss: 0.5962 - val_accuracy: 0.8070
Epoch 49/100
912/912 [==============================] - 1s 625us/step - loss: 0.2714 - accuracy: 0.9156 - val_loss: 0.3860 - val_accuracy: 0.8816
Epoch 50/100
912/912 [==============================] - 1s 582us/step - loss: 0.2818 - accuracy: 0.8980 - val_loss: 0.4841 - val_accuracy: 0.8596
Epoch 51/100
912/912 [==============================] - 0s 495us/step - loss: 0.2804 - accuracy: 0.9013 - val_loss: 0.4012 - val_accuracy: 0.8728
Epoch 52/100
912/912 [==============================] - 0s 434us/step - loss: 0.2306 - accuracy: 0.9265 - val_loss: 0.4704 - val_accuracy: 0.8377
Epoch 53/100
912/912 [==============================] - 0s 330us/step - loss: 0.3080 - accuracy: 0.8783 - val_loss: 0.5931 - val_accuracy: 0.7719
Epoch 54/100
912/912 [==============================] - 0s 377us/step - loss: 0.3070 - accuracy: 0.8914 - val_loss: 0.5869 - val_accuracy: 0.7719
Epoch 55/100
912/912 [==============================] - 0s 353us/step - loss: 0.2369 - accuracy: 0.9254 - val_loss: 0.3767 - val_accuracy: 0.8728
Epoch 56/100
912/912 [==============================] - 0s 413us/step - loss: 0.2058 - accuracy: 0.9397 - val_loss: 0.4404 - val_accuracy: 0.8421
Epoch 57/100
912/912 [==============================] - 0s 381us/step - loss: 0.2970 - accuracy: 0.8991 - val_loss: 0.4261 - val_accuracy: 0.8553
Epoch 58/100
912/912 [==============================] - 0s 458us/step - loss: 0.2060 - accuracy: 0.9342 - val_loss: 0.3968 - val_accuracy: 0.8684
Epoch 59/100
912/912 [==============================] - 0s 523us/step - loss: 0.2294 - accuracy: 0.9254 - val_loss: 0.3865 - val_accuracy: 0.8816
Epoch 60/100
912/912 [==============================] - 1s 702us/step - loss: 0.1972 - accuracy: 0.9276 - val_loss: 0.4764 - val_accuracy: 0.8728
Epoch 61/100
912/912 [==============================] - 1s 709us/step - loss: 0.2488 - accuracy: 0.9079 - val_loss: 0.4340 - val_accuracy: 0.8553
Epoch 62/100
912/912 [==============================] - 1s 642us/step - loss: 0.2203 - accuracy: 0.9211 - val_loss: 0.3556 - val_accuracy: 0.8860
Epoch 63/100
912/912 [==============================] - 1s 787us/step - loss: 0.1869 - accuracy: 0.9441 - val_loss: 0.4188 - val_accuracy: 0.8596
Epoch 64/100
912/912 [==============================] - 1s 627us/step - loss: 0.1809 - accuracy: 0.9452 - val_loss: 0.4900 - val_accuracy: 0.8465
Epoch 65/100
912/912 [==============================] - 0s 494us/step - loss: 0.2186 - accuracy: 0.9265 - val_loss: 0.4840 - val_accuracy: 0.8377
Epoch 66/100
912/912 [==============================] - 0s 517us/step - loss: 0.1989 - accuracy: 0.9386 - val_loss: 0.3763 - val_accuracy: 0.8772
Epoch 67/100
912/912 [==============================] - 0s 415us/step - loss: 0.1555 - accuracy: 0.9583 - val_loss: 0.3873 - val_accuracy: 0.8684
Epoch 68/100
912/912 [==============================] - 0s 508us/step - loss: 0.1621 - accuracy: 0.9539 - val_loss: 0.4367 - val_accuracy: 0.8509
Epoch 69/100
912/912 [==============================] - 0s 458us/step - loss: 0.1914 - accuracy: 0.9397 - val_loss: 0.3869 - val_accuracy: 0.8728
Epoch 70/100
912/912 [==============================] - 0s 399us/step - loss: 0.2007 - accuracy: 0.9320 - val_loss: 0.3875 - val_accuracy: 0.8816
Epoch 71/100
912/912 [==============================] - 0s 428us/step - loss: 0.1522 - accuracy: 0.9671 - val_loss: 0.3730 - val_accuracy: 0.8772
Epoch 72/100
912/912 [==============================] - 0s 495us/step - loss: 0.1451 - accuracy: 0.9649 - val_loss: 0.4252 - val_accuracy: 0.8377
Epoch 73/100
912/912 [==============================] - 0s 452us/step - loss: 0.1410 - accuracy: 0.9671 - val_loss: 0.4266 - val_accuracy: 0.8640
Epoch 74/100
912/912 [==============================] - 1s 906us/step - loss: 0.2045 - accuracy: 0.9265 - val_loss: 0.4284 - val_accuracy: 0.8509
Epoch 75/100
912/912 [==============================] - 1s 809us/step - loss: 0.1417 - accuracy: 0.9572 - val_loss: 0.4306 - val_accuracy: 0.8377
Epoch 76/100
912/912 [==============================] - 1s 740us/step - loss: 0.1723 - accuracy: 0.9452 - val_loss: 0.3701 - val_accuracy: 0.8991
Epoch 77/100
912/912 [==============================] - 1s 749us/step - loss: 0.2276 - accuracy: 0.9189 - val_loss: 0.3804 - val_accuracy: 0.8904
Epoch 78/100
912/912 [==============================] - 1s 813us/step - loss: 0.1231 - accuracy: 0.9715 - val_loss: 0.4148 - val_accuracy: 0.8596
Epoch 79/100
912/912 [==============================] - 1s 831us/step - loss: 0.1536 - accuracy: 0.9485 - val_loss: 0.4078 - val_accuracy: 0.8553
Epoch 80/100
912/912 [==============================] - 1s 814us/step - loss: 0.1213 - accuracy: 0.9704 - val_loss: 0.4201 - val_accuracy: 0.8684
Epoch 81/100
912/912 [==============================] - 1s 701us/step - loss: 0.1245 - accuracy: 0.9693 - val_loss: 0.3758 - val_accuracy: 0.8904
Epoch 82/100
912/912 [==============================] - 1s 759us/step - loss: 0.1510 - accuracy: 0.9507 - val_loss: 0.6575 - val_accuracy: 0.7939
Epoch 83/100
912/912 [==============================] - 1s 895us/step - loss: 0.1361 - accuracy: 0.9627 - val_loss: 0.3853 - val_accuracy: 0.8728
Epoch 84/100
912/912 [==============================] - 1s 797us/step - loss: 0.1269 - accuracy: 0.9627 - val_loss: 0.5673 - val_accuracy: 0.8289
Epoch 85/100
912/912 [==============================] - 1s 729us/step - loss: 0.1184 - accuracy: 0.9781 - val_loss: 0.3799 - val_accuracy: 0.8816
Epoch 86/100
912/912 [==============================] - 1s 599us/step - loss: 0.1416 - accuracy: 0.9539 - val_loss: 0.5975 - val_accuracy: 0.8421
Epoch 87/100
912/912 [==============================] - 0s 533us/step - loss: 0.1294 - accuracy: 0.9616 - val_loss: 0.5008 - val_accuracy: 0.8553
Epoch 88/100
912/912 [==============================] - 1s 554us/step - loss: 0.1907 - accuracy: 0.9331 - val_loss: 0.5433 - val_accuracy: 0.8158
Epoch 89/100
912/912 [==============================] - 0s 462us/step - loss: 0.1299 - accuracy: 0.9726 - val_loss: 0.4458 - val_accuracy: 0.8465
Epoch 90/100
912/912 [==============================] - 0s 537us/step - loss: 0.1194 - accuracy: 0.9638 - val_loss: 0.3898 - val_accuracy: 0.8816
Epoch 91/100
912/912 [==============================] - 1s 602us/step - loss: 0.1078 - accuracy: 0.9748 - val_loss: 0.3865 - val_accuracy: 0.8904
Epoch 92/100
912/912 [==============================] - 0s 446us/step - loss: 0.1152 - accuracy: 0.9693 - val_loss: 0.4933 - val_accuracy: 0.8553
Epoch 93/100
912/912 [==============================] - 1s 550us/step - loss: 0.2413 - accuracy: 0.9079 - val_loss: 0.5272 - val_accuracy: 0.8377
Epoch 94/100
912/912 [==============================] - 1s 590us/step - loss: 0.1461 - accuracy: 0.9507 - val_loss: 0.3840 - val_accuracy: 0.8640
Epoch 95/100
912/912 [==============================] - 0s 469us/step - loss: 0.1025 - accuracy: 0.9671 - val_loss: 0.3649 - val_accuracy: 0.8860
Epoch 96/100
912/912 [==============================] - 1s 656us/step - loss: 0.1038 - accuracy: 0.9693 - val_loss: 0.4356 - val_accuracy: 0.8553
Epoch 97/100
912/912 [==============================] - 1s 614us/step - loss: 0.0936 - accuracy: 0.9792 - val_loss: 0.4444 - val_accuracy: 0.8640
Epoch 98/100
912/912 [==============================] - 1s 642us/step - loss: 0.1224 - accuracy: 0.9616 - val_loss: 0.6326 - val_accuracy: 0.8070
Epoch 99/100
912/912 [==============================] - 1s 641us/step - loss: 0.0959 - accuracy: 0.9803 - val_loss: 0.3762 - val_accuracy: 0.8991
Epoch 100/100
912/912 [==============================] - 0s 426us/step - loss: 0.1022 - accuracy: 0.9704 - val_loss: 0.4051 - val_accuracy: 0.8816

keras's fit function returns a history object containing information about the training and validation accuracies measured following each epoch of the training. Let's use that information to plot the training and validation accuracy over time.

```python
def show_history(hist):
    acc = hist.history['accuracy']
    val_acc = hist.history['val_accuracy']
    epochs = range(1, len(acc) + 1)

    plt.plot(epochs, acc, '-', label='Training Accuracy')
    plt.plot(epochs, val_acc, ':', label='Validation Accuracy')
    plt.title('Training and Validation Accuracy')
    plt.xlabel('Epoch')
    plt.ylabel('Accuracy')
    plt.legend(loc='lower right')
    plt.plot()
    
show_history(hist)
```

In all likelihood, the training accuracy approached 100% (1.0) in later epochs, while the validation accuracy peaked out between 80% and 90%. Let's try widening the working layer to 512 neurons and comparing the results.

```python
model = Sequential()
model.add(Dense(512, activation='relu', input_shape=(image_width * image_height,)))
model.add(Dense(class_count, activation='softmax'))
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
hist = model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=100, batch_size=25)
```

Train on 912 samples, validate on 228 samples
Epoch 1/100
912/912 [==============================] - 2s 2ms/step - loss: 2.6869 - accuracy: 0.3147 - val_loss: 1.3441 - val_accuracy: 0.4649
Epoch 2/100
912/912 [==============================] - 1s 2ms/step - loss: 1.2892 - accuracy: 0.5274 - val_loss: 1.2221 - val_accuracy: 0.4956
Epoch 3/100
912/912 [==============================] - 1s 1ms/step - loss: 1.1908 - accuracy: 0.5724 - val_loss: 1.1404 - val_accuracy: 0.6096
Epoch 4/100
912/912 [==============================] - 1s 1ms/step - loss: 1.1108 - accuracy: 0.5779 - val_loss: 1.1174 - val_accuracy: 0.6228
Epoch 5/100
912/912 [==============================] - 1s 1ms/step - loss: 1.0865 - accuracy: 0.6086 - val_loss: 1.0726 - val_accuracy: 0.6053
Epoch 6/100
912/912 [==============================] - 1s 1ms/step - loss: 0.9285 - accuracy: 0.6798 - val_loss: 0.8657 - val_accuracy: 0.7105
Epoch 7/100
912/912 [==============================] - 1s 1ms/step - loss: 0.8611 - accuracy: 0.6908 - val_loss: 0.8076 - val_accuracy: 0.7588
Epoch 8/100
912/912 [==============================] - 1s 1ms/step - loss: 0.8237 - accuracy: 0.7193 - val_loss: 0.7907 - val_accuracy: 0.7325
Epoch 9/100
912/912 [==============================] - 1s 1ms/step - loss: 0.7768 - accuracy: 0.7094 - val_loss: 0.8126 - val_accuracy: 0.7325
Epoch 10/100
912/912 [==============================] - 1s 1ms/step - loss: 0.7148 - accuracy: 0.7610 - val_loss: 0.8015 - val_accuracy: 0.7939
Epoch 11/100
912/912 [==============================] - 2s 2ms/step - loss: 0.7783 - accuracy: 0.7127 - val_loss: 0.8668 - val_accuracy: 0.6842
Epoch 12/100
912/912 [==============================] - 1s 2ms/step - loss: 0.6662 - accuracy: 0.7730 - val_loss: 0.6606 - val_accuracy: 0.7807
Epoch 13/100
912/912 [==============================] - 2s 2ms/step - loss: 0.6318 - accuracy: 0.7851 - val_loss: 0.6414 - val_accuracy: 0.7982
Epoch 14/100
912/912 [==============================] - 1s 1ms/step - loss: 0.5620 - accuracy: 0.8114 - val_loss: 0.6658 - val_accuracy: 0.7807
Epoch 15/100
912/912 [==============================] - 1s 1ms/step - loss: 0.6075 - accuracy: 0.7993 - val_loss: 0.6141 - val_accuracy: 0.8026
Epoch 16/100
912/912 [==============================] - 1s 1ms/step - loss: 0.4982 - accuracy: 0.8366 - val_loss: 0.4963 - val_accuracy: 0.8553
Epoch 17/100
912/912 [==============================] - 1s 1ms/step - loss: 0.4504 - accuracy: 0.8662 - val_loss: 0.5229 - val_accuracy: 0.8333
Epoch 18/100
912/912 [==============================] - 1s 983us/step - loss: 0.4812 - accuracy: 0.8377 - val_loss: 0.5792 - val_accuracy: 0.8114
Epoch 19/100
912/912 [==============================] - 1s 983us/step - loss: 0.4676 - accuracy: 0.8531 - val_loss: 0.7442 - val_accuracy: 0.7105
Epoch 20/100
912/912 [==============================] - 1s 1ms/step - loss: 0.5340 - accuracy: 0.8114 - val_loss: 0.5768 - val_accuracy: 0.7982
Epoch 21/100
912/912 [==============================] - 1s 1ms/step - loss: 0.4351 - accuracy: 0.8607 - val_loss: 0.5489 - val_accuracy: 0.8246
Epoch 22/100
912/912 [==============================] - 1s 979us/step - loss: 0.5662 - accuracy: 0.7928 - val_loss: 0.7664 - val_accuracy: 0.7807
Epoch 23/100
912/912 [==============================] - 1s 897us/step - loss: 0.4993 - accuracy: 0.8136 - val_loss: 0.4207 - val_accuracy: 0.8772
Epoch 24/100
912/912 [==============================] - 1s 987us/step - loss: 0.3686 - accuracy: 0.8860 - val_loss: 0.4181 - val_accuracy: 0.8860
Epoch 25/100
912/912 [==============================] - 1s 854us/step - loss: 0.4091 - accuracy: 0.8629 - val_loss: 0.5302 - val_accuracy: 0.7939
Epoch 26/100
912/912 [==============================] - 1s 1ms/step - loss: 0.4413 - accuracy: 0.8377 - val_loss: 0.4966 - val_accuracy: 0.8289
Epoch 27/100
912/912 [==============================] - 1s 844us/step - loss: 0.4253 - accuracy: 0.8662 - val_loss: 0.5573 - val_accuracy: 0.8026
Epoch 28/100
912/912 [==============================] - 1s 906us/step - loss: 0.3722 - accuracy: 0.8871 - val_loss: 0.4461 - val_accuracy: 0.8465
Epoch 29/100
912/912 [==============================] - 1s 842us/step - loss: 0.3880 - accuracy: 0.8553 - val_loss: 0.4718 - val_accuracy: 0.8246
Epoch 30/100
912/912 [==============================] - 1s 1ms/step - loss: 0.3231 - accuracy: 0.8914 - val_loss: 0.4161 - val_accuracy: 0.8816
Epoch 31/100
912/912 [==============================] - 1s 1ms/step - loss: 0.3367 - accuracy: 0.8893 - val_loss: 0.3975 - val_accuracy: 0.8640
Epoch 32/100
912/912 [==============================] - 1s 1ms/step - loss: 0.3480 - accuracy: 0.8849 - val_loss: 0.4707 - val_accuracy: 0.8553
Epoch 33/100
912/912 [==============================] - 1s 1ms/step - loss: 0.4201 - accuracy: 0.8575 - val_loss: 0.4719 - val_accuracy: 0.8377
Epoch 34/100
912/912 [==============================] - 2s 2ms/step - loss: 0.3236 - accuracy: 0.8904 - val_loss: 0.4144 - val_accuracy: 0.8772
Epoch 35/100
912/912 [==============================] - 1s 1ms/step - loss: 0.2876 - accuracy: 0.9090 - val_loss: 0.3868 - val_accuracy: 0.8553
Epoch 36/100
912/912 [==============================] - 1s 1ms/step - loss: 0.3250 - accuracy: 0.8904 - val_loss: 0.4251 - val_accuracy: 0.8509
Epoch 37/100
912/912 [==============================] - 1s 777us/step - loss: 0.2997 - accuracy: 0.9013 - val_loss: 0.4343 - val_accuracy: 0.8596
Epoch 38/100
912/912 [==============================] - 1s 924us/step - loss: 0.2973 - accuracy: 0.8958 - val_loss: 0.4753 - val_accuracy: 0.8640
Epoch 39/100
912/912 [==============================] - 1s 848us/step - loss: 0.3244 - accuracy: 0.8816 - val_loss: 0.8080 - val_accuracy: 0.7368
Epoch 40/100
912/912 [==============================] - 1s 838us/step - loss: 0.4173 - accuracy: 0.8443 - val_loss: 0.4753 - val_accuracy: 0.8421
Epoch 41/100
912/912 [==============================] - 1s 931us/step - loss: 0.2751 - accuracy: 0.9068 - val_loss: 0.4038 - val_accuracy: 0.8596
Epoch 42/100
912/912 [==============================] - 1s 837us/step - loss: 0.2497 - accuracy: 0.9156 - val_loss: 0.4223 - val_accuracy: 0.8596
Epoch 43/100
912/912 [==============================] - 1s 749us/step - loss: 0.2135 - accuracy: 0.9342 - val_loss: 0.4158 - val_accuracy: 0.8465
Epoch 44/100
912/912 [==============================] - 1s 812us/step - loss: 0.2363 - accuracy: 0.9211 - val_loss: 0.3891 - val_accuracy: 0.8772
Epoch 45/100
912/912 [==============================] - 1s 885us/step - loss: 0.2813 - accuracy: 0.9013 - val_loss: 0.3594 - val_accuracy: 0.8947
Epoch 46/100
912/912 [==============================] - 1s 1ms/step - loss: 0.2884 - accuracy: 0.8969 - val_loss: 0.4269 - val_accuracy: 0.8465
Epoch 47/100
912/912 [==============================] - 1s 1ms/step - loss: 0.2086 - accuracy: 0.9276 - val_loss: 0.5600 - val_accuracy: 0.8026
Epoch 48/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1930 - accuracy: 0.9441 - val_loss: 0.3703 - val_accuracy: 0.9035
Epoch 49/100
912/912 [==============================] - 1s 756us/step - loss: 0.1915 - accuracy: 0.9430 - val_loss: 0.4014 - val_accuracy: 0.8553
Epoch 50/100
912/912 [==============================] - 1s 991us/step - loss: 0.2279 - accuracy: 0.9265 - val_loss: 0.4207 - val_accuracy: 0.8728
Epoch 51/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1967 - accuracy: 0.9364 - val_loss: 0.7295 - val_accuracy: 0.7456
Epoch 52/100
912/912 [==============================] - 1s 1ms/step - loss: 0.2703 - accuracy: 0.9068 - val_loss: 0.4158 - val_accuracy: 0.8640
Epoch 53/100
912/912 [==============================] - 1s 1ms/step - loss: 0.2297 - accuracy: 0.9211 - val_loss: 0.3866 - val_accuracy: 0.8640
Epoch 54/100
912/912 [==============================] - 1s 863us/step - loss: 0.1898 - accuracy: 0.9386 - val_loss: 0.4670 - val_accuracy: 0.8377
Epoch 55/100
912/912 [==============================] - 1s 741us/step - loss: 0.1855 - accuracy: 0.9397 - val_loss: 0.4504 - val_accuracy: 0.8860
Epoch 56/100
912/912 [==============================] - 1s 821us/step - loss: 0.2434 - accuracy: 0.9243 - val_loss: 0.4797 - val_accuracy: 0.8377
Epoch 57/100
912/912 [==============================] - 1s 994us/step - loss: 0.1714 - accuracy: 0.9463 - val_loss: 0.3624 - val_accuracy: 0.8947
Epoch 58/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1911 - accuracy: 0.9353 - val_loss: 0.4688 - val_accuracy: 0.8246
Epoch 59/100
912/912 [==============================] - 2s 2ms/step - loss: 0.1689 - accuracy: 0.9430 - val_loss: 0.3758 - val_accuracy: 0.8816
Epoch 60/100
912/912 [==============================] - 2s 2ms/step - loss: 0.1414 - accuracy: 0.9583 - val_loss: 0.4201 - val_accuracy: 0.8509
Epoch 61/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1424 - accuracy: 0.9572 - val_loss: 0.3741 - val_accuracy: 0.8684
Epoch 62/100
912/912 [==============================] - 1s 979us/step - loss: 0.1312 - accuracy: 0.9682 - val_loss: 0.4030 - val_accuracy: 0.8860
Epoch 63/100
912/912 [==============================] - 1s 939us/step - loss: 0.1780 - accuracy: 0.9364 - val_loss: 0.4299 - val_accuracy: 0.8728
Epoch 64/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1614 - accuracy: 0.9463 - val_loss: 0.4114 - val_accuracy: 0.8728
Epoch 65/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1751 - accuracy: 0.9397 - val_loss: 0.3800 - val_accuracy: 0.8728
Epoch 66/100
912/912 [==============================] - 1s 923us/step - loss: 0.1528 - accuracy: 0.9518 - val_loss: 0.4512 - val_accuracy: 0.8553
Epoch 67/100
912/912 [==============================] - 1s 877us/step - loss: 0.1287 - accuracy: 0.9649 - val_loss: 0.4567 - val_accuracy: 0.8816
Epoch 68/100
912/912 [==============================] - 1s 903us/step - loss: 0.1524 - accuracy: 0.9529 - val_loss: 0.5017 - val_accuracy: 0.8333
Epoch 69/100
912/912 [==============================] - 1s 979us/step - loss: 0.1496 - accuracy: 0.9463 - val_loss: 0.4467 - val_accuracy: 0.8640
Epoch 70/100
912/912 [==============================] - 1s 942us/step - loss: 0.2098 - accuracy: 0.9254 - val_loss: 0.7081 - val_accuracy: 0.7982
Epoch 71/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1865 - accuracy: 0.9386 - val_loss: 0.6780 - val_accuracy: 0.7763
Epoch 72/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1665 - accuracy: 0.9529 - val_loss: 0.4137 - val_accuracy: 0.8509
Epoch 73/100
912/912 [==============================] - 1s 986us/step - loss: 0.1286 - accuracy: 0.9550 - val_loss: 0.4641 - val_accuracy: 0.8553
Epoch 74/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1356 - accuracy: 0.9594 - val_loss: 0.3864 - val_accuracy: 0.8991
Epoch 75/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1744 - accuracy: 0.9518 - val_loss: 0.5702 - val_accuracy: 0.8070
Epoch 76/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1459 - accuracy: 0.9561 - val_loss: 0.4275 - val_accuracy: 0.8904
Epoch 77/100
912/912 [==============================] - 1s 783us/step - loss: 0.1033 - accuracy: 0.9748 - val_loss: 0.3795 - val_accuracy: 0.8860
Epoch 78/100
912/912 [==============================] - 1s 1ms/step - loss: 0.0878 - accuracy: 0.9781 - val_loss: 0.3890 - val_accuracy: 0.8640
Epoch 79/100
912/912 [==============================] - 1s 1ms/step - loss: 0.0891 - accuracy: 0.9792 - val_loss: 0.4483 - val_accuracy: 0.8553
Epoch 80/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1188 - accuracy: 0.9572 - val_loss: 0.3944 - val_accuracy: 0.8684
Epoch 81/100
912/912 [==============================] - 1s 1ms/step - loss: 0.2067 - accuracy: 0.9243 - val_loss: 0.5785 - val_accuracy: 0.8114
Epoch 82/100
912/912 [==============================] - 1s 759us/step - loss: 0.1789 - accuracy: 0.9331 - val_loss: 0.9625 - val_accuracy: 0.7632
Epoch 83/100
912/912 [==============================] - 1s 828us/step - loss: 0.2174 - accuracy: 0.9189 - val_loss: 0.4735 - val_accuracy: 0.8509
Epoch 84/100
912/912 [==============================] - 1s 860us/step - loss: 0.0957 - accuracy: 0.9737 - val_loss: 0.4941 - val_accuracy: 0.8553
Epoch 85/100
912/912 [==============================] - 1s 905us/step - loss: 0.1261 - accuracy: 0.9583 - val_loss: 0.3931 - val_accuracy: 0.8684
Epoch 86/100
912/912 [==============================] - 1s 850us/step - loss: 0.0804 - accuracy: 0.9814 - val_loss: 0.3875 - val_accuracy: 0.8596
Epoch 87/100
912/912 [==============================] - 1s 857us/step - loss: 0.0823 - accuracy: 0.9781 - val_loss: 0.3714 - val_accuracy: 0.8816
Epoch 88/100
912/912 [==============================] - 1s 893us/step - loss: 0.0997 - accuracy: 0.9781 - val_loss: 0.4320 - val_accuracy: 0.8465
Epoch 89/100
912/912 [==============================] - 1s 935us/step - loss: 0.0654 - accuracy: 0.9868 - val_loss: 0.3846 - val_accuracy: 0.8947
Epoch 90/100
912/912 [==============================] - 1s 1ms/step - loss: 0.1077 - accuracy: 0.9682 - val_loss: 0.5073 - val_accuracy: 0.8509
Epoch 91/100
912/912 [==============================] - 1s 1ms/step - loss: 0.2256 - accuracy: 0.9123 - val_loss: 0.5296 - val_accuracy: 0.8333
Epoch 92/100
912/912 [==============================] - 1s 927us/step - loss: 0.1008 - accuracy: 0.9726 - val_loss: 0.4487 - val_accuracy: 0.8553
Epoch 93/100
912/912 [==============================] - 1s 873us/step - loss: 0.0614 - accuracy: 0.9901 - val_loss: 0.4266 - val_accuracy: 0.8640
Epoch 94/100
912/912 [==============================] - 1s 893us/step - loss: 0.0669 - accuracy: 0.9857 - val_loss: 0.5734 - val_accuracy: 0.8246
Epoch 95/100
912/912 [==============================] - 1s 977us/step - loss: 0.0990 - accuracy: 0.9704 - val_loss: 0.4536 - val_accuracy: 0.8772
Epoch 96/100
912/912 [==============================] - 1s 1ms/step - loss: 0.0641 - accuracy: 0.9846 - val_loss: 0.4583 - val_accuracy: 0.8553
Epoch 97/100
912/912 [==============================] - 1s 1ms/step - loss: 0.0583 - accuracy: 0.9912 - val_loss: 0.4090 - val_accuracy: 0.8684
Epoch 98/100
912/912 [==============================] - 1s 1ms/step - loss: 0.0600 - accuracy: 0.9868 - val_loss: 0.4453 - val_accuracy: 0.8684
Epoch 99/100
912/912 [==============================] - 1s 845us/step - loss: 0.0555 - accuracy: 0.9890 - val_loss: 0.4216 - val_accuracy: 0.8553
Epoch 100/100
912/912 [==============================] - 1s 1ms/step - loss: 0.0817 - accuracy: 0.9770 - val_loss: 0.8871 - val_accuracy: 0.7500
Once more, we will plot the accuracy over time to assess how well the network learned from the training data.

In [9]:
show_history(hist)

Were the results significantly different than before? Probably not. But now let's modify the network so that it contains four hidden layers of 128 neurons each. It's the same number of neurons as the previous model, but the network itself is narrower and deeper. You should find that this model trains somewhat faster.

In [10]:
model = Sequential()
model.add(Dense(128, activation='relu', input_shape=(image_width * image_height,)))
model.add(Dense(128, activation='relu'))
model.add(Dense(128, activation='relu'))
model.add(Dense(128, activation='relu'))
model.add(Dense(class_count, activation='softmax'))
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
hist = model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=100, batch_size=25)
Train on 912 samples, validate on 228 samples
Epoch 1/100
912/912 [==============================] - 1s 1ms/step - loss: 1.4706 - accuracy: 0.4408 - val_loss: 1.3985 - val_accuracy: 0.4649
Epoch 2/100
912/912 [==============================] - 0s 450us/step - loss: 1.4029 - accuracy: 0.4583 - val_loss: 1.3895 - val_accuracy: 0.4649
Epoch 3/100
912/912 [==============================] - 0s 381us/step - loss: 1.3479 - accuracy: 0.4890 - val_loss: 1.2512 - val_accuracy: 0.5877
Epoch 4/100
912/912 [==============================] - 0s 332us/step - loss: 1.3065 - accuracy: 0.5143 - val_loss: 1.2408 - val_accuracy: 0.5307
Epoch 5/100
912/912 [==============================] - 0s 321us/step - loss: 1.1978 - accuracy: 0.5559 - val_loss: 1.0710 - val_accuracy: 0.6053
Epoch 6/100
912/912 [==============================] - 0s 265us/step - loss: 1.1037 - accuracy: 0.5691 - val_loss: 1.0260 - val_accuracy: 0.6272
Epoch 7/100
912/912 [==============================] - 0s 293us/step - loss: 1.0686 - accuracy: 0.5855 - val_loss: 1.1008 - val_accuracy: 0.6184
Epoch 8/100
912/912 [==============================] - 0s 259us/step - loss: 1.0372 - accuracy: 0.6151 - val_loss: 0.8705 - val_accuracy: 0.6535
Epoch 9/100
912/912 [==============================] - 0s 291us/step - loss: 0.9364 - accuracy: 0.6425 - val_loss: 0.8780 - val_accuracy: 0.6754
Epoch 10/100
912/912 [==============================] - 0s 310us/step - loss: 0.8382 - accuracy: 0.6711 - val_loss: 0.8708 - val_accuracy: 0.6798
Epoch 11/100
912/912 [==============================] - 0s 325us/step - loss: 0.7812 - accuracy: 0.6886 - val_loss: 0.7437 - val_accuracy: 0.7412
Epoch 12/100
912/912 [==============================] - 0s 287us/step - loss: 0.8281 - accuracy: 0.6743 - val_loss: 0.9776 - val_accuracy: 0.6579
Epoch 13/100
912/912 [==============================] - 0s 315us/step - loss: 0.7495 - accuracy: 0.7083 - val_loss: 0.8548 - val_accuracy: 0.6974
Epoch 14/100
912/912 [==============================] - 0s 413us/step - loss: 0.6566 - accuracy: 0.7610 - val_loss: 0.8852 - val_accuracy: 0.6754
Epoch 15/100
912/912 [==============================] - 0s 311us/step - loss: 0.7410 - accuracy: 0.7357 - val_loss: 0.5672 - val_accuracy: 0.7895
Epoch 16/100
912/912 [==============================] - 0s 299us/step - loss: 0.6089 - accuracy: 0.7577 - val_loss: 0.5285 - val_accuracy: 0.8246
Epoch 17/100
912/912 [==============================] - 0s 274us/step - loss: 0.5855 - accuracy: 0.7785 - val_loss: 0.6046 - val_accuracy: 0.7719
Epoch 18/100
912/912 [==============================] - 0s 335us/step - loss: 0.5005 - accuracy: 0.8224 - val_loss: 0.5993 - val_accuracy: 0.7939
Epoch 19/100
912/912 [==============================] - 0s 323us/step - loss: 0.5983 - accuracy: 0.7818 - val_loss: 0.6424 - val_accuracy: 0.7719
Epoch 20/100
912/912 [==============================] - 0s 324us/step - loss: 0.4729 - accuracy: 0.8279 - val_loss: 1.0061 - val_accuracy: 0.6798
Epoch 21/100
912/912 [==============================] - 0s 280us/step - loss: 0.5420 - accuracy: 0.7851 - val_loss: 0.5597 - val_accuracy: 0.7939
Epoch 22/100
912/912 [==============================] - 0s 457us/step - loss: 0.5609 - accuracy: 0.7928 - val_loss: 0.5401 - val_accuracy: 0.7895
Epoch 23/100
912/912 [==============================] - 0s 536us/step - loss: 0.5755 - accuracy: 0.7917 - val_loss: 0.5380 - val_accuracy: 0.7982
Epoch 24/100
912/912 [==============================] - 0s 529us/step - loss: 0.4916 - accuracy: 0.8410 - val_loss: 0.5199 - val_accuracy: 0.8026
Epoch 25/100
912/912 [==============================] - 0s 507us/step - loss: 0.4021 - accuracy: 0.8673 - val_loss: 0.4160 - val_accuracy: 0.8553
Epoch 26/100
912/912 [==============================] - 0s 508us/step - loss: 0.3662 - accuracy: 0.8684 - val_loss: 0.5896 - val_accuracy: 0.7982
Epoch 27/100
912/912 [==============================] - 1s 570us/step - loss: 0.4375 - accuracy: 0.8443 - val_loss: 0.7819 - val_accuracy: 0.7325
Epoch 28/100
912/912 [==============================] - 1s 672us/step - loss: 0.4187 - accuracy: 0.8531 - val_loss: 0.3739 - val_accuracy: 0.8772
Epoch 29/100
912/912 [==============================] - 0s 402us/step - loss: 0.3659 - accuracy: 0.8761 - val_loss: 0.8119 - val_accuracy: 0.7105
Epoch 30/100
912/912 [==============================] - 0s 381us/step - loss: 0.4292 - accuracy: 0.8487 - val_loss: 0.4476 - val_accuracy: 0.8465
Epoch 31/100
912/912 [==============================] - 0s 490us/step - loss: 0.3337 - accuracy: 0.8991 - val_loss: 0.4788 - val_accuracy: 0.8246
Epoch 32/100
912/912 [==============================] - 0s 515us/step - loss: 0.3050 - accuracy: 0.8882 - val_loss: 0.4598 - val_accuracy: 0.8114
Epoch 33/100
912/912 [==============================] - 0s 327us/step - loss: 0.3088 - accuracy: 0.8882 - val_loss: 0.5002 - val_accuracy: 0.8289
Epoch 34/100
912/912 [==============================] - 0s 356us/step - loss: 0.3607 - accuracy: 0.8728 - val_loss: 0.4495 - val_accuracy: 0.8421
Epoch 35/100
912/912 [==============================] - 0s 331us/step - loss: 0.2739 - accuracy: 0.9013 - val_loss: 0.5770 - val_accuracy: 0.7982
Epoch 36/100
912/912 [==============================] - 0s 308us/step - loss: 0.3039 - accuracy: 0.8914 - val_loss: 0.4118 - val_accuracy: 0.8596
Epoch 37/100
912/912 [==============================] - 0s 350us/step - loss: 0.5169 - accuracy: 0.8235 - val_loss: 0.9512 - val_accuracy: 0.7368
Epoch 38/100
912/912 [==============================] - 0s 451us/step - loss: 0.3537 - accuracy: 0.8761 - val_loss: 0.4046 - val_accuracy: 0.8553
Epoch 39/100
912/912 [==============================] - 0s 517us/step - loss: 0.2184 - accuracy: 0.9287 - val_loss: 0.4919 - val_accuracy: 0.8246
Epoch 40/100
912/912 [==============================] - 0s 406us/step - loss: 0.2709 - accuracy: 0.9112 - val_loss: 0.3942 - val_accuracy: 0.8553
Epoch 41/100
912/912 [==============================] - 0s 361us/step - loss: 0.2216 - accuracy: 0.9156 - val_loss: 0.6044 - val_accuracy: 0.8246
Epoch 42/100
912/912 [==============================] - 0s 381us/step - loss: 0.3471 - accuracy: 0.8750 - val_loss: 0.6026 - val_accuracy: 0.8026
Epoch 43/100
912/912 [==============================] - 0s 325us/step - loss: 0.4488 - accuracy: 0.8366 - val_loss: 0.4119 - val_accuracy: 0.8553
Epoch 44/100
912/912 [==============================] - 0s 278us/step - loss: 0.2982 - accuracy: 0.8947 - val_loss: 0.7837 - val_accuracy: 0.8026
Epoch 45/100
912/912 [==============================] - 0s 295us/step - loss: 0.2480 - accuracy: 0.9123 - val_loss: 0.4240 - val_accuracy: 0.8509
Epoch 46/100
912/912 [==============================] - 0s 342us/step - loss: 0.3298 - accuracy: 0.8783 - val_loss: 0.4134 - val_accuracy: 0.8553
Epoch 47/100
912/912 [==============================] - 0s 493us/step - loss: 0.2761 - accuracy: 0.8969 - val_loss: 0.3564 - val_accuracy: 0.8860
Epoch 48/100
912/912 [==============================] - 0s 472us/step - loss: 0.2153 - accuracy: 0.9265 - val_loss: 0.4636 - val_accuracy: 0.8333
Epoch 49/100
912/912 [==============================] - 1s 607us/step - loss: 0.2545 - accuracy: 0.9112 - val_loss: 0.4598 - val_accuracy: 0.8421
Epoch 50/100
912/912 [==============================] - 0s 456us/step - loss: 0.2584 - accuracy: 0.8991 - val_loss: 0.4204 - val_accuracy: 0.8509
Epoch 51/100
912/912 [==============================] - 0s 515us/step - loss: 0.2464 - accuracy: 0.9123 - val_loss: 0.5506 - val_accuracy: 0.8333
Epoch 52/100
912/912 [==============================] - 0s 370us/step - loss: 0.2494 - accuracy: 0.9167 - val_loss: 0.5455 - val_accuracy: 0.8333
Epoch 53/100
912/912 [==============================] - 1s 590us/step - loss: 0.2978 - accuracy: 0.8947 - val_loss: 0.4066 - val_accuracy: 0.8421
Epoch 54/100
912/912 [==============================] - 0s 535us/step - loss: 0.2235 - accuracy: 0.9200 - val_loss: 0.4580 - val_accuracy: 0.8553
Epoch 55/100
912/912 [==============================] - 0s 543us/step - loss: 0.2838 - accuracy: 0.8914 - val_loss: 0.3742 - val_accuracy: 0.8640
Epoch 56/100
912/912 [==============================] - 1s 601us/step - loss: 0.2492 - accuracy: 0.9079 - val_loss: 0.5299 - val_accuracy: 0.8289
Epoch 57/100
912/912 [==============================] - 0s 433us/step - loss: 0.1787 - accuracy: 0.9430 - val_loss: 0.3940 - val_accuracy: 0.8772
Epoch 58/100
912/912 [==============================] - 0s 425us/step - loss: 0.1417 - accuracy: 0.9539 - val_loss: 0.5732 - val_accuracy: 0.8333
Epoch 59/100
912/912 [==============================] - 0s 297us/step - loss: 0.1661 - accuracy: 0.9364 - val_loss: 0.5132 - val_accuracy: 0.8421
Epoch 60/100
912/912 [==============================] - 0s 314us/step - loss: 0.2697 - accuracy: 0.9024 - val_loss: 0.8622 - val_accuracy: 0.7412
Epoch 61/100
912/912 [==============================] - 0s 304us/step - loss: 0.2894 - accuracy: 0.9013 - val_loss: 0.5437 - val_accuracy: 0.8246
Epoch 62/100
912/912 [==============================] - 0s 431us/step - loss: 0.1729 - accuracy: 0.9375 - val_loss: 0.3942 - val_accuracy: 0.8684
Epoch 63/100
912/912 [==============================] - 0s 491us/step - loss: 0.1845 - accuracy: 0.9419 - val_loss: 1.2583 - val_accuracy: 0.6754
Epoch 64/100
912/912 [==============================] - 0s 446us/step - loss: 0.5103 - accuracy: 0.8125 - val_loss: 0.4472 - val_accuracy: 0.8377
Epoch 65/100
912/912 [==============================] - 0s 391us/step - loss: 0.4271 - accuracy: 0.8465 - val_loss: 0.5670 - val_accuracy: 0.8333
Epoch 66/100
912/912 [==============================] - 0s 349us/step - loss: 0.3294 - accuracy: 0.8827 - val_loss: 0.5590 - val_accuracy: 0.8026
Epoch 67/100
912/912 [==============================] - 0s 403us/step - loss: 0.3364 - accuracy: 0.8706 - val_loss: 0.3459 - val_accuracy: 0.8772
Epoch 68/100
912/912 [==============================] - 0s 310us/step - loss: 0.2373 - accuracy: 0.9178 - val_loss: 0.3411 - val_accuracy: 0.8772
Epoch 69/100
912/912 [==============================] - 0s 394us/step - loss: 0.1443 - accuracy: 0.9518 - val_loss: 0.3694 - val_accuracy: 0.8684
Epoch 70/100
912/912 [==============================] - 0s 313us/step - loss: 0.1377 - accuracy: 0.9507 - val_loss: 0.4187 - val_accuracy: 0.8553
Epoch 71/100
912/912 [==============================] - 0s 297us/step - loss: 0.1775 - accuracy: 0.9353 - val_loss: 0.4391 - val_accuracy: 0.8596
Epoch 72/100
912/912 [==============================] - 0s 294us/step - loss: 0.1857 - accuracy: 0.9276 - val_loss: 0.5986 - val_accuracy: 0.8158
Epoch 73/100
912/912 [==============================] - 0s 288us/step - loss: 0.1408 - accuracy: 0.9529 - val_loss: 1.1152 - val_accuracy: 0.7281
Epoch 74/100
912/912 [==============================] - 0s 283us/step - loss: 0.3208 - accuracy: 0.8838 - val_loss: 0.3586 - val_accuracy: 0.8728
Epoch 75/100
912/912 [==============================] - 0s 294us/step - loss: 0.2100 - accuracy: 0.9211 - val_loss: 0.3189 - val_accuracy: 0.8991
Epoch 76/100
912/912 [==============================] - 0s 364us/step - loss: 0.1277 - accuracy: 0.9550 - val_loss: 0.3826 - val_accuracy: 0.8816
Epoch 77/100
912/912 [==============================] - 0s 476us/step - loss: 0.1324 - accuracy: 0.9507 - val_loss: 0.3462 - val_accuracy: 0.8947
Epoch 78/100
912/912 [==============================] - 0s 487us/step - loss: 0.1663 - accuracy: 0.9430 - val_loss: 0.4483 - val_accuracy: 0.8728
Epoch 79/100
912/912 [==============================] - 0s 525us/step - loss: 0.3152 - accuracy: 0.8991 - val_loss: 0.4654 - val_accuracy: 0.8509
Epoch 80/100
912/912 [==============================] - 0s 325us/step - loss: 0.1666 - accuracy: 0.9430 - val_loss: 0.6399 - val_accuracy: 0.7982
Epoch 81/100
912/912 [==============================] - 0s 401us/step - loss: 0.1036 - accuracy: 0.9671 - val_loss: 0.3432 - val_accuracy: 0.8816
Epoch 82/100
912/912 [==============================] - 0s 321us/step - loss: 0.1224 - accuracy: 0.9572 - val_loss: 0.4165 - val_accuracy: 0.8640
Epoch 83/100
912/912 [==============================] - 0s 347us/step - loss: 0.1958 - accuracy: 0.9320 - val_loss: 0.6427 - val_accuracy: 0.8289
Epoch 84/100
912/912 [==============================] - 0s 298us/step - loss: 0.1141 - accuracy: 0.9616 - val_loss: 0.4132 - val_accuracy: 0.8596
Epoch 85/100
912/912 [==============================] - 0s 281us/step - loss: 0.0845 - accuracy: 0.9792 - val_loss: 0.3563 - val_accuracy: 0.8904
Epoch 86/100
912/912 [==============================] - 0s 315us/step - loss: 0.0769 - accuracy: 0.9781 - val_loss: 0.3757 - val_accuracy: 0.8991
Epoch 87/100
912/912 [==============================] - 0s 291us/step - loss: 0.0779 - accuracy: 0.9737 - val_loss: 0.3730 - val_accuracy: 0.8772
Epoch 88/100
912/912 [==============================] - 0s 335us/step - loss: 0.0823 - accuracy: 0.9748 - val_loss: 0.5206 - val_accuracy: 0.8596
Epoch 89/100
912/912 [==============================] - 0s 332us/step - loss: 0.5473 - accuracy: 0.8454 - val_loss: 0.3567 - val_accuracy: 0.8816
Epoch 90/100
912/912 [==============================] - 0s 296us/step - loss: 0.1460 - accuracy: 0.9529 - val_loss: 0.3129 - val_accuracy: 0.8991
Epoch 91/100
912/912 [==============================] - 0s 310us/step - loss: 0.1102 - accuracy: 0.9627 - val_loss: 0.3716 - val_accuracy: 0.8860
Epoch 92/100
912/912 [==============================] - 0s 331us/step - loss: 0.1846 - accuracy: 0.9309 - val_loss: 0.3364 - val_accuracy: 0.8904
Epoch 93/100
912/912 [==============================] - 0s 365us/step - loss: 0.1120 - accuracy: 0.9594 - val_loss: 0.4363 - val_accuracy: 0.8684
Epoch 94/100
912/912 [==============================] - 0s 319us/step - loss: 0.1076 - accuracy: 0.9605 - val_loss: 0.3561 - val_accuracy: 0.8904
Epoch 95/100
912/912 [==============================] - 0s 292us/step - loss: 0.3089 - accuracy: 0.8816 - val_loss: 0.6300 - val_accuracy: 0.7632
Epoch 96/100
912/912 [==============================] - 0s 294us/step - loss: 0.1930 - accuracy: 0.9243 - val_loss: 0.3730 - val_accuracy: 0.8947
Epoch 97/100
912/912 [==============================] - 0s 358us/step - loss: 0.0835 - accuracy: 0.9770 - val_loss: 0.4095 - val_accuracy: 0.8904
Epoch 98/100
912/912 [==============================] - 0s 337us/step - loss: 0.1278 - accuracy: 0.9550 - val_loss: 0.3960 - val_accuracy: 0.8904
Epoch 99/100
912/912 [==============================] - 0s 300us/step - loss: 0.1222 - accuracy: 0.9561 - val_loss: 0.4443 - val_accuracy: 0.8772
Epoch 100/100
912/912 [==============================] - 0s 340us/step - loss: 0.1235 - accuracy: 0.9627 - val_loss: 0.6925 - val_accuracy: 0.8333
Now let's see what happened during training.

In [11]:
show_history(hist)

Expanding to four hidden layers doesn't seem to help much in terms of accuracy, so let's back off to two layers. You never want more layers (or more neurons) than necessary, and too many can prevent the model from generalizing well.

In [12]:
model = Sequential()
model.add(Dense(128, activation='relu', input_shape=(image_width * image_height,)))
model.add(Dense(128, activation='relu'))
model.add(Dense(class_count, activation='softmax'))
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
hist = model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=100, batch_size=25)
Train on 912 samples, validate on 228 samples
Epoch 1/100
912/912 [==============================] - 1s 608us/step - loss: 1.5148 - accuracy: 0.4167 - val_loss: 1.4200 - val_accuracy: 0.4649
Epoch 2/100
912/912 [==============================] - 0s 284us/step - loss: 1.3796 - accuracy: 0.5022 - val_loss: 1.3329 - val_accuracy: 0.5000
Epoch 3/100
912/912 [==============================] - 0s 335us/step - loss: 1.2574 - accuracy: 0.5296 - val_loss: 1.2739 - val_accuracy: 0.5746
Epoch 4/100
912/912 [==============================] - 0s 405us/step - loss: 1.1450 - accuracy: 0.5833 - val_loss: 1.0604 - val_accuracy: 0.6184
Epoch 5/100
912/912 [==============================] - 0s 456us/step - loss: 1.0307 - accuracy: 0.6195 - val_loss: 0.9526 - val_accuracy: 0.6842
Epoch 6/100
912/912 [==============================] - 0s 434us/step - loss: 1.0090 - accuracy: 0.6217 - val_loss: 0.9115 - val_accuracy: 0.6272
Epoch 7/100
912/912 [==============================] - 0s 399us/step - loss: 0.8725 - accuracy: 0.6809 - val_loss: 0.7447 - val_accuracy: 0.7544
Epoch 8/100
912/912 [==============================] - 0s 272us/step - loss: 0.8470 - accuracy: 0.6831 - val_loss: 0.8352 - val_accuracy: 0.6974
Epoch 9/100
912/912 [==============================] - 0s 287us/step - loss: 0.7633 - accuracy: 0.7336 - val_loss: 0.6555 - val_accuracy: 0.8114
Epoch 10/100
912/912 [==============================] - 0s 318us/step - loss: 0.6988 - accuracy: 0.7478 - val_loss: 0.5725 - val_accuracy: 0.8465
Epoch 11/100
912/912 [==============================] - 0s 396us/step - loss: 0.6296 - accuracy: 0.7818 - val_loss: 0.7121 - val_accuracy: 0.7456
Epoch 12/100
912/912 [==============================] - 1s 603us/step - loss: 0.5817 - accuracy: 0.7851 - val_loss: 0.5546 - val_accuracy: 0.8158
Epoch 13/100
912/912 [==============================] - 0s 547us/step - loss: 0.5145 - accuracy: 0.8224 - val_loss: 0.4884 - val_accuracy: 0.8421
Epoch 14/100
912/912 [==============================] - 0s 500us/step - loss: 0.4754 - accuracy: 0.8410 - val_loss: 0.6947 - val_accuracy: 0.7763
Epoch 15/100
912/912 [==============================] - 0s 450us/step - loss: 0.5755 - accuracy: 0.7884 - val_loss: 0.5218 - val_accuracy: 0.8246
Epoch 16/100
912/912 [==============================] - 0s 382us/step - loss: 0.4737 - accuracy: 0.8366 - val_loss: 0.4537 - val_accuracy: 0.8728
Epoch 17/100
912/912 [==============================] - 0s 352us/step - loss: 0.3915 - accuracy: 0.8739 - val_loss: 0.5132 - val_accuracy: 0.8246
Epoch 18/100
912/912 [==============================] - 0s 249us/step - loss: 0.5412 - accuracy: 0.8114 - val_loss: 0.6923 - val_accuracy: 0.7632
Epoch 19/100
912/912 [==============================] - 0s 484us/step - loss: 0.4155 - accuracy: 0.8640 - val_loss: 0.4437 - val_accuracy: 0.8333
Epoch 20/100
912/912 [==============================] - 0s 460us/step - loss: 0.4704 - accuracy: 0.8268 - val_loss: 0.8081 - val_accuracy: 0.7149
Epoch 21/100
912/912 [==============================] - 0s 370us/step - loss: 0.3858 - accuracy: 0.8662 - val_loss: 0.4134 - val_accuracy: 0.8596
Epoch 22/100
912/912 [==============================] - 0s 378us/step - loss: 0.3689 - accuracy: 0.8772 - val_loss: 0.5950 - val_accuracy: 0.7982
Epoch 23/100
912/912 [==============================] - 0s 258us/step - loss: 0.4962 - accuracy: 0.8235 - val_loss: 0.4768 - val_accuracy: 0.8509
Epoch 24/100
912/912 [==============================] - 0s 297us/step - loss: 0.4005 - accuracy: 0.8596 - val_loss: 0.4905 - val_accuracy: 0.8333
Epoch 25/100
912/912 [==============================] - 0s 272us/step - loss: 0.2929 - accuracy: 0.9134 - val_loss: 0.4548 - val_accuracy: 0.8684
Epoch 26/100
912/912 [==============================] - 0s 271us/step - loss: 0.5007 - accuracy: 0.8268 - val_loss: 0.4810 - val_accuracy: 0.8465
Epoch 27/100
912/912 [==============================] - 0s 273us/step - loss: 0.3881 - accuracy: 0.8651 - val_loss: 0.5993 - val_accuracy: 0.7851
Epoch 28/100
912/912 [==============================] - 0s 291us/step - loss: 0.3695 - accuracy: 0.8651 - val_loss: 0.4674 - val_accuracy: 0.8553
Epoch 29/100
912/912 [==============================] - 0s 281us/step - loss: 0.3291 - accuracy: 0.8838 - val_loss: 0.4970 - val_accuracy: 0.8289
Epoch 30/100
912/912 [==============================] - 0s 296us/step - loss: 0.3182 - accuracy: 0.8893 - val_loss: 0.3885 - val_accuracy: 0.8947
Epoch 31/100
912/912 [==============================] - 0s 361us/step - loss: 0.3246 - accuracy: 0.8871 - val_loss: 0.4223 - val_accuracy: 0.8860
Epoch 32/100
912/912 [==============================] - 0s 538us/step - loss: 0.2583 - accuracy: 0.9112 - val_loss: 0.4178 - val_accuracy: 0.8860
Epoch 33/100
912/912 [==============================] - 0s 391us/step - loss: 0.2923 - accuracy: 0.8882 - val_loss: 0.4261 - val_accuracy: 0.8684
Epoch 34/100
912/912 [==============================] - 0s 309us/step - loss: 0.3119 - accuracy: 0.8849 - val_loss: 0.6609 - val_accuracy: 0.7719
Epoch 35/100
912/912 [==============================] - 0s 411us/step - loss: 0.3236 - accuracy: 0.8838 - val_loss: 0.4912 - val_accuracy: 0.8377
Epoch 36/100
912/912 [==============================] - 0s 291us/step - loss: 0.3015 - accuracy: 0.8936 - val_loss: 0.4474 - val_accuracy: 0.8465
Epoch 37/100
912/912 [==============================] - 0s 293us/step - loss: 0.2414 - accuracy: 0.9200 - val_loss: 0.4376 - val_accuracy: 0.8684
Epoch 38/100
912/912 [==============================] - 0s 323us/step - loss: 0.3104 - accuracy: 0.8958 - val_loss: 0.4224 - val_accuracy: 0.8421
Epoch 39/100
912/912 [==============================] - 0s 295us/step - loss: 0.2341 - accuracy: 0.9211 - val_loss: 0.7080 - val_accuracy: 0.7763
Epoch 40/100
912/912 [==============================] - 0s 268us/step - loss: 0.3102 - accuracy: 0.8838 - val_loss: 0.4127 - val_accuracy: 0.8728
Epoch 41/100
912/912 [==============================] - 0s 281us/step - loss: 0.2949 - accuracy: 0.8893 - val_loss: 0.4317 - val_accuracy: 0.8772
Epoch 42/100
912/912 [==============================] - 0s 262us/step - loss: 0.2279 - accuracy: 0.9221 - val_loss: 0.4143 - val_accuracy: 0.8684
Epoch 43/100
912/912 [==============================] - 0s 362us/step - loss: 0.2491 - accuracy: 0.9189 - val_loss: 0.6280 - val_accuracy: 0.8158
Epoch 44/100
912/912 [==============================] - 0s 280us/step - loss: 0.2305 - accuracy: 0.9265 - val_loss: 0.3829 - val_accuracy: 0.8772
Epoch 45/100
912/912 [==============================] - 0s 303us/step - loss: 0.1616 - accuracy: 0.9518 - val_loss: 0.5137 - val_accuracy: 0.8421
Epoch 46/100
912/912 [==============================] - 0s 300us/step - loss: 0.1842 - accuracy: 0.9320 - val_loss: 0.4900 - val_accuracy: 0.8509
Epoch 47/100
912/912 [==============================] - 0s 275us/step - loss: 0.1914 - accuracy: 0.9353 - val_loss: 0.4250 - val_accuracy: 0.8728
Epoch 48/100
912/912 [==============================] - 0s 343us/step - loss: 0.1898 - accuracy: 0.9375 - val_loss: 0.5117 - val_accuracy: 0.8246
Epoch 49/100
912/912 [==============================] - 0s 310us/step - loss: 0.1512 - accuracy: 0.9529 - val_loss: 0.5652 - val_accuracy: 0.8289
Epoch 50/100
912/912 [==============================] - 0s 274us/step - loss: 0.1714 - accuracy: 0.9452 - val_loss: 0.4655 - val_accuracy: 0.8684
Epoch 51/100
912/912 [==============================] - 0s 393us/step - loss: 0.1961 - accuracy: 0.9386 - val_loss: 0.4282 - val_accuracy: 0.8684
Epoch 52/100
912/912 [==============================] - 0s 514us/step - loss: 0.1509 - accuracy: 0.9529 - val_loss: 0.4194 - val_accuracy: 0.8772
Epoch 53/100
912/912 [==============================] - 0s 393us/step - loss: 0.1688 - accuracy: 0.9507 - val_loss: 0.4410 - val_accuracy: 0.8684
Epoch 54/100
912/912 [==============================] - 0s 431us/step - loss: 0.1585 - accuracy: 0.9529 - val_loss: 0.3936 - val_accuracy: 0.8860
Epoch 55/100
912/912 [==============================] - 0s 472us/step - loss: 0.1692 - accuracy: 0.9452 - val_loss: 0.4655 - val_accuracy: 0.8553
Epoch 56/100
912/912 [==============================] - 0s 394us/step - loss: 0.1903 - accuracy: 0.9419 - val_loss: 0.5486 - val_accuracy: 0.8377
Epoch 57/100
912/912 [==============================] - 0s 339us/step - loss: 0.2069 - accuracy: 0.9189 - val_loss: 0.5283 - val_accuracy: 0.8246
Epoch 58/100
912/912 [==============================] - 0s 306us/step - loss: 0.1335 - accuracy: 0.9518 - val_loss: 0.5396 - val_accuracy: 0.8465
Epoch 59/100
912/912 [==============================] - 0s 348us/step - loss: 0.2928 - accuracy: 0.8893 - val_loss: 0.8458 - val_accuracy: 0.7675
Epoch 60/100
912/912 [==============================] - 0s 395us/step - loss: 0.1861 - accuracy: 0.9397 - val_loss: 0.5854 - val_accuracy: 0.8246
Epoch 61/100
912/912 [==============================] - 0s 293us/step - loss: 0.1883 - accuracy: 0.9265 - val_loss: 0.4772 - val_accuracy: 0.8640
Epoch 62/100
912/912 [==============================] - 0s 255us/step - loss: 0.1488 - accuracy: 0.9518 - val_loss: 0.5255 - val_accuracy: 0.8596
Epoch 63/100
912/912 [==============================] - 0s 256us/step - loss: 0.2004 - accuracy: 0.9178 - val_loss: 0.4111 - val_accuracy: 0.8816
Epoch 64/100
912/912 [==============================] - 0s 340us/step - loss: 0.1306 - accuracy: 0.9561 - val_loss: 0.4232 - val_accuracy: 0.8684
Epoch 65/100
912/912 [==============================] - 0s 299us/step - loss: 0.1266 - accuracy: 0.9605 - val_loss: 0.5433 - val_accuracy: 0.8465
Epoch 66/100
912/912 [==============================] - 0s 280us/step - loss: 0.1259 - accuracy: 0.9594 - val_loss: 0.4513 - val_accuracy: 0.8684
Epoch 67/100
912/912 [==============================] - 0s 440us/step - loss: 0.1635 - accuracy: 0.9397 - val_loss: 0.8093 - val_accuracy: 0.7675
Epoch 68/100
912/912 [==============================] - 0s 531us/step - loss: 0.1399 - accuracy: 0.9561 - val_loss: 0.4397 - val_accuracy: 0.8860
Epoch 69/100
912/912 [==============================] - 0s 449us/step - loss: 0.1144 - accuracy: 0.9616 - val_loss: 0.6042 - val_accuracy: 0.8377
Epoch 70/100
912/912 [==============================] - 0s 455us/step - loss: 0.1340 - accuracy: 0.9539 - val_loss: 0.4381 - val_accuracy: 0.8947
Epoch 71/100
912/912 [==============================] - 1s 556us/step - loss: 0.1254 - accuracy: 0.9583 - val_loss: 0.4265 - val_accuracy: 0.8684
Epoch 72/100
912/912 [==============================] - 0s 404us/step - loss: 0.1310 - accuracy: 0.9616 - val_loss: 0.4033 - val_accuracy: 0.8860
Epoch 73/100
912/912 [==============================] - 0s 482us/step - loss: 0.0716 - accuracy: 0.9803 - val_loss: 0.4462 - val_accuracy: 0.8904
Epoch 74/100
912/912 [==============================] - 0s 426us/step - loss: 0.1302 - accuracy: 0.9518 - val_loss: 1.1149 - val_accuracy: 0.7149
Epoch 75/100
912/912 [==============================] - 0s 437us/step - loss: 0.4992 - accuracy: 0.8388 - val_loss: 0.4537 - val_accuracy: 0.8596
Epoch 76/100
912/912 [==============================] - 0s 351us/step - loss: 0.2557 - accuracy: 0.9079 - val_loss: 0.4223 - val_accuracy: 0.8640
Epoch 77/100
912/912 [==============================] - 0s 257us/step - loss: 0.1751 - accuracy: 0.9375 - val_loss: 0.3795 - val_accuracy: 0.8684
Epoch 78/100
912/912 [==============================] - 0s 268us/step - loss: 0.2483 - accuracy: 0.9068 - val_loss: 0.7509 - val_accuracy: 0.7588
Epoch 79/100
912/912 [==============================] - 0s 249us/step - loss: 0.3264 - accuracy: 0.8706 - val_loss: 0.4124 - val_accuracy: 0.8640
Epoch 80/100
912/912 [==============================] - 0s 288us/step - loss: 0.1471 - accuracy: 0.9550 - val_loss: 0.7963 - val_accuracy: 0.7895
Epoch 81/100
912/912 [==============================] - 0s 267us/step - loss: 0.2465 - accuracy: 0.9079 - val_loss: 0.4190 - val_accuracy: 0.8509
Epoch 82/100
912/912 [==============================] - 0s 433us/step - loss: 0.1235 - accuracy: 0.9550 - val_loss: 0.5488 - val_accuracy: 0.8377
Epoch 83/100
912/912 [==============================] - 0s 284us/step - loss: 0.1441 - accuracy: 0.9441 - val_loss: 0.7975 - val_accuracy: 0.7895
Epoch 84/100
912/912 [==============================] - 0s 255us/step - loss: 0.2027 - accuracy: 0.9243 - val_loss: 0.4210 - val_accuracy: 0.8772
Epoch 85/100
912/912 [==============================] - 0s 277us/step - loss: 0.1419 - accuracy: 0.9463 - val_loss: 0.6129 - val_accuracy: 0.8377
Epoch 86/100
912/912 [==============================] - 0s 311us/step - loss: 0.1788 - accuracy: 0.9342 - val_loss: 0.5461 - val_accuracy: 0.8377
Epoch 87/100
912/912 [==============================] - 0s 299us/step - loss: 0.1101 - accuracy: 0.9638 - val_loss: 0.5102 - val_accuracy: 0.8596
Epoch 88/100
912/912 [==============================] - 0s 246us/step - loss: 0.1098 - accuracy: 0.9550 - val_loss: 0.4263 - val_accuracy: 0.8772
Epoch 89/100
912/912 [==============================] - 0s 292us/step - loss: 0.0734 - accuracy: 0.9770 - val_loss: 0.4640 - val_accuracy: 0.8947
Epoch 90/100
912/912 [==============================] - 0s 426us/step - loss: 0.0864 - accuracy: 0.9671 - val_loss: 0.4746 - val_accuracy: 0.8553
Epoch 91/100
912/912 [==============================] - 0s 514us/step - loss: 0.0847 - accuracy: 0.9737 - val_loss: 0.5595 - val_accuracy: 0.8421
Epoch 92/100
912/912 [==============================] - 0s 380us/step - loss: 0.1242 - accuracy: 0.9539 - val_loss: 0.5668 - val_accuracy: 0.8377
Epoch 93/100
912/912 [==============================] - 0s 314us/step - loss: 0.0727 - accuracy: 0.9715 - val_loss: 0.4471 - val_accuracy: 0.8640
Epoch 94/100
912/912 [==============================] - 0s 288us/step - loss: 0.0482 - accuracy: 0.9890 - val_loss: 0.4222 - val_accuracy: 0.8596
Epoch 95/100
912/912 [==============================] - 0s 305us/step - loss: 0.0510 - accuracy: 0.9890 - val_loss: 0.4107 - val_accuracy: 0.8947
Epoch 96/100
912/912 [==============================] - 0s 378us/step - loss: 0.0489 - accuracy: 0.9814 - val_loss: 0.4622 - val_accuracy: 0.8640
Epoch 97/100
912/912 [==============================] - 0s 286us/step - loss: 0.0482 - accuracy: 0.9879 - val_loss: 0.4974 - val_accuracy: 0.8553
Epoch 98/100
912/912 [==============================] - 0s 317us/step - loss: 0.1920 - accuracy: 0.9298 - val_loss: 0.9020 - val_accuracy: 0.7851
Epoch 99/100
912/912 [==============================] - 0s 271us/step - loss: 0.1110 - accuracy: 0.9649 - val_loss: 0.5530 - val_accuracy: 0.8640
Epoch 100/100
912/912 [==============================] - 0s 317us/step - loss: 0.1846 - accuracy: 0.9298 - val_loss: 0.5241 - val_accuracy: 0.8596
Time to check the results.

```python
show_history(hist)
```

At this point, it might be helpful to run some test data through the network and generate a confusion matrix showing how it performed. We can use scikit-learn's confusion_matrix function to generate the confusion matrix and seaborn to plot it.

```python
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split

y_predicted = model.predict(x_test)
mat = confusion_matrix(y_test.argmax(axis=1), y_predicted.argmax(axis=1))

sns.heatmap(mat.T, square=True, annot=True, fmt='d', cbar=False, cmap='Blues',
            xticklabels=faces.target_names,
            yticklabels=faces.target_names)

plt.xlabel('Actual label')
plt.ylabel('Predicted label')
Out[14]:
Text(89.18, 0.5, 'Predicted label')
```

How many times did the model correctly identify George W. Bush, who had the most samples in the training set? How many times did it identify him as someone else?

