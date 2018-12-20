Class {
	#name : #AWSLogStream,
	#superclass : #Object,
	#instVars : [
		'service',
		'groupName',
		'streamName',
		'sequenceToken',
		'events'
	],
	#category : #'AWS-CloudWatch-Logs-Core'
}

{ #category : #'as yet unclassified' }
AWSLogStream class >> service: awsLogsService stream: streamName group: groupName [

	^ self new initWithService: awsLogsService stream: streamName group: groupName
]

{ #category : #operations }
AWSLogStream >> addEvent: anInputLogEvent [
	"Add the events to the receivers events collection. Use the flush operation to send these events
	to the CloudWatch Logs service."

	^ events add: anInputLogEvent
]

{ #category : #operations }
AWSLogStream >> addEventMessage: aString [
	"Add the events to the receivers events collection. Use the flush operation to send these events
	to the CloudWatch Logs service."

	^ self addEvent: (AWSInputLogEvent message: aString)
]

{ #category : #operations }
AWSLogStream >> flush [
	"Send all the events to the CloudWatch Logs service using the PutLogEvents action."

	| request result |

	events isEmpty 
		ifTrue: [ ^ self ].
		
	request := AWSPutLogEventsRequest new
		logGroupName: groupName;
		logStreamName: streamName;
		logEvents: events;
		sequenceToken: sequenceToken;
		yourself.

	[ 	
		result := [ service execute: request ]
			on: AWSInvalidSequenceTokenException do: [ :ex | 
				request sequenceToken: ex expectedSequenceToken.
				ex return: nil ].
		result notNil ] whileFalse.

	sequenceToken := result nextSequenceToken.
	events removeAll
]

{ #category : #accessing }
AWSLogStream >> groupName [
	^ groupName
]

{ #category : #initialization }
AWSLogStream >> initWithService: awsLogsService stream: aStreamName group: aGroupName [

	service := awsLogsService.
	groupName := aGroupName.
	streamName := aStreamName.
	events := OrderedCollection new.
	self makeReady
]

{ #category : #initialization }
AWSLogStream >> makeReady [

	"Make sure the LogGroup exists."
	[ service execute: (AWSCreateLogGroupRequest new
			logGroupName: groupName ;
			yourself) ] on: AWSResourceAlreadyExistsException do: [ :ex | ex return ].

	"Make sure the LogStream exists."
	[ service execute: (AWSCreateLogStreamRequest new
		logGroupName: groupName;
		logStreamName: streamName;
		yourself) ] on: AWSResourceAlreadyExistsException do: [ :ex | ex return ].

]

{ #category : #accessing }
AWSLogStream >> sequenceToken [
	^ sequenceToken
]

{ #category : #accessing }
AWSLogStream >> streamName [
	^ streamName
]
