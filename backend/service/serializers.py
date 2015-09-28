from rest_framework import serializers
from service.models import Service

class ServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Service
        fields = ('id', 'time_take', 'mood', 'personality',
            'influence', 'reputation')

