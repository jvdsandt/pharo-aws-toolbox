Class {
	#name : #AWSSQService,
	#superclass : #AWSService,
	#category : #'AWS-SimpleQueueService'
}

{ #category : #api }
AWSSQService >> createQueue: aCreateQueueRequest [

	| httpRequest response |

	httpRequest := ZnRequest post: self endpoint.
	httpRequest entity: aCreateQueueRequest asEntity.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSSQSCreateQueueResponse fromXmlString: response contents
]

{ #category : #api }
AWSSQService >> getQueueUrl: queueName ifAbsent: absentBlock [

	| url httpRequest response xmlDoc |

	url := self endpoint asZnUrl.
	url queryAt: 'Action' put: 'GetQueueUrl'.
	url queryAt: 'QueueName' put: queueName.
	url queryAt: 'Version' put: '2012-11-05'.
	httpRequest := ZnRequest get: url.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ 
			[ self handleErrorResponse: response ]
				on: AWSError do: [ :ex | 
					ex code = 'AWS.SimpleQueueService.NonExistentQueue'
						ifTrue: [ ^ absentBlock value ]
						ifFalse: [ ex pass ] ] ].

	xmlDoc := self xmlParser parse: response contents.
	^ (xmlDoc root elementAt: 'GetQueueUrlResult') contentStringAt: 'QueueUrl'
]

{ #category : #internal }
AWSSQService >> handleErrorResponse: httpResponse [

	| dom |
	
	(httpResponse hasEntity and: [ httpResponse contentType sub = 'xml' ])
		ifFalse: [ ^ super handleErrorResponse: httpResponse ].
		
	dom := self xmlParser parse: httpResponse contents.
	(AWSError xmlData: dom root) signal
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

{ #category : #api }
AWSSQService >> sendMessage: aSendMessageRequest on: aQueueUrl [

	| httpRequest response |

	httpRequest := ZnRequest post: aQueueUrl.
	httpRequest entity: aSendMessageRequest asEntity.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSSQSCreateQueueResponse fromXmlString: response contents
]

{ #category : #resources }
AWSSQService >> xmlParser [

	^ XMLDOMParser
]
