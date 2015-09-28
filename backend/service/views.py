from service.models import Service
from service.serializers import ServiceSerializer
from rest_framework import generics
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response
from rest_framework.views import APIView
from api import *
from runner import *


class ServiceList(generics.ListAPIView):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer
    renderer_classes = (JSONRenderer,)

    def list(self, request, format=None):
        rc = RingCentral()
        rc.auth()
        call_logs = rc.get_call_logs()

        sound_file = download_sound_file()
        rc_file = rc.download_recordings()

        a, b = retrieveRecordings(sound_file, rc_file)
        result = analyze(a, b)

        result['call_logs'] = call_logs

        final_json = result

        return Response(final_json)


class ServiceSMSList(generics.ListAPIView):
    queryset = Service.objects.all()
    serializers = ServiceSerializer
    renderer_classes = (JSONRenderer,)

    def list(self, request, format=None):
        rc = RingCentral()
        rc.auth()
        sms_logs = rc.get_sms_logs()
        return Response(sms_logs)
