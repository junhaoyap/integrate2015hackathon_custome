import requests
import boto3
from authkey import *

RING_CENTRAL_BASE_API = "https://platform.devtest.ringcentral.com"

RING_CENTRAL = RING_CENTRAL_BASE_API + "/restapi/oauth/token"
CALL_LOG_API = RING_CENTRAL_BASE_API + "/restapi/v1.0/account/~/extension/~/call-log?withRecording=False&phoneNumber=%s" % PHONE_NUMBER
RECORDING_LOG_API = RING_CENTRAL_BASE_API + "/restapi/v1.0/account/~/extension/~/call-log?withRecording=True&phoneNumber=%s" % PHONE_NUMBER
SMS_LOG_API = RING_CENTRAL_BASE_API + "/restapi/v1.0/account/~/extension/~/message-store?availability=Alive&dateFrom=2015-09-20T00:00:00.000Z&page=1&perPage=100"

AUTH_HEADERS = {
    'Authorization': 'Basic %s' % RING_CENTRAL_AUTH,
    'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' 
}

PAYLOAD = {
    'grant_type': 'password',
    'username': USERNAME,
    'extension': '101',
    'password': PASSWORD
}

class RingCentral(object):
    """Wrapper for RingCentral Restful API"""
    def __init__(self):
        self.session = requests.Session()
        self.token = None

    def auth(self):
        r = self.session.post(RING_CENTRAL, headers=AUTH_HEADERS, data=PAYLOAD)
        self.token = r.json()['access_token']

    def get_call_logs(self):
        r = self.session.get(CALL_LOG_API, headers={'Authorization': 'Bearer %s' % self.token})
        return r.json()

    def get_recordings(self):
        r = self.session.get(RECORDING_LOG_API,
            headers={'Authorization': 'Bearer %s' % self.token})
        return r.json()

    def get_sms_logs(self):
        r = self.session.get(SMS_LOG_API,
            headers={'Authorization': 'Bearer %s' % self.token})
        return r.json()

    def download_recordings(self):
        recordings = self.get_recordings()["records"]
        print(recordings)
        
        found = False
        for i in range(len(recordings)):
            if "recording" in recordings[i]:
                uri = recordings[i]["recording"]["contentUri"]
                found = True
                break

        if not found:        
            return "ringCentralFile.wav"

        print(uri)
        r = self.session.get(uri,
            headers={'Authorization': 'Bearer %s' % self.token})

        print(r.status_code)
        if r.status_code == 200:
            with open('ringCentralFile.wav', 'wb') as f:
                f.write(r.content)

        return "ringCentralFile.wav"
               


def download_sound_file():
    s3 = boto3.resource('s3')
    sound_file = s3.Object(bucket_name='goodservice', key='soundFileKey.wav')
    sound_file.download_file('./soundFileKey.wav')
    return "soundFileKey.wav"