Class {
	#name : #AWSLogsResult,
	#superclass : #AWSJsonObject,
	#category : #'AWS-CloudWatch-Logs-Results'
}

{ #category : #'instance creation' }
AWSLogsResult class >> fromHttpResponse: httpResponse [

	self assert: httpResponse isSuccess.

	^ (self fromJsonString: httpResponse contents)
			setHeaders: httpResponse headers;
			yourself
]

{ #category : #initialization }
AWSLogsResult >> setHeaders: responseHeaders [
	"Optionally get some information from the headers of the http response."
]
