Class {
	#name : #AWSSQService,
	#superclass : #AWSService,
	#category : #'AWS-SimpleQueueService'
}

{ #category : #api }
AWSSQService >> createQueue: aCreateQueueRequest [

	| httpRequest response |

	httpRequest := ZnRequest post: self endpoint.
	httpRequest entity: aCreateQueueRequest asFormUrlEncodedEntity.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSSQSCreateQueueResponse fromXmlString: response contents
]

{ #category : #initialization }
AWSSQService >> initWithCredentials: aCredentials region: aRegion [

	super initWithCredentials: aCredentials region: aRegion.
	endpoint := 'https://sqs.', region asLowercase, '.amazonaws.com'.
]

{ #category : #api }
AWSSQService >> listQueues [
	^ self listQueues: nil
]

{ #category : #api }
AWSSQService >> listQueues: aPrefix [

	| url httpRequest response |

	url := self endpoint asZnUrl.
	url queryAt: 'Action' put: 'ListQueues'.
	url queryAt: 'Version' put: '2012-11-05'.
	aPrefix isEmptyOrNil 
		ifFalse: [ url queryAt: 'QueueNamePrefix' put: aPrefix ].
	httpRequest := ZnRequest get: url.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].

	^ AWSSQSListQueuesResponse fromXmlString: response contents
]
