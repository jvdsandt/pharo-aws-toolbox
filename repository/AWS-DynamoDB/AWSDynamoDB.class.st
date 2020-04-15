Class {
	#name : #AWSDynamoDB,
	#superclass : #AWSService,
	#category : #'AWS-DynamoDB'
}

{ #category : #api }
AWSDynamoDB >> createTable: aCreateTableRequest [

	| httpRequest response |

	httpRequest := aCreateTableRequest asHttpRequest: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ NeoJSONReader fromString: response contents
]

{ #category : #api }
AWSDynamoDB >> deleteItem: aDeleteItemRequest [

	| httpRequest response |

	httpRequest := aDeleteItemRequest asHttpRequest: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSDynamoDeleteItemResponse fromJsonString: response contents
]

{ #category : #api }
AWSDynamoDB >> getItem: aGetItemRequest [

	| httpRequest response |

	httpRequest := aGetItemRequest asHttpRequest: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSDynamoGetItemResponse fromJsonString: response contents
]

{ #category : #initialization }
AWSDynamoDB >> initWithCredentials: aCredentials region: aRegion [

	super initWithCredentials: aCredentials region: aRegion.
	endpoint := 'https://dynamodb.', region asLowercase, '.amazonaws.com'.
]

{ #category : #api }
AWSDynamoDB >> putItem: aPutItemRequest [

	| httpRequest response |

	httpRequest := aPutItemRequest asHttpRequest: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ]
]

{ #category : #api }
AWSDynamoDB >> query: aQueryRequest [

	| httpRequest response |

	httpRequest := aQueryRequest asHttpRequest: self endpoint.
	self signRequest: httpRequest.
	
	response := self httpClient 
		request: httpRequest;
		execute;
		response.
	response isSuccess 
		ifFalse: [ self handleErrorResponse: response ].
		
	^ AWSDynamoQueryResponse fromJsonString: response contents
]
