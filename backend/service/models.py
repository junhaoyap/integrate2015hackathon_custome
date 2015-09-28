from django.db import models

class Service(models.Model):
    time_taken = models.DurationField()
    mood = models.DecimalField(max_digits=5, decimal_places=2)
    personality = models.CharField(max_length=100)
    influence = models.CharField(max_length=100)
    reputation = models.CharField(max_length=100)
