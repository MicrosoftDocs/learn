Use dropout to increase generalization
The fact that training accuracy approaches 100% (1.0) tells us that the network is deep enough and wide enough to learn from the facial data we train it with. But the validation accuracy peaks out much lower. This means that the model isn't generalizing well — that is, it isn't responding as well as we would like to facial images it hasn't seen. One way to mitigate that is to introduce dropout during training.

Dropout is a commonly used technique to help neural networks generalize better. In keras, you can introduce dropout by following a Dense layer with a Dropout layer, specifying the fraction of connections that should be randomly dropped between layers in each training epoch. Let's introduce dropout to the network and see if it has an effect on the network's validation accuracy. Because dropout causes the model to train more slowly, we'll increase the number of epochs to 200.

In [15]:
from keras.layers import Dropout

model = Sequential()
model.add(Dense(128, activation='relu', input_shape=(image_width * image_height,)))
model.add(Dropout(0.1))
model.add(Dense(class_count, activation='softmax'))
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
hist = model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=200, batch_size=25)
Train on 912 samples, validate on 228 samples
Epoch 1/200
912/912 [==============================] - 1s 988us/step - loss: 1.6210 - accuracy: 0.4112 - val_loss: 1.3309 - val_accuracy: 0.5482
Epoch 2/200
912/912 [==============================] - 0s 346us/step - loss: 1.3257 - accuracy: 0.4879 - val_loss: 1.2463 - val_accuracy: 0.4868
Epoch 3/200
912/912 [==============================] - 0s 384us/step - loss: 1.2589 - accuracy: 0.5143 - val_loss: 1.1739 - val_accuracy: 0.5921
Epoch 4/200
912/912 [==============================] - 0s 266us/step - loss: 1.1661 - accuracy: 0.5603 - val_loss: 1.1569 - val_accuracy: 0.4912
Epoch 5/200
912/912 [==============================] - 0s 389us/step - loss: 1.1083 - accuracy: 0.5833 - val_loss: 1.0413 - val_accuracy: 0.5965
Epoch 6/200
912/912 [==============================] - 0s 418us/step - loss: 1.0366 - accuracy: 0.5998 - val_loss: 1.0288 - val_accuracy: 0.6930
Epoch 7/200
912/912 [==============================] - 1s 580us/step - loss: 1.0563 - accuracy: 0.5866 - val_loss: 1.1255 - val_accuracy: 0.5789
Epoch 8/200
912/912 [==============================] - 0s 408us/step - loss: 1.0358 - accuracy: 0.6075 - val_loss: 0.8852 - val_accuracy: 0.6930
Epoch 9/200
912/912 [==============================] - 0s 353us/step - loss: 0.9141 - accuracy: 0.6579 - val_loss: 0.9439 - val_accuracy: 0.7105
Epoch 10/200
912/912 [==============================] - 1s 560us/step - loss: 0.9318 - accuracy: 0.6414 - val_loss: 0.8597 - val_accuracy: 0.6798
Epoch 11/200
912/912 [==============================] - 0s 474us/step - loss: 0.8658 - accuracy: 0.6743 - val_loss: 0.8122 - val_accuracy: 0.7105
Epoch 12/200
912/912 [==============================] - 0s 427us/step - loss: 0.8457 - accuracy: 0.6919 - val_loss: 0.7818 - val_accuracy: 0.7719
Epoch 13/200
912/912 [==============================] - 0s 405us/step - loss: 0.8154 - accuracy: 0.6996 - val_loss: 0.7694 - val_accuracy: 0.7588
Epoch 14/200
912/912 [==============================] - 0s 410us/step - loss: 0.7729 - accuracy: 0.7237 - val_loss: 0.7314 - val_accuracy: 0.7719
Epoch 15/200
912/912 [==============================] - 0s 439us/step - loss: 0.7455 - accuracy: 0.7204 - val_loss: 0.7662 - val_accuracy: 0.7763
Epoch 16/200
912/912 [==============================] - 0s 388us/step - loss: 0.7290 - accuracy: 0.7357 - val_loss: 0.6735 - val_accuracy: 0.7939
Epoch 17/200
912/912 [==============================] - 0s 437us/step - loss: 0.7142 - accuracy: 0.7434 - val_loss: 0.7231 - val_accuracy: 0.7456
Epoch 18/200
912/912 [==============================] - 0s 458us/step - loss: 0.7063 - accuracy: 0.7456 - val_loss: 0.6860 - val_accuracy: 0.7719
Epoch 19/200
912/912 [==============================] - 0s 382us/step - loss: 0.6901 - accuracy: 0.7588 - val_loss: 0.7615 - val_accuracy: 0.6930
Epoch 20/200
912/912 [==============================] - 0s 339us/step - loss: 0.6340 - accuracy: 0.7664 - val_loss: 0.6052 - val_accuracy: 0.8070
Epoch 21/200
912/912 [==============================] - 0s 456us/step - loss: 0.6283 - accuracy: 0.7807 - val_loss: 0.6145 - val_accuracy: 0.8202
Epoch 22/200
912/912 [==============================] - 0s 406us/step - loss: 0.6114 - accuracy: 0.7884 - val_loss: 0.6062 - val_accuracy: 0.7895
Epoch 23/200
912/912 [==============================] - 0s 454us/step - loss: 0.5745 - accuracy: 0.8070 - val_loss: 0.5513 - val_accuracy: 0.8114
Epoch 24/200
912/912 [==============================] - 0s 455us/step - loss: 0.5976 - accuracy: 0.7971 - val_loss: 0.5627 - val_accuracy: 0.8026
Epoch 25/200
912/912 [==============================] - 0s 494us/step - loss: 0.5805 - accuracy: 0.7895 - val_loss: 0.6119 - val_accuracy: 0.7719
Epoch 26/200
912/912 [==============================] - 0s 514us/step - loss: 0.5488 - accuracy: 0.8158 - val_loss: 0.5350 - val_accuracy: 0.8114
Epoch 27/200
912/912 [==============================] - 0s 450us/step - loss: 0.5648 - accuracy: 0.7917 - val_loss: 0.5619 - val_accuracy: 0.8202
Epoch 28/200
912/912 [==============================] - 0s 400us/step - loss: 0.5405 - accuracy: 0.8158 - val_loss: 0.5078 - val_accuracy: 0.8421
Epoch 29/200
912/912 [==============================] - 0s 399us/step - loss: 0.5003 - accuracy: 0.8180 - val_loss: 0.5440 - val_accuracy: 0.7982
Epoch 30/200
912/912 [==============================] - 0s 261us/step - loss: 0.5324 - accuracy: 0.8147 - val_loss: 0.5406 - val_accuracy: 0.8289
Epoch 31/200
912/912 [==============================] - 1s 754us/step - loss: 0.4951 - accuracy: 0.8279 - val_loss: 0.4953 - val_accuracy: 0.8377
Epoch 32/200
912/912 [==============================] - 1s 816us/step - loss: 0.4918 - accuracy: 0.8311 - val_loss: 0.5224 - val_accuracy: 0.8509
Epoch 33/200
912/912 [==============================] - 1s 769us/step - loss: 0.5123 - accuracy: 0.8180 - val_loss: 0.6664 - val_accuracy: 0.7456
Epoch 34/200
912/912 [==============================] - 1s 664us/step - loss: 0.5451 - accuracy: 0.8048 - val_loss: 0.5085 - val_accuracy: 0.8289
Epoch 35/200
912/912 [==============================] - 1s 775us/step - loss: 0.4546 - accuracy: 0.8421 - val_loss: 0.5315 - val_accuracy: 0.8246
Epoch 36/200
912/912 [==============================] - 1s 619us/step - loss: 0.4352 - accuracy: 0.8520 - val_loss: 0.4287 - val_accuracy: 0.8728
Epoch 37/200
912/912 [==============================] - 1s 678us/step - loss: 0.4507 - accuracy: 0.8410 - val_loss: 0.4705 - val_accuracy: 0.8377
Epoch 38/200
912/912 [==============================] - 1s 805us/step - loss: 0.5315 - accuracy: 0.8004 - val_loss: 0.5497 - val_accuracy: 0.7939
Epoch 39/200
912/912 [==============================] - 1s 702us/step - loss: 0.4905 - accuracy: 0.8246 - val_loss: 0.4402 - val_accuracy: 0.8509
Epoch 40/200
912/912 [==============================] - 1s 671us/step - loss: 0.4914 - accuracy: 0.8377 - val_loss: 0.5085 - val_accuracy: 0.8289
Epoch 41/200
912/912 [==============================] - 1s 644us/step - loss: 0.4024 - accuracy: 0.8640 - val_loss: 0.5352 - val_accuracy: 0.8114
Epoch 42/200
912/912 [==============================] - 1s 605us/step - loss: 0.4711 - accuracy: 0.8279 - val_loss: 0.4264 - val_accuracy: 0.8640
Epoch 43/200
912/912 [==============================] - 0s 456us/step - loss: 0.4054 - accuracy: 0.8596 - val_loss: 0.4309 - val_accuracy: 0.8728
Epoch 44/200
912/912 [==============================] - 0s 540us/step - loss: 0.3933 - accuracy: 0.8695 - val_loss: 0.5065 - val_accuracy: 0.8202
Epoch 45/200
912/912 [==============================] - 0s 484us/step - loss: 0.3787 - accuracy: 0.8695 - val_loss: 0.4155 - val_accuracy: 0.8640
Epoch 46/200
912/912 [==============================] - 0s 393us/step - loss: 0.4045 - accuracy: 0.8542 - val_loss: 0.5444 - val_accuracy: 0.8070
Epoch 47/200
912/912 [==============================] - 0s 528us/step - loss: 0.4072 - accuracy: 0.8509 - val_loss: 0.6849 - val_accuracy: 0.7544
Epoch 48/200
912/912 [==============================] - 1s 556us/step - loss: 0.4948 - accuracy: 0.8158 - val_loss: 0.6867 - val_accuracy: 0.7588
Epoch 49/200
912/912 [==============================] - 0s 457us/step - loss: 0.4766 - accuracy: 0.8268 - val_loss: 0.4599 - val_accuracy: 0.8202
Epoch 50/200
912/912 [==============================] - 0s 502us/step - loss: 0.4031 - accuracy: 0.8344 - val_loss: 0.6260 - val_accuracy: 0.7632
Epoch 51/200
912/912 [==============================] - 1s 556us/step - loss: 0.4834 - accuracy: 0.8322 - val_loss: 0.4117 - val_accuracy: 0.8904
Epoch 52/200
912/912 [==============================] - 1s 602us/step - loss: 0.3665 - accuracy: 0.8739 - val_loss: 0.4251 - val_accuracy: 0.8684
Epoch 53/200
912/912 [==============================] - 1s 654us/step - loss: 0.3488 - accuracy: 0.8838 - val_loss: 0.4252 - val_accuracy: 0.8333
Epoch 54/200
912/912 [==============================] - 1s 550us/step - loss: 0.3258 - accuracy: 0.8772 - val_loss: 0.3901 - val_accuracy: 0.8860
Epoch 55/200
912/912 [==============================] - 1s 671us/step - loss: 0.3299 - accuracy: 0.8904 - val_loss: 0.4145 - val_accuracy: 0.8596
Epoch 56/200
912/912 [==============================] - 1s 602us/step - loss: 0.3247 - accuracy: 0.8925 - val_loss: 0.4060 - val_accuracy: 0.8728
Epoch 57/200
912/912 [==============================] - 0s 503us/step - loss: 0.3632 - accuracy: 0.8651 - val_loss: 0.3872 - val_accuracy: 0.8728
Epoch 58/200
912/912 [==============================] - 1s 632us/step - loss: 0.3154 - accuracy: 0.8860 - val_loss: 0.4693 - val_accuracy: 0.8246
Epoch 59/200
912/912 [==============================] - 1s 697us/step - loss: 0.3177 - accuracy: 0.9002 - val_loss: 0.4102 - val_accuracy: 0.8640
Epoch 60/200
912/912 [==============================] - 1s 584us/step - loss: 0.3045 - accuracy: 0.8936 - val_loss: 0.3782 - val_accuracy: 0.9035
Epoch 61/200
912/912 [==============================] - 0s 538us/step - loss: 0.3298 - accuracy: 0.8761 - val_loss: 0.4403 - val_accuracy: 0.8509
Epoch 62/200
912/912 [==============================] - 1s 688us/step - loss: 0.3323 - accuracy: 0.8728 - val_loss: 0.4655 - val_accuracy: 0.8421
Epoch 63/200
912/912 [==============================] - 1s 556us/step - loss: 0.3481 - accuracy: 0.8761 - val_loss: 0.4133 - val_accuracy: 0.8640
Epoch 64/200
912/912 [==============================] - 1s 567us/step - loss: 0.2777 - accuracy: 0.9090 - val_loss: 0.3989 - val_accuracy: 0.8772
Epoch 65/200
912/912 [==============================] - 1s 572us/step - loss: 0.2772 - accuracy: 0.9090 - val_loss: 0.3789 - val_accuracy: 0.8728
Epoch 66/200
912/912 [==============================] - 0s 409us/step - loss: 0.2623 - accuracy: 0.9101 - val_loss: 0.3866 - val_accuracy: 0.8816
Epoch 67/200
912/912 [==============================] - 0s 464us/step - loss: 0.2742 - accuracy: 0.9046 - val_loss: 0.3876 - val_accuracy: 0.8816
Epoch 68/200
912/912 [==============================] - 1s 561us/step - loss: 0.2738 - accuracy: 0.9035 - val_loss: 0.3625 - val_accuracy: 0.8991
Epoch 69/200
912/912 [==============================] - 1s 566us/step - loss: 0.2752 - accuracy: 0.9002 - val_loss: 0.3731 - val_accuracy: 0.8772
Epoch 70/200
912/912 [==============================] - 1s 695us/step - loss: 0.2690 - accuracy: 0.9035 - val_loss: 0.4230 - val_accuracy: 0.8553
Epoch 71/200
912/912 [==============================] - 1s 794us/step - loss: 0.2735 - accuracy: 0.8958 - val_loss: 0.5938 - val_accuracy: 0.8289
Epoch 72/200
912/912 [==============================] - 1s 579us/step - loss: 0.3173 - accuracy: 0.8893 - val_loss: 0.4188 - val_accuracy: 0.8640
Epoch 73/200
912/912 [==============================] - 1s 564us/step - loss: 0.3407 - accuracy: 0.8739 - val_loss: 0.4857 - val_accuracy: 0.8553
Epoch 74/200
912/912 [==============================] - 1s 621us/step - loss: 0.3021 - accuracy: 0.8838 - val_loss: 0.5434 - val_accuracy: 0.8114
Epoch 75/200
912/912 [==============================] - 1s 692us/step - loss: 0.2971 - accuracy: 0.8882 - val_loss: 0.3525 - val_accuracy: 0.8860
Epoch 76/200
912/912 [==============================] - 1s 564us/step - loss: 0.2796 - accuracy: 0.8991 - val_loss: 0.3713 - val_accuracy: 0.8772
Epoch 77/200
912/912 [==============================] - 0s 521us/step - loss: 0.2700 - accuracy: 0.9068 - val_loss: 0.3422 - val_accuracy: 0.9035
Epoch 78/200
912/912 [==============================] - 1s 577us/step - loss: 0.2405 - accuracy: 0.9243 - val_loss: 0.4097 - val_accuracy: 0.8640
Epoch 79/200
912/912 [==============================] - 1s 568us/step - loss: 0.2577 - accuracy: 0.9112 - val_loss: 0.4206 - val_accuracy: 0.8377
Epoch 80/200
912/912 [==============================] - 0s 459us/step - loss: 0.2484 - accuracy: 0.9167 - val_loss: 0.5284 - val_accuracy: 0.8114
Epoch 81/200
912/912 [==============================] - 0s 420us/step - loss: 0.2594 - accuracy: 0.9101 - val_loss: 0.4017 - val_accuracy: 0.8596
Epoch 82/200
912/912 [==============================] - 0s 532us/step - loss: 0.2318 - accuracy: 0.9221 - val_loss: 0.4326 - val_accuracy: 0.8596
Epoch 83/200
912/912 [==============================] - 0s 483us/step - loss: 0.2405 - accuracy: 0.9134 - val_loss: 0.4191 - val_accuracy: 0.8640
Epoch 84/200
912/912 [==============================] - 1s 571us/step - loss: 0.2417 - accuracy: 0.9112 - val_loss: 0.4507 - val_accuracy: 0.8640
Epoch 85/200
912/912 [==============================] - 0s 520us/step - loss: 0.2302 - accuracy: 0.9200 - val_loss: 0.3940 - val_accuracy: 0.8772
Epoch 86/200
912/912 [==============================] - 1s 638us/step - loss: 0.2162 - accuracy: 0.9265 - val_loss: 0.4025 - val_accuracy: 0.8684
Epoch 87/200
912/912 [==============================] - 1s 698us/step - loss: 0.2588 - accuracy: 0.9112 - val_loss: 0.5320 - val_accuracy: 0.8202
Epoch 88/200
912/912 [==============================] - 1s 725us/step - loss: 0.2416 - accuracy: 0.9178 - val_loss: 0.3816 - val_accuracy: 0.8640
Epoch 89/200
912/912 [==============================] - 1s 608us/step - loss: 0.3640 - accuracy: 0.8673 - val_loss: 0.5870 - val_accuracy: 0.7807
Epoch 90/200
912/912 [==============================] - 0s 467us/step - loss: 0.3121 - accuracy: 0.8673 - val_loss: 0.4308 - val_accuracy: 0.8509
Epoch 91/200
912/912 [==============================] - 1s 773us/step - loss: 0.2975 - accuracy: 0.8958 - val_loss: 0.3836 - val_accuracy: 0.8816
Epoch 92/200
912/912 [==============================] - 1s 880us/step - loss: 0.2871 - accuracy: 0.9035 - val_loss: 0.3793 - val_accuracy: 0.8904
Epoch 93/200
912/912 [==============================] - 1s 900us/step - loss: 0.2453 - accuracy: 0.9200 - val_loss: 0.4206 - val_accuracy: 0.8772
Epoch 94/200
912/912 [==============================] - 1s 794us/step - loss: 0.2185 - accuracy: 0.9156 - val_loss: 0.4048 - val_accuracy: 0.8728
Epoch 95/200
912/912 [==============================] - 1s 794us/step - loss: 0.2223 - accuracy: 0.9232 - val_loss: 0.3405 - val_accuracy: 0.9035
Epoch 96/200
912/912 [==============================] - 1s 759us/step - loss: 0.2708 - accuracy: 0.8882 - val_loss: 0.3678 - val_accuracy: 0.8684
Epoch 97/200
912/912 [==============================] - 1s 775us/step - loss: 0.2283 - accuracy: 0.9123 - val_loss: 0.3589 - val_accuracy: 0.9123
Epoch 98/200
912/912 [==============================] - 1s 859us/step - loss: 0.2096 - accuracy: 0.9298 - val_loss: 0.4608 - val_accuracy: 0.8509
Epoch 99/200
912/912 [==============================] - 1s 883us/step - loss: 0.1847 - accuracy: 0.9386 - val_loss: 0.4025 - val_accuracy: 0.8553
Epoch 100/200
912/912 [==============================] - 1s 790us/step - loss: 0.1758 - accuracy: 0.9375 - val_loss: 0.3684 - val_accuracy: 0.8728
Epoch 101/200
912/912 [==============================] - 1s 656us/step - loss: 0.1869 - accuracy: 0.9331 - val_loss: 0.3885 - val_accuracy: 0.8860
Epoch 102/200
912/912 [==============================] - 1s 762us/step - loss: 0.1869 - accuracy: 0.9353 - val_loss: 0.3771 - val_accuracy: 0.8860
Epoch 103/200
912/912 [==============================] - 0s 460us/step - loss: 0.1939 - accuracy: 0.9287 - val_loss: 0.3935 - val_accuracy: 0.8816
Epoch 104/200
912/912 [==============================] - 0s 398us/step - loss: 0.1791 - accuracy: 0.9320 - val_loss: 0.3676 - val_accuracy: 0.8684
Epoch 105/200
912/912 [==============================] - 1s 576us/step - loss: 0.1672 - accuracy: 0.9474 - val_loss: 0.4562 - val_accuracy: 0.8596
Epoch 106/200
912/912 [==============================] - 1s 703us/step - loss: 0.2005 - accuracy: 0.9243 - val_loss: 0.4092 - val_accuracy: 0.8684
Epoch 107/200
912/912 [==============================] - 1s 653us/step - loss: 0.2215 - accuracy: 0.9189 - val_loss: 0.3519 - val_accuracy: 0.8904
Epoch 108/200
912/912 [==============================] - 1s 557us/step - loss: 0.1734 - accuracy: 0.9353 - val_loss: 0.3466 - val_accuracy: 0.8947
Epoch 109/200
912/912 [==============================] - 0s 477us/step - loss: 0.1644 - accuracy: 0.9550 - val_loss: 0.4153 - val_accuracy: 0.8728
Epoch 110/200
912/912 [==============================] - 0s 494us/step - loss: 0.1693 - accuracy: 0.9320 - val_loss: 0.4288 - val_accuracy: 0.8596
Epoch 111/200
912/912 [==============================] - 1s 578us/step - loss: 0.2224 - accuracy: 0.9123 - val_loss: 0.4406 - val_accuracy: 0.8860
Epoch 112/200
912/912 [==============================] - 1s 671us/step - loss: 0.1795 - accuracy: 0.9375 - val_loss: 0.3814 - val_accuracy: 0.8947
Epoch 113/200
912/912 [==============================] - 1s 556us/step - loss: 0.1557 - accuracy: 0.9529 - val_loss: 0.3544 - val_accuracy: 0.9035
Epoch 114/200
912/912 [==============================] - 0s 522us/step - loss: 0.2048 - accuracy: 0.9178 - val_loss: 0.3716 - val_accuracy: 0.8904
Epoch 115/200
912/912 [==============================] - 1s 552us/step - loss: 0.1539 - accuracy: 0.9419 - val_loss: 0.4127 - val_accuracy: 0.8728
Epoch 116/200
912/912 [==============================] - 1s 571us/step - loss: 0.1648 - accuracy: 0.9430 - val_loss: 0.3686 - val_accuracy: 0.8860
Epoch 117/200
912/912 [==============================] - 1s 569us/step - loss: 0.1720 - accuracy: 0.9452 - val_loss: 0.3909 - val_accuracy: 0.8772
Epoch 118/200
912/912 [==============================] - 1s 645us/step - loss: 0.2420 - accuracy: 0.9079 - val_loss: 0.3743 - val_accuracy: 0.8684
Epoch 119/200
912/912 [==============================] - 1s 662us/step - loss: 0.2894 - accuracy: 0.8893 - val_loss: 0.3803 - val_accuracy: 0.8816
Epoch 120/200
912/912 [==============================] - 1s 676us/step - loss: 0.2710 - accuracy: 0.8936 - val_loss: 0.4327 - val_accuracy: 0.8509
Epoch 121/200
912/912 [==============================] - 0s 544us/step - loss: 0.2883 - accuracy: 0.8893 - val_loss: 0.4405 - val_accuracy: 0.8596
Epoch 122/200
912/912 [==============================] - 0s 513us/step - loss: 0.2204 - accuracy: 0.9156 - val_loss: 0.4341 - val_accuracy: 0.8640
Epoch 123/200
912/912 [==============================] - 1s 550us/step - loss: 0.2187 - accuracy: 0.9134 - val_loss: 0.3845 - val_accuracy: 0.8947
Epoch 124/200
912/912 [==============================] - 0s 495us/step - loss: 0.1567 - accuracy: 0.9430 - val_loss: 0.4209 - val_accuracy: 0.8772
Epoch 125/200
912/912 [==============================] - 0s 546us/step - loss: 0.1484 - accuracy: 0.9474 - val_loss: 0.4093 - val_accuracy: 0.8772
Epoch 126/200
912/912 [==============================] - 0s 438us/step - loss: 0.1525 - accuracy: 0.9507 - val_loss: 0.4583 - val_accuracy: 0.8596
Epoch 127/200
912/912 [==============================] - 0s 458us/step - loss: 0.2012 - accuracy: 0.9200 - val_loss: 0.4462 - val_accuracy: 0.8816
Epoch 128/200
912/912 [==============================] - 0s 477us/step - loss: 0.1372 - accuracy: 0.9518 - val_loss: 0.4195 - val_accuracy: 0.8772
Epoch 129/200
912/912 [==============================] - 0s 516us/step - loss: 0.1296 - accuracy: 0.9583 - val_loss: 0.4133 - val_accuracy: 0.8728
Epoch 130/200
912/912 [==============================] - 0s 472us/step - loss: 0.1474 - accuracy: 0.9550 - val_loss: 0.4353 - val_accuracy: 0.8728
Epoch 131/200
912/912 [==============================] - 1s 570us/step - loss: 0.1403 - accuracy: 0.9594 - val_loss: 0.4635 - val_accuracy: 0.8640
Epoch 132/200
912/912 [==============================] - 0s 519us/step - loss: 0.1490 - accuracy: 0.9496 - val_loss: 0.3772 - val_accuracy: 0.8947
Epoch 133/200
912/912 [==============================] - 0s 528us/step - loss: 0.1380 - accuracy: 0.9430 - val_loss: 0.4025 - val_accuracy: 0.8816
Epoch 134/200
912/912 [==============================] - 1s 561us/step - loss: 0.1141 - accuracy: 0.9638 - val_loss: 0.3546 - val_accuracy: 0.8904
Epoch 135/200
912/912 [==============================] - 1s 589us/step - loss: 0.1466 - accuracy: 0.9463 - val_loss: 0.5349 - val_accuracy: 0.8421
Epoch 136/200
912/912 [==============================] - 0s 466us/step - loss: 0.1480 - accuracy: 0.9561 - val_loss: 0.4247 - val_accuracy: 0.8728
Epoch 137/200
912/912 [==============================] - 0s 517us/step - loss: 0.1354 - accuracy: 0.9561 - val_loss: 0.4264 - val_accuracy: 0.8684
Epoch 138/200
912/912 [==============================] - 0s 538us/step - loss: 0.1893 - accuracy: 0.9254 - val_loss: 0.4281 - val_accuracy: 0.8596
Epoch 139/200
912/912 [==============================] - 1s 599us/step - loss: 0.1553 - accuracy: 0.9419 - val_loss: 0.3742 - val_accuracy: 0.8904
Epoch 140/200
912/912 [==============================] - 1s 586us/step - loss: 0.1783 - accuracy: 0.9342 - val_loss: 0.4007 - val_accuracy: 0.8772
Epoch 141/200
912/912 [==============================] - 1s 602us/step - loss: 0.1959 - accuracy: 0.9364 - val_loss: 0.4160 - val_accuracy: 0.8596
Epoch 142/200
912/912 [==============================] - 0s 473us/step - loss: 0.1285 - accuracy: 0.9529 - val_loss: 0.4474 - val_accuracy: 0.8640
Epoch 143/200
912/912 [==============================] - 0s 437us/step - loss: 0.1483 - accuracy: 0.9474 - val_loss: 0.4063 - val_accuracy: 0.8684
Epoch 144/200
912/912 [==============================] - 0s 473us/step - loss: 0.1227 - accuracy: 0.9550 - val_loss: 0.6770 - val_accuracy: 0.7851
Epoch 145/200
912/912 [==============================] - 0s 519us/step - loss: 0.1758 - accuracy: 0.9364 - val_loss: 0.4039 - val_accuracy: 0.8816
Epoch 146/200
912/912 [==============================] - 0s 543us/step - loss: 0.1664 - accuracy: 0.9397 - val_loss: 0.4145 - val_accuracy: 0.8728
Epoch 147/200
912/912 [==============================] - 1s 642us/step - loss: 0.1100 - accuracy: 0.9660 - val_loss: 0.3779 - val_accuracy: 0.8860
Epoch 148/200
912/912 [==============================] - 0s 474us/step - loss: 0.1092 - accuracy: 0.9605 - val_loss: 0.4694 - val_accuracy: 0.8816
Epoch 149/200
912/912 [==============================] - 0s 543us/step - loss: 0.1330 - accuracy: 0.9561 - val_loss: 0.6819 - val_accuracy: 0.7939
Epoch 150/200
912/912 [==============================] - 0s 501us/step - loss: 0.2207 - accuracy: 0.9200 - val_loss: 0.4858 - val_accuracy: 0.8684
Epoch 151/200
912/912 [==============================] - 0s 447us/step - loss: 0.1384 - accuracy: 0.9452 - val_loss: 0.4353 - val_accuracy: 0.8772
Epoch 152/200
912/912 [==============================] - 0s 436us/step - loss: 0.1222 - accuracy: 0.9583 - val_loss: 0.4877 - val_accuracy: 0.8553
Epoch 153/200
912/912 [==============================] - 0s 518us/step - loss: 0.1442 - accuracy: 0.9507 - val_loss: 0.4985 - val_accuracy: 0.8465
Epoch 154/200
912/912 [==============================] - 0s 521us/step - loss: 0.1181 - accuracy: 0.9572 - val_loss: 0.3806 - val_accuracy: 0.8772
Epoch 155/200
912/912 [==============================] - 1s 566us/step - loss: 0.1162 - accuracy: 0.9561 - val_loss: 0.5339 - val_accuracy: 0.8333
Epoch 156/200
912/912 [==============================] - 0s 466us/step - loss: 0.2617 - accuracy: 0.8969 - val_loss: 0.5135 - val_accuracy: 0.8465
Epoch 157/200
912/912 [==============================] - 0s 344us/step - loss: 0.2640 - accuracy: 0.8958 - val_loss: 0.4179 - val_accuracy: 0.8904
Epoch 158/200
912/912 [==============================] - 0s 258us/step - loss: 0.1484 - accuracy: 0.9507 - val_loss: 0.4473 - val_accuracy: 0.8816
Epoch 159/200
912/912 [==============================] - 0s 289us/step - loss: 0.1658 - accuracy: 0.9397 - val_loss: 0.4309 - val_accuracy: 0.8947
Epoch 160/200
912/912 [==============================] - 0s 306us/step - loss: 0.2044 - accuracy: 0.9167 - val_loss: 0.5051 - val_accuracy: 0.8553
Epoch 161/200
912/912 [==============================] - 0s 484us/step - loss: 0.1936 - accuracy: 0.9287 - val_loss: 0.4174 - val_accuracy: 0.8684
Epoch 162/200
912/912 [==============================] - 0s 432us/step - loss: 0.1685 - accuracy: 0.9441 - val_loss: 0.4150 - val_accuracy: 0.8728
Epoch 163/200
912/912 [==============================] - 1s 644us/step - loss: 0.1415 - accuracy: 0.9463 - val_loss: 0.4051 - val_accuracy: 0.8728
Epoch 164/200
912/912 [==============================] - 1s 670us/step - loss: 0.1924 - accuracy: 0.9276 - val_loss: 0.4055 - val_accuracy: 0.8904
Epoch 165/200
912/912 [==============================] - 1s 575us/step - loss: 0.1367 - accuracy: 0.9594 - val_loss: 0.4902 - val_accuracy: 0.8904
Epoch 166/200
912/912 [==============================] - 0s 542us/step - loss: 0.1426 - accuracy: 0.9463 - val_loss: 0.4669 - val_accuracy: 0.8640
Epoch 167/200
912/912 [==============================] - 1s 550us/step - loss: 0.1588 - accuracy: 0.9287 - val_loss: 0.4889 - val_accuracy: 0.8509
Epoch 168/200
912/912 [==============================] - 1s 592us/step - loss: 0.1461 - accuracy: 0.9507 - val_loss: 0.4797 - val_accuracy: 0.8421
Epoch 169/200
912/912 [==============================] - 1s 611us/step - loss: 0.1747 - accuracy: 0.9265 - val_loss: 0.4452 - val_accuracy: 0.8860
Epoch 170/200
912/912 [==============================] - 1s 656us/step - loss: 0.1531 - accuracy: 0.9408 - val_loss: 0.4208 - val_accuracy: 0.8684
Epoch 171/200
912/912 [==============================] - 1s 646us/step - loss: 0.1734 - accuracy: 0.9243 - val_loss: 0.5062 - val_accuracy: 0.8596
Epoch 172/200
912/912 [==============================] - 0s 458us/step - loss: 0.1164 - accuracy: 0.9594 - val_loss: 0.4233 - val_accuracy: 0.8772
Epoch 173/200
912/912 [==============================] - 0s 510us/step - loss: 0.1310 - accuracy: 0.9572 - val_loss: 0.4415 - val_accuracy: 0.8947
Epoch 174/200
912/912 [==============================] - 1s 561us/step - loss: 0.1514 - accuracy: 0.9463 - val_loss: 0.4515 - val_accuracy: 0.8947
Epoch 175/200
912/912 [==============================] - 0s 402us/step - loss: 0.1553 - accuracy: 0.9419 - val_loss: 0.4189 - val_accuracy: 0.8684
Epoch 176/200
912/912 [==============================] - 0s 374us/step - loss: 0.1629 - accuracy: 0.9320 - val_loss: 0.5070 - val_accuracy: 0.8509
Epoch 177/200
912/912 [==============================] - 0s 387us/step - loss: 0.2292 - accuracy: 0.9090 - val_loss: 0.4919 - val_accuracy: 0.8816
Epoch 178/200
912/912 [==============================] - 0s 292us/step - loss: 0.2383 - accuracy: 0.9123 - val_loss: 0.4260 - val_accuracy: 0.8860
Epoch 179/200
912/912 [==============================] - 0s 296us/step - loss: 0.1833 - accuracy: 0.9364 - val_loss: 0.4867 - val_accuracy: 0.8465
Epoch 180/200
912/912 [==============================] - 0s 370us/step - loss: 0.2003 - accuracy: 0.9189 - val_loss: 0.4885 - val_accuracy: 0.8553
Epoch 181/200
912/912 [==============================] - 0s 420us/step - loss: 0.2120 - accuracy: 0.9156 - val_loss: 0.4639 - val_accuracy: 0.8684
Epoch 182/200
912/912 [==============================] - 0s 342us/step - loss: 0.2255 - accuracy: 0.9112 - val_loss: 0.5012 - val_accuracy: 0.8553
Epoch 183/200
912/912 [==============================] - 0s 390us/step - loss: 0.1717 - accuracy: 0.9320 - val_loss: 0.4466 - val_accuracy: 0.8947
Epoch 184/200
912/912 [==============================] - 0s 384us/step - loss: 0.2214 - accuracy: 0.9013 - val_loss: 0.4887 - val_accuracy: 0.8421
Epoch 185/200
912/912 [==============================] - 0s 463us/step - loss: 0.1745 - accuracy: 0.9287 - val_loss: 0.4321 - val_accuracy: 0.8816
Epoch 186/200
912/912 [==============================] - 0s 374us/step - loss: 0.1564 - accuracy: 0.9353 - val_loss: 0.4668 - val_accuracy: 0.8728
Epoch 187/200
912/912 [==============================] - 0s 337us/step - loss: 0.1323 - accuracy: 0.9539 - val_loss: 0.5447 - val_accuracy: 0.8640
Epoch 188/200
912/912 [==============================] - 0s 273us/step - loss: 0.1330 - accuracy: 0.9463 - val_loss: 0.4563 - val_accuracy: 0.8772
Epoch 189/200
912/912 [==============================] - 0s 268us/step - loss: 0.1189 - accuracy: 0.9572 - val_loss: 0.5924 - val_accuracy: 0.8465
Epoch 190/200
912/912 [==============================] - 0s 389us/step - loss: 0.1205 - accuracy: 0.9529 - val_loss: 0.4510 - val_accuracy: 0.8640
Epoch 191/200
912/912 [==============================] - 0s 261us/step - loss: 0.1150 - accuracy: 0.9605 - val_loss: 0.4395 - val_accuracy: 0.8904
Epoch 192/200
912/912 [==============================] - 0s 285us/step - loss: 0.0967 - accuracy: 0.9660 - val_loss: 0.4885 - val_accuracy: 0.8684
Epoch 193/200
912/912 [==============================] - 0s 265us/step - loss: 0.0967 - accuracy: 0.9660 - val_loss: 0.3954 - val_accuracy: 0.8860
Epoch 194/200
912/912 [==============================] - 0s 502us/step - loss: 0.0955 - accuracy: 0.9715 - val_loss: 0.4457 - val_accuracy: 0.8816
Epoch 195/200
912/912 [==============================] - 0s 486us/step - loss: 0.0955 - accuracy: 0.9682 - val_loss: 0.4890 - val_accuracy: 0.8947
Epoch 196/200
912/912 [==============================] - 0s 457us/step - loss: 0.1700 - accuracy: 0.9364 - val_loss: 0.4738 - val_accuracy: 0.8640
Epoch 197/200
912/912 [==============================] - 0s 461us/step - loss: 0.1482 - accuracy: 0.9331 - val_loss: 0.4550 - val_accuracy: 0.8772
Epoch 198/200
912/912 [==============================] - 0s 484us/step - loss: 0.1019 - accuracy: 0.9572 - val_loss: 0.4156 - val_accuracy: 0.8904
Epoch 199/200
912/912 [==============================] - 0s 251us/step - loss: 0.0980 - accuracy: 0.9660 - val_loss: 0.4890 - val_accuracy: 0.8947
Epoch 200/200
912/912 [==============================] - 0s 278us/step - loss: 0.1405 - accuracy: 0.9430 - val_loss: 0.4912 - val_accuracy: 0.8640
Now let's plot the training history. Does the model seem to generalize better?

In [16]:
show_history(hist)

While the gap between training accuracy and validation accuracy probably narrowed, validation accuracy probably didn't improve much. That might be an indication that more training data is needed to make the network "smarter." In the confusion matrix above, George W. Bush probably scored the highest for accuracy, and if so, it's no coincidence that the dataset contains almost as many samples of George W. Bush as it does of the other candidates combined.

