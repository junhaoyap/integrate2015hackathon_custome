import time
import requests
from hp_api import *


# Magic functions

def retrieveRecordings(user, mixed):
	# translate to text
	job1 = recognizeSpeech(open(user, 'rb'))
	job2 = recognizeSpeech(open(mixed, 'rb'))

	userVoice = retrieveAsyncJob(job1["jobID"])
	mixedVoice = retrieveAsyncJob(job2["jobID"])

	# For testing
	# userVoice = retrieveAsyncJob('usw3p_af4596ca-6f9e-4e90-9958-223d76df0c5f')
	# mixedVoice = retrieveAsyncJob('usw3p_af4596ca-6f9e-4e90-9958-223d76df0c5f')

	return userVoice, mixedVoice




def analyze(userVoice, mixedVoice):
	result = {}

	userText = userVoice["actions"][0]["result"]["document"][0]["content"]
	mixedText = mixedVoice["actions"][0]["result"]["document"][0]["content"]

	userText = userText.split(" ")
	mixedText = mixedText.split(" ")

	# diff text (customer) with naive O(n^2)
	for i in range(len(userText)):
		for j in range(len(mixedText)):
			if userText[i] == mixedText[j]:
				userText[i] = ""
				mixedText[j] = ""
				break

	mixedText = " ".join(mixedText)

	# sentiment analysis
	result['sentiment_analysis'] = sentimentAnalysis(mixedText)

	# tone analysis
	data2 = {'scorecard':'email', 'text': mixedText}
	data2 = json.dumps(data2)

	response = requests.post("http://localhost:5000/tone", data=data2, headers={'Content-type': 'application/json'})

	result['tone_analysis'] = response.json()

	return result



