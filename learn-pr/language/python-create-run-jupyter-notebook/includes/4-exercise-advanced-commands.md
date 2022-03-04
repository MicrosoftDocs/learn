You have created a basic notebook with some Markdown and a widget to start your ship. There is a lot more you can do with notebooks, however!

In your ship's manual, you'd like to create a chart of your ship's daily statistics. You can create all kinds of interesting charts in a notebook, which is also useful for data scientists and machine learning engineers (not just astronauts). Build a chart to show your ship's oxygen levels by using `Matplotlib`, a popular library for creating charts and graphs in Python.

## Create a visualization

Build a bar chart with some mock data to show how you could plot oxygen levels in your ship. To do this, you'll need some more libraries.

1. Create a Markdown block to notate what you will display:

   ```md
   ## Oxygen levels
   
   Display ten minutes of oxygen levels in your ship.
   ```

1. Create a new code block and import two libraries, `numpy` and `matplotlib`. Use them to build a bar chart:

   ```python
   import numpy as np
   import matplotlib.pyplot as plt
   data = np.random.default_rng(12345)
   oxy_nums = data.integers(low=0, high=10, size=10)

   plt.bar(range(len(oxy_nums)), oxy_nums)
   plt.show()
   ```

   > [!TIP]
   > If you're a new user of Python, you might need to install `numpy`, `matplotlib`, and other libraries not yet installed on your system. To install `numpy`, use an activated virtual environment, type `pip install numpy` in a code block, and run it. To install `matplotlib`, use an activated virtual environment, type `pip install matplotlib` in a code block, and run it. Follow this basic procedure for any other libraries you need to install.
   
   Of course, this data is a mockup of real data, using `numpy` to create an array of 100 integers between 1 and 10.

   Your bar chart looks like this:

   :::image type="content" source="../media/chart.png" alt-text="Screenshot that shows an example of a bar chart.":::

   > [!TIP]
   > If you hover your mouse over the chart image in the notebook, you can save the chart as a *.png* file image to your local computer for future reference.

## Perform ship calculations

Next, you want to show the time that your ship needs to take to get up to a good speed. Annotate and create an equation that will allow you to input your ship's start velocity, desired end velocity, and acceleration in meters per second.

1. Create a Markdown block to explain the equation:

   ```md
   ## Ship's velocity

   Show the seconds needed to get from 0 to 60 meters per second, given the ship's acceleration in meters per second.
   ```

1. Add a code block for the equation:

   ```python
   endVelocity = 60
   startVelocity = 0
   acceleration = 9.8
 
   time = (endVelocity - startVelocity) / acceleration
   print("Time to reach desired velocity = ", time)
   ```

1. Run the code block to determine how long it will take to reach your desired velocity.
1. Tweak the start and end velocity values, or the acceleration, to determine how your spaceship will perform.

   > [!TIP]
   > Try adding some different values for your variables to see how they affect the outcome of the equation.

Congratulations! You have successfully created a ship's manual that shows some useful information about your spaceship. Because everything is contained in a Jupyter notebook, you won't have any difficulty keeping track of it, as it's all well-annotated and nicely displayed. It even includes an ignition switch! Jupyter notebooks are a useful way to display all kinds of data and even small user interfaces.
