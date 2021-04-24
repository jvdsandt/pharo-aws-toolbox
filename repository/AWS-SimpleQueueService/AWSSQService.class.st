Class {
	#name : #AWSSQService,
	#superclass : #AWSService,
	#traits : 'AWSTXmlErrorResponseHandler',
	#classTraits : 'AWSTXmlErrorResponseHandler classTrait',
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
AWSSQService >> deleteMessage: aReceiptHandle on: aQueueUrl [

	| httpRequest response |

	httpRequest := ZnRequest post: aQueueUrl.
	httpRequest entity: (AWSSQSRequest convertEntity: (
		ZnApplicationFormUrlEncodedEntity new
			at: 'Action' put: 'DeleteMessage';
			at: 'ReceiptHandle' put: aReceiptHandle;
			at: 'Version' put: AWSSQSRequest version;
			yourself)).
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSSQSResponse fromXmlString: response contents
]

{ #category : #api }
AWSSQService >> deleteQueue: aQueueUrl [
	"Deletes the messages in a queue specified by the QueueURL parameter."

	| httpRequest response |

	httpRequest := ZnRequest post: aQueueUrl.
	httpRequest entity: (AWSSQSRequest createEntityForAction: 'DeleteQueue').
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSSQSResponse fromXmlString: response contents
]

{ #category : #api }
AWSSQService >> getQueueAttributes: aQueueUrl names: attribNames [
	"Gets attributes for the specified queue."

	| entity httpRequest response |
	
	entity := ZnApplicationFormUrlEncodedEntity new
			at: 'Action' put: 'GetQueueAttributes';
			at: 'Version' put: AWSSQSRequest version;
			yourself.
	attribNames 
		ifNotNil: [ 
			attribNames doWithIndex: [ :name :index |
				entity at: 'AttributeName.', index asString put: name ] ].
	httpRequest := ZnRequest post: aQueueUrl.
	httpRequest entity: (AWSSQSRequest convertEntity: entity).
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSSQSGetAttributesResponse fromXmlString: response contents
]

{ #category : #api }
AWSSQService >> getQueueUrl: queueName ifAbsent: absentBlock [

	| url httpRequest response xmlDoc |

	url := self endpoint asZnUrl.
	url queryAt: 'Action' put: 'GetQueueUrl'.
	url queryAt: 'QueueName' put: queueName.
	url queryAt: 'Version' put: AWSSQSRequest version.
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

{ #category : #convenience }
AWSSQService >> getQueueUrlNamed: qName [
	"Look for an existing queue named <qName> or create a new one.
	Answer the queue url."
	
	^ self getQueueUrl: qName ifAbsent: [ 
			| response |
			response := self createQueue: (AWSSQSCreateQueueRequest new
					queueName: qName;
					yourself).
			response queueUrl ]
]

{ #category : #initialization }
AWSSQService >> initEndpointWithRegion: aRegion [
	endpoint := 'https://sqs.' , region asLowercase , '.amazonaws.com'
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
AWSSQService >> purgeQueue: aQueueUrl [
	"Deletes the messages in a queue specified by the QueueURL parameter."

	| httpRequest response |

	httpRequest := ZnRequest post: aQueueUrl.
	httpRequest entity: (AWSSQSRequest createEntityForAction: 'PurgeQueue').
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
	
	^ AWSSQSResponse fromXmlString: response contents
]

{ #category : #api }
AWSSQService >> receiveMessage: aReceiveMessageRequest on: aQueueUrl [

	| httpRequest response |

	httpRequest := ZnRequest post: aQueueUrl.
	httpRequest entity: aReceiveMessageRequest asEntity.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSSQSReceiveMessageResponse fromXmlString: response contents
]

{ #category : #api }
AWSSQService >> sendMessage: aSendMessageRequest on: aQueueUrl [

	| httpRequest httpResponse response md5hash |

	httpRequest := ZnRequest post: aQueueUrl.
	httpRequest entity: aSendMessageRequest asEntity.
	self signRequest: httpRequest.
	md5hash := MD5 new hashMessage: aSendMessageRequest body utf8Encoded. 
	
	httpResponse := self httpClient 
		request: httpRequest;
		execute;
		response.
		
	httpResponse isSuccess 
		ifFalse: [ self handleErrorResponse: httpResponse ].
	response := AWSSQSSendMessageResponse fromXmlString: httpResponse contents.
	(md5hash hex match: response md5OfMessageBody)
		ifFalse: [ AWSError signal: 'Data error - hash mismatch' ].
		
	^ response
]
