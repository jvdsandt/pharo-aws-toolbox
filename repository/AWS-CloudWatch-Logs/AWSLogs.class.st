Class {
	#name : #AWSLogs,
	#superclass : #Object,
	#instVars : [
		'httpClient',
		'awsCredentials',
		'endpoint',
		'region'
	],
	#category : #'AWS-CloudWatch-Logs-Core'
}

{ #category : #'instance creation' }
AWSLogs class >> new [

	^ self newWithCredentials: AWSCredentials default 
			region: (AWSSignerUtils getRegionNameFromProfile: 'default' ifAbsent: [ self error: 'AWS: No default region' ])
]

{ #category : #'instance creation' }
AWSLogs class >> newWithCredentials: aCredentials region: aRegion [

	^ self basicNew initWithCredentials: aCredentials region: aRegion
]

{ #category : #accessing }
AWSLogs >> awsCredentials [
	^ awsCredentials
]

{ #category : #accessing }
AWSLogs >> endpoint [
	^ endpoint
]

{ #category : #running }
AWSLogs >> execute: awsLogsRequest [

	| httpRequest response |

	httpRequest := awsLogsRequest asHttpRequest: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ awsLogsRequest resultClass fromHttpResponse: response
]

{ #category : #running }
AWSLogs >> getStream: streamName group: groupName [

	^ AWSLogStream service: self stream: streamName group: groupName
]

{ #category : #internal }
AWSLogs >> handleErrorResponse: httpResponse [

	| data |
	
	data := httpResponse contents.
	data notNil
		ifTrue: [ 
			data := NeoJSONReader fromString: data.
			(AWSError data: data) signal ].
		
	self error: 'Unknown AWS error'
]

{ #category : #accessing }
AWSLogs >> httpClient [

	^ httpClient ifNil: [ 
			httpClient := ZnClient new
				systemPolicy;
				enforceHttpSuccess: false;
				enforceAcceptContentType: false;
				yourself ]
]

{ #category : #initialization }
AWSLogs >> initWithCredentials: aCredentials region: aRegion [

	awsCredentials := aCredentials.
	region := aRegion.
	endpoint := 'https://logs.', region asLowercase, '.amazonaws.com'.
]

{ #category : #accessing }
AWSLogs >> region [
	^ region
]

{ #category : #internal }
AWSLogs >> signRequest: httpRequest [

	awsCredentials sessionToken notNil
		ifTrue: [ httpRequest headers at: AWSHeaders x_amz_security_token put: awsCredentials sessionToken ].
	
	AWSSignerV4 new sign: httpRequest using: awsCredentials
]
