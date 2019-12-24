"
I am the main access point to the AWS CloudWatch Logs service. To function I need valid AWS credentials with the permissions to access the Logs feature of AWS and a region.

To execute a service a request object for the specific service must be created and used with the #execute: method. An example:

	| awsLogs |
	
	awsLogs := AWSLogs newWithCredentials: AWSCredentials default region: 'eu-west-1'.
	^ awsLogs execute: (AWSDescribeLogGroupsRequest new)

"
Class {
	#name : #AWSLogs,
	#superclass : #AWSService,
	#category : #'AWS-CloudWatch-Logs-Core'
}

{ #category : #running }
AWSLogs >> execute: awsLogsRequest [

	| httpRequest response |

	httpRequest := awsLogsRequest asHttpRequest: self endpoint.
	self signRequest: httpRequest.
	
	response := self executeHttpRequest: httpRequest.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ awsLogsRequest resultClass fromHttpResponse: response
]

{ #category : #running }
AWSLogs >> executeHttpRequest: httpRequest [

	^ [ self httpClient request: httpRequest; execute; response ]
			on: Error do: [ :sig |
				"Close connection and retry"
				self httpClient close.
				self httpClient request: httpRequest; execute; response ]
]

{ #category : #running }
AWSLogs >> getStream: streamName group: groupName [

	^ AWSLogStream service: self stream: streamName group: groupName
]

{ #category : #initialization }
AWSLogs >> initWithCredentials: aCredentials region: aRegion [

	super initWithCredentials: aCredentials region: aRegion.
	endpoint := 'https://logs.', region asLowercase, '.amazonaws.com'.
]
