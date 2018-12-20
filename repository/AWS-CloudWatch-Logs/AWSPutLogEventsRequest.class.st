Class {
	#name : #AWSPutLogEventsRequest,
	#superclass : #AWSLogsRequest,
	#instVars : [
		'logGroupName',
		'logStreamName',
		'logEvents',
		'sequenceToken'
	],
	#category : #'AWS-CloudWatch-Logs-Requests'
}

{ #category : #adding }
AWSPutLogEventsRequest >> addLogEvent: aLogEvent [

	^ self logEvents add: aLogEvent
]

{ #category : #adding }
AWSPutLogEventsRequest >> addLogMessage: aString [

	^ self addLogEvent: (AWSInputLogEvent message: aString)
]

{ #category : #accessing }
AWSPutLogEventsRequest >> logEvents [
	^ logEvents ifNil: [ logEvents  := OrderedCollection new ]
]

{ #category : #accessing }
AWSPutLogEventsRequest >> logEvents: anObject [
	logEvents := anObject
]

{ #category : #accessing }
AWSPutLogEventsRequest >> logGroupName [
	^ logGroupName
]

{ #category : #accessing }
AWSPutLogEventsRequest >> logGroupName: anObject [
	logGroupName := anObject
]

{ #category : #accessing }
AWSPutLogEventsRequest >> logStreamName [
	^ logStreamName
]

{ #category : #accessing }
AWSPutLogEventsRequest >> logStreamName: anObject [
	logStreamName := anObject
]

{ #category : #accessing }
AWSPutLogEventsRequest >> operationName [

	^ 'PutLogEvents'
]

{ #category : #accessing }
AWSPutLogEventsRequest >> resultClass [ 

	^ AWSPutLogEventsResult
]

{ #category : #accessing }
AWSPutLogEventsRequest >> sequenceToken [
	^ sequenceToken
]

{ #category : #accessing }
AWSPutLogEventsRequest >> sequenceToken: anObject [
	sequenceToken := anObject
]
