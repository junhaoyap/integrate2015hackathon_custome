import requests
import json
import time
from authkey import *

apikey = HP_API

apiUrl = "https://api.idolondemand.com/1/api"
jobUrl = "https://api.idolondemand.com/1/job"

def post(handler, data={}, headers={}, files={}, async=False, **args):
	syncstr = "sync"
	if async:
		syncstr = "async"



	url = ("/%s/%s/%s" % (syncstr, handler, "v1"))

	response = requests.post(apiUrl+url, data=data, files=files, headers=headers)

	return response


# https://www.idolondemand.com/developer/apis/analyzesentiment#response
def sentimentAnalysis(text):
	data = {"text": text}
	data["apikey"] = apikey
	data = json.dumps(data)

	r = post("analyzesentiment", data, headers={'Content-type': 'application/json'})

	return r.json()

# https://www.idolondemand.com/developer/apis/recognizespeech#response
# open the file first.
# returns job ID as this is a async request.
def recognizeSpeech(speechFile):
	files = {"file": speechFile}
	data = {}
	data["apikey"] = apikey

	# Does not accept synchronous calls.
	r = post("recognizespeech", data, files=files, async=True)

	return r.json()

def retrieveAsyncJob(jobID):
	data = {}
	data["apikey"] = apikey

	internal_tries = 0
	while internal_tries < 30:
		print("looping")
		time.sleep(10)
		r = requests.get(jobUrl+"/status/"+jobID, data)

		if r.json()["status"] == "finished":
			break

		internal_tries += 1

	return r.json()

# resultId = recognizeSpeech(open('carlin_letter.mp3', 'rb'))
# print(sentimentAnalysis(":)"))

# print(retrieveAsyncJob(resultId["jobID"]))

#print(retrieveAsyncJob('usw3p_af4596ca-6f9e-4e90-9958-223d76df0c5f'))