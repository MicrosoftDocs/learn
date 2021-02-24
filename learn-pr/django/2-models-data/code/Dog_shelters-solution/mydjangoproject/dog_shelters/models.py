from django.db import models

#[TODO] Create your app models.
import datetime

class Shelter(models.Model):
    shelter_name = models.CharField(max_length=200)
    shelter_location = models.CharField(max_length=200)

     # [TODO] Add __str__ method to Shelter model
    def __str__(self):
        return self.shelter_name
        return self.shelter_location

class Dog(models.Model):
    shelter = models.ForeignKey(Shelter, on_delete=models.CASCADE)
    dog_name = models.CharField(max_length=200)
    dog_description = models.TextField()
    dog_image = models.ImageField(upload_to='images', blank=True)
    drop_off_date = models.DateTimeField(default=datetime.datetime.now())
    adoption_date = models.DateTimeField(default=datetime.datetime.now(), blank=True, null=True)
    dog_breed = models.CharField(max_length=200)

    # [TODO] Add __str__ method to Dog model
    def __str__(self):
        return self.dog_name
        return self.dog_description
        return self.drop_off_date
        return self.adoption_date
        return self.dog_breed