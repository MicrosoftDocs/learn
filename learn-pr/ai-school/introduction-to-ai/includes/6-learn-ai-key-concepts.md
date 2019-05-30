In AI we talk about building __models__, which are shaped by __cost functions__ to measure __error__. So what does this all mean?

## What are models

Models are an estimation of how reality works. These are not just part of AI; our brains use models every day. For example, while driving, we might be able to estimate how fast our car will accelerate if we push down its accelerator pedal. We have a __model__ in our head of the relationship between the pedal and the speed of the car.

We say this model is an __estimation__ of reality, because when we think about how fast the car will run, we don’t take into account the position of every atom in the engine, wind resistance, and so on. In fact, we may know nothing about how a car engine works, and yet we can still make good guesses as to how fast we will travel.

AI is the process of building models like this by using __data__, just like we do in everyday life. When people learn to drive, they will often be surprised at how fast (or slow) the car goes when the accelerator pedal is pushed. The model in our head starts off inaccurately. With experience (data), we improve it more and more, until we can accurately estimate how the car will react. AI works in a similar way. If we give a computer a large amount of data about car speeds when the accelerator is pushed, then, using AI, the computer can build a model that is more accurate than we are.

## What is error

Error is a measure of how accurate a model is at estimating or predicting something. Small amounts of error mean the model is accurate. Large amounts of error mean the model makes many mistakes - or that it sometimes makes bad mistakes.

For example, when learning to drive, we might estimate that we will travel 10 mph faster if we push the pedal down to the floor. We find out that we travel 50 mph faster. This means we have an error of 40 mph.

## What are cost functions

We learn from our mistakes, and so does AI. Some mistakes need to be taken a lot more seriously than others, though.

For example, if we are learning to drive on the open road, and we get the speed wrong by 5 mph, this may not matter at all. When we are more than 5 mph over the speed limit, though, the police may give us a fine of $100. If we are more than 10 mph over the limit, this fine may be $200.

__Cost__ is the number we learn from (for example, the size of the fine). It is calculated from the error (for example, how badly we estimate our speed). It is also referred to as the __penalty__. In the above example, we are unlikely to learn much when we speed 3 mph over the limit, because we do not get a fine. When we speed 11 mph over the limit, the fine is large, and so we learn very quickly to be more careful with the accelerator pedal.

A __cost function__ is the way we convert error into cost. The cost function above would be “cost is $100 if they are more than 5 mph over the limit, $200 if they are more than 10 mph over the limit. If they are between the limit and 5 mph over the limit, the cost is $0”.

In AI, things are a little more mathematical than the examples above, but the general concepts are the same. In AI, cost functions are not in dollars, but in unitless numbers. The example above gives an intuitive understanding of how these work. In AI the goal is to minimize error as much as possible - which will make our result as accurate as possible.
  
Now that you’ve had an introduction to AI, let’s wrap up everything you’ve learned with a knowledge check.