Class {
	#name : #AWSLogsRequestTest,
	#superclass : #TestCase,
	#category : #'AWS-CloudWatch-Logs-Tests'
}

{ #category : #tests }
AWSLogsRequestTest >> testDescribeLogGroupsRequestAsJson [

	| request |
	
	request := AWSDescribeLogGroupsRequest new.
	self assert: '{}' equals: request asJsonString.
	
	request limit: 22.
	self assert: '{"limit":22}' equals: request asJsonString.
	
	request logGroupNamePrefix: 'qwerty'.
	self assert: '{"limit":22,"logGroupNamePrefix":"qwerty"}' equals: request asJsonString.
	
	request nextToken: '12qw'.
	self assert: '{"limit":22,"logGroupNamePrefix":"qwerty","nextToken":"12qw"}' equals: request asJsonString.
]

{ #category : #tests }
AWSLogsRequestTest >> testDescribeLogGroupsRequestToJson [

	| request |
	
	request := AWSDescribeLogGroupsRequest new.
	self assert: '{}' equals: request asJsonString.
	
	request limit: 22.
	self assert: '{"limit":22}' equals: request asJsonString.
	
	request logGroupNamePrefix: 'qwerty'.
	self assert: '{"limit":22,"logGroupNamePrefix":"qwerty"}' equals: request asJsonString.
	
	request nextToken: '12qw'.
	self assert: '{"limit":22,"logGroupNamePrefix":"qwerty","nextToken":"12qw"}' equals: request asJsonString.
]

{ #category : #tests }
AWSLogsRequestTest >> testPutLogEventsRequestAsJson [

	| request |
	
	request := AWSPutLogEventsRequest new.
	request logGroupName: 'my-group'.
	request logStreamName: 'my-stream'.
	request addLogEvent: (AWSInputLogEvent message: 'my-message' timestamp: 1544713619690).

	self assert: '{"logGroupName":"my-group","logStreamName":"my-stream","logEvents":[{"message":"my-message","timestamp":1544713619690}]}'
			equals: request asJsonString.
]

{ #category : #tests }
AWSLogsRequestTest >> testPutLogEventsRequestToJson [

	| request |
	
	request := AWSPutLogEventsRequest new.
	request logGroupName: 'my-group'.
	request logStreamName: 'my-stream'.
	request addLogEvent: (AWSInputLogEvent message: 'my-message' timestamp: 1544713619690).

	self assert: '{"logGroupName":"my-group","logStreamName":"my-stream","logEvents":[{"message":"my-message","timestamp":1544713619690}]}'
			equals: request asJsonString.
]
