Instance methods are associated with a particular object rather than with the class. They are defined by adding functions to the class that receive `self` as the first parameter. Internally, instance methods are free to access the object's attributes and even other methods.

1. Return to your MissingPersons.py file and replace your definition of the `Person` class with a new one:

	```python
	import datetime
	
	class mPerson:
	    def __init__(self, name, photo, date_of_birth):
	        self.name = name
	        self.photo = photo
	        self.dob = date_of_birth
	        
	    def get_age(self):
	        return int((datetime.datetime.now() - self.dob).days / 365.25)
	    
	    def show_face(self):
	        plt.axis('off')
	        plt.imshow(self.photo, cmap=plt.cm.gray)
	```

	`mPerson` now contains two instance methods: one named `get_age()` that returns the person's age in years, and another named `show_face` that displays the person's face.

	> [!NOTE]
	> The age computation isn't exact because it provides only rudimentary handling of leap years. The solution to that is a topic for another day.

1. Now run the following statements in a new cell to test these methods:

	```python
	aPerson = mPerson("Adam", faces.images[0], datetime.datetime(1990, 9, 16))
	print(str(aPerson.get_age()))
	aPerson.show_face()
	```

1. Confirm that you see the following output:

	![Output from instance methods](../media/instance-method-output.png)
	
	_Output from instance methods_

Neither of the instance methods you added take arguments (other than `self`, which is required of an instance method), but be aware that instance methods *can* take arguments just like other functions in Python.

## Override the __str__() method

Python supplies a default `__str__()` method that works well with the rather primitive built-in object types. But for custom types, it rarely provides the results you want. The default method tells you the object's name and where the object is located in memory. It would be a lot more useful if it could tell you something specific about the object's content. 

You can replace the built-in `___str__()` method (or any other method, for that matter) by *overriding* it. You don't have to do anything  special to override a method in Python. You just provide a new version of the method in the class.

1. To demonstrate, return to the `mPerson` class in your notebook and add the following method to it:

	```python
	def __str__(self):
	    return self.name + ', age ' + str(self.get_age())
	```

	This method returns a string denoting the person's name and age. The information contained in the string is obtained by reading the object's `name` attribute and calling the object's `get_age()` method.

1. Use the following code to test the new `__str__()` method:

	```python
	print(str(aPerson))
	print(aPerson.__str__())
	print(aPerson)
	```

How do the outputs from the three `print()` statements differ, or do they differ at all? What does this tell you about how Python's `str()` function is implemented inside the Python run-time?
