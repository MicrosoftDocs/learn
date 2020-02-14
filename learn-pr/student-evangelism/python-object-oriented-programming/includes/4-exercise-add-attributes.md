So that we have some data to work with, let's load a database of facial images. The dataset is a publicly available one called the [Olivetti Faces dataset](https://scikit-learn.org/0.19/datasets/olivetti_faces.html). It was originally created by AT&T.

1. Let's create a new file for this class. Open the Cloud Shell editor and create a new file with the following command:

    ```bash
    code MissingPersons.py
    ```

1. One of the many popular packages available for Python is [Scikit-learn](https://scikit-learn.org/stable/index.html), which is an open-source library used to build machine-learning models. Scikit-learn includes several built-in datasets, one of which is the Olivetti faces dataset.

    Paste the following statements into your new file to load the faces dataset:

    ```python
    from sklearn.datasets import fetch_olivetti_faces

    # Load the dataset
    faces = fetch_olivetti_faces()

    # Prove that the dataset was loaded
    print(faces.data.shape)
    ```

    The first line imports the Scikit-learn function that loads the dataset. The second loads the dataset, and the third shows the shape of the dataset.

1. Before we can run the code, we must ensure that the `sklearn` Python package is installed. Run the following command to install it in Cloud Shell:

    ```bash
    pip install sklearn
    ```

    It will take a bit to install. Watch the output of Cloud Shell to see when it finishes.

1. When it finishes, use the following command to run your code:

    ```bash
    python3 MissingPersons.py
    ```

    Examine the output. The dataset contains 400 faces, each of which consists of an image with 4,096 pixels. The dataset contains 10 photos each of 40 different people. The first ten images in `faces.images` represent the first person, the next 10 images represent the second person, and so on.

    Curious about what the dataset looks like? Here's the first five people in the Olivetti dataset:

    ![The first five people in the Olivetti dataset](../media/show-faces.png)

    _The first five people in the Olivetti dataset_

Now that we have some faces to work with, let's shift our thinking to objects, classes, and attributes.

## Define a class containing instance attributes

Instance attributes differ from one class instance (object) to another. You can't access them without a class instance, as you can with class attributes. Instead, you must create an instance of the class.

Python provides multiple ways to create instance attributes, but the most common is to define an `__init__()` method containing the attributes you want objects to have.

1. Type the following code in your file to define an `Person` class containing three instance attributes:

    ```python
    class Person:
        def __init__(self, name, photo, date_of_birth):
            self.name = name
            self.photo = photo
            self.dob = date_of_birth
    ```

    The `self` keyword refers to the object instance and is provided in the first argument to `__init__()`. Inside `__init__()` are three instance attributes that can be accessed on `Person` objects:

    - `name`, which holds the person's name
    - `photo`, which holds an image of the person's face
    - `dob`, which holds the person's date of birth

    Three arguments — `name`, `photo`, and `date_of_birth` — must be provided when the object is created. (The `self` argument is provided by Python itself.) Each is copied into the corresponding instance attribute.

1. Let's test these attributes. Add the following line of code at the top of the file, right below the exisint import statement:

    ```python
    import datetime
    ```

1. Now, add the following code at the bottom of the file to create an instance of `Person` named `aPerson` that has the name "Adam" and is assigned the first face in the Olivetti dataset:

    ```python
    aPerson = Person("Adam", faces.images[0], datetime.datetime(1990, 9, 16))
    ```

1. Now add this statement to display Adam's name.

    ```python
    print(aPerson.name)
    ```

Because `name`, `photo`, and `dob` are instance attributes, you could create hundreds of `Person` objects, and each could hold a different name, photo, and date of birth. If these were class attributes instead, `name`, `photo`, and `dob` would have to be the same for every person — clearly not a model of what happens in the real world.

## Data hiding

Many programming languages that support OOP also support *data hiding* by allowing methods and attributes — "class members" — to be declared private or protected. Private class members can be accessed from inside an object, but not from the outside. Protected class members can be accessed inside an object and objects subclassed from it (more on this later), but not from the outside.

Python doesn't support data hiding — at least not in the same sense that other languages do. Guido van Rossum, the creator of Python, felt that data hiding makes languages harder to use. Consequently, you can't hide class members in Python.

You can, however, use well-established conventions to let others know that certain class members are for internal use only and should *not* be accessed from the outside. Prefacing a class-member name with an underscore, as in `_myProtectedVar`, indicates that the class member is protected. Using two underscores (for example, `__cleanup()`) indicates that the class member is private.

Although you can still write code to access private and protected methods and attributes from the outside, many Python programming environments honor these conventions and hide private and protected members from view. So Python does support a limited form of data hiding, but only by convention and you need to be aware of that when you send your code to the world.
