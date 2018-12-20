Class {
	#name : #AWSPutLogEventsResult,
	#superclass : #AWSLogsResult,
	#instVars : [
		'nextSequenceToken',
		'rejectedLogEventsInfo'
	],
	#category : #'AWS-CloudWatch-Logs-Results'
}

{ #category : #accessing }
AWSPutLogEventsResult >> nextSequenceToken [
	^ nextSequenceToken
]

{ #category : #accessing }
AWSPutLogEventsResult >> rejectedLogEventsInfo [
	^ rejectedLogEventsInfo
]
