Class {
	#name : #AWSInputLogEventTest,
	#superclass : #TestCase,
	#instVars : [
		'timestamp',
		'message'
	],
	#category : #'AWS-CloudWatch-Logs-Tests'
}

{ #category : #tests }
AWSInputLogEventTest >> testAsJson [

	| event json event2 |
	
	event := AWSInputLogEvent message: 'This is a Test!' timestamp: 1544711418274.
	json := NeoJSONWriter toString: event.
	self assert: '{"message":"This is a Test!","timestamp":1544711418274}' equals: json.
	
	event2 := AWSInputLogEvent fromJsonString: json.
	self assert: event message equals: event2 message.
	self assert: event timestamp equals: event2 timestamp
]
